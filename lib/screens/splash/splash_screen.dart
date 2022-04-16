import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/config/auth_wrapper.dart';
import '/config/shared_prefs.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash';
  const SplashScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const SplashScreen(),
    );
  }

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  // double value = 0.0;
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 500), (time) {
      print('Timer tick -- ${_timer.tick}');
      if (_timer.tick == 3) {
        setState(() {
          selected = true;
        });
      }

      if (_timer.tick == 4) {
        setState(() {
          animated = true;
        });
      } else if (_timer.tick == 6) {
        _timer.cancel();
        final routeName = SharedPrefs().isFirstTime
            ? OnBoardingScreen.routeName
            : AuthWrapper.routeName;

        Navigator.of(context).pushNamed(routeName);
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    print('Dispose is called');
    super.dispose();
  }

  bool animated = false;
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(

          /// systemNavigationBarColor: Colors.blue, // navigation bar color
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark // status bar color
          ),
    );
    print('Moving --- ${_timer.tick < 5}');
    final _canvas = MediaQuery.of(context).size;
    const text = 'PR      M      T     ';
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF4243E6),
              Color(0xff1A1091),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          color: Colors.purple,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      animated ? text.replaceAll(' ', '') : text,
                      //  value >= 1.4 ? text.replaceAll(' ', '') : text,
                      //  animated ? ' PRMT' : 'PR      M      T     ',

                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 60.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -7.0,
                      ),
                    ),
                    Text(
                      'YOUR BUSSINESS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                        letterSpacing: animated ? -0.0 : 8.0,
                      ),
                    ),
                  ],
                ),
              ),
              if (!animated)
                AnimatedPositioned(
                  top: selected ? -50 : _canvas.height * 0.432,
                  // bottom: selected ? -70 : _canvas.height * 0.475,
                  //  top: selected ? -50 : _canvas.height * 0.432,
                  // top: _canvas.height * 0.432,
                  //  right: 130.0,
                  right: _canvas.width * 0.33,
                  // top: selected ? -50 : 350.0,
                  // right: 130.0,
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeInOutBack,
                  child: const Text(
                    'O',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 60.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -7.0,
                    ),
                  ),
                ),
              if (!animated)
                AnimatedPositioned(
                  bottom: selected ? -70 : _canvas.height * 0.475,

                  //top: _canvas.height * 0.432,
                  //  right: 130.0,
                  right: _canvas.width * 0.56,
                  // top: selected ? -50 : 350.0,
                  // right: 130.0,
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeInOutBack,
                  child: const Text(
                    'O',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 60.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -7.0,
                    ),
                  ),
                ),
              if (!animated)
                AnimatedPositioned(
                  bottom: selected ? -70 : _canvas.height * 0.475,
                  //   bottom: selected ? 150 : _canvas.height * 0.9,
                  //  top: selected ? 150 : _canvas.height * 0.432,
                  // top: _canvas.height * 0.432,
                  //  right: 130.0,
                  right: _canvas.width * 0.19,
                  // top: selected ? -50 : 350.0,
                  // right: 130.0,
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeInOutBack,
                  child: const Text(
                    'E',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 60.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -7.0,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}








// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import '/config/auth_wrapper.dart';
// import '/config/shared_prefs.dart';
// import '/screens/onboarding/onboarding_screen.dart';

// class SplashScreen extends StatefulWidget {
//   static const String routeName = '/splash';
//   const SplashScreen({Key? key}) : super(key: key);

//   static Route route() {
//     return MaterialPageRoute(
//       settings: const RouteSettings(name: routeName),
//       builder: (_) => const SplashScreen(),
//     );
//   }

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   late Timer _timer;
//   // double value = 0.0;
//   @override
//   void initState() {
//     super.initState();
//     _timer = Timer.periodic(const Duration(seconds: 1), (time) {
//       if (_timer.tick == 1) {
//         setState(() {
//           selected = true;
//         });
//       }

//       if (_timer.tick == 2) {
//         setState(() {
//           animated = true;
//         });
//       } else if (_timer.tick == 3) {
//         //  _timer.cancel();
//         // final routeName = SharedPrefs().isFirstTime
//         //     ? OnBoardingScreen.routeName
//         //     : AuthWrapper.routeName;

//         // Navigator.of(context).pushNamed(routeName);
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     print('Dispose is called');
//     super.dispose();
//   }

//   bool animated = false;
//   bool selected = false;

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(
//       const SystemUiOverlayStyle(

//           /// systemNavigationBarColor: Colors.blue, // navigation bar color
//           statusBarColor: Colors.transparent,
//           statusBarIconBrightness: Brightness.dark // status bar color
//           ),
//     );
//     print('Moving --- ${_timer.tick < 5}');
//     final _canvas = MediaQuery.of(context).size;
//     const text = 'PR      M      T     ';
//     return WillPopScope(
//       onWillPop: () async => false,
//       child: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(0xFF4243E6),
//               Color(0xff1A1091),
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           color: Colors.purple,
//         ),
//         child: Scaffold(
//           backgroundColor: Colors.transparent,
//           body: Stack(
//             children: [
//               Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       animated ? text.replaceAll(' ', '') : text,
//                       //  value >= 1.4 ? text.replaceAll(' ', '') : text,
//                       //  animated ? ' PRMT' : 'PR      M      T     ',

//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 60.0,
//                         fontWeight: FontWeight.w600,
//                         letterSpacing: -7.0,
//                       ),
//                     ),
//                     Text(
//                       'YOUR BUSSINESS',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 28.0,
//                         letterSpacing: animated ? -0.0 : 8.0,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               if (!animated)
//                 AnimatedPositioned(
//                   top: selected ? -50 : _canvas.height * 0.432,
//                   // bottom: selected ? -70 : _canvas.height * 0.475,
//                   //  top: selected ? -50 : _canvas.height * 0.432,
//                   // top: _canvas.height * 0.432,
//                   //  right: 130.0,
//                   right: _canvas.width * 0.33,
//                   // top: selected ? -50 : 350.0,
//                   // right: 130.0,
//                   duration: const Duration(milliseconds: 1000),
//                   curve: Curves.easeInOutBack,
//                   child: const Text(
//                     'O',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 60.0,
//                       fontWeight: FontWeight.w600,
//                       letterSpacing: -7.0,
//                     ),
//                   ),
//                 ),
//               if (!animated)
//                 AnimatedPositioned(
//                   bottom: selected ? -70 : _canvas.height * 0.475,

//                   //top: _canvas.height * 0.432,
//                   //  right: 130.0,
//                   right: _canvas.width * 0.56,
//                   // top: selected ? -50 : 350.0,
//                   // right: 130.0,
//                   duration: const Duration(milliseconds: 1000),
//                   curve: Curves.easeInOutBack,
//                   child: const Text(
//                     'O',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 60.0,
//                       fontWeight: FontWeight.w600,
//                       letterSpacing: -7.0,
//                     ),
//                   ),
//                 ),
//               if (!animated)
//                 AnimatedPositioned(
//                   bottom: selected ? -70 : _canvas.height * 0.475,
//                   //   bottom: selected ? 150 : _canvas.height * 0.9,
//                   //  top: selected ? 150 : _canvas.height * 0.432,
//                   // top: _canvas.height * 0.432,
//                   //  right: 130.0,
//                   right: _canvas.width * 0.19,
//                   // top: selected ? -50 : 350.0,
//                   // right: 130.0,
//                   duration: const Duration(milliseconds: 1000),
//                   curve: Curves.easeInOutBack,
//                   child: const Text(
//                     'E',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 60.0,
//                       fontWeight: FontWeight.w600,
//                       letterSpacing: -7.0,
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



