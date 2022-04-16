import 'package:flutter/material.dart';

class ProgressContainer extends StatelessWidget {
  final int progress;

  const ProgressContainer({
    Key? key,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _canvas = MediaQuery.of(context).size;
    print('Sizes --- ${(_canvas.width - 25) / 11} ');
    final _progressSize = (_canvas.width - 60) / 5;
    return Container(
      height: 18.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xffEEEEEE),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        children: [
          Container(
            width: _progressSize * progress,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ],
      ),
    );
  }
}
