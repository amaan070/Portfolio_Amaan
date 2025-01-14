import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

class SlidingCardsProject extends StatefulWidget {
  final List<String> images;
  const SlidingCardsProject({
    super.key,
    required this.images,
  });

  @override
  State<SlidingCardsProject> createState() => _SlidingCardsViewState();
}

class _SlidingCardsViewState extends State<SlidingCardsProject> {
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: PageView.builder(
        clipBehavior: Clip.none,
        controller: pageController,
        itemCount: widget.images.length,
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
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(8, 20),
                        blurRadius: 24,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(32), bottom: Radius.circular(32)),
                    child: Image.asset(
                      widget.images[index],
                      height: MediaQuery.of(context).size.height * 0.5,
                      fit: BoxFit.fitWidth,
                      alignment: Alignment(pageOffset, 0),
                    ),
                  ),
                  // Rest of the content
                ),
              );
            },
          );
        },
      ),
    );
  }
}
