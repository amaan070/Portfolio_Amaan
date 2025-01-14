import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:my_portfolio/common/widgets/animated_heading.dart';
import 'package:my_portfolio/common/widgets/animated_sub_heading.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({
    super.key,
    required this.delay,
    required this.durn,
    required this.assetPath,
    required this.headingHeight,
    required this.descriptionText,
    required this.headingText,
    required this.subHeadingText,
  });
  final int delay;
  final int durn;
  final String assetPath;
  final double headingHeight;
  final String descriptionText;
  final String headingText;
  final String subHeadingText;

  @override
  IntroPageState createState() => IntroPageState();
}

class IntroPageState extends State<IntroPage> {
  bool _showHeadingText = false;

  @override
  void initState() {
    super.initState();
    // Delay the display of animatedPortfolioText by 2.5 seconds
    Future.delayed(Duration(milliseconds: widget.delay), () {
      setState(() {
        _showHeadingText = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff1E1F1E),
        body: Stack(
          children: [
            // Background image
            // Gradient background
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 2, 48, 54),
                    Color(0xff011F23),
                    Colors.black
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 300,
                      width: 300,
                      child: Lottie.asset(widget.assetPath)),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      AnimatedSubHeading(
                        subHeadingText: widget.subHeadingText,
                        durn: widget.durn,
                        fontSize: 28,
                      ),
                      _showHeadingText
                          ? AnimatedHeading(
                              headingText: widget.headingText,
                              durn: widget.durn,
                              fontSize: 36,
                            )
                          : SizedBox(
                              height: widget.headingHeight,
                              width: 60,
                            )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.descriptionText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
