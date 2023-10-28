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

// enum class for pop menu items
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
  final ScrollController _scrollController = ScrollController(); // Create a ScrollController to manage scrolling in the widget.
  late final AnimationController _animationController = AnimationController(
    vsync: this, // Synchronize the animation with the widget's lifecycle.
    duration: const Duration(milliseconds: 700), // Set the duration for the animation.
  );
  late final Animation<Offset> position = Tween<Offset>(
    begin: const Offset(10, 0), // Define the starting position for the animation.
    end: const Offset(0, 0), // Define the ending position for the animation.
  ).animate(
    CurvedAnimation(parent: _animationController, curve: Curves.linear), // Create a curved animation.
  );

  Future<void> getData() async {
    await ref.read(blogDataList.notifier).getBlogs(); // Fetch data for the widget asynchronously.
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 1000) {
        _animationController.forward(); // Start the animation when scrolling position is over 1000.
      } else {
        _animationController.reverse(); // Reverse the animation when scrolling position is less than or equal to 1000.
      }
    });
    getData(); // Call the asynchronous function to load data when the widget is initialized.
  }

  String formatDate(String date) {
    // date = '2021-01-26T03:17:00.000000Z';
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date); // Parse the input date string.
    var inputDate = DateTime.parse(parseDate.toString()); // Convert parsed date to DateTime object.
    var outputFormat = DateFormat('MM/dd/yyyy'); // Define the desired output date format.
    var outputDate = outputFormat.format(inputDate); // Format the date in the desired output format.
    print(outputDate); // Print the formatted date to the console.
    return outputDate; // Return the formatted date as a string.
  }
  @override
  Widget build(BuildContext context) {
    final blogList = ref.watch(blogDataList); // data of the blog list
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(title: StringManager.blogsAppBarTitle),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.0.w),
          // widget to pull and refresh the screen
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
                                                formatDate(blogList[index].createdAt!), //date parsing function
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: ColorManager.greyColor,
                                                ),
                                              ),
                                            ),
                                            Visibility(
                                              visible: UserPreferences.userId == blogList[index].userId,
                                              // When edit update functionality is enabled when the authorId and CurrentUser Id will be match i.e only the author can edit or delete the blog
                                              child: PopupMenuButton(
                                                initialValue: selectedItem,
                                                onSelected: (EditAuth item) {
                                                  if (item == EditAuth.edit) {
                                                    //pass the blag data to add blog screen so author can edit the blogs
                                                    context.push(
                                                      RoutesName.addBlogScreen,
                                                      extra: BlogPreferences(
                                                        blogChoice: true,
                                                        blogData: blogList[index],
                                                      ),
                                                    );
                                                  } else {
                                                    dialogBox(
                                                      context,
                                                      headLine: StringManager.deleteBLogHeadLineTxt,
                                                      onPressed: () {
                                                        // function to delete the blog
                                                        ref
                                                            .read(blogDataList.notifier)
                                                            .blogDelete(blogList[index].id!, index);
                                                        buildShowToast(toastMessage:StringManager.deleteBLogSuccessTxt );
                                                        Navigator.pop(context);
                                                      },
                                                      button:StringManager.deleteTxt ,
                                                    );

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
                                            style: TextStyle(fontSize: 15.sp),
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
                      Positioned(
                        // Up scroll animation
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
