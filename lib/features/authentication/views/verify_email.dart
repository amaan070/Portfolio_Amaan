import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_portfolio/common/widgets/navigate_to.dart';
import 'package:my_portfolio/common/widgets/snackbar_display.dart';
import 'package:my_portfolio/features/authentication/services/authentication_service.dart';
import 'package:my_portfolio/common/widgets/gradient_button.dart';
import 'package:my_portfolio/common/widgets/theme_background.dart';
import 'package:my_portfolio/features/authentication/views/login_page.dart';
import 'package:provider/provider.dart';

class VerifyEmail extends StatefulWidget {
  final String email;
  const VerifyEmail({super.key, required this.email});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final SnackbarDisplay snackBar = SnackbarDisplay();
  late Timer timer;
  bool isButtonEnabled = true;
  final NavigateTo navigator = NavigateTo();

  @override
  void initState() {
    super.initState();
    final authService = context.read<AuthenticationService>();
    authService.sendVerificationEmail();
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      User? user = FirebaseAuth.instance.currentUser;
      user!.reload();
      if (user.emailVerified) {
        timer.cancel();
        navigator.replaceAndGoTo(
            context: context, destination: const LoginPage());
        snackBar.displaySnackbar(
            context: context, message: 'Login into your account now!');
      }
    });
  }

  void _disableButton() {
    setState(() {
      isButtonEnabled = false;
    });

    Timer(const Duration(seconds: 30), () {
      setState(() {
        isButtonEnabled = true;
      });
    });
  }

  void _sendVerificationEmail() async {
    final authService = context.read<AuthenticationService>();
    await authService.sendVerificationEmail();
    _disableButton();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(75.0), // Set the desired height
        child: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0), // Adjust the padding as needed
            child: Image.asset(
                'assets/images/amn.png'), // Replace with your logo path
          ),
        ),
      ),
      body: ThemeBackground(
        background_image: 'assets/images/light.jpg',
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 40),
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Verify your',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    'Email!',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'A verification link has been sent to ${widget.email}!',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  Lottie.asset('assets/verifyemail.json'),
                  Consumer<AuthenticationService>(
                    builder: (context, authService, child) {
                      return authService.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : SizedBox(
                              width: double.infinity,
                              height: 55,
                              child: isButtonEnabled
                                  ? GradientButton(
                                      onPressed: () {
                                        _sendVerificationEmail();
                                        snackBar.displaySnackbar(
                                            context: context,
                                            message:
                                                'Verification link sent to your mail!');
                                      },
                                      text: 'Resend Verification Link',
                                      gradient: LinearGradient(colors: [
                                        Theme.of(context).hoverColor,
                                        Theme.of(context).dividerColor
                                      ]),
                                    )
                                  : GradientButton(
                                      onPressed: () {
                                        snackBar.displaySnackbar(
                                            context: context,
                                            message:
                                                'Wait 30s before resending email.');
                                      },
                                      text: 'Resend Verification Link',
                                      gradient: const LinearGradient(colors: [
                                        Colors.grey,
                                        Color.fromARGB(255, 59, 59, 59)
                                      ]),
                                    ),
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
