import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'color_helper.dart';
class AppTheme{
  static const Color whiteColor = Colors.white;
  static const Color blackColor = Colors.black;

 static ThemeData lightTheme = ThemeData(
   dividerTheme:  DividerThemeData(
     color: Colors.grey.shade200,
   ),
   inputDecorationTheme:   const InputDecorationTheme(
     focusedBorder: UnderlineInputBorder(
       borderSide: BorderSide(
           color: ColorHelper.mainColor
       ),
     ),
     enabledBorder: UnderlineInputBorder(
       borderSide: BorderSide(
           color: Color(0xffD6D6D6)
       ),
     ),
   ),
   drawerTheme: const DrawerThemeData(

     backgroundColor: Colors.white,
   ),
   cardTheme:  CardThemeData(
     shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(15),
     side: BorderSide(
       color: Colors.grey.shade200,
     ),
     ),
     color: Colors.white,
   ),
   primaryColor: Colors.white,
   primaryColorDark: const Color(0xff273B4A),
   bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,

   ),
   snackBarTheme: SnackBarThemeData(
     contentTextStyle: const TextStyle(
       color: Colors.black,
     ),
     //actionBackgroundColor: Colors.white,
     actionTextColor: Colors.black,
     disabledActionTextColor: Colors.black,
     closeIconColor: Colors.black,
     shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(15),
         side:  BorderSide(
             color: Colors.grey.shade200
         )

     ),
     backgroundColor: Colors.white,

   ),
   dropdownMenuTheme:  DropdownMenuThemeData(

     textStyle: const TextStyle(
       color: Colors.black,
     ),
     inputDecorationTheme: InputDecorationTheme(
       enabledBorder: OutlineInputBorder(
         borderRadius: BorderRadius.circular(15),
         borderSide:  const BorderSide(
             color: Color(0xffB1B5C3),
             width: 1
         ),
       ),

       filled: true,
       suffixStyle: const TextStyle(
         color: Colors.white,
       ),
       iconColor: Colors.black,
       suffixIconColor:Colors.black,
       hintStyle: const TextStyle(
         color: Colors.white,

       ),
       labelStyle: const TextStyle(
         color: Colors.white,
       ),
       alignLabelWithHint: true,
       fillColor: Colors.grey.shade200,
       border: OutlineInputBorder(
           borderRadius: BorderRadius.circular(15),
           borderSide: const BorderSide(
               color: Colors.transparent
           )
       ),
     ),
     menuStyle: MenuStyle(
       side:  const WidgetStatePropertyAll(
           BorderSide(
               color: Colors.black12
           )
       ),
       shadowColor: WidgetStateProperty.all(
           Colors.grey.withOpacity(.1)
       ),
       shape: WidgetStateProperty.all(
           RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(15),
           )
       ),
       backgroundColor: WidgetStateProperty.all(
         Colors.grey.shade200,
       ),
     ),
   ),
   textTheme: const TextTheme(
     displayMedium: TextStyle(
       color: Color(0xff273B4A),
       fontSize: 16,
       fontFamily: "Cairo",
       // fontWeight: FontWeight.bold
     ),
     titleMedium:  TextStyle(
       color: Colors.black,
       fontSize: 25,
       fontFamily: "Cairo",
       // fontWeight: FontWeight.bold
     ),
   ),
   dialogTheme: const DialogThemeData(
     titleTextStyle: TextStyle(
       color: Colors.black,
       fontSize: 20,
     ),
     backgroundColor: Colors.white,
     contentTextStyle: TextStyle(
         color: Colors.black
     ),

   ),
   fontFamily: "Cairo",
   elevatedButtonTheme:   ElevatedButtonThemeData(
       style: ButtonStyle(
         overlayColor: WidgetStateProperty.all(
             Colors.white.withOpacity(.1)
         ),
         backgroundColor: const WidgetStatePropertyAll(
             Color(0xff2D201C)
         ),
         foregroundColor: const WidgetStatePropertyAll(
             Colors.white
         ),
       )
   ),
   bottomSheetTheme: const BottomSheetThemeData(
     dragHandleColor: ColorHelper.mainColor,
     backgroundColor: ColorHelper.darkColor,
     dragHandleSize: Size(200,7),
     showDragHandle: true,
     shape:  RoundedRectangleBorder(
       borderRadius: BorderRadius.vertical(
         top: Radius.circular(25.0),
       ),
     ),
   ),

   appBarTheme:  const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black,
        statusBarIconBrightness: Brightness.dark,
      ),
       iconTheme: IconThemeData(
         color: ColorHelper.mainColor,
       ),
       color: ColorHelper.lightColor,
       centerTitle: true,
       titleTextStyle: TextStyle(
           color: ColorHelper.mainColor,
           fontSize: 25,
           fontWeight: FontWeight.bold,
           fontFamily: "Cairo"
       )
   ),
   scaffoldBackgroundColor: Colors.white,
   // primaryColor: ColorHelper.mainColor,
   colorScheme: const ColorScheme.light(
     onPrimary: Color(0xff3A2C27),
     secondary: Color(0xff9D9D9D),
     inversePrimary: Color(0xffF3F3F3),
     brightness: Brightness.light,
     onSurface: ColorHelper.darkColor,
     primary: ColorHelper.mainColor,
     surfaceContainer: Colors.white,
   ),
   useMaterial3: true,
 );

 static ThemeData darkTheme = ThemeData(
   primaryColorDark: const Color(0xffB1B5C3),
   datePickerTheme: const DatePickerThemeData(
      dividerColor: Colors.grey,

     dayForegroundColor: WidgetStatePropertyAll(Colors.grey),
     headerForegroundColor: Colors.white,
     headerBackgroundColor: ColorHelper.mainColor,
     todayForegroundColor: WidgetStatePropertyAll(Colors.white),
     yearForegroundColor: WidgetStatePropertyAll(Colors.white),


     headerHelpStyle: TextStyle(
       color: Colors.white,
     ),
     headerHeadlineStyle: TextStyle(
       color: Colors.white,
     ),
     dayStyle: TextStyle(
       color: Colors.white,

     ),
     inputDecorationTheme: InputDecorationTheme(
       iconColor: Colors.white,
       hintStyle: TextStyle(
         color: Colors.white,
       ),
       labelStyle: TextStyle(
         color: Colors.white,
       ),

     ),
     weekdayStyle: TextStyle(
       color: Colors.white,
       fontSize: 20,
       fontWeight: FontWeight.bold,
     ),
   ),
   cardTheme:  CardThemeData(
     shadowColor: Colors.black,
     shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(15),

     ),
     color: ColorHelper.darkThemeColor,
   ),
   drawerTheme: const DrawerThemeData(

     backgroundColor: Color(0xff141416),
   ),
   primaryColor: ColorHelper.darkThemeColor,
   listTileTheme: const ListTileThemeData(
     iconColor: Colors.white,
   ),
   dropdownMenuTheme:  DropdownMenuThemeData(
     textStyle: const TextStyle(
       color: Colors.white,
     ),
     inputDecorationTheme: InputDecorationTheme(
       enabledBorder: OutlineInputBorder(
         borderRadius: BorderRadius.circular(15),
         borderSide:  const BorderSide(
             color: Color(0xffB1B5C3),
             width: 1
         ),
       ),

       filled: true,
       suffixStyle: const TextStyle(
         color: Colors.white,
       ),
       iconColor: Colors.white,
       suffixIconColor: Colors.white,
       hintStyle: const TextStyle(
          color: Colors.white,

       ),
       labelStyle: const TextStyle(
         color: Colors.white,
       ),
       alignLabelWithHint: true,
       fillColor: ColorHelper.darkThemeColor,
       border: OutlineInputBorder(
           borderRadius: BorderRadius.circular(15),
           borderSide: const BorderSide(
               color: Colors.transparent
           )
       ),
     ),
     menuStyle: MenuStyle(
       side: const WidgetStatePropertyAll(
           BorderSide(
               color: Colors.transparent

           )
       ),
       shadowColor: WidgetStateProperty.all(
           Colors.grey.withOpacity(.1)
       ),
       shape: WidgetStateProperty.all(
           RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(15),
           )
       ),
       backgroundColor: WidgetStateProperty.all(
         ColorHelper.darkThemeColor,
       ),
     ),

   ),
   menuButtonTheme: MenuButtonThemeData(
     style: ButtonStyle(
       overlayColor: WidgetStateProperty.all(
           Colors.grey.withOpacity(.5)
       ),
       foregroundColor: WidgetStateProperty.all(
           Colors.white
       ),
      ),
   ),
   expansionTileTheme: const ExpansionTileThemeData(
     textColor: Colors.white,
     iconColor: Colors.white,
     collapsedIconColor: Colors.white,
   ),
   dividerColor: const Color(0xff23262F),
   dividerTheme: const DividerThemeData(
     color: Color(0xff23262F),
   ),
   snackBarTheme: SnackBarThemeData(
     contentTextStyle: const TextStyle(
       color: Colors.white,
     ),
     //actionBackgroundColor: Colors.white,
     actionTextColor: Colors.white,
     disabledActionTextColor: Colors.white,
     closeIconColor: Colors.white,
     shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(15),
         side: const BorderSide(
             color: Color(0xff23262F)
         )

     ),
     backgroundColor: ColorHelper.darkThemeColor,

   ),
   bottomNavigationBarTheme: const BottomNavigationBarThemeData(
     backgroundColor: ColorHelper.darkThemeColor,
     selectedItemColor: Colors.white,
     unselectedItemColor: Color(0xff353945),
   ),
   textTheme: const TextTheme(
     titleMedium:  TextStyle(
       color: Colors.white,
       fontSize: 25,
       fontFamily: "Cairo",
       // fontWeight: FontWeight.bold
     ),
   ),
   dialogTheme: const DialogThemeData(
     titleTextStyle: TextStyle(
       color: Colors.white,
       fontSize: 20,
     ),
     backgroundColor: ColorHelper.darkThemeColor,
     contentTextStyle: TextStyle(
         color: Colors.white
     ),

   ),
   fontFamily: "Cairo",
   elevatedButtonTheme:   ElevatedButtonThemeData(
       style: ButtonStyle(
         shape: WidgetStateProperty.all(
             RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(10),
             )
         ),
         overlayColor: WidgetStateProperty.all(
             Colors.grey.withOpacity(.5)
         ),
         backgroundColor: const WidgetStatePropertyAll(
             Colors.white
         ),
         foregroundColor: const WidgetStatePropertyAll(
             ColorHelper.darkThemeColor
         ),
       )
   ),
   bottomSheetTheme: const BottomSheetThemeData(
     dragHandleColor: Colors.white,
     backgroundColor: ColorHelper.darkThemeColor,
     dragHandleSize: Size(200,7),
     showDragHandle: true,
     shape:  RoundedRectangleBorder(
       borderRadius: BorderRadius.vertical(
         top: Radius.circular(25.0),
       ),
     ),
   ),
   appBarTheme: const AppBarTheme(
       systemOverlayStyle: SystemUiOverlayStyle.light,
       iconTheme: IconThemeData(
         color: Colors.white,
       ),
       color: ColorHelper.darkThemeColor,
       centerTitle: true,
       titleTextStyle: TextStyle(
           color: Colors.white,
           fontSize: 25,
           fontWeight: FontWeight.bold,
           fontFamily: "Cairo"
       )
   ),
   scaffoldBackgroundColor: ColorHelper.darkThemeColor,
   // primaryColor: ColorHelper.mainColor,
     //Color(0xff23262F)
     //Color(0xffB1B5C3)
   colorScheme: const ColorScheme.dark(
     onPrimary: Color(0xffFCFCFD),
     secondary: Color(0xffB1B5C3),
     inversePrimary: Color(0xff23262F),
     brightness: Brightness.dark,
     onSurface: ColorHelper.darkColor,
     primary: ColorHelper.mainColor,
     surfaceContainer: ColorHelper.darkThemeColor,
   ),
   useMaterial3: true,
   inputDecorationTheme: const InputDecorationTheme(
     focusedBorder: UnderlineInputBorder(
       borderSide: BorderSide(
           color: Colors.white
       ),
     ),
     enabledBorder: UnderlineInputBorder(
       borderSide: BorderSide(
           color: Color(0xff777E90)
       ),
     ),
   )
 );


}

