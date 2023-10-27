import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../resources/resources.dart';
import '../../../routes/routes_name.dart';
import '../../../services/services.dart';
import '../../../widget/widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}


class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final userPreferences = UserPreferences();

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
        WidgetsBinding.instance.focusManager.primaryFocus
            ?.unfocus(); // unfocus the text field on tapping gesture deatector
      },
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      IconAssets.appIcon,
                      height: 80.h,
                      color: ColorManager.gradientDarkTealColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
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
                        StringManager.signUpText,
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.r),
                      child: PrimaryTextFilled(
                        controller: _userController,
                        hintText: StringManager.userHintTxt,
                        labelText: StringManager.userLabelTxt,
                        prefixIcon: const Icon(
                          Icons.text_format,
                          color: ColorManager.tealColor,
                        ),
                        keyboardType: TextInputType.emailAddress,
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
                      ),
                    ),
                    PrimaryButton(
                      title: StringManager.signUpText,
                      onTap: () async {
                        if (_emailController.text.trim() == "" ||
                            _emailController.text.trim().isEmpty ||
                            _passController.text.trim() == "" ||
                            _passController.text.trim().isEmpty) {
                          WarningBar.snackMessage(context, message: StringManager.requiredWarningTxt, color: ColorManager.redColor);
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const Center(child: Loading());
                              });
                          await ApiServices().postApi(
                            api: "http://10.200.147.245:1234/user/signUp",
                            body: {
                              "userName": _userController.text.trim(),
                              "email": _emailController.text.trim(),
                              "password": _passController.text.trim(),
                            },
                          ).then(
                            (value) {
                              log("Success");
                              log(value.toString());
                              if(value["success"]){
                                userPreferences.saveLoginUserInfo(
                                    value["token"],
                                    value["success"],
                                    value["userId"],
                                );
                                Navigator.pop(context);
                                context.go(RoutesName.dashboardScreen);
                              }else{
                                Navigator.pop(context);

                              }

                              log(value["result"]);
                            },
                          );
                        }
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0.r),
                      child: GestureDetector(
                        onTap: () {
                          context.go(RoutesName.loginScreen); //navgationto login screen
                        },
                        child:   TextRich(
                          firstText: StringManager.haveAccountTxt,
                          secText: StringManager.loginText,
                          style1: TextStyle(color: ColorManager.tealColor, fontSize: 14.sp),
                          style2: TextStyle(
                            color: ColorManager.blackColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w800,
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
    );
  }
}
