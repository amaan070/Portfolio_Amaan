import 'package:flutter/material.dart';
import 'package:my_portfolio/features/authentication/controllers/auth_controller.dart';
import 'package:my_portfolio/features/authentication/services/authentication_service.dart';
import 'package:my_portfolio/common/widgets/gradient_button.dart';
import 'package:my_portfolio/common/widgets/theme_background.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final AuthenticationController _authController = AuthenticationController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(75.0), // Set the desired height
          child: AppBar(
            leading: Padding(
              padding:
                  const EdgeInsets.all(8.0), // Adjust the padding as needed
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
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Reset your',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      'Password!',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Enter your email to receive a password reset link.',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    const SizedBox(height: 40),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        hintText: 'E-mail',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Consumer<AuthenticationService>(
                      builder: (context, authService, child) {
                        return authService.isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : SizedBox(
                                width: double.infinity,
                                height: 55,
                                child: GradientButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                        _authController.reset(
                                            email: _emailController.text.trim(),
                                            context: context);
                                      }
                                    },
                                    text: 'Send Reset Link',
                                    gradient: LinearGradient(colors: [
                                      Theme.of(context).hoverColor,
                                      Theme.of(context).dividerColor
                                    ])));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