ThemeData themeData(BuildContext context) {
  return ThemeData(

    bannerTheme: const MaterialBannerThemeData(
      backgroundColor: Colors.white,
    ),
    scrollbarTheme:  ScrollbarThemeData(
       interactive: true,
      trackColor: WidgetStateProperty.all(Colors.grey),
      trackVisibility:  WidgetStateProperty.all(true),
      thumbColor: WidgetStateProperty.all(Colors.black),
    ),
    textTheme: const TextTheme(

      titleMedium:  TextStyle(
          color: Colors.black,
          fontSize: 25,
          fontFamily: "Cairo",
         // fontWeight: FontWeight.bold
      ),
    ),
    dialogTheme: const DialogThemeData(
      titleTextStyle: TextStyle(
          color: ColorHelper.mainColor,
          fontSize: 20,
        fontFamily: "Cairo"

      ),
      backgroundColor: ColorHelper.darkColor,
      contentTextStyle: TextStyle(
          color: Colors.white,
          fontFamily: "Cairo"
      ),

    ),
    fontFamily: "Cairo",
    elevatedButtonTheme:   ElevatedButtonThemeData(
      style: ButtonStyle(
       overlayColor: WidgetStateProperty.all(
           Colors.white.withOpacity(.1)
       ),
        shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )
        ),
        backgroundColor: const WidgetStatePropertyAll(
            ColorHelper.mainColor
        ),
        foregroundColor: const WidgetStatePropertyAll(
            Colors.white
        ),
      )
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      dragHandleColor: ColorHelper.mainColor,
      backgroundColor: ColorHelper.darkColor,
      dragHandleSize: Size(200,7),
      showDragHandle: true,
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
    ),
    appBarTheme: const AppBarTheme(
       // systemOverlayStyle: SystemUiOverlayStyle.dark,
        iconTheme: IconThemeData(
        color: Colors.white,
      ),
        color: Colors.black,
        surfaceTintColor: Colors.transparent,

        centerTitle: true,
        titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          fontFamily: "Cairo"
        )
    ),
    scaffoldBackgroundColor: ColorHelper.darkColor,
   // primaryColor: ColorHelper.mainColor,
    colorScheme: const ColorScheme.dark(
      brightness: Brightness.dark,
    onSurface: ColorHelper.darkColor,
   primary: ColorHelper.mainColor,
    ),

    dataTableTheme: DataTableThemeData(
      headingRowColor: WidgetStateProperty.all(ColorHelper.mainColor),

      headingTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontFamily: "Cairo",
      ),
      decoration: BoxDecoration(border: Border.all(color: Colors.white)

      ),
      dataTextStyle: const TextStyle(

        color: Colors.white,
        fontSize: 16,
        fontFamily: "Cairo",
      ),
    ),
    useMaterial3: true,
  );
}
