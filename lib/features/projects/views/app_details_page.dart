import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/common/widgets/animated_heading.dart';
import 'package:my_portfolio/common/widgets/animated_sub_heading.dart';
import 'package:my_portfolio/common/widgets/theme_background.dart';
import 'package:my_portfolio/features/projects/data/app_details.dart';
import 'package:my_portfolio/features/projects/models/cards_for_projects.dart';
import 'package:my_portfolio/features/projects/models/features_list.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AppDetailsPage extends StatefulWidget {
  final AppDetails appDetails;

  const AppDetailsPage({
    super.key,
    required this.appDetails,
  });

  @override
  State<AppDetailsPage> createState() => _AppDetailsPageState();
}

class _AppDetailsPageState extends State<AppDetailsPage> {
  late YoutubePlayerController _controller;
  Future openAppWebView(String url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw Exception('Invalid Link');
    }
  }

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.appDetails.ytLink, // Replace with your video id
      flags: const YoutubePlayerFlags(
          autoPlay: false, mute: false, showLiveFullscreenButton: true),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.appDetails.appTitle,
          style: GoogleFonts.spaceGrotesk(fontSize: 16),
        ),
      ),
      body: ThemeBackground(
          background_image: 'assets/images/light_background.png',
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.asset(widget.appDetails.startImage)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: AnimatedSubHeading(
                      subHeadingText: 'Welcome to the',
                      durn: 100,
                      fontSize: 20,
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: AnimatedHeading(
                      headingText: widget.appDetails.appTitle,
                      durn: 100,
                      fontSize: 36,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
                  child: Text(
                    widget.appDetails.description,
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.spaceGrotesk(fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
                  child: Text(
                    'UI Gallery',
                    style: GoogleFonts.spaceGrotesk(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SlidingCardsProject(images: widget.appDetails.imageLink),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 12),
                  child: Text(
                    'Key Features',
                    style: GoogleFonts.spaceGrotesk(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                FeaturesList(features: widget.appDetails.features),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 30),
                  child: Text(
                    'Interact with my app!',
                    style: GoogleFonts.spaceGrotesk(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        openAppWebView(widget.appDetails.codeLink);
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.github),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text('Source Code')
                        ],
                      )),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 10),
                  child: Text(
                    'Demo Video',
                    style: GoogleFonts.spaceGrotesk(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
                  child: Container(
                    height: 600,
                    width: 350,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: YoutubePlayer(
                        controller: _controller,
                        showVideoProgressIndicator: true,
                        progressIndicatorColor: Colors.amber,
                        progressColors: const ProgressBarColors(
                          playedColor: Colors.amber,
                          handleColor: Colors.amberAccent,
                        ),
                        onReady: () {
                          _controller.addListener(() {});
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                )
              ],
            ),
          )),
    );
  }
}
