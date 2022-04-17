import 'package:flutter/material.dart';
import '/screens/profile/profile_screen.dart';
import '/screens/live-ads/screens/share_ad.dart';
import '/screens/registration/screens/registrations_screen.dart';
import '/screens/signup/otp_screen.dart';
import '/screens/live-ads/live_ads_screen.dart';
import '/screens/dashboard/dashboard.dart';
import '/screens/signup/signup_screen.dart';
import '/screens/splash/onboarding_screen.dart';
import '/screens/splash/splash_screen.dart';

import 'auth_wrapper.dart';

class CustomRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('Route: ${settings.name}');
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/'),
            builder: (_) => const Scaffold());

      case AuthWrapper.routeName:
        return AuthWrapper.route();

      case SplashScreen.routeName:
        return SplashScreen.route();

      case OnBoardingScreen.routeName:
        return OnBoardingScreen.route();

      case SignUpScreen.routeName:
        return SignUpScreen.route();

      case LiveAdsScreen.routeName:
        return LiveAdsScreen.route();

      // // case ProfileCompleted.routeName:
      // //   return ProfileCompleted.route();

      case OtpScreen.routeName:
        return OtpScreen.route(args: settings.arguments as OtpScreenArgs);

      case RegistrationScreen.routeName:
        return RegistrationScreen.route();

      case ShareAdScreen.routeName:
        return ShareAdScreen.route(args: settings.arguments as ShareAdsArgs);

      case DashBoard.routeName:
        return DashBoard.route();

      case ProfileScreen.routeName:
        return ProfileScreen.route();

      // case CreateAdScreen.routeName:
      //   return CreateAdScreen.route();

      // case PreviewAdScreen.routeName:
      //   return PreviewAdScreen.route(args: settings.arguments as PreviewAdArgs);

      // case PaymentScreen.routeName:
      //   return PaymentScreen.route(
      //       args: settings.arguments as PaymentScreenArgs);

      // case PaymentSuccussfull.routeName:
      //   return PaymentSuccussfull.route();

      // case AdDetails.routeName:
      //   return AdDetails.route(args: settings.arguments as AdDetailsArgs);

      // case ProfileScreen.routeName:
      //   return ProfileScreen.route();

      // case EditProfile.routeName:
      //   return EditProfile.route();

      // case CardPayment.routeName:
      //   return CardPayment.route(args: settings.arguments as CardPaymentArgs);

      // case RazorpayPayment.routeName:
      //   return RazorpayPayment.route(
      //       args: settings.arguments as RazorpayPaymentArgs);

      default:
        return _errorRoute();
    }
  }

  static Route onGenerateNestedRouter(RouteSettings settings) {
    print('NestedRoute: ${settings.name}');
    switch (settings.name) {
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Error',
          ),
        ),
        body: const Center(
          child: Text(
            'Something went wrong',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
