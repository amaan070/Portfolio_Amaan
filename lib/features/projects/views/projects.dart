import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/common/widgets/theme_background.dart';
import 'package:my_portfolio/features/projects/models/exhibition_bottom_sheet.dart';
import 'package:my_portfolio/features/projects/models/sliding_cards.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            'P R O J E C T S',
            style: GoogleFonts.spaceGrotesk(fontSize: 16),
          )),
      body: ThemeBackground(
          child: Stack(
            children: <Widget>[
              SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 20),
                    Center(
                      child: Text(
                        'Featured Projects',
                        style: GoogleFonts.spaceGrotesk(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 10),
                    SlidingCardsView(),
                  ],
                ),
              ),
              ExhibitionBottomSheet(), //use this or ScrollableExhibitionSheet
            ],
          ),
          background_image: 'assets/images/light_background.png'),
    );
  }
}
