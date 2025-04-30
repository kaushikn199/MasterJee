import 'package:flutter/material.dart';

class CircularRadioButton extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final double size;
  final double innerCircleSize;
  final Color selectedColor;
  final Color unselectedColor;

  const CircularRadioButton({
    Key? key,
    required this.isSelected,
    required this.onTap,
    this.size = 20,
    this.innerCircleSize = 10,
    this.selectedColor = Colors.green,
    this.unselectedColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? selectedColor : unselectedColor,
            width: 2,
          ),
        ),
        child: isSelected
            ? Center(
          child: Container(
            width: innerCircleSize,
            height: innerCircleSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selectedColor,
            ),
          ),
        )
            : null,
      ),
    );
  }
}
