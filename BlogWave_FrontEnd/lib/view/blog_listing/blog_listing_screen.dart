import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../model/model.dart';
import '../../resources/resources.dart';
import '../../routes/routes_name.dart';
import '../../services/services.dart';
import '../../widget/widget.dart';
import 'blog_listing_provider.dart';

enum EditAuth {
  edit,
  delete,
}

class BlogListingScreen extends ConsumerStatefulWidget {
  const BlogListingScreen({super.key});

  @override
  ConsumerState<BlogListingScreen> createState() => _BlogListingScreenState();
}

class _BlogListingScreenState extends ConsumerState<BlogListingScreen> with SingleTickerProviderStateMixin {
  EditAuth? selectedItem;
  final ScrollController _scrollController = ScrollController();
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 700),
  );
  late final Animation<Offset> position = Tween<Offset>(
    begin: const Offset(10, 0),
    end: const Offset(0, 0),
  ).animate(
    CurvedAnimation(parent: _animationController, curve: Curves.linear),
  );

  Future<void> getData() async {
    await ref.read(blogDataList.notifier).getBlogs();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 1000) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
    getData();
  }

  String formatDate(String date) {
    // date = '2021-01-26T03:17:00.000000Z';
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MM/dd/yyyy');
    var outputDate = outputFormat.format(inputDate);
    print(outputDate);
    return outputDate;
  }

  @override
  Widget build(BuildContext context) {
    final blogList = ref.watch(blogDataList);
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(title: StringManager.blogsAppBarTitle),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.0.w),
          child: RefreshIndicator(
            onRefresh: ref.read(blogDataList.notifier).getBlogs,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.only(bottom: 15.w),
                        itemCount: blogList.length,
                        controller: _scrollController,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              context.push(RoutesName.blogDetailsScreen, extra: blogList[index]);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Card(
                                  color: Colors.white,
                                  elevation: 5,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 15),
                                              child: Text(
                                                formatDate(blogList[index].createdAt!),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: ColorManager.greyColor,
                                                ),
                                              ),
                                            ),
                                            Visibility(
                                              visible: UserPreferences.userId == blogList[index].userId,
                                              // When edit update functionality is enabled when the authorId and CurrentUser Id will be match
                                              child: PopupMenuButton(
                                                initialValue: selectedItem,
                                                onSelected: (EditAuth item) {
                                                  if (item == EditAuth.edit) {
                                                    context.push(
                                                      RoutesName.addBlogScreen,
                                                      //pass the blag data to add blog screen
                                                      extra: BlogPreferences(
                                                        blogChoice: true,
                                                        blogData: blogList[index],
                                                      ),
                                                    );
                                                  } else {
                                                    dialogBox(
                                                      context,
                                                      headLine: "Are you sure, you want to delete Blog?",
                                                      onPressed: () {
                                                        ref
                                                            .read(blogDataList.notifier)
                                                            .blogDelete(blogList[index].id!, index);
                                                        buildShowToast(toastMessage: "Blog deleted Successfully");
                                                        Navigator.pop(context);
                                                      },
                                                      button: "Delete",
                                                    );
                                                    // function to delete the blog

                                                  }
                                                },
                                                itemBuilder: (BuildContext context) => <PopupMenuEntry<EditAuth>>[
                                                  const PopupMenuItem(
                                                    value: EditAuth.edit,
                                                    child: PopMenuBtn(
                                                      title: StringManager.editTxt,
                                                      icon: Icons.edit,
                                                    ),
                                                  ),
                                                  const PopupMenuItem(
                                                    value: EditAuth.delete,
                                                    child: PopMenuBtn(
                                                      title: StringManager.deleteTxt,
                                                      icon: Icons.delete_outline_rounded,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(12.w),
                                          child: CacheImage(
                                            imgUrl: blogList[index].blogImgUrl!,
                                            errorWidget: Center(
                                              child: Image.asset(
                                                IconAssets.blankImgIcon,
                                                height: 60.h,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical: 7.w),
                                          child: Text(
                                            blogList[index].title!,
                                            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w800),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      //scroll animation

                      Positioned(
                        bottom: 15.h,
                        right: 0.h,
                        child: UpAnimation(position: position, scrollController: _scrollController),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
