import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/blog_data_list.dart';
import '../../model/model.dart';
import '../../resources/resources.dart';
import '../../services/services.dart';
import '../../widget/widget.dart';
import '../blog_listing/blog_listing_provider.dart';

class AddBlogScreen extends StatefulWidget {
  const AddBlogScreen({
    super.key,
    required this.blogContent,
  });

  final BlogPreferences
      blogContent; // Variable help to make ensure that data in coming from add vlog screen or blog details screen

  @override
  State<AddBlogScreen> createState() => _AddBlogScreenState();
}

class _AddBlogScreenState extends State<AddBlogScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();
  final ImagePicker picker = ImagePicker(); // image picker function to choose photo from gallery
  final ValueNotifier<List> _tagsList = ValueNotifier([]); // list of tags to display in post
  ValueNotifier<String> imgUrl = ValueNotifier(""); // get the image url
  final _formKey =
      GlobalKey<FormState>(); //form key to add validation on textform filled so user can't enter forbidden data

  File? imageFile;
  String dropdownValue = 'Lifestyle';

  @override
  void initState() {
    super.initState();
    // the condition check while data is coming from blog list screen and used to update the blog data
    if (widget.blogContent.blogChoice) {
      imgUrl.value = widget.blogContent.blogData!.blogImgUrl!;
      _titleController.text = widget.blogContent.blogData!.title!;
      dropdownValue = widget.blogContent.blogData!.categories!;
      _tagsList.value = widget.blogContent.blogData!.tags!;
      _descriptionController.text = widget.blogContent.blogData!.description!;
    }
  }

  // Function that store the image in server and return the imageUrl
  Future<String> uploadImage() async {
    try {
      final FirebaseStorage storage = FirebaseStorage.instance;
      final File? image = imageFile;
      var random = Random.secure();
      var values = List<int>.generate(20, (i) => random.nextInt(255));
      String imageName = base64UrlEncode(values);
      final String imagePath = 'blogsImages/${UserPreferences.userId}/$imageName';
      UploadTask uploadTask = storage.ref().child(imagePath).putFile(image!);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      final String imageUrl = await taskSnapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      return "";
    }
  }

  @override
  void dispose() {
    // dispose the textForm filled
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _tagsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 1,
        title: AppBarTitle(
          title: widget.blogContent.blogChoice
              ? StringManager.updateBlogTxt
              : StringManager.addBlogTxt, //check weather its should be add blog or update blog
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(15.w),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Center(
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: Radius.circular(12.r),
                      padding: EdgeInsets.all(6.r),
                      dashPattern: const [7, 3],
                      strokeWidth: 1,
                      child: Stack(
                        children: [
                          ValueListenableBuilder(
                            valueListenable: imgUrl,
                            builder: (context, value, child) {
                              return SizedBox(
                                height: 170.h,
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.w),
                                  ),
                                  child: CacheImage(
                                    imgUrl: value,
                                    errorWidget: Center(
                                      child: Image.asset(
                                        IconAssets.blankImgIcon,
                                        height: 60.h,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorManager.rgbWhiteColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: IconButton(
                                onPressed: () async {
                                  // function to choose the image from gallery
                                  await picker
                                      .pickImage(
                                    source: ImageSource.gallery,
                                  )
                                      .then((image) async {
                                    if (image != null) {
                                      loading(context);
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
                                    color: ColorManager.blackColor,
                                    Icons.camera,
                                    size: 18.h,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.r),
                    child: PrimaryTextFilled(
                      controller: _titleController,
                      textCapitalization: TextCapitalization.sentences,
                      hintText: StringManager.titleHintTxt,
                      labelText: StringManager.titleLabelTxt,
                      prefixIcon: const Icon(
                        Icons.title,
                        color: ColorManager.gradientDarkTealColor,
                      ),
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return StringManager.titleHintTxt;
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0.r),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        enabledBorder: buildOutlineInputBorder(),
                        focusedBorder: buildOutlineInputBorder(),
                      ),
                      value: BlogDataList.blogCategory[0],
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: BlogDataList.blogCategory.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(fontSize: 15.sp),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: _tagsList,
                    builder: (context, data, child) {
                      return Padding(
                        padding: EdgeInsets.only(top: 10.r),
                        child: GridView.builder(
                          shrinkWrap: true,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 2.1,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 1,
                          ),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Card(
                                child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("#${data[index]}"),
                                  InkWell(
                                    onTap: () {
                                      _tagsList.value.removeAt(index);
                                      setState(() {});
                                    },
                                    child: CircleAvatar(
                                      radius: 10,
                                      backgroundColor: ColorManager.grey300Color,
                                      child: Icon(
                                        Icons.close,
                                        size: 13.h,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ));
                          },
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.r),
                    child: PrimaryTextFilled(
                      controller: _tagsController,
                      hintText: StringManager.hashHintTxt,
                      labelText: StringManager.hashLabelTxt,
                      textCapitalization: TextCapitalization.sentences,
                      onFieldSubmitted: (p0) {
                        if (_tagsController.text.trim() != "") {
                          _tagsList.value.insert(0, _tagsController.text.trim());
                          _tagsController.clear();
                        }
                      },
                      suffixIcon: IconButton(
                        onPressed: () {
                          if (_tagsController.text.trim() != "") {
                            _tagsList.value.insert(0, _tagsController.text.trim());
                            _tagsController.clear();
                            setState(() {});
                          }
                        },
                        icon: const CircleAvatar(
                          backgroundColor: ColorManager.gradientLightTealColor,
                          radius: 18,
                          child: Icon(Icons.add),
                        ),
                      ),
                      textInputAction: TextInputAction.done,
                      prefixIcon: const Icon(
                        Icons.tag,
                        color: ColorManager.tealColor,
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.r),
                    child: PrimaryTextFilled(
                      controller: _descriptionController,
                      hintText: StringManager.descHintTxt,
                      textCapitalization: TextCapitalization.sentences,
                      labelText: StringManager.descLabelTxt,
                      maxLines: 6,
                      prefixIcon: const Icon(
                        Icons.title,
                        color: ColorManager.gradientDarkTealColor,
                      ),
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return StringManager.descHintTxt;
                        }
                        return null;
                      },
                    ),
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      return PrimaryButton(
                        title: widget.blogContent.blogChoice ? StringManager.updateBlogTxt : StringManager.addBlogTxt,
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            loading(context);
                            if (widget.blogContent.blogChoice) {
                              // Api to update the existing blog
                              ApiServices().postApi(
                                api: "${APIConstants.baseUrl}blog/updateBlog",
                                body: {
                                  ApiRequestBody.apiTitle: _titleController.text.trim(),
                                  ApiRequestBody.apiDescription: _descriptionController.text.trim(),
                                  ApiRequestBody.apiCategories: dropdownValue,
                                  ApiRequestBody.apiTags: _tagsList.value,
                                  ApiRequestBody.apiBlogImageUrl: imgUrl.value,
                                  ApiRequestBody.apiId: widget.blogContent.blogData!.id!
                                },
                              ).then(
                                (value) async {
                                  if (value.statusCode == ServerStatusCodes.addSuccess) {
                                    WarningBar.snackMessage(context,
                                        message: StringManager.updateBlogSuccessTxt, color: ColorManager.greenColor);
                                    await ref.read(blogDataList.notifier).getBlogs();
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  } else {
                                    WarningBar.snackMessage(context,
                                        message: value.data["message"], color: ColorManager.greenColor);
                                    Navigator.pop(context);
                                  }
                                },
                              );
                            } else {
                              // Api to Create new blog
                              ApiServices().postApi(
                                api: "${APIConstants.baseUrl}blog/createBlog",
                                body: {
                                  ApiRequestBody.apiTitle: _titleController.text.trim(),
                                  ApiRequestBody.apiDescription: _descriptionController.text.trim(),
                                  ApiRequestBody.apiCategories: dropdownValue,
                                  ApiRequestBody.apiTags: _tagsList.value,
                                  ApiRequestBody.apiBlogImageUrl: imgUrl.value,
                                  ApiRequestBody.apiUserId: UserPreferences.userId
                                },
                              ).then(
                                (value) async {
                                  if (value.statusCode == ServerStatusCodes.addSuccess) {
                                    _titleController.clear();
                                    _descriptionController.clear();
                                    _tagsList.value.clear();
                                    imgUrl.value = "";
                                    setState(() {});
                                    WarningBar.snackMessage(context,
                                        message: StringManager.addBlogSuccessTxt, color: ColorManager.greenColor);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  } else {
                                    WarningBar.snackMessage(context,
                                        message: value.data["message"], color: ColorManager.greenColor);
                                    Navigator.pop(context);
                                  }
                                },
                              );
                            }
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
