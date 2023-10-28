import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../resources/resources.dart';
import '../../../routes/routes_name.dart';
import '../../../services/services.dart';
import '../../../widget/widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final userPreferences = UserPreferences(); //class is user to store data locally
  final _formKey = GlobalKey<FormState>(); // its used to validate the textFilled form


  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus(); // To remove on the text filled
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 15.w, right: 15.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        IconAssets.appIcon,
                        height: 80.h,
                        color: ColorManager.gradientDarkTealColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Text(
                          StringManager.appTitle,
                          style: TextStyle(
                            fontSize: 34.sp,
                            fontFamily: "DancingScript",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 12.r),
                        child: Text(
                          StringManager.loginTitle,
                          style: TextStyle(fontSize: 15.sp),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15.r),
                        child: PrimaryTextFilled(
                          controller: _emailController,
                          hintText: StringManager.emailHintTxt,
                          labelText: StringManager.emailLabelTxt,
                          prefixIcon: const Icon(
                            Icons.mail_rounded,
                            color: ColorManager.tealColor,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return StringManager.emailHintTxt;
                            }
                             if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(p0)){
                              return StringManager.correctEmailTxt;
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 12.0.sp),
                        child: PrimaryPassField(
                          textPassCtrl: _passController,
                          hintText: StringManager.passHintTxt,
                          labelText: StringManager.passLabelTxt,
                          prefixIcon: const Icon(
                            Icons.password_rounded,
                            color: ColorManager.tealColor,
                          ),
                          validator: (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return StringManager.passHintTxt;
                            }
                            return null;
                          },
                        ),
                      ),
                      PrimaryButton(
                        title: StringManager.loginText,
                        onTap: () async {
                          // get success after validation is  correct
                          if (_formKey.currentState!.validate()) {
                            loading(context);
                            // Login API
                             ApiServices().postApi(
                              api: "${APIConstants.baseUrl}user/login", // API endpoint URL.
                               // pass the API arguments
                              body: {
                                ApiRequestBody.apiEmail: _emailController.text.trim(),
                                ApiRequestBody.apiPassword: _passController.text.trim(),
                              },
                            ).then(
                                  (value) {
                                    if(value.statusCode==ServerStatusCodes.unAuthorised){
                                      Navigator.pop(context);// pop loading screen
                                      // toast snackBar message of invalid credentials
                                      WarningBar.snackMessage(context,
                                          message: StringManager.invalidCredentialsTxt, color: ColorManager.redColor);
                                    }
                                    else{
                                      // store user token , and userId , logged in bool value
                                      userPreferences.saveLoginUserInfo(
                                        value.data["token"],
                                        value.data["success"],
                                        value.data["userId"],
                                      );
                                      // Navigate to dashboard
                                      context.go(RoutesName.dashboardScreen);
                                    }
                              },
                            );
                          }
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 12.0.r),
                        child: GestureDetector(
                          onTap: () {
                            context.goNamed(RoutesName.signupName); // navigate to the signup screen
                          },
                          child:   TextRich(
                            firstText: StringManager.noAccountTxt,
                            secText: StringManager.signUpText,
                            style1: TextStyle(color: ColorManager.tealColor, fontSize: 14.sp),
                            style2: TextStyle(
                              color: ColorManager.grey800Color,
                              fontSize: 14.sp,

                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
