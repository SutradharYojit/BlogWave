import 'dart:developer';
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

  final String blogId;

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentCtrl = TextEditingController();

  ValueNotifier<List<CommentModel>> commentData = ValueNotifier([]);

  Future<List<CommentModel>> getComments() async {
    final List<CommentModel> bloggersList = [];
    bloggersList.clear();
    final data = await ApiServices().getApi(
      api: "${APIConstants.baseUrl}comment/getComment",
      body: {"blogId": widget.blogId},
    );
    for (Map<String, dynamic> i in data) {
      bloggersList.add(CommentModel.fromJson(i));
    }
    return bloggersList;
  }
  String formatDate(String date) {
    DateTime parseDate = new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MM/dd/yyyy');
    var outputDate = outputFormat.format(inputDate);
    print(outputDate);
    return outputDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Comments"),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            children: [
              FutureBuilder(
                future: getComments(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularLoading();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    commentData.value = snapshot.data as List<CommentModel>;
                    return ValueListenableBuilder(
                      valueListenable: commentData,
                      builder: (context, value, child) {
                        return value.isEmpty
                            ? Expanded(
                                child: Center(
                                  child: Text(
                                    "No Comments",
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  itemCount: value.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(

                                      contentPadding: EdgeInsets.zero,
                                      leading: InkWell(
                                        borderRadius: BorderRadius.circular(10),
                                        onTap: () {
                                          context.push(
                                            RoutesName.bloggerProfileScreen,
                                            extra: value[index].user,
                                          );
                                        },
                                        child: ClipOval(
                                          child: SizedBox.fromSize(
                                            size: Size.fromRadius(25.w), // Image radius
                                            child: CachedNetworkImage(
                                              imageUrl: value[index].user!.profileUrl!,
                                              fit: BoxFit.cover,
                                              progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                                                child: CircularProgressIndicator(
                                                  value: downloadProgress.progress,
                                                ),
                                              ),
                                              errorWidget: (context, url, error) =>
                                                  Image.asset(ImageAssets.blankProfileImg),
                                            ),
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        value[index].user!.userName!,
                                        style: const TextStyle(fontWeight: FontWeight.w600),
                                      ),
                                      subtitle: Text(
                                        value[index].comment!,
                                        style: TextStyle(
                                          color: ColorManager.grey800Color,
                                        ),
                                      ),
                                      trailing: Text(formatDate(value[index].createdAt!)),
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
                            ApiServices().postApi(
                              api: "${APIConstants.baseUrl}comment/addComment",
                              body: {
                                "description": _commentCtrl.text.trim(),
                                "blogId": widget.blogId,
                                "userId": UserPreferences.userId
                              },
                            ).then(
                              (data) {
                                log(data.toString());
                                // commentData.value.insert(0, CommentModel.fromJson(data));
                                _commentCtrl.clear();
                                setState(() {});
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
