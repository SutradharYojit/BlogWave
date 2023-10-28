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

  final BloggerPortfolio bloggerPortfolio; // data class  helps to get the data of blogger

// Define a function to fetch a list of ProjectModel objects.
  Future<List<ProjectModel>> getProjects() async {
    final List<ProjectModel> projectList = []; // Create an empty list to store ProjectModel objects.
    projectList.clear(); // Clear the list to ensure it's empty before populating.
    // Make an API request to get user projects using the ApiServices class.
    final data = await ApiServices().getApi(
      api: "${APIConstants.baseUrl}Project/userProjects", // API endpoint URL.
      body: {
        ApiRequestBody.apiId: bloggerPortfolio.id, // Pass the user's ID as a request parameter.
      },
    );
    // Iterate over the data obtained from the API response and convert it into ProjectModel objects.
    for (Map<String, dynamic> i in data) {
      projectList.add(ProjectModel.fromJson(i)); // Create ProjectModel objects and add them to the list.
    }
    return projectList; // Return the list of ProjectModel objects.
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
                // Sending the blogger email and username to contact screen, then send the mail to blogger
                context.push(
                  RoutesName.bloggerContactScreen,
                  extra: SendBlogMes(
                    bloggerMail: bloggerPortfolio.email!,
                    bloggerName: bloggerPortfolio.userName!,
                  ),
                );
              },
              child: Text(
                StringManager.contactTxt,
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
                        imageUrl: bloggerPortfolio.profileUrl!, // The URL of the image to be loaded.
                        fit: BoxFit.cover, // How the image should fit within its container.
                        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                            value: downloadProgress.progress, // Show a progress indicator while the image is loading.
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(
                          Icons.account_circle_outlined, // Display an outlined account circle icon if there's an error.
                          size: 78.h, // Set the size of the error icon.
                          color: ColorManager.greyColor, // Define the color of the error icon.
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
                  StringManager.bioTxt,
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
                  StringManager.projectTxt,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              FutureBuilder(
                future: getProjects(), // Define the future function to be executed.
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator()); // Display a loading indicator while waiting for data.
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}'); // Display an error message if there's an error.
                  } else {
                    final projectData = snapshot.data as List<ProjectModel>; // Retrieve the data from the snapshot.

                    return projectData.isEmpty
                        ? Center(
                      child: Column(
                        children: [
                          Image.asset(
                            IconAssets.emptyProjectIcon,
                            height: 60.h,
                          ),
                          const Text(StringManager.emptyProjectTxt) // Show a message for empty project data.
                        ],
                      ),
                    )
                        : Expanded(
                      child: ListView.builder(
                        itemCount: projectData.length, // Number of items to display in the list.
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              onTap: () {
                                context.push(
                                  RoutesName.projectDetailsScreen, // Navigate to the project details screen.
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
                                      constraints: BoxConstraints(maxWidth: 200.w),
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
                                      constraints: BoxConstraints(maxWidth: 200.w),
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
                            ),
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

// Data class help to send the data of the blogger contact Screen
class SendBlogMes {
  final String bloggerMail;
  final String bloggerName;

  SendBlogMes({
    required this.bloggerMail,
    required this.bloggerName,
  });
}
