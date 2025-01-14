// lib/models/app_details.dart

class AppDetails {
  final String ytLink;
  final String appTitle;
  final String startImage;
  final String description;
  final String codeLink;
  final List<String> imageLink;
  final List<String> features;

  const AppDetails({
    required this.ytLink,
    required this.appTitle,
    required this.startImage,
    required this.description,
    required this.codeLink,
    required this.imageLink,
    required this.features,
  });
}
