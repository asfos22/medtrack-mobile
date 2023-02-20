import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medtrack/dashboard/models/item.dart';

class AppConstants {
  // Name
  static String appName = "MedTrack";

  static String docName = "Dr. Ahmed Suley";
  static String docName2 = "Dr. Felix Adams";
  static String docTitle = "Physician";
  static String docDate = "1st Jan 2021";
  static String docTime = "10:32 am";

  // Accent Color
  static Color primaryColor = const Color(0xFF3952A6);
  static Color accentColor = const Color(0xFFF0F3F7);

  //edit text background
  static Color textEditBackground = const Color(0xFF5A7083);

  //Art board background
  static Color artBoardBackground = const Color(0xFFF0F3F7);

  // Background
  static Color backgroundColor = const Color(0xFFF6F8FB);
  static Color secondaryBackGround = const Color(0xFFf7f8fc);

  // White Color
  static Color whiteColor = const Color(0xFFFFFFFF);

  // Orange
  static Color darkOrange = const Color(0xFFFFB74D);

// Line
  static Color lineColor = const Color(0xFFE0EAF4);
  static Color borderLineColor = const Color(0xFFd3e0ee);

  //--Sub label
  static Color subLabelColor = const Color(0xFF5A7083);

  //--Red Color
  static Color colorRed = const Color(0xFFFE5858);

  // -- Black color
  static Color blackColor = const Color(0xFF141F2A);

  // -- Green color
  static Color greenColor = const Color(0xFF00B066);

  // -- Grey color
  static Color greyColor = const Color(0xFF9E9E9E);

  // keypad
  static Color kColorGreyShade200 = Colors.grey.shade200;

  static Color kBackGroundGreyColor = Colors.grey.shade200;

  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      backgroundColor: backgroundColor,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: artBoardBackground,
      textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
          color: accentColor,
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(cursorColor: accentColor),
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: accentColor),
    );
  }

  static double headerHeight = 228.5;
  static double paddingSide = 30.0;

