import 'package:flutter/material.dart';
import 'package:sessions/constants.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {super.key,
      required this.title,
      required this.onPress,
      this.color = kPrimaryColor,
      this.textColor = Colors.white,
      this.pressEnable = true});

  final String title;
  final VoidCallback onPress;
  final Color color, textColor;
  final bool pressEnable;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.75,
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          disabledBackgroundColor: color,
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: pressEnable ? onPress : null,
        child: Text(
          title,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
    );
  }
}
