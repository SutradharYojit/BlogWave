import 'package:blogwave_frontend/routes/routes_name.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../model/model.dart';
import '../../resources/resources.dart';
import '../../services/services.dart';
import '../../widget/widget.dart';

class BloggerProfileScreen extends StatelessWidget {
  const BloggerProfileScreen({super.key, required this.bloggerPortfolio});

  final BloggerPortfolio bloggerPortfolio;

  Future<List<ProjectModel>> getProjects() async {
    final List<ProjectModel> projectList = [];
    projectList.clear();
    final data = await ApiServices().getApi(
      api: "${APIConstants.baseUrl}Project/userProjects",
      body: {
        "id": bloggerPortfolio.id,
      },
    );
    for (Map<String, dynamic> i in data) {
      projectList.add(ProjectModel.fromJson(i));
    }
    return projectList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(title: bloggerPortfolio.userName!),
        leadingWidth: 40,
        titleSpacing: 1,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: TextButton(
              onPressed: () {
                context.push(RoutesName.bloggerContactScreen,
                    extra: SendBlogMes(
                      bloggerMail: bloggerPortfolio.email!,
                      bloggerName: bloggerPortfolio.userName!,
                    ));
              },
              child: Text(
                "Contact",
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipOval(
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(44.w), // Image radius
                      child: CachedNetworkImage(
                        imageUrl: bloggerPortfolio.profileUrl!,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                            value: downloadProgress.progress,
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(
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
                          bloggerPortfolio.userName!,
                          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            bloggerPortfolio.email!,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: ColorManager.greyColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.r),
                child: Text(
                  "Bio",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.r),
                child: Text(
                  bloggerPortfolio.bio ?? "",
                  style: TextStyle(
                    fontSize: 13.sp,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.r),
                child: Text(
                  "Projects",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              FutureBuilder(
                future: getProjects(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final projectData = snapshot.data as List<ProjectModel>;
                    return projectData.isEmpty
                        ? Center(
                            child: Column(
                              children: [
                                Image.asset(
                                  IconAssets.emptyProjectIcon,
                                  height: 60.h,
                                ),
                                const Text(StringManager.emptyProjectTxt)
                              ],
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount: projectData.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    onTap: () {
                                      context.push(
                                        RoutesName.projectDetailsScreen,
                                        extra: ProjectDetailsModel(
                                          currentUserId: UserPreferences.userId!,
                                          projectData: projectData[index],
                                        ),
                                      );
                                    },
                                    title: Row(
                                      children: [
                                        Image.asset(
                                          IconAssets.tagIcon,
                                          height: 15.h,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 5.0),
                                          child: Container(
                                            constraints: BoxConstraints( maxWidth: 200.w),
                                            child: Text(
                                              ":${projectData[index].title}",
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    subtitle: Row(
                                      children: [
                                        Image.asset(
                                          IconAssets.linkIcon,
                                          height: 15.h,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 5.0),
                                          child: Container(
                                            constraints: BoxConstraints( maxWidth: 200.w),
                                            child: Text(
                                              ":${projectData[index].projectUrl}",
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: ColorManager.blurColor,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                                decoration: TextDecoration.underline,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    trailing: Icon(
                                      Icons.chevron_right_rounded,
                                      size: 25.h,
                                    ),
                                  )
                                );
                              },
                            ),
                          );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SendBlogMes {
  final String bloggerMail;
  final String bloggerName;

  SendBlogMes({
    required this.bloggerMail,
    required this.bloggerName,
  });
}
