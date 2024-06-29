


import 'package:intl/intl.dart';

class StringFormatting{
static String formatRegistrationDate({required String date}){
  DateTime dateTime = DateTime.parse(date);
  return DateFormat('dd MMMM, yyyy').format(dateTime);
}

static String capitalizeAfterSpace(String str) {
  List<String> words = str.split(' ');
  for (int i = 0; i < words.length; i++) {
    words[i] = words[i].toLowerCase().splitMapJoin(
      RegExp(r'^\w'),
      onMatch: (match) => match.group(0)!.toUpperCase(),
      onNonMatch: (nonMatch) => nonMatch,
    );
  }
  return words.join(' ');
}


static String formatLocationTime({required String date}){
  DateTime dateTime = DateTime.parse(date);
  return DateFormat('dd MMMM, yyyy hh:mm a').format(dateTime);
}

}