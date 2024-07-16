import 'package:flutter/material.dart';
import 'package:my_portfolio/common/widgets/navigate_to.dart';
import 'package:my_portfolio/features/authentication/controllers/auth_controller.dart';
import 'package:my_portfolio/features/authentication/services/authentication_service.dart';
import 'package:my_portfolio/common/widgets/gradient_button.dart';
import 'package:my_portfolio/features/authentication/views/login_page.dart';
import 'package:my_portfolio/features/authentication/controllers/obscure_provider.dart';
import 'package:my_portfolio/common/widgets/theme_background.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final AuthenticationController _authController = AuthenticationController();
  final NavigateTo navigator = NavigateTo();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(75.0), // Set the desired height
          child: AppBar(
            // Remove the shadow
            leading: Padding(
              padding:
                  const EdgeInsets.all(8.0), // Adjust the padding as needed
              child: Image.asset(
                  'assets/images/amn.png'), // Replace with your logo path
            ),
          ),
        ), // Light background color
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
                        'Create Your',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        'Account!',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Create your account to kickstart this journey.',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      const SizedBox(height: 32.0),
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          hintText: 'Enter your name',
                          prefixIcon: Icon(
                            Icons.person_2_outlined,
                          ), // Dark icon// Light fill color
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                        style: TextStyle(
                            color: Theme.of(context)
                                .primaryColor), // Dark text color
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          hintText: 'Enter your email address',
                          prefixIcon: Icon(Icons.email), // Dark icon,
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
                        style: TextStyle(
                            color: Theme.of(context)
                                .primaryColor), // Dark text color
                      ),
                      const SizedBox(height: 10.0),
                      Consumer<ObscureProvider>(
                          builder: (context, obscureProvider, child) {
                        return TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                              hintText: 'Enter your password',
                              prefixIcon: const Icon(
                                Icons.lock,
                              ),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    obscureProvider.toggleObscure();
                                  },
                                  icon: Icon(obscureProvider.isObscure
                                      ? Icons.visibility_off
                                      : Icons.visibility)) // Dark icon,
                              ),
                          obscureText: obscureProvider.isObscure,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          style: TextStyle(
                              color: Theme.of(context)
                                  .primaryColor), // Dark text color
                        );
                      }),
                      const SizedBox(height: 10.0),
                      Consumer<ObscureProvider>(
                          builder: (context, obscureProvider, child) {
                        return TextFormField(
                          controller: _confirmPasswordController,
                          decoration: InputDecoration(
                              hintText: 'Re-enter your password',
                              prefixIcon: const Icon(
                                Icons.lock,
                              ),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    obscureProvider.toggleObscure();
                                  },
                                  icon: Icon(obscureProvider.isObscure
                                      ? Icons.visibility_off
                                      : Icons.visibility)) // Dark icon,
                              ),
                          obscureText: obscureProvider.isObscure,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                          style: TextStyle(
                              color: Theme.of(context)
                                  .primaryColor), // Dark text color
                        );
                      }),
                      const SizedBox(height: 32.0),
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
                                          _authController.registerUser(
                                              email:
                                                  _emailController.text.trim(),
                                              name: _nameController.text.trim(),
                                              password: _passwordController.text
                                                  .trim(),
                                              context: context);
                                        }
                                      },
                                      text: 'REGISTER',
                                      gradient: LinearGradient(colors: [
                                        Theme.of(context).hoverColor,
                                        Theme.of(context).dividerColor,
                                      ])));
                        },
                      ),
                      const SizedBox(height: 16.0),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            navigator.replaceAndGoTo(
                                context: context,
                                destination: const LoginPage());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already Registered? ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                              Text(
                                " Sign into your account!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Theme.of(context).focusColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ));
  }
}
