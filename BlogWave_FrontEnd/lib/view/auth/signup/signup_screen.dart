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
  final userPreferences = UserPreferences();//class is user to store data locally
  final _formKey = GlobalKey<FormState>();// its used to validate the textFilled form


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
            ?.unfocus(); // remove the text field on tapping gesture deatector
      },
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15.w),
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
                          validator: (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return StringManager.userHintTxt;
                            }
                            return null;
                          },
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
                              return  StringManager.emailHintTxt;
                            }
                            if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(p0)){
                              return  StringManager.correctEmailTxt;
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
                              return 'Enter Password';
                            }
                            return null;
                          },
                        ),
                      ),
                      PrimaryButton(
                        title: StringManager.signUpText,
                        onTap: () async {
                          // get success after validation is  correct
                          loading(context);
                          if (_formKey.currentState!.validate()) {
                            // SignUp Api
                            await ApiServices().postApi(
                              api: "${APIConstants.baseUrl}user/signUp",
                              body: {
                                ApiRequestBody.apiUserName: _userController.text.trim(),
                                ApiRequestBody.apiEmail: _emailController.text.trim(),
                                ApiRequestBody.apiPassword: _passController.text.trim(),
                              },
                            ).then(
                                  (value) {
                                if(value.statusCode==ServerStatusCodes.forBid){
                                  Navigator.pop(context);// pop loading screen
                                  // toast snackBar message of existing User
                                  WarningBar.snackMessage(context,
                                      message: StringManager.userExistTxt, color: ColorManager.redColor);
                                }
                                else{
                                  // store user token , and userId , logged in bool value
                                  userPreferences.saveLoginUserInfo(
                                    value.data["token"],
                                    value.data["success"],
                                    value.data["userId"],
                                  );
                                  // Navigate to dashboard screen
                                  context.go(RoutesName.dashboardScreen);
                                }
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
