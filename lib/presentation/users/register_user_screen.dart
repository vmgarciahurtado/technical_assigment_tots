import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thechnical_assignment_tots/config/config.dart';
import 'package:thechnical_assignment_tots/presentation/presentation.dart';
import 'package:thechnical_assignment_tots/presentation/shared/custom_secondary_button.dart';
import 'package:thechnical_assignment_tots/presentation/users/user_provider.dart';

class RegisterUserScreen extends ConsumerStatefulWidget {
  const RegisterUserScreen({super.key});

  @override
  ConsumerState<RegisterUserScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterUserScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstnameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    firstnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocale.add_new_user.getString(context)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    labelText: AppLocale.mail.getString(context)),
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return AppLocale.invalid_mail.getString(context);
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                    labelText: AppLocale.password.getString(context)),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocale.invalid_password.getString(context);
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: firstnameController,
                decoration: InputDecoration(
                    labelText: AppLocale.first_name.getString(context)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocale.required_field.getString(context);
                  }
                  return null;
                },
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SecondaryCustomButton(
                      onPressed: () => Navigator.pop(context),
                      text: AppLocale.mail.getString(context)),
                  PrimaryCustomButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await ref.read(userRegistrationProvider).registerUser(
                              context,
                              emailController.text,
                              passwordController.text,
                              firstnameController.text,
                            );
                      }
                    },
                    text: AppLocale.save.getString(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
