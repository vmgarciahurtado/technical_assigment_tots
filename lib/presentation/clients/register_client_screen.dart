import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thechnical_assignment_tots/config/config.dart';
import 'package:thechnical_assignment_tots/presentation/presentation.dart';

class RegisterClientScreen extends ConsumerStatefulWidget {
  const RegisterClientScreen({super.key});

  @override
  ConsumerState<RegisterClientScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterClientScreen> {
  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final captionController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    addressController.dispose();
    captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(AppLocale.add_new_client.getString(context)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              InkWell(
                child: Stack(
                  alignment: const AlignmentDirectional(0, 0),
                  children: [
                    Image.asset(Res.images.circle),
                    Image.asset(Res.images.image),
                  ],
                ),
                onTap: () {},
              ),
              TextFormField(
                controller: firstNameController,
                decoration: InputDecoration(
                    labelText: AppLocale.first_name.getString(context)),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocale.required_field.getString(context);
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: lastNameController,
                decoration: InputDecoration(
                    labelText: AppLocale.last_name.getString(context)),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocale.required_field.getString(context);
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    labelText: AppLocale.mail.getString(context)),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return AppLocale.invalid_mail.getString(context);
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: captionController,
                decoration: InputDecoration(
                    labelText: AppLocale.caption.getString(context)),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocale.required_field.getString(context);
                  }
                  return null;
                },
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      flex: 4,
                      child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            AppLocale.cancel.getString(context),
                            style: TextStyles.bodyStyle(
                                color: Colors.grey, isBold: false),
                          ))),
                  Expanded(
                    flex: 7,
                    child: PrimaryCustomButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await ref
                              .read(clientRegistrationProvider)
                              .registerClient(
                                  context,
                                  firstNameController.text,
                                  lastNameController.text,
                                  emailController.text,
                                  addressController.text,
                                  '',
                                  captionController.text);
                        }
                      },
                      text: AppLocale.save.getString(context),
                    ),
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
