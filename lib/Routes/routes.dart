import 'package:computer_service/View/Contect_us.dart';
import 'package:computer_service/View/ForgotPasswordModoule/view.dart';
import 'package:computer_service/View/PrivacyPolicy.dart';
import 'package:computer_service/View/SignUpModoule/View.dart';
import 'package:computer_service/View/create_support.dart';
import 'package:computer_service/View/get_all_support.dart';
import 'package:computer_service/View/productdetails/product_details_page.dart';
import 'package:get/get.dart';

import '../View/HomeModoule/HomeScreen.dart';
import '../View/LoginModoule/View.dart';

abstract class Routes {
  static const LOGIN = '/login';
  static const SIGNP = '/signup';
  static const FORGOT_PASSWORD = '/forgotpassword';
  static const HOME = '/home';
  static const PRODUCT_DETAILS = '/productdetails';
  static const CREATE_SUPPORT = '/createsupoort';
  static const GET_ALL_SUPPORT = '/getallSupport';
  static const PRIVACY_POLICY = '/privacyPolicy';
  static const CONTACT_US = '/contactus';
}

abstract class AppPages {
  static final pages = [
    GetPage(name: Routes.LOGIN, page: () => LoginScreen()),
    GetPage(name: Routes.SIGNP, page: () => SignUp()),
    GetPage(name: Routes.FORGOT_PASSWORD, page: () => ForgotPassword()),
    GetPage(name: Routes.HOME, page: () => HomeScreen()),
    GetPage(name: Routes.PRODUCT_DETAILS, page: () => ProductDetailScreen()),
    GetPage(name: Routes.CREATE_SUPPORT, page: () => CreateSupport()),
    GetPage(name: Routes.GET_ALL_SUPPORT, page: () => GetAllSupport()),
    GetPage(name: Routes.PRIVACY_POLICY, page: () => PrivacyPolicy()),
    GetPage(name: Routes.CONTACT_US, page: () => ContactUS()),
  ];
}
