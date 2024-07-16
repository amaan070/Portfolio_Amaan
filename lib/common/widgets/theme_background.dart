import 'package:flutter/material.dart';

class ThemeBackground extends StatelessWidget {
  final Widget child;
  final String background_image;

  const ThemeBackground(
      {super.key, required this.child, required this.background_image});

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return Stack(
      children: [
        isDarkTheme
            ?
            // Gradient background
            Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 2, 48, 54),
                      Color(0xff011F23),
                      Colors.black
                    ], // Light theme gradient
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              )
            : Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(background_image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
        // Main content
        SafeArea(
          child: child,
        ),
      ],
    );
  }
}
