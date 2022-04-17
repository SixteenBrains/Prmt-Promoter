import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/screens/dashboard/dashboard.dart';
import '/screens/registration/screens/registrations_screen.dart';
import '/screens/signup/signup_screen.dart';
import '/blocs/auth/auth_bloc.dart';
import '/widgets/loading_indicator.dart';

class AuthWrapper extends StatelessWidget {
  static const String routeName = '/authwrapper';

  const AuthWrapper({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const AuthWrapper(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.unauthenticated) {
          Navigator.of(context).pushNamed(SignUpScreen.routeName);
        } else if (state.status == AuthStatus.authenticated) {
          //  print('Auth State user - ${state.user}');
          if (state.promoter?.name == null && state.promoter?.email == null) {
            // this is first time user where their account is not created
            Navigator.of(context).pushNamed(RegistrationScreen.routeName);
          } else {
            Navigator.of(context).pushNamed(DashBoard.routeName);
            // Navigator.of(context).pushNamed(LiveAdsScreen.routeName);
            //Navigator.of(context).pushNamed(DashBoard.routeName);
            // Navigator.of(context).pushNamed(RegistrationScreen.routeName);
          }

          //
        }
      },
      child: const Scaffold(
        body: LoadingIndicator(),
      ),
    );
  }
}
