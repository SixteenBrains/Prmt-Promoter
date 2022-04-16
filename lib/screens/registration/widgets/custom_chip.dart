import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isSelected;

  const CustomChip({
    Key? key,
    required this.label,
    required this.onTap,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Label lenht ${label.length}');
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40.0,
        //width: 100.0,
        width: label.length < 5 ? 65 : label.length * 12,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : const Color(0xffF4F4F9),
          //color: const Color(0xffF4F4F9),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
