import 'dart:io';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:my_portfolio/common/widgets/theme_background.dart';
import 'package:my_portfolio/features/authentication/services/authentication_service.dart';
import 'package:my_portfolio/features/authentication/views/login_page.dart';
import 'package:my_portfolio/features/github_repo/views/github_page.dart';
import 'package:my_portfolio/features/projects/views/projects.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future fetchTweet() async {
    http.Response response;
    response = await http.get(Uri.parse('uri'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 2, 50, 55),
        child: Column(
          children: [
            DrawerHeader(
                child: SizedBox(
                    height: 75,
                    width: 75,
                    child: Image.asset('assets/images/amn.png'))),
            ListTile(
              leading: Icon(FontAwesomeIcons.rocket),
              title: Text('P R O J E C T S'),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.toolbox),
              title: Text('S K I L L S'),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.graduationCap),
              title: Text('E X P E R I E N C E'),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.phone),
              title: Text('C O N T A C T'),
            ),
            const Text(
              '________________',
              style: TextStyle(color: Color.fromARGB(255, 187, 187, 187)),
            ),
            const SizedBox(
              height: 8,
            ),
            ListTile(
              autofocus: true,
              leading: Icon(Icons.person_3),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Preferences'),
            ),
            GestureDetector(
              onTap: () {
                context.read<AuthenticationService>().signOut();
                context.read<AuthenticationService>().signOutFromGoogle();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              child: ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
              ),
            )
          ],
        ),
      ),
      body: ThemeBackground(
        background_image: 'assets/images/light_background.png',
        child: CustomScrollView(
          slivers: [
            //silver app bar
            SliverAppBar(
              clipBehavior: Clip.antiAlias,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: Text(
                'A M A A N  A H M A D',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: 16),
              ),
              expandedHeight: 300,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(200),
                    bottomRight: Radius.circular(200),
                  ),
                  child: Image.asset(
                    'assets/images/amaan_ahmad.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            //items

            SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 40.0, right: 30, left: 30, bottom: 10),
                  child: Text(
                    'Hi, Welcome to my Space',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    height: 50,
                    child: Text(
                      "I'm a . . . .",
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 28,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  height: 50,
                  child: DefaultTextStyle(
                    style: GoogleFonts.bungeeOutline(
                        fontSize: 38,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                    child: AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: [
                        RotateAnimatedText('CODER',
                            duration: Duration(milliseconds: 1500)),
                        RotateAnimatedText('APP DEVELOPER',
                            duration: Duration(milliseconds: 1500)),
                        RotateAnimatedText('ENGINEER',
                            duration: Duration(milliseconds: 1500)),
                      ],
                      onTap: () {},
                    ),
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  height: 50,
                  child: OutlinedButton(
                      onPressed: () {
                        openFile(
                            url:
                                'https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_1mb.mp4',
                            fileName: 'cv.mp4');
                      },
                      child: Text(
                        'DOWNLOAD CV',
                      )),
                ),
              ),
            ),

            //Projects
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
                child: Text(
                  "View Projects",
                  style: GoogleFonts.spaceGrotesk(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 20, left: 25, right: 25),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProjectsPage()));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                        height: 270,
                        child: Lottie.asset('assets/projects_lite.json',
                            fit: BoxFit.fitWidth)),
                  ),
                ),
              ),
            ),

            //skils
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
                child: Text(
                  "View Skills",
                  style: GoogleFonts.spaceGrotesk(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 25.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Color(0xff01469D), Color(0xff051B4B)])),
                      height: 270,
                      child: Lottie.asset('assets/skills_dark.json',
                          fit: BoxFit.contain)),
                ),
              ),
            ),

            //experience
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 50, bottom: 5),
                child: Text(
                  "View Experience",
                  style: GoogleFonts.spaceGrotesk(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 25.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 270,
                    color: Colors.grey,
                    child: Lottie.asset('assets/experience.json',
                        fit: BoxFit.fill),
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 50, bottom: 5),
                child: Text(
                  "Let's Connect!",
                  style: GoogleFonts.spaceGrotesk(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
                child: Container(
                  height: 250,
                  padding: const EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey), // Outline color
                    borderRadius:
                        BorderRadius.circular(10.0), // Rounded corners
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 45.0),
                        child: Text(
                          'Find me on:',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            FontAwesomeIcons.linkedin,
                            size: 40,
                          ),
                          Icon(
                            FontAwesomeIcons.instagram,
                            size: 40,
                          ),
                          Icon(
                            FontAwesomeIcons.twitter,
                            size: 40,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Look at my GitHub '),
                              Icon(FontAwesomeIcons.github)
                            ],
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const GithubPage()));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 40.0, right: 30, left: 30, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.copyright,
                        size: 9,
                        color: Colors.grey[700],
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '2024 AMAAN AHMAD. ALL RIGHT RESERVED.',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future openFile({required String url, required String? fileName}) async {
    final file = await downloadFile(url, fileName!);
    if (file == null) return;
    print('Path: ${file.path}');
    OpenFile.open(file.path);
  }

  Future<File?> downloadFile(String url, String name) async {
    final appsStorage = await getApplicationDocumentsDirectory();
    final file = File('${appsStorage.path}/$name');

    try {
      final response = await Dio().get(url,
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              receiveTimeout: Duration.zero));

      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      return file;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
