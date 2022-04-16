import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/screens/splash/splash_screen.dart';
import '/blocs/auth/auth_bloc.dart';
import 'blocs/simple_bloc_observer.dart';
import 'config/custom_router.dart';
import 'config/shared_prefs.dart';
import 'repositories/ads/ads_repository.dart';
import 'repositories/auth/auth_repository.dart';
import 'repositories/profile/profile_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Stripe.publishableKey = stripePublishableKey;
  // Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  // Stripe.urlScheme = 'flutterstripe';
  // await Stripe.instance.applySettings();
  if (kIsWeb) {
    // await Firebase.initializeApp(
    //   options: const FirebaseOptions(
    //     apiKey: 'AIzaSyAog5tvJGNb63Hjbe6TpPVPW_Qp_D9iKRs',
    //     appId: '1:526121573343:web:b0caef970924f065c6c26a',
    //     messagingSenderId: '526121573343',
    //     projectId: 'viewyourstories-4bf4d',
    //     storageBucket: 'viewyourstories-4bf4d.appspot.com',
    //   ),
    // );
  } else {
    await Firebase.initializeApp();
  }

  await SharedPrefs().init();
  EquatableConfig.stringify = kDebugMode;
  // Bloc.observer = SimpleBlocObserver();
  BlocOverrides.runZoned(() {}, blocObserver: SimpleBlocObserver());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(

          /// systemNavigationBarColor: Colors.blue, // navigation bar color
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark // status bar color
          ),
    );
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (_) => AuthRepository(),
        ),
        RepositoryProvider<ProfileRepository>(
          create: (_) => ProfileRepository(),
        ),
        RepositoryProvider<AdsRepository>(
          create: (_) => AdsRepository(),
        )
        // RepositoryProvider<RegistrationRepository>(
        //   create: (_) => RegistrationRepository(),
        // ),
        // RepositoryProvider<AdRepository>(
        //   create: (_) => AdRepository(),
        // ),
        // RepositoryProvider<PaymentRepository>(
        //   create: (_) => PaymentRepository(),
        // )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
                authRepository: context.read<AuthRepository>(),
                profileRepository: context.read<ProfileRepository>()),
          ),
          // BlocProvider(
          //   create: (context) => SignUpCubit(),
          // )
        ],
        child: MaterialApp(
          //showPerformanceOverlay: true,
          theme: ThemeData(
            fontFamily: 'GoogleSans',
            scaffoldBackgroundColor: Colors.white,
          ),
          debugShowCheckedModeBanner: false,
          //  home: const SplashScreen3(),

          //  const ShowUp(
          //   child: Scaffold(
          //     body: Center(
          //       child: Text('I am good'),
          //     ),
          //   ),
          //   delay: 10,
          // ),
          onGenerateRoute: CustomRouter.onGenerateRoute,
          initialRoute: SplashScreen.routeName,

          // debugShowCheckedModeBanner: false,
          // title: 'Flutter Demo',
          // theme: ThemeData(
          //   scaffoldBackgroundColor: Colors.white,
          //   primarySwatch: Colors.blue,
          //   fontFamily: 'GoogleSans',
          // ),
          // home: const SplashScreen(),
          //home: const DashBoard(),
        ),
      ),
    );
  }
}
