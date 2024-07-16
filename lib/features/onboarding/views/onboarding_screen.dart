import 'package:flutter/material.dart';
import 'package:my_portfolio/common/widgets/gradient_button.dart';
import 'package:my_portfolio/common/widgets/navigate_to.dart';
import 'package:my_portfolio/features/onboarding/models/intro_page.dart';
import 'package:my_portfolio/features/authentication/views/login_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({super.key});

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  //keeping a track of onboarding page
  final PageController _controller = PageController();
  final NavigateTo navigator = NavigateTo();

  //Know if we are on last page
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: const [
              //PAGE 1
              IntroPage(
                delay: 1750,
                durn: 140,
                assetPath: 'assets/round2.json',
                headingHeight: 51,
                descriptionText:
                    "Discover my journey as a developer and explore the projects I've created with passion and dedication. Swipe to get started.",
                headingText: 'Portfolio App!',
                subHeadingText: 'Welcome to My',
              ),
              //PAGE 2
              IntroPage(
                delay: 1150,
                durn: 200,
                assetPath: 'assets/hehe.json',
                headingHeight: 51,
                descriptionText:
                    "Through this app, you'll learn about my skills, experience, and the projects that showcase my abilities. Navigate through my portfolio to see what I've been working on.",
                headingText: 'Know Me!',
                subHeadingText: 'Get to',
              ),
              //PAGE 3
              IntroPage(
                delay: 1700,
                durn: 120,
                assetPath: 'assets/people.json',
                headingHeight: 102,
                descriptionText:
                    "Feel free to explore and interact with my work. Don't hesitate to reach out via the contact section to discuss potential collaborations or just to say hello!",
                headingText: 'Engage & Connect!',
                subHeadingText: "Don't Forget to",
              ),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SmoothPageIndicator(
                    effect: const SwapEffect(
                        activeDotColor: Color(0xff00BFFF), dotHeight: 10),
                    controller: _controller,
                    count: 3),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: 160,
                  child: GradientButton(
                      onPressed: () async {
                        if (onLastPage) {
                          navigator.replaceAndGoTo(
                              context: context, destination: const LoginPage());
                        } else {
                          _controller.nextPage(
                              duration: const Duration(milliseconds: 350),
                              curve: Curves.easeIn);
                        }
                      },
                      text: onLastPage ? 'Get Started' : 'Next',
                      gradient: const LinearGradient(
                          colors: [Colors.blue, Colors.green])),
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
