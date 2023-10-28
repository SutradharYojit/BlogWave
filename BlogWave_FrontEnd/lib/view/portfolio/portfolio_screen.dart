import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../model/model.dart';
import '../../resources/resources.dart';
import '../../routes/routes_name.dart';
import '../../services/services.dart';
import '../../widget/widget.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

// Define a function to fetch a list of BloggerPortfolio objects.
  Future<List<BloggerPortfolio>> getBLoggers() async {
    await UserPreferences().getUserInfo(); // Retrieve user information from UserPreferences.
    final List<BloggerPortfolio> bloggersList = []; // Create an empty list to store BloggerPortfolio objects.
    bloggersList.clear(); // Clear the list to ensure it's empty before populating.
    // Make an API request to get all portfolios of a user using the ApiServices class.
    final data = await ApiServices().getApi(
      api: "${APIConstants.baseUrl}Portfolio/getUserAll", // API endpoint URL.
      body: {
        ApiRequestBody.apiUserId: UserPreferences.userId, // Pass the user's ID as a request parameter.
      },
    );
    // Iterate over the data obtained from the API response and convert it into BloggerPortfolio objects.
    for (Map<String, dynamic> i in data) {
      bloggersList.add(BloggerPortfolio.fromJson(i)); // Create BloggerPortfolio objects and add them to the list.
    }
    return bloggersList; // Return the list of BloggerPortfolio objects.
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(title: StringManager.portfolioAppBarTitle),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0.w),
          child: Column(
            children: [
              FutureBuilder(
                future: getBLoggers(), // Define the future function to be executed to fetch blogger portfolios.
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Expanded(child: CircularLoading()); // Display a loading indicator while waiting for data.
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}'); // Display an error message if there's an error.
                  } else {
                    final bloggerData = snapshot.data as List<BloggerPortfolio>; // Retrieve blogger portfolio data.

                    return Expanded(
                      child: ListView.builder(
                        itemCount: bloggerData.length, // Number of items to display in the list.
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              context.push(
                                RoutesName.bloggerProfileScreen, // Navigate to the blogger's profile screen.
                                extra: bloggerData[index], // Pass the blogger's portfolio data as an extra.
                              );
                            },
                            child: Card(
                              elevation: 10,
                              color: ColorManager.whiteColor,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 110.w,
                                    height: 80.h,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10.w),
                                        topLeft: Radius.circular(10.w),
                                      ),
                                      child: CacheImage(
                                        imgUrl: bloggerData[index].profileUrl!, // Display the blogger's profile image.
                                        errorWidget: Icon(
                                          Icons.account_circle_outlined,
                                          size: 78.h,
                                          color: ColorManager.greyColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(11.0.w),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          bloggerData[index].userName!, // Display the blogger's username.
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 2.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                bloggerData[index].email!, // Display the blogger's email.
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
