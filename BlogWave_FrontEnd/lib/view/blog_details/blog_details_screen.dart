import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/model.dart';
import '../../resources/resources.dart';
import '../../services/utils.dart';
import '../../widget/widget.dart';
import '../view.dart';

class BlogDetailsScreen extends StatelessWidget {
  const BlogDetailsScreen({super.key, required this.blogData});

  final BlogDataModel blogData; //Get the blog data from blog Listing screen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          blogData.title!,
          style: TextStyle(fontSize: 17.sp),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        "Published : ${Utils.formatDate(blogData.createdAt!)}",
                        style: TextStyle(fontSize: 14.sp, color: ColorManager.greyColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        blogData.title!,
                        style: TextStyle(fontSize: 25.sp, color: ColorManager.gradientDarkTealColor),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                constraints: BoxConstraints(
                  minHeight: 250.h,
                ),
                // refactor widget of cache Network Images load blog image on error return default blank image
                child: CacheImage(
                  imgUrl: blogData.blogImgUrl!,
                  errorWidget: Center(child: Image.asset(ImageAssets.noImg)),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Listing the Blog Tags
                    Padding(
                      padding: EdgeInsets.only(top: 10.r),
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 1,
                          childAspectRatio: 2.5,
                        ),
                        itemCount: blogData.tags!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: SizedBox(
                                width: 100,
                                child: Center(
                                    child: Text(
                                  "# ${blogData.tags![index]}",
                                  style: TextStyle(fontSize: 12.sp),
                                )),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        blogData.categories!,
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    Divider(
                      height: 18.h,
                      thickness: 1.5,
                      color: ColorManager.greyColor,
                    ),
                    SizedBox(
                      height: 500,
                      // MardDown widget helps to read the text of .md file (rich text formatting)
                      child: Markdown(
                        data: blogData.description!,
                        styleSheet: MarkdownStyleSheet(
                          h1: const TextStyle(fontSize: 25),
                          h2: const TextStyle(fontSize: 20),
                          a: const TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorManager.rgbWhiteColor,
        onPressed: () {
          // bottom Sheet to open comment Screen on blog Post
          buildShowModalBottomSheet(
            context,
            widget: CommentScreen(blogId: blogData.id!),
          );
        },
        child: Image.asset(IconAssets.commentIcon, height: 25.h),
      ),
    );
  }
}