// Form Error
  final RegExp emailValidatorRegExp =
      RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static const String kEmailNullError = "Please Enter your email";
  static const String kInvalidEmailError = "Please Enter Valid Email";
  static const String kPassNullError = "Please Enter your password";
  static const String kCurrentPassNullError =
      "Please Enter your current password";
  static const String kNewPassNullError = "Please Enter your new password";
  static const String kShortPassError = "Password is too short";
  static const String kMatchPassError = "Passwords don't match";
  static const String kMatchNotPassError =
      "Current and new password cannot be same";
  static const String kNameNullError = "Please Enter your name";
  static const String kPhoneNumberNullError = "Please Enter your phone number";
  static const String kAddressNullError = "Please Enter your address";
  static const String kYearNullError = "Please Enter year";
  static const String kMonthNullError = "Please Select month";
  static const String kDayNullError = "Please Enter day";
  static const String noInternet =
      "No internet connection, Connect via WiFi/Cellular";

  static const String kGhanaCardCodeNullError = "Enter Ghana Card code eg: GHA";
  static const String kSixSeriesNullError =
      "Enter six series number code eg: 000 000";
  static const String kThreeSeriesNullError =
      "Enter three series number code eg: 000";

  // -- keypad

  static const double kDialPadButtonSpacing = 20;

  static const Map<String, String> numToTextMapping = {
    "1": "",
    "2": "A B C",
    "3": "D E F",
    "4": "G H I",
    "5": "J K L",
    "6": "M N O",
    "7": "P Q R S",
    "8": "T U V",
    "9": "W X Y Z",
    "0": "",
    "*": "",
    "#": ""
  };

  List<Item> monthList = <Item>[
    Item(id: "01", value: 'JANUARY'),
    Item(id: "02", value: "FEBRUARY"),
    Item(id: "03", value: 'MARCH'),
    Item(id: "04", value: "APRIL"),
    Item(id: "05", value: 'MAY'),
    Item(id: "06", value: 'JUNE'),
    Item(id: "07", value: 'JULY'),
    Item(id: "08", value: 'AUGUST'),
    Item(id: "09", value: 'SEPTEMBER'),
    Item(id: "10", value: 'OCTOBER'),
    Item(id: "11", value: 'NOVEMBER'),
    Item(id: "12", value: 'DECEMBER')
  ];

  static List<Item> genderList = <Item>[
    Item(id: "1", value: 'Male'),
    Item(id: "2", value: "Female")
  ];

  static List<Item> regionsList = <Item>[
    Item(id: "1", value: 'Greater Accra'),
    Item(id: "2", value: "Ashanti"),
    Item(id: "3", value: 'Eastern'),
    Item(id: "4", value: "Western"),
    Item(id: "5", value: 'Volta'),
    Item(id: "6", value: 'Central'),
    Item(id: "7", value: 'Upper West'),
    Item(id: "8", value: 'Northern'),
    Item(id: "9", value: 'Upper East'),
    Item(id: "10", value: 'Savannah'),
    Item(id: "11", value: 'North East'),
    Item(id: "12", value: 'Bono East'),
    Item(id: "13", value: 'Oti'),
    Item(id: "14", value: 'Ahafo'),
    Item(id: "15", value: 'Bono'),
    Item(id: "16", value: 'Western North')
  ];

  static List<Item> cityList = <Item>[
    Item(id: "1", value: 'Accra'),
    Item(id: "2", value: "Kumasi"),
    Item(id: "3", value: 'Tamale'),
    Item(id: "4", value: "Sekondi-Takoradi"),
    Item(id: "5", value: 'Ashaiman'),
    Item(id: "6", value: 'Sunyani'),
    Item(id: "7", value: 'Cape Coast'),
    Item(id: "8", value: 'Obuasi'),
    Item(id: "9", value: 'Teshie'),
    Item(id: "10", value: 'Tema'),
    Item(id: "11", value: 'Madina'),
    Item(id: "12", value: 'Koforidua'),
    Item(id: "13", value: 'Wa'),
    Item(id: "14", value: 'Ho'),
    Item(id: "15", value: 'Nungua'),
    Item(id: "17", value: 'Lashibi')
  ];

  static List<Item> bloodGroupList = <Item>[
    Item(id: "1", value: 'A+'),
    Item(id: "2", value: 'A-'),
    Item(id: "3", value: 'B-'),
    Item(id: "4", value: "B+"),
    Item(id: "5", value: 'AB+'),
    Item(id: "6", value: 'AB-'),
    Item(id: "7", value: "O+"),
    Item(id: "8", value: 'O-'),
  ];

  String selected = 'Month';

  static TextStyle kKeyPadNumberTextStyle = TextStyle(
    fontSize: 32,
    color: AppConstants.whiteColor,
    fontWeight: FontWeight.w900,
  );

  final TextStyle kLargeCaptionLabelTextStyle = TextStyle(
    fontSize: 50,
    backgroundColor: kBackGroundGreyColor,
    fontWeight: FontWeight.bold,
  );

  static const String pinCodeCreate = "CREATE";
  static const String pinCodeConfirm = "CONFIRM";
  static const String pinCodeUpdateCreate = "UPDATE_CREATE";
  static const String pinCodeUpdateConfirm = "UPDATE_CONFIRM";
  static const String pinCodeNotification = "NOTIFICATION_CREATE";
  static const String pinCodeNotificationConfirm = "NOTIFICATION_CONFIRM";

  //-- cat
  static const String catPrescription = "PRESCRIPTIONS";
  static const String catClinical = "CLINICAL";
  static const String catDiagnosis = "DIAGNOSIS";
  static const String catHealthData = "HEALTH_DATA";

  //
  static const String pending = "Pending";
  static const String dispensed = "Dispensed";

  static const String completed = "COMPLETED";
  static const String diagnosis = "DIAGNOSTIC";
  static const String prescriptions = "PRESCRIPTIONS";

  //
  static const String profilePhoto = "Profile Photo";
  static const String update = "Update";

  static const String profileURL = "https://via.placeholder.com/150x150.jpg";
  static const String profileName = "Janet Jackson";
  static const String healthCardID = "GHA 211121212 01";

  //--- appBar
  static const double defaultAppBarSizeHeight = 150;
  static const double settingsAppBarSizeHeight = 200;

  //-- fonts
  //-- h1 header Label

  static TextStyle h1HeadingTextStyle = TextStyle(
      color: blackColor,
      fontWeight: FontWeight.bold,
      fontSize: 34,
      height: 1.2);

  //-- h2 header Label
  static TextStyle h2HeadingTextStyle = TextStyle(
      color: blackColor,
      fontWeight: FontWeight.bold,
      fontSize: 17,
      height: 1.5,
      letterSpacing: -0.3);

  //-- h2 header light Label
  static TextStyle h2HeadingLightTextStyle = TextStyle(
      color: subLabelColor,
      fontWeight: FontWeight.bold,
      fontSize: 17,
      height: 1.5,
      letterSpacing: -0.3);

  //-- body dark style
  static TextStyle bodyCopyDarkTextStyle = TextStyle(
      color: blackColor,
      fontWeight: FontWeight.w500,
      fontSize: 17,
      height: 1.5,
      letterSpacing: -0.1);

  //-- body light

  static TextStyle bodyCopyLightTextStyle = TextStyle(
      color: subLabelColor,
      fontWeight: FontWeight.w500,
      fontSize: 17,
      height: 1.4,
      letterSpacing: -0.1);

  //-- Input field
  static TextStyle inputFieldTextStyle = TextStyle(
      color: blackColor,
      fontWeight: FontWeight.w500,
      fontSize: 15,
      letterSpacing: -0.2);

  //-- Secondary Label
  static TextStyle h4SecondaryLabelTextStyle = TextStyle(
      color: blackColor,
      fontWeight: FontWeight.w500,
      fontSize: 15,
      letterSpacing: -0.3);

  //-- Secondary Label light

  static TextStyle subLabelLightTextStyle(
      FontWeight fontWeight, Color fontColor) {
    return TextStyle(
        color: fontColor,
        fontWeight: fontWeight,
        fontSize: 15,
        height: 1.5,
        letterSpacing: -0.3);
  }

  static TextStyle h4SecondaryLabelLightTextStyle = TextStyle(
      color: subLabelColor,
      fontWeight: FontWeight.w700,
      fontSize: 15,
      letterSpacing: -0.3);

  //-- Label
  static TextStyle labelTextStyle = TextStyle(
    color: subLabelColor,
    fontWeight: FontWeight.w300,
  );
}
