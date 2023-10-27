import 'package:intl/intl.dart';

class Utils{

  static String formatDate(String date) {

    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MM/dd/yyyy');
    var outputDate = outputFormat.format(inputDate);
    print(outputDate);
    return outputDate;
  }
}