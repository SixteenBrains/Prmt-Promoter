import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import '/config/auth_wrapper.dart';
import '/config/shared_prefs.dart';
import '/widgets/bottom_nav_button.dart';

class OnBoardingScreen extends StatefulWidget {
  static const String routeName = '/onboarding';
  const OnBoardingScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const OnBoardingScreen(),
    );
  }

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {}

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset(
      'assets/images/$assetName',
      width: width,
      fit: BoxFit.contain,
      // height: 400.0,
      // width: 300.0,

      //fit: BoxFit.cover,
      //height: double.infinity,
      // width: double.infinity,
      alignment: Alignment.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    final _canvas = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: _canvas.height * 0.1),
              Expanded(
                child: IntroductionScreen(
                  key: introKey,
                  globalBackgroundColor: Colors.white,

                  pages: [
                    PageViewModel(
                      title: 'Showcase your ad in the',
                      bodyWidget: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Icon(
                                FontAwesomeIcons.whatsappSquare,
                                color: Colors.blue,
                                size: 38.0,
                              ),
                              Icon(
                                FontAwesomeIcons.facebookSquare,
                                color: Colors.blue,
                                size: 38.0,
                              ),
                              Icon(
                                FontAwesomeIcons.instagram,
                                color: Colors.blue,
                                size: 38.0,
                              )
                            ],
                          ),
                          const SizedBox(height: 15.0),
                          const Text(
                            'of the real users',
                            style: TextStyle(
                              // style: GoogleFonts.openSans(
                              color: Color(0xff4A4980),
                              fontSize: 25.0,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                      decoration: const PageDecoration(
                        titleTextStyle: TextStyle(
                          color: Color(0xff4A4980),
                          fontSize: 25.0,
                          fontWeight: FontWeight.w600,
                        ),
                        imageAlignment: Alignment.center,
                        //imagePadding: const EdgeInsets.only(top: 100.0),
                      ),
                      image: _buildImage('Group 121.png'),
                    ),
                    PageViewModel(
                      title: '',
                      bodyWidget: Text(
                        'Maximum reach and conversions from the minimum investment',
                        style: GoogleFonts.openSans(
                          color: const Color(0xff4A4980),
                          fontSize: 25.0,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      decoration: PageDecoration(
                        titleTextStyle: GoogleFonts.openSans(
                          color: const Color(0xff4A4980),
                          fontSize: 25.0,
                          fontWeight: FontWeight.w600,
                        ),
                        imageAlignment: Alignment.center,
                        // imagePadding: const EdgeInsets.only(top: 100.0),
                      ),
                      image: _buildImage('Group 67.png'),
                    ),
                  ],
                  onDone: () => _onIntroEnd(context),
                  //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
                  showSkipButton: false,
                  skipOrBackFlex: 0,
                  nextFlex: 0,
                  showDoneButton: false,
                  showNextButton: false, showBackButton: false,
                  curve: Curves.fastLinearToSlowEaseIn,
                  controlsMargin: const EdgeInsets.all(16),
                  controlsPadding: kIsWeb
                      ? const EdgeInsets.all(12.0)
                      : EdgeInsets.fromLTRB(
                          8.0, 4.0, 8.0, _canvas.height * 0.1),
                  dotsDecorator: const DotsDecorator(
                    size: Size(10.0, 10.0),
                    color: Color(0xFFBDBDBD),
                    activeSize: Size(22.0, 10.0),
                    activeColor: Color(0xff4243E6),
                    activeSizes: [
                      Size(15.0, 15.0),
                      Size(15.0, 15.0),
                    ],
                  ),
                  dotsContainerDecorator: const ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                  ),
                ),
              ),
              BottomNavButton(
                isEnabled: true,
                onTap: () async {
                  await SharedPrefs().setFirstTime(false);
                  Navigator.of(context).pushNamed(AuthWrapper.routeName);
                  // Navigator.of(context)
                  //     .push(MaterialPageRoute(builder: (_) => SignUpScreen()));
                },
                label: 'LOG IN OR SIGN UP',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
