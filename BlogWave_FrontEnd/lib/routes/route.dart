import 'package:go_router/go_router.dart';
import '../model/model.dart';
import '../view/view.dart';
import 'routes_name.dart';

GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: RoutesName.splashScreen,
      builder: (context, state) {
        return const SplashScreen();
      },
    ),
    // its Routes defines to reduce the stack of screen in login and signup screen
    GoRoute(
      path: RoutesName.loginScreen,
      builder: (context, state) {
        return const LoginScreen();
      },
      routes: [
        GoRoute(
          name: RoutesName.signupName,
          path: RoutesName.signupScreen,
          builder: (context, state) {
            return const SignUpScreen();
          },
        ),
      ],
    ),
    GoRoute(
      path: RoutesName.dashboardScreen,
      builder: (context, state) {
        return DashboardScreen();
      },
    ),
    GoRoute(
      path: RoutesName.editProfileScreen,
      builder: (context, state) {
        return const EditProfileScreen();
      },
    ),
    GoRoute(
      path: RoutesName.userProjectListingScreen,
      builder: (context, state) {
        return const UserProjectListing();
      },
    ),
    GoRoute(
      path: RoutesName.addProjectScreen,
      builder: (context, state) {
        return AddProject(
          editProject: state.extra as EditProject,
        );
      },
    ),
    GoRoute(
      path: RoutesName.projectDetailsScreen,
      builder: (context, state) {
        return ProjectDetailsScreen(
          projectDetails: state.extra as ProjectDetailsModel,
        );
      },
    ),
    GoRoute(
      path: RoutesName.webViewScreen,
      builder: (context, state) {
        return WebView(
          webView: state.extra as WebViewData,
        );
      },
    ),
    GoRoute(
      path: RoutesName.bloggerProfileScreen,
      builder: (context, state) {
        return BloggerProfileScreen(
          bloggerPortfolio: state.extra as BloggerPortfolio,
        );
      },
    ),
    GoRoute(
      path: RoutesName.addBlogScreen,
      builder: (context, state) {
        return AddBlogScreen(blogContent:  state.extra as BlogPreferences,);
      },
    ),
    GoRoute(
      path: RoutesName.blogDetailsScreen,
      builder: (context, state) {
        return BlogDetailsScreen(
          blogData: state.extra as BlogDataModel,
        );
      },
    ),
    GoRoute(
      path: RoutesName.bloggerContactScreen,
      builder: (context, state) {
        return BloggerContactScreen(
          message: state.extra as SendBlogMes,
        );
      },
    ),
  ],
);
