import 'dart:developer';
import 'package:blogwave_frontend/services/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../model/model.dart';
import '../../resources/resources.dart';
import '../../routes/routes_name.dart';
import '../../services/services.dart';
import '../../widget/widget.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key, required this.blogId});

  // getting the blog ID to display the comment on the specific blogs
  final String blogId;

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
// Create a TextEditingController to manage the text input for comments.
  final TextEditingController _commentCtrl = TextEditingController();

// Create a ValueNotifier to hold and notify changes in the list of CommentModel objects.
  ValueNotifier<List<CommentModel>> commentData = ValueNotifier([]);

// Define a function to fetch a list of CommentModel objects.
  Future<List<CommentModel>> getComments() async {
    final List<CommentModel> bloggersList = []; // Create an empty list to store CommentModel objects.

    bloggersList.clear(); // Clear the list to ensure it's empty before populating.

    // Make an API request to get comments for a specific blog using the ApiServices class.
    final data = await ApiServices().getApi(
      api: "${APIConstants.baseUrl}comment/getComment", // API endpoint URL.
      body: {ApiRequestBody.apiBlogId: widget.blogId}, // Pass the blog ID as a request parameter.
    );

    // Iterate over the data obtained from the API response and convert it into CommentModel objects.
    for (Map<String, dynamic> i in data) {
      bloggersList.add(CommentModel.fromJson(i)); // Create CommentModel objects and add them to the list.
    }
    return bloggersList; // Return the list of CommentModel objects.
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(StringManager.commentAppBarTitle),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            children: [
              FutureBuilder(
                future: getComments(), // Define the future function to be executed to fetch comments.
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularLoading(); // Display a loading indicator while waiting for data.
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}'); // Display an error message if there's an error.
                  } else {
                    commentData.value = snapshot.data as List<CommentModel>; // Set the comment data using the snapshot data.

                    return ValueListenableBuilder(
                      valueListenable: commentData,
                      builder: (context, value, child) {
                        return value.isEmpty
                            ? Expanded(
                          child: Center(
                            child: Text(
                              StringManager.noCommentsTxt, // Display a message for no comments.
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                            : Expanded(
                          child: ListView.builder(
                            itemCount: value.length, // Number of items to display in the list.
                            itemBuilder: (context, index) {
                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: () {
                                    context.push(
                                      RoutesName.bloggerProfileScreen, // Navigate to the blogger's profile screen.
                                      extra: value[index].user, // Pass the blogger's user data as an extra.
                                    );
                                  },
                                  child: ClipOval(
                                    child: SizedBox.fromSize(
                                      size: Size.fromRadius(25.w), // Set the image radius.
                                      child: CachedNetworkImage(
                                        imageUrl: value[index].user!.profileUrl!, // Display the blogger's profile image.
                                        fit: BoxFit.cover,
                                        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                                          child: CircularProgressIndicator(
                                            value: downloadProgress.progress,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) => Image.asset(ImageAssets.blankProfileImg),
                                      ),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  value[index].user!.userName!, // Display the blogger's username.
                                  style: const TextStyle(fontWeight: FontWeight.w600),
                                ),
                                subtitle: Text(
                                  value[index].comment!, // Display the comment.
                                  style: TextStyle(
                                    color: ColorManager.grey800Color,
                                  ),
                                ),
                                trailing: Text(Utils.formatDate(value[index].createdAt!)), // Display the comment's creation date.
                              );
                            },
                          ),
                        );
                      },
                    );
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 15.0.w),
                child: Row(
                  children: [
                    Expanded(
                      child: PrimaryTextFilled(
                        controller: _commentCtrl,
                        hintText: StringManager.commentHintTxt,
                        labelText: StringManager.commentLabelTxt,
                        textCapitalization: TextCapitalization.sentences,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset(
                            IconAssets.commentIcon,
                            height: 0.h,
                          ),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            // Make an API POST request to add a new comment.
                            ApiServices().postApi(
                              api: "${APIConstants.baseUrl}comment/addComment", // The API endpoint URL for adding a comment.
                              body: {
                                ApiRequestBody.apiDescription: _commentCtrl.text.trim(), // Trimmed comment text.
                                ApiRequestBody.apiBlogId: widget.blogId, // Pass the blog ID as a request parameter.
                                ApiRequestBody.apiUserId: UserPreferences.userId, // Pass the user's ID as a request parameter.
                              },
                            ).then(
                                  (data) {
                                if (data.statusCode == ServerStatusCodes.addSuccess) {
                                  _commentCtrl.clear(); // Clear the comment input field.
                                  setState(() {}); // Trigger a UI update to reflect the new comment.
                                } else {
                                  // Show a warning message in a snack bar in case of an error.
                                  WarningBar.snackMessage(context,
                                      message:  StringManager.wentWrongTxt, color: ColorManager.greenColor);
                                  Navigator.pop(context); // Close the current screen in case of an error.
                                }
                              },
                            );

                          },
                          icon: CircleAvatar(
                            backgroundColor: ColorManager.rgbWhiteColor,
                            radius: 25,
                            child: Image.asset(IconAssets.sendIcon, height: 20.h),
                          ),
                        ),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
