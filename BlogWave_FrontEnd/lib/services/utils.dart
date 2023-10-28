import 'package:intl/intl.dart';

class Utils{
  // Function to formatting the coming date from database into => 10/11/2023
  static String formatDate(String date) {
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MM/dd/yyyy');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }
}