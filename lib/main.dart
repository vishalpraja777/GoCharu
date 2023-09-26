import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:follow_dp/controller/auth_controller.dart';
import 'package:follow_dp/controller/crud_crontroller.dart';
import 'package:follow_dp/controller/firebase_api_messaging.dart';
import 'package:follow_dp/theme/app_theme.dart';
import 'package:follow_dp/views/pages/ads/interstitial_ad_page.dart';
import 'package:follow_dp/views/pages/authentication/email_verification.dart';
import 'package:follow_dp/views/pages/authentication/signuppage.dart';
import 'package:follow_dp/views/pages/forgot_password_screen.dart';
import 'package:follow_dp/views/pages/homepage.dart';
import 'package:follow_dp/views/pages/onboarding_page.dart';
import 'package:follow_dp/views/pages/authentication/loginpage.dart';
import 'package:follow_dp/views/pages/authentication/phone_verification/otp_verification.dart';
import 'package:follow_dp/views/pages/authentication/phone_verification/phone_number_page.dart';
import 'package:follow_dp/views/pages/test_page.dart';
import 'package:follow_dp/views/pages/update_profile.dart';
import 'package:follow_dp/views/pages/user_info.dart';
import 'package:follow_dp/views/pages/view_photo.dart';
import 'package:get/get.dart';
// import 'package:follow_dp/views/pages/authentication/loginpage.dart';
import 'firebase_options.dart';
import 'views/pages/authentication/splash_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) {
    Get.put(AuthController());
    Get.put(CrudController());
  });
  await FirebaseApiMeaasging().initNoifications();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        'loginPage': (context) => LoginPage(),
        'signuppage': (context) => const SignupPage(),
        'userinfo': (context) => const UserInfo(),
        'phone': (context) => const PhoneNumberPage(),
        'otp': (context) => const OtpVerification(),
        'onboarding': (context) => const OnboardingPage(),
        'homepage': (context) => const Homepage(),
        'splashscreen': (context) => const SplashScreen(),
        'emailVerification': (context) => const EmailVerification(),
        'updateProfile': (context) => const UpdateProfile(),
        'viewPhoto': (context) => const ViewPhoto(),
        'forgotPasswordScreen': (context) => const ForgotPasswordScreen(),
        'testpage': (context) => const TestPage(),
      },
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: const SplashScreen(),
      // home: InterstitialAdPage(),
    );
  }
}
