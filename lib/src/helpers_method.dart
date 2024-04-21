// import 'dart:math';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart' as intl;
// import 'package:kitsys_ecommerce/app/core/language_and_localization/app_strings.dart';
// import 'package:logger/logger.dart';
//
// import '../../global_widget/app_ui_helper/different_dialogs.dart';
// import '../../services/connectivity_service/connectivity_controller.dart';
// import '../../services/connectivity_service/no_connection_snack_bar.dart';
//
// class HelpersMethods {
//   // var logger = Logger();
//
//   static final Size appBarSize = AppBar().preferredSize;
//
//   bool get inDebugMode => kDebugMode;
//
//   Duration timeOutDuration({int seconds = 5}) {
//     return Duration(seconds: seconds);
//   }
//
//   bool noInternetConnection() {
//     if (Get.find<ConnectivityController>().currentConnectivityStatus == null) {
//       Get.find<ConnectivityController>().checkWhenStreamIsNull();
//     }
//     return !(Get.find<ConnectivityController>().currentConnectivityStatus!);
//   }
//
//   onNOInternetConnection() async {
//     return await NoConnectionSnackBar.instance.showNoConnectionSnackBar();
//   }
//
//   toastMessage(
//     String message, {
//     Color? backgroundColor,
//     Color? textColor,
//   }) {
//     DifferentDialogs.toastMessage(
//       message: message,
//       backgroundColor: backgroundColor,
//       textColor: textColor,
//     );
//   }
//
//   static String? splitOnlyTowUserName(
//     String? fullName, {
//     bool withMid = false,
//     bool onlyFirstName = false,
//   }) {
//     if (fullName != null) {
//       var names = fullName.split(' ');
//
//       if (onlyFirstName) {
//         return names.first;
//       }
//
//       if (names.length == 1) {
//         return names.first;
//       }
//
//       return withMid && names.length > 2
//           ? '${names.first} ${names[1]} ${names.last}'
//           : '${names.first} ${names.last}';
//     }
//     return null;
//   }
//
//   buildErrorSnackBar({String? msg, String? title}) {
//     if (Get.isSnackbarOpen) {
//       Get.closeCurrentSnackbar();
//     }
//     return WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       Get.showSnackbar(
//         DifferentDialogs.errorSnackBar(
//           message: msg,
//           title: title,
//         ),
//       );
//     });
//   }
//
//   buildSuccessSnackBar({String? msg, String? title}) {
//     if (Get.isSnackbarOpen) {
//       Get.closeCurrentSnackbar();
//     }
//     return WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       Get.showSnackbar(
//         DifferentDialogs.successSnackBar(
//           message: msg,
//           title: title,
//         ),
//       );
//     });
//   }
//
//   buildInfoSnack({required String? msg, String? title}) {
//     if (Get.isSnackbarOpen) {
//       Get.closeCurrentSnackbar();
//     }
//     return Get.showSnackbar(
//       DifferentDialogs.messageSnackBar(
//         message: msg,
//         title: title,
//       ),
//     );
//   }
//
//   hideStatusBar() {
//     SystemChrome.setEnabledSystemUIMode(
//       SystemUiMode.leanBack,
//       overlays: [
//         // to enable only top pass SystemUiOverlay.top
//         // SystemUiOverlay.top
//         // to enable only bottom pass SystemUiOverlay.bottom
//       ],
//     );
//   }
//
//   showStatusBar() {
//     SystemChrome.setEnabledSystemUIMode(
//       SystemUiMode.manual,
//       overlays: SystemUiOverlay.values.toList(),
//     );
//   }
//
//   // showYouMayHaveBadInternetConnection() {
//   //   DifferentDialogs.hideProgressDialog();
//   //   buildFailedSnackBar(
//   //       msg: AppStrings.youMayHaveBadInternetConnection.tr.capitalizeFirst);
//   // }
//
//   hideSoftKeyBoard() {
//     // FocusScope.of(Get.context!).requestFocus(FocusNode());
//     WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
//     // FocusScope.of(Get.context).unfocus();
//     // return Future.value(true);
//   }
//
//   copyToClipBoard(String value) async {
//     await Clipboard.setData(ClipboardData(text: value));
//     toastMessage(AppStrings.successfullyCopyToClipboard.tr.capitalizeFirst!);
//   }
//
//   // static TextDirection currentLocaleTextDirection() {
//   //   bool isRtl = intl.Bidi.isRtlLanguage(
//   //       Localizations.localeOf(Get.context!).languageCode);
//   //   return isRtl ? TextDirection.rtl : TextDirection.ltr;
//   // }
//
//   // static bool get isDirectionRTL {
//   //   return intl.Bidi.isRtlLanguage(
//   //     Localizations.localeOf(Get.context!).languageCode,
//   //   );
//   // }
//
//   ///... format numbers ............................................
//
//   static String formatNumbersWithSeparators(num number) {
//     var formatter = intl.NumberFormat('###,###,###');
//     return formatter.format(number);
//   }
//
//   static String formatDoubleNumberDecimal(double? v) {
//     if (v == null) return '';
//     intl.NumberFormat formatter = intl.NumberFormat();
//     formatter.minimumFractionDigits = 0;
//     formatter.maximumFractionDigits = 2;
//     return formatter.format(v);
//   }
//
//   static String getLikeCountWithSuffix(int likes) {
//     String? text;
//     if (likes >= 1000) {
//       text = '${(likes / pow(10, 3)).toStringAsFixed(1)}k';
//     } else if (likes >= 1000000) {
//       text = '${(likes / 1000000.0).toStringAsFixed(1)}m';
//     }
//     return text ?? likes.toString();
//   }
//
//   static Color getRandomColor() {
//     List<Color> colors = [];
//     colors.add(const Color(0xFFE9E9F2));
//     colors.add(const Color(0xFFD8DEF2));
//     colors.add(const Color(0xFFC4DDF2));
//     colors.add(const Color(0xFFD5E5F2));
//     colors.add(const Color(0xFFDFEDF2));
//     // Generate random values for the red, green, and blue components of the color.
//     return colors[Random().nextInt(5)];
//   }
//
//   static bool isSameDay(DateTime date1, DateTime date2) {
//     // Get the year, month, and day from the two DateTime objects.
//     int year1 = date1.year;
//     int month1 = date1.month;
//     int day1 = date1.day;
//     int year2 = date2.year;
//     int month2 = date2.month;
//     int day2 = date2.day;
//
//     // If the year, month, and day are all equal, then the two dates exist in the same day.
//     return year1 == year2 && month1 == month2 && day1 == day2;
//   }
// }
