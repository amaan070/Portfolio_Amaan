import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/features/projects/models/app_details.dart';
import 'dart:math' as math;
import 'package:my_portfolio/features/projects/views/app_details_page.dart';

class SlidingCardsView extends StatefulWidget {
  const SlidingCardsView({
    super.key,
  });

  @override
  State<SlidingCardsView> createState() => _SlidingCardsViewState();
}

class _SlidingCardsViewState extends State<SlidingCardsView> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  final List<String> descriptions = [
    'Sample App for Google Developers Students Club',
    'Calculator App',
    'Quiz App'
  ];

  final List<String> image = [
    'assets/images/gdsc_sample.jpg',
    'assets/images/calculator.jpg',
    'assets/images/quiz.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: PageView.builder(
        clipBehavior: Clip.none,
        controller: pageController,
        itemCount: descriptions.length,
        itemBuilder: (context, index) {
          // double offset = pageOffset - index;

          return AnimatedBuilder(
            animation: pageController,
            builder: (context, child) {
              double pageOffset = 0;
              if (pageController.position.haveDimensions) {
                pageOffset = pageController.page! - index;
              }
              double gauss =
                  math.exp(-(math.pow(pageOffset.abs() - 0.5, 2) / 0.08));
              return Transform.translate(
                offset: Offset(-32 * gauss * pageOffset.sign, 0),
                child: Container(
                  clipBehavior: Clip.none,
                  margin: const EdgeInsets.only(left: 8, right: 8, bottom: 24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Theme.of(context).hoverColor,
                      Theme.of(context).dividerColor
                    ]),
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(8, 20),
                        blurRadius: 24,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // Image
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(32)),
                        child: Image.asset(
                          image[index],
                          height: MediaQuery.of(context).size.height * 0.5,
                          fit: BoxFit.cover,
                          alignment: Alignment(pageOffset, 0),
                        ),
                      ),
                      // Rest of the content
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 20, right: 20),
                        child: Text(
                          descriptions[index],
                          style: GoogleFonts.spaceGrotesk(
                              fontSize: 18, color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: OutlinedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AppDetailsPage(
                                              appDetails:
                                                  appDetailsList[index])));
                                },
                                child: const Text('Explore'))),
                      ),
                      const SizedBox(
                        height: 0,
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
