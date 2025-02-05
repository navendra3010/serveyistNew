import 'package:flutter/material.dart';
import 'package:surveyist/utils/appFont.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {super.key,
      required this.text,
      required this.color,
      required this.onPressed});
  final String text;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 100 / 100,
        height: MediaQuery.of(context).size.height * 5 / 100,
        decoration: BoxDecoration(
          color:color,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: const Color.fromARGB(255, 252, 249, 255),
              fontWeight: FontWeight.w600,
              fontSize: 18,
              fontFamily: AppFont.fontFamily,
            ),
          ),
        ),
      ),
    );
  }
}
