import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:email_validator/email_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:thechnical_assignment_tots/config/config.dart';
import 'package:thechnical_assignment_tots/presentation/presentation.dart';
import 'package:thechnical_assignment_tots/presentation/shared/custom_secondary_button.dart';
import 'login_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final obscureText = ref.watch(obscurePasswordProvider);
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: Image.asset(
              Res.images.loginTopGradient,
              height: size.height * 0.6,
              width: size.width * 0.6,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 0,
            top: size.height * 0.40,
            child: Image.asset(
              Res.images.loginCenterGradient,
              height: size.height * 0.3,
              width: size.width * 0.3,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: Image.asset(
              Res.images.loginBottomGradient,
              height: size.height * 0.35,
              width: size.width * 0.9,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            top: size.height * 0.15,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      height: size.height * 0.15,
                      width: size.width * 0.15,
                      Res.images.logo,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      textAlign: TextAlign.center,
                      style: TextStyles.body2Style(isBold: false),
                      AppLocale.login.getString(context),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: AppLocale.mail.getString(context),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (!EmailValidator.validate(value ?? '')) {
                          return AppLocale.invalid_mail.getString(context);
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: passwordController,
                      obscureText: obscureText,
                      decoration: InputDecoration(
                        labelText: AppLocale.password.getString(context),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            ref.read(obscurePasswordProvider.notifier).state =
                                !obscureText;
                          },
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value != null && value.length < 2) {
                          return AppLocale.invalid_password.getString(context);
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 70),
                    PrimaryCustomButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await ref.read(loginProvider).login(
                                context,
                                emailController.text,
                                passwordController.text,
                              );
                        }
                      },
                      text: AppLocale.login.getString(context),
                    ),
                    const SizedBox(height: 10),
                    SecondaryCustomButton(
                      onPressed: () {
                        context.push('/user_register');
                      },
                      text: AppLocale.signup.getString(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
