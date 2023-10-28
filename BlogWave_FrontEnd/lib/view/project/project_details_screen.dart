import 'package:blogwave_frontend/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../model/model.dart';
import '../../resources/resources.dart';
import '../../services/services.dart';
import '../../widget/project_list_tile.dart';
import '../../widget/widget.dart';
import '../view.dart';

class ProjectDetailsScreen extends StatelessWidget {
  const ProjectDetailsScreen({
    super.key,
    required this.projectDetails,
  });

  // Data class to helps to get the project details
  final ProjectDetailsModel projectDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringManager.projectDetailsAppBarTitle),
        actions: [
          Visibility(
            // Show the edit button only if the current user's ID matches the project owner's ID.
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
              icon: const Icon(Icons.edit), // Display an edit icon.
            ),
          ),
          Visibility(
            // Show the delete button only if the current user's ID matches the project owner's ID.
            visible: UserPreferences.userId == projectDetails.projectData.userId!,
            child: IconButton(
              onPressed: () {
                dialogBox(
                  context,
                  headLine: StringManager.deleteProjectHeadLineTxt,
                  onPressed: () {
                    loading(context); // Display a loading indicator.

                    // Make an API request to delete the project.
                    ApiServices().deleteApi(
                      api: "${APIConstants.baseUrl}Project/deleteProject", // API endpoint for deleting a project.
                      body: {
                        ApiRequestBody.apiId: projectDetails.projectData.id!, // Pass the project's ID for deletion.
                      },
                    ).then(
                          (value) {
                        WarningBar.snackMessage(context, message: StringManager.deleteProjectSuccessTxt, color: ColorManager.greenColor);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    );
                  },
                  button: "Yes",
                );
              },
              icon: const Icon(Icons.delete_outline_rounded), // Display a delete icon.
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
                headline:StringManager.titleTxt,
                body: Text(projectDetails.projectData.title!),
              ),
              ProjectDetailCard(
                headline: StringManager.descTxt,
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
                          StringManager.techTxt,
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
                  context.push(
                    RoutesName.webViewScreen, // Navigate to the WebViewScreen.
                    extra: WebViewData(
                      title: projectDetails.projectData.title!, // Set the title for the web view screen.
                      url: projectDetails.projectData.projectUrl!, // Set the URL to be displayed in the web view.
                    ),
                  );

                },
                child: ProjectDetailCard(
                  headline: StringManager.projectUrlTxt,
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


