import 'dart:developer';
import 'package:blogwave_frontend/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../model/model.dart';
import '../../resources/resources.dart';
import '../../services/services.dart';
import '../../widget/widget.dart';
import '../view.dart';

class ProjectDetailsScreen extends StatelessWidget {
  ProjectDetailsScreen({
    super.key,
    required this.projectDetails,
  });

  final ProjectDetailsModel projectDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Project Detail"),
        actions: [
          Visibility(
            visible: UserPreferences.userId == projectDetails.projectData.userId!,
            child: IconButton(
              onPressed: () {
                context.push(
                  RoutesName.addProjectScreen,
                  extra: EditProject(
                    projectDetailsScreen: true,
                    projectData: projectDetails.projectData,
                  ),
                );
              },
              icon: const Icon(Icons.edit),
            ),
          ),
          Visibility(
            visible: UserPreferences.userId == projectDetails.projectData.userId!,
            child: IconButton(
              onPressed: () {
                dialogBox(
                  context,
                  headLine: "Are you sure, you want to delete this project?",
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const Center(child: Loading());
                        });
                    ApiServices().deleteApi(
                      api: "${APIConstants.baseUrl}Project/deleteProject",
                      body: {
                        "id": projectDetails.projectData.id!,
                      },
                    ).then(
                      (value) {
                        WarningBar.snackMessage(context, message: StringManager.updateProjectSuccessTxt, color: ColorManager.greenColor);
                        Navigator.pop(context); // for Project Details
                        Navigator.pop(context); // For Loading
                        Navigator.pop(context); // for Project Details
                      },
                    );
                  },
                  button: "Yes",
                );
              },
              icon: const Icon(Icons.delete_outline_rounded),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProjectDetailCard(
                headline: "Title",
                body: Text(projectDetails.projectData.title!),
              ),
              ProjectDetailCard(
                headline: "Description",
                body: Text(projectDetails.projectData.description!),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.r),
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(8.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Technologies",
                          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 2.r),
                          child: ListView.builder(
                            itemCount: projectDetails.projectData.technologies!.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.only(top: 2),
                                child: Text("${index + 1}. ${projectDetails.projectData.technologies![index]}"),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  log("web View");
                  context.push(
                    RoutesName.webViewScreen,
                    extra: WebViewData(
                      title: projectDetails.projectData.title!,
                      url: projectDetails.projectData.projectUrl!,
                    ),
                  );
                },
                child: ProjectDetailCard(
                  headline: "Project URL",
                  body: Row(
                    children: [
                      Image.asset(
                        IconAssets.linkIcon,
                        height: 15.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Container(
                          constraints: BoxConstraints( maxWidth: 250.w),
                          child: Text(
                            projectDetails.projectData.projectUrl!,
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
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProjectDetailCard extends StatelessWidget {
  const ProjectDetailCard({
    super.key,
    required this.headline,
    required this.body,
  });

  final String headline;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.r),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(),
              Text(
                headline,
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
              ),
              Padding(padding: EdgeInsets.only(top: 4.r), child: body)
            ],
          ),
        ),
      ),
    );
  }
}
