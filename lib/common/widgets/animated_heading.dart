import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedHeading extends StatelessWidget {
  final String headingText;
  final int durn;
  final double fontSize;
  const AnimatedHeading(
      {super.key,
      required this.headingText,
      required this.durn,
      required this.fontSize});

  @override
  Widget build(BuildContext context) {
    final colorizeTextStyle = GoogleFonts.spaceGrotesk(
        fontWeight: FontWeight.bold, fontSize: fontSize);
    final colorizeColors = [
      Colors.blue,
      const Color.fromARGB(255, 113, 230, 117),
    ];
    return SizedBox(
      width: 250.0,
      child: AnimatedTextKit(
        pause: const Duration(milliseconds: 1000),
        repeatForever: true,
        animatedTexts: [
          ColorizeAnimatedText(headingText,
              textStyle: colorizeTextStyle,
              colors: colorizeColors,
              textAlign: TextAlign.center),
        ],
        isRepeatingAnimation: true,
        onTap: () {},
      ),
    );
  }
}
