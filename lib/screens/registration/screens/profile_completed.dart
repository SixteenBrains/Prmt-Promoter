import 'package:flutter/material.dart';
import '/screens/live-ads/live_ads_screen.dart';
import '/widgets/bottom_nav_button.dart';

class ProfileCompleted extends StatelessWidget {
  const ProfileCompleted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _canvas = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: _canvas.height * 0.15),
              Image.asset(
                'assets/images/Group 101.png',
                height: _canvas.height * 0.35,
                width: _canvas.height * 0.35,
                fit: BoxFit.contain,
              ),
              SizedBox(height: _canvas.height * 0.06),
              Text(
                'Your profile is completed.',
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0),
              Text(
                'Now let\'s create your first ad ',
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              BottomNavButton(
                onTap: () {
                  // final _regisCubit = context.read<RegistrationCubit>();
                  // _regisCubit.setFirstAdCreated();
                  // print(
                  //     'First ad  ${_regisCubit.state.currentUser?.firstAdCreated}');
                  Navigator.of(context).pushNamed(LiveAdsScreen.routeName);
                },
                label: 'START PROMOTING',
                isEnabled: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
