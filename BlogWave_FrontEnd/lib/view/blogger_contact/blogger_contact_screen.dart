import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../resources/resources.dart';
import '../../services/services.dart';
import '../../widget/widget.dart';
import '../view.dart';

class BloggerContactScreen extends StatefulWidget {
  BloggerContactScreen({super.key, required this.message});

  final SendBlogMes message;

  @override
  State<BloggerContactScreen> createState() => _BloggerContactScreenState();
}

class _BloggerContactScreenState extends State<BloggerContactScreen> {
  final TextEditingController _titleCtrl = TextEditingController();

  final TextEditingController _messageCtrl = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _titleCtrl.dispose();
    _messageCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(15.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                    prefixIcon: const Icon(
                      Icons.title_rounded,
                      color: ColorManager.tealColor,
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.r),
                  child: PrimaryTextFilled(
                    controller: _messageCtrl,
                    hintText: StringManager.messHintTxt,
                    labelText: StringManager.messLabelTxt,
                    prefixIcon: const Icon(
                      Icons.message_outlined,
                      color: ColorManager.tealColor,
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                PrimaryButton(
                  title: StringManager.sendMailTxt,
                  onTap: () async {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const Center(child: Loading());
                        });
                    ApiServices().postApi(
                      api: "${APIConstants.baseUrl}mail/sendEmail",
                      body: {
                        "email": widget.message.bloggerMail,
                        "bloggerName": widget.message.bloggerName,
                        "title": _titleCtrl.text.trim(),
                        "message": _messageCtrl.text.trim()
                      },
                    ).then(
                      (value) {
                        _titleCtrl.clear();
                        _messageCtrl.clear();
                        Fluttertoast.showToast(
                          msg: 'Mail Send Successfully',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                        );
                        Navigator.pop(context);
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
