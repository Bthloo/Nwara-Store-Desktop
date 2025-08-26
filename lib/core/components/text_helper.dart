import 'dart:ui';

TextDirection getTextDirectionBasedOnContent(String text) {
  // Define a regular expression for RTL characters
  RegExp rtlCharacters = RegExp(r'[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB1D-\uFB4F\uFE70-\uFEFF]');
  
  if (rtlCharacters.hasMatch(text)) {
    return TextDirection.rtl;
  } else {
    return TextDirection.ltr;
  }
}