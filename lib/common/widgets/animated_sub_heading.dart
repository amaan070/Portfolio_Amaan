import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedSubHeading extends StatelessWidget {
  final String subHeadingText;
  final int durn;
  final double fontSize;
  const AnimatedSubHeading(
      {super.key,
      required this.subHeadingText,
      required this.durn,
      required this.fontSize});

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      width: 250.0,
      child: DefaultTextStyle(
        style: GoogleFonts.spaceGrotesk(
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
            color: isDarkTheme ? Colors.white : Colors.black),
        child: AnimatedTextKit(
          totalRepeatCount: 1,
          animatedTexts: [
            TypewriterAnimatedText(subHeadingText,
                speed: Duration(milliseconds: durn),
                textAlign: TextAlign.center),
          ],
          onTap: () {},
        ),
      ),
    );
  }
}
