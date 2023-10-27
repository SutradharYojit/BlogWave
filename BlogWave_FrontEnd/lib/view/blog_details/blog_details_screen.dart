import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../model/model.dart';
import '../../resources/resources.dart';
import '../../services/utils.dart';
import '../../widget/widget.dart';
import '../view.dart';

class BlogDetailsScreen extends StatelessWidget {
  const BlogDetailsScreen({super.key, required this.blogData});

  final BlogDataModel blogData;
  final String markdownData = """
  # Flutter Markdown Example

    This is an example of using Markdown in a Flutter app.

    ## Formatting

    - *Italic*
    - **Bold**
    - `Code`

    ## Lists

    1. First item
    2. Second item
    3. Third item

    ## Links

    [OpenAI](https://www.openai.com)

    ## Images

    ![Flutter Logo](https://flutter.dev/assets/homepage/logo/flutter-lockup-cqf-98ccdf76af1df69a4d609a73e12f44e06b874974b8eaf6fbb7e72b86553682ca0.png)
    """;

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
               padding:   EdgeInsets.all(15.w),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,

                 children: [
                    Padding(
                      padding: const EdgeInsets.only( top:5),
                      child: Text(
                        "Published : ${Utils.formatDate(blogData.createdAt!)}",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: ColorManager.greyColor
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        blogData.title!,
                        style: TextStyle(
                          fontSize: 25.sp,
                          color: ColorManager.gradientDarkTealColor
                        ),
                      ),
                    ),
                  ],
               ),
             ),

              Container(
                constraints: BoxConstraints(
                  minHeight: 250.h,
                ),
                child: FadeInImage(
                  width: double.infinity,
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(
                    blogData.blogImgUrl!,
                  ),
                  fit: BoxFit.cover,
                  height: 200,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
