import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/common/widgets/navigate_to.dart';
import 'package:my_portfolio/common/widgets/snackbar_display.dart';
import 'package:my_portfolio/features/dashboard/views/dashboard2.dart';
import 'package:my_portfolio/features/authentication/services/authentication_service.dart';
import 'package:my_portfolio/features/authentication/views/verify_email.dart';
import 'package:provider/provider.dart';

class AuthenticationController {
  final NavigateTo navigator = NavigateTo();
  final SnackbarDisplay snackBar = SnackbarDisplay();

  //login controller
  void login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    final authService = context.read<AuthenticationService>();
    String? result =
        await authService.signInWithEmail(email: email, password: password);

    if (!FirebaseAuth.instance.currentUser!.emailVerified) {
      authService.sendVerificationEmail();
      navigator.replaceAndGoTo(
          context: context, destination: VerifyEmail(email: email));
      snackBar.displaySnackbar(
          context: context,
          message: 'Please verify your email before logging in!');
    } else {
      if (result == "Signed in") {
        navigator.replaceAndGoTo(
            context: context, destination: const ProfileScreen());
        snackBar.displaySnackbar(
            context: context, message: "Sign in successful!");
      } else if (result ==
          "The supplied auth credential is incorrect, malformed or has expired.") {
        snackBar.displaySnackbar(
            context: context,
            message:
                "Unable to log in! Check your password or try logging in using Google.");
      } else {
        snackBar.displaySnackbar(
            context: context, message: 'Sign in failed. Try again!');
      }
    }
  }

  void registerUser(
      {required String email,
      required String name,
      required String password,
      required BuildContext context}) async {
    final authService = context.read<AuthenticationService>();
    String? result = await authService.signUpWithEmail(
        email: email, password: password, name: name);

    if (result == "Sign up successful! Please verify your email.") {
      navigator.replaceAndGoTo(
          context: context, destination: VerifyEmail(email: email));
      snackBar.displaySnackbar(
          context: context,
          message: result ?? 'Sign up successful, Please verify your email!');
    } else {
      snackBar.displaySnackbar(
          context: context, message: 'Sign up failed. Try again!');
    }
  }

  void reset({required String email, required BuildContext context}) async {
    final authService = context.read<AuthenticationService>();
    String? result = await authService.resetPassword(email);

    if (result == "Password reset email sent!") {
      Navigator.of(context).pop();
      snackBar.displaySnackbar(
          context: context,
          message: 'Password reset link sent. Check you email!');
    } else {
      snackBar.displaySnackbar(
          context: context, message: result ?? 'Reset failed!');
    }
  }

  void signInWithGoogle({required BuildContext context}) async {
    String? result =
        await context.read<AuthenticationService>().signInWithGoogle();
    if (result == 'Sign in successful') {
      navigator.replaceAndGoTo(
          context: context, destination: const ProfileScreen());
      snackBar.displaySnackbar(
          context: context, message: 'Signed into your account!');
    } else {
      // Show error message if sign-in failed
      snackBar.displaySnackbar(
          context: context, message: result ?? 'An error occurred!');
    }
  }
}
