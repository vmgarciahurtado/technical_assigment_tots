// presentation/screens/update_client_screen.dart
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thechnical_assignment_tots/config/config.dart';
import 'package:thechnical_assignment_tots/domain/clients/model/client.dart';
import 'package:thechnical_assignment_tots/presentation/presentation.dart';

class UpdateClientScreen extends ConsumerStatefulWidget {
  final Client client;

  const UpdateClientScreen({super.key, required this.client});

  @override
  ConsumerState<UpdateClientScreen> createState() => _UpdateClientScreenState();
}

class _UpdateClientScreenState extends ConsumerState<UpdateClientScreen> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  late TextEditingController captionController;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: widget.client.firstname);
    lastNameController = TextEditingController(text: widget.client.lastname);
    emailController = TextEditingController(text: widget.client.email);
    addressController = TextEditingController(text: widget.client.address);
    captionController = TextEditingController(text: widget.client.caption);
  }

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
        title: Text(AppLocale.edit_client.getString(context)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
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
                controller: addressController,
                decoration: InputDecoration(
                    labelText: AppLocale.address.getString(context)),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
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
                          final updatedClient = Client(
                            id: widget.client.id,
                            firstname: firstNameController.text,
                            lastname: lastNameController.text,
                            email: emailController.text,
                            address: addressController.text,
                            photo: widget.client.photo,
                            caption: captionController.text,
                          );

                          await ref.read(clientProvider).updateClient(
                              context, updatedClient.id!, updatedClient);

                          Navigator.pop(context);
                        }
                      },
                      text: AppLocale.update.getString(context),
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
