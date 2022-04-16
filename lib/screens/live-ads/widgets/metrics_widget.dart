import 'package:flutter/material.dart';

class MetricsWidget extends StatelessWidget {
  final double width;
  final BorderRadiusGeometry borderRadius;
  const MetricsWidget({
    Key? key,
    required this.width,
    required this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      width: width,
      decoration: BoxDecoration(
          border: Border.all(
            width: 0.5,
            color: const Color(0xffDEB030),
          ),
          borderRadius: borderRadius),
      child: Column(
        //  mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20.0),
          Image.asset('assets/images/note.png'),
          const SizedBox(height: 10.0),
          const Text(
            '₹ 20.00',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20.0,
            ),
          ),
          const SizedBox(height: 2.0),
          const Text('PER CONVERSION')
        ],
      ),
    );
  }
}
