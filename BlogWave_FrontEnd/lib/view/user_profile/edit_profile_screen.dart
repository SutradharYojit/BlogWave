import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../resources/resources.dart';
import '../../services/services.dart';
import '../../widget/widget.dart';
import 'user_profile_provider.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final TextEditingController _userNameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _bioCtrl = TextEditingController();
  ValueNotifier<bool> editProfile = ValueNotifier(true); // to manage the focus
  ValueNotifier<String> imgUrl = ValueNotifier(""); // to manage the focus
  final ImagePicker picker = ImagePicker();
  File? imageFile;
  String? imageUrl;

  Future<String> uploadImage() async {
    try {
      final FirebaseStorage storage = FirebaseStorage.instance;
      final File? image = imageFile;
      var random = Random.secure();
      var values = List<int>.generate(20, (i) => random.nextInt(255));
      String imageName = base64UrlEncode(values);
      final String imagePath = 'usersProfile/${UserPreferences.userId}/$imageName';
      UploadTask uploadTask = storage.ref().child(imagePath).putFile(image!);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      final String imageUrl = await taskSnapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      return "";
    }
  }

  @override
  void initState() {
    super.initState();
    updateData();
  }

  void updateData() {
    final userData = ref.read(userDataList);
    _userNameCtrl.text = userData.first.userData!.userName!;
    _emailCtrl.text = userData.first.userData!.email!;
    _bioCtrl.text = userData.first.userData!.bio!;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus(); // To unfocus on the text filled
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Edit Profile"),
          actions: [
            IconButton(
              onPressed: () {
                editProfile.value = false;
              },
              icon: Icon(
                Icons.edit,
                size: 20.sp,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(15.w),
              child: ValueListenableBuilder(
                valueListenable: editProfile,
                builder: (context, value, child) {
                  return Column(
                    children: [
                      Consumer(
                        builder: (context, ref, child) {
                          final image = ref.read(userDataList.notifier).image;
                          imgUrl.value = image ?? "";
                          return Center(
                            child: Stack(
                              children: [
                                ClipOval(
                                  child: SizedBox.fromSize(
                                    size: Size.fromRadius(50.w), // Image radius
                                    child: CachedNetworkImage(
                                      imageUrl: image ?? "",
                                      fit: BoxFit.cover,
                                      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                                        child: CircularProgressIndicator(value: downloadProgress.progress),
                                      ),
                                      errorWidget: (context, url, error) => Icon(
                                        Icons.account_circle_outlined,
                                        size: 78.h,
                                        color: ColorManager.greyColor,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Visibility(
                                    visible: !value,
                                    child: CircleAvatar(
                                      radius: 17.r,
                                      child: IconButton(
                                        onPressed: () async {
                                          await picker
                                              .pickImage(
                                            source: ImageSource.gallery,
                                          )
                                              .then((image) async {
                                            if (image != null) {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return const Center(
                                                    child: Loading(),
                                                  );
                                                },
                                              );
                                              setState(() {
                                                imageFile = File(image.path);
                                              });
                                              final imageUrl = await uploadImage();
                                              imgUrl.value = imageUrl;
                                              Navigator.pop(context);
                                            }
                                          });
                                        },
                                        icon: Center(
                                          child: Icon(
                                            Icons.camera,
                                            size: 18.h,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15.r),
                        child: PrimaryTextFilled(
                          // focusNode: _focus,
                          readOnly: value,
                          controller: _userNameCtrl,
                          textCapitalization: TextCapitalization.sentences,
                          hintText: "Enter userName",
                          labelText: "UserName",
                          prefixIcon: const Icon(
                            Icons.text_format_rounded,
                            color: ColorManager.gradientDarkTealColor,
                          ),
                          maxLines: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15.r),
                        child: PrimaryTextFilled(
                          readOnly: value,
                          controller: _emailCtrl,
                          hintText: "Enter Email",
                          labelText: "Email",
                          prefixIcon: const Icon(
                            Icons.email_rounded,
                            color: ColorManager.gradientDarkTealColor,
                          ),
                          maxLines: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15.r),
                        child: PrimaryTextFilled(
                          readOnly: value,
                          textCapitalization: TextCapitalization.sentences,
                          controller: _bioCtrl,
                          hintText: "Enter Bio",
                          labelText: "Bio",
                          prefixIcon: const Icon(
                            Icons.note_alt_rounded,
                            color: ColorManager.gradientDarkTealColor,
                          ),
                          maxLines: 1,
                        ),
                      ),
                      Visibility(
                        visible: !editProfile.value,
                        child: PrimaryButton(
                          title: "Update Profile",
                          onTap: () async {
                            editProfile.value = true;
                            ref.read(userDataList.notifier).update(
                              data: {
                                "id": UserPreferences.userId,
                                "userName": _userNameCtrl.text.trim(),
                                "email": _emailCtrl.text.trim(),
                                "bio": _bioCtrl.text.trim(),
                                "profileUrl": imgUrl.value
                              },
                            );
                            buildShowToast(toastMessage: "Profile Update Successfully");
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
