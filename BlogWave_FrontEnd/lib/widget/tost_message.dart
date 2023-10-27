import 'package:fluttertoast/fluttertoast.dart';

Future<bool?> buildShowToast({required String toastMessage}) {
  return Fluttertoast.showToast(
    msg: toastMessage,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
  );
}
