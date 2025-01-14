import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/common/widgets/theme_background.dart';
import 'package:my_portfolio/features/github_repo/controllers/user_provider.dart';
import 'package:provider/provider.dart';

class GithubPage extends StatefulWidget {
  const GithubPage({super.key});

  @override
  State<GithubPage> createState() => _GithubPageState();
}

class _GithubPageState extends State<GithubPage> {
  TextStyle style = GoogleFonts.spaceGrotesk(fontSize: 14);
  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'GitHub User',
            style: TextStyle(fontSize: 12),
          ),
        ),
        body: ThemeBackground(
            background_image: 'assets/images/light_background.png',
            child: Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                if (userProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (userProvider.data != null) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                userProvider.data![
                                  'avatar_url'], // Replace with your image URL
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(userProvider.data!['name'],
                                    style: GoogleFonts.montserrat(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  width: 290,
                                  child: Text(
                                    userProvider.data!['bio'] ??
                                        'No bio availabe',
                                    style: style,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: <Widget>[
                            Text(
                                '${userProvider.data!['followers']} Followers'),
                            const SizedBox(width: 20),
                            Text(
                                '${userProvider.data!['following']} Following'),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Repositories',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Write a gridview which displays all the repos
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 3 / 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: userProvider.repositories!.length,
                            itemBuilder: (context, index) {
                              final repo = userProvider.repositories![index];
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        repo['name'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        repo['description'] ?? 'No description',
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(child: Text('Failed to load user data'));
                }
              },
            )));
  }
}
