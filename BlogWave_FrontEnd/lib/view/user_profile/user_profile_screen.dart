import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import '../../model/model.dart';
import '../../resources/resources.dart';
import '../../routes/routes_name.dart';
import '../../services/services.dart';
import '../../widget/widget.dart';
import 'user_profile_provider.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  const UserProfileScreen({super.key});

  @override
  ConsumerState<UserProfileScreen> createState() => _BloggerProfileScreenState();
}

class _BloggerProfileScreenState extends ConsumerState<UserProfileScreen> {
  ValueNotifier<bool> loading = ValueNotifier(true); // to manage the focus

  @override
  void initState() {
    super.initState();
    // fetch user profile information and make lodinf false
    ref.read(userDataList.notifier).getUser().then((value) {
      loading.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(userDataList);
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(title: StringManager.userProfileAppBarTitle),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(15.0.w),
            child: ValueListenableBuilder(
              valueListenable: loading,
              builder: (context, value, child) {
                return value
                    ? const Center(
                        child: SpinKitFoldingCube(
                          color: Colors.black,
                          size: 45,
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipOval(
                                child: SizedBox.fromSize(
                                  size: Size.fromRadius(44.w), // Image radius
                                  child: CacheImage(
                                    imgUrl: userData.first.userData!.profileUrl!,
                                     errorWidget: Icon(
                                       Icons.account_circle_outlined,
                                       size: 78.h,
                                       color: ColorManager.greyColor,
                                     ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10.0.r, top: 14.r),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userData.first.userData!.userName!,
                                      style: TextStyle(fontSize: 15.sp, ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        userData.first.userData!.email!,
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: ColorManager.greyColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.r),
                            child: Text(
                              "Bio",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.r),
                            child: Text(
                              userData.first.userData!.bio!,
                              style: TextStyle(
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(15),
                              onTap: () {
                                context.push(RoutesName.editProfileScreen);
                              },
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading:   Icon(Icons.edit_note_rounded,size: 27.h,),
                                title: const Text("Edit Profile"),
                                trailing: Icon(
                                  Icons.chevron_right_rounded,
                                  size: 25.h,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(15),
                              onTap: () {
                                context.push(RoutesName.userProjectListingScreen);
                              },
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: const Icon(Icons.notes_rounded),
                                title: const Text("Projects"),
                                trailing: Icon(
                                  Icons.chevron_right_rounded,
                                  size: 25.h,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(15),
                              onTap: () {
                                context.push(RoutesName.addBlogScreen, extra: BlogPreferences(blogChoice: false));
                              },
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: const Icon(Icons.add_task),
                                title: const Text("Add Blog"),
                                trailing: Icon(
                                  Icons.chevron_right_rounded,
                                  size: 25.h,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(15),
                              onTap: () {
                                dialogBox(
                                  context,
                                  headLine: "Are you sure, you want to log out?",
                                  onPressed: () {
                                    // Logout function
                                    UserPreferences().logOutsetData(context);
                                  },
                                  button: "Log out",
                                );
                              },
                              child: const ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Icon(
                                  Icons.logout_rounded,
                                  color: ColorManager.redColor,
                                ),
                                title: Text(
                                  "LogOut",
                                  style: TextStyle(color: ColorManager.redColor),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}
