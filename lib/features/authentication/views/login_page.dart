import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portfolio/common/widgets/navigate_to.dart';
import 'package:my_portfolio/features/authentication/controllers/auth_controller.dart';
import 'package:my_portfolio/features/authentication/services/authentication_service.dart';
import 'package:my_portfolio/common/widgets/gradient_button.dart';
import 'package:my_portfolio/features/authentication/controllers/obscure_provider.dart';
import 'package:my_portfolio/features/authentication/views/forgot_password.dart';
import 'package:my_portfolio/features/authentication/views/register_page.dart';
import 'package:my_portfolio/common/widgets/theme_background.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthenticationController _authController = AuthenticationController();
  final NavigateTo navigator = NavigateTo();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                      'Login to',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      'Continue!',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Access your account to view my projects and progress.',
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
                    const SizedBox(height: 15),
                    Consumer<ObscureProvider>(
                        builder: (context, obscureProvider, child) {
                      return TextFormField(
                        controller: _passwordController,
                        obscureText: obscureProvider.isObscure,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          hintText: 'Password',
                          suffixIcon: IconButton(
                              onPressed: () {
                                obscureProvider.toggleObscure();
                              },
                              icon: Icon(obscureProvider.isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      );
                    }),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(Icons.lock_open),
                        TextButton(
                          onPressed: () {
                            navigator.goTo(
                                context: context,
                                destination: const ForgotPassword());
                          },
                          child: Text(
                            'Forgot Password?',
                            style:
                                TextStyle(color: Theme.of(context).shadowColor),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
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
                                        _authController.login(
                                            email: _emailController.text.trim(),
                                            password:
                                                _passwordController.text.trim(),
                                            context: context);
                                      }
                                    },
                                    text: 'SIGN IN',
                                    gradient: LinearGradient(colors: [
                                      Theme.of(context).hoverColor,
                                      Theme.of(context).dividerColor
                                    ])));
                      },
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      children: [
                        Expanded(
                            child:
                                Divider(color: Theme.of(context).shadowColor)),
                        Text("  OR SIGN IN WITH  ",
                            style: TextStyle(
                                color: Theme.of(context).shadowColor)),
                        Expanded(
                            child:
                                Divider(color: Theme.of(context).shadowColor)),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.phone,
                              color: Theme.of(context).primaryColor),
                          onPressed: () {
                            context.read<AuthenticationService>().signOut();
                            context
                                .read<AuthenticationService>()
                                .signOutFromGoogle();
                          },
                        ),
                        IconButton(
                            icon: Icon(FontAwesomeIcons.google,
                                color: Theme.of(context).primaryColor),
                            onPressed: () {
                              _authController.signInWithGoogle(
                                  context: context);
                            }),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        navigator.replaceAndGoTo(
                            context: context,
                            destination: const RegisterPage());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor)),
                          const SizedBox(
                            width: 5,
                          ),
                          Text('Register With Us!',
                              style: TextStyle(
                                  color: Theme.of(context).focusColor,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
