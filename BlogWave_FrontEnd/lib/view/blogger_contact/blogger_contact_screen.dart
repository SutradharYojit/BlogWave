import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../resources/resources.dart';
import '../../services/services.dart';
import '../../widget/widget.dart';
import '../view.dart';

class BloggerContactScreen extends StatefulWidget {
  const BloggerContactScreen({super.key, required this.message});

  final SendBlogMes message; // data class where you can get the deatils of the blogger contact

  @override
  State<BloggerContactScreen> createState() => _BloggerContactScreenState();
}

class _BloggerContactScreenState extends State<BloggerContactScreen> {
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _messageCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();// its used to validate the textFilled form

  @override
  void dispose() {
    // disposing the textfilled controller
    super.dispose();
    _titleCtrl.dispose();
    _messageCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringManager.contactAppBarTitle),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(15.0.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Image of the app Icon
                  Image.asset(
                    IconAssets.appIcon,
                    height: 100.h,
                  ),
                  Text(
                    StringManager.myApp,
                    style: TextStyle(
                      fontSize: 45.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: "DancingScript",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.r),
                    child: PrimaryTextFilled(
                      controller: _titleCtrl,
                      hintText: StringManager.titleHintTxt,
                      labelText: StringManager.titleLabelTxt,
                      textCapitalization: TextCapitalization.sentences,
                      prefixIcon: const Icon(
                        Icons.title_rounded,
                        color: ColorManager.tealColor,
                      ),
                      keyboardType: TextInputType.text,
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return StringManager.titleHintTxt;
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.r),
                    child: PrimaryTextFilled(
                      controller: _messageCtrl,
                      hintText: StringManager.messHintTxt,
                      labelText: StringManager.messLabelTxt,
                      textCapitalization: TextCapitalization.sentences,
                      prefixIcon: const Icon(
                        Icons.message_outlined,
                        color: ColorManager.tealColor,
                      ),
                      keyboardType: TextInputType.text,
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return StringManager.messHintTxt;
                        }
                        return null;
                      },
                    ),
                  ),
                  PrimaryButton(
                    title: StringManager.sendMailTxt,
                    onTap: () async {
                      // get success after validation is  correct
                      if(_formKey.currentState!.validate()){
                        loading(context);
                        // Api to send mail to blogger
                        // Make an API POST request to send an email.
                        ApiServices().postApi(
                          api: "${APIConstants.baseUrl}mail/sendEmail", // The API endpoint URL for sending emails.
                          body: {
                            ApiRequestBody.apiEmail: widget.message.bloggerMail, // Blogger's email address.
                            ApiRequestBody.apiBloggerName: widget.message.bloggerName, // Blogger's name.
                            ApiRequestBody.apiTitle: _titleCtrl.text.trim(), // Trimmed email title.
                            ApiRequestBody.apiMessage: _messageCtrl.text.trim(), // Trimmed email message.
                          },
                        ).then(
                              (value) {
                            if (value.statusCode == ServerStatusCodes.success) {
                              _titleCtrl.clear(); // Clear the email title input field.
                              _messageCtrl.clear(); // Clear the email message input field.
                              // Show a toast message indicating that the email was sent successfully.
                              Fluttertoast.showToast(
                                msg: StringManager.mailSendSuccessTxt,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                              );

                              Navigator.pop(context); // Close the current screen (Loading Screen).
                            } else {
                              // Show a toast message in case of an error.
                              Fluttertoast.showToast(
                                msg: StringManager.errorTxt,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                              );
                              Navigator.pop(context); // Close the current screen (Loading Screen) in case of an error.
                            }
                          },
                        );

                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
