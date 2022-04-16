import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitFadingCircle(
        // lineWidth: 1.0,
        color: Colors.blue,
      ),
      // SizedBox(
      //   height: 50.0,
      //   width: 50.0,
      //   child: SpinKitChasingDots(
      //     color: Colors.white,
      //   ),
      // ),
    );
  }
}
