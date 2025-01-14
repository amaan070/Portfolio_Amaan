import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BulletTexts extends StatelessWidget {
  final String text;
  const BulletTexts({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.arrow_right),
          const SizedBox(width: 5.0),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.openSans(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
