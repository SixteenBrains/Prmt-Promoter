import 'package:flutter/material.dart';

import '/widgets/bottom_nav_button.dart';

class AdCreated extends StatelessWidget {
  const AdCreated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _canvas = MediaQuery.of(context).size;
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: _canvas.height * 0.12),
              Image.asset(
                'assets/images/Group 101.png',
                height: _canvas.height * 0.35,
                width: _canvas.height * 0.35,
                fit: BoxFit.contain,
              ),
              SizedBox(height: _canvas.height * 0.06),
              Text(
                'Awesome! Now lets select your target group, demographics and location ',
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              //const Spacer(),
            ],
          ),
        ),
        Positioned(
          bottom: 2.0,
          right: 2.0,
          left: 2.0,
          child: BottomNavButton(
            onTap: () {},
            label: 'CONTINUE',
            isEnabled: true,
          ),
        ),
      ],
    );
  }
}
