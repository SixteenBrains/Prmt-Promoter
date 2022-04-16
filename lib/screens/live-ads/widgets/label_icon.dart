import 'package:flutter/material.dart';

class LabelIcon extends StatelessWidget {
  final String? label;
  final IconData icon;
  const LabelIcon({Key? key, required this.label, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 15.0,
          color: Colors.grey.shade600,
        ),
        const SizedBox(width: 4.0),
        Text(label ?? ''),
      ],
    );
  }
}
