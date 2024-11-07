// presentation/screens/update_client_screen.dart
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thechnical_assignment_tots/config/config.dart';
import 'package:thechnical_assignment_tots/domain/clients/model/client.dart';
import 'package:thechnical_assignment_tots/presentation/presentation.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class UpdateClientScreen extends ConsumerStatefulWidget {
  final Client client;

  const UpdateClientScreen({super.key, required this.client});

  @override
  ConsumerState<UpdateClientScreen> createState() => _UpdateClientScreenState();
}

class _UpdateClientScreenState extends ConsumerState<UpdateClientScreen> {
  File? _imageFile;
  String? _imageUrl;

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

    if (widget.client.photo != null && widget.client.photo!.isNotEmpty) {
      if (widget.client.photo!.startsWith('http')) {
        _imageUrl = widget.client.photo;
      } else {
        _imageFile = File(widget.client.photo!);
      }
    }
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
              InkWell(
                onTap: () {
                  _showImageSourceSelection(context);
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(Res.images.circle),
                    if (_imageFile != null)
                      ClipOval(
                        child: Image.file(
                          _imageFile!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      )
                    else if (_imageUrl != null && _imageUrl!.isNotEmpty)
                      ClipOval(
                        child: Image.network(
                          _imageUrl!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      )
                    else
                      Image.asset(Res.images.image),
                  ],
                ),
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
                          String? imagePath;
                          if (_imageFile != null) {
                            imagePath = await _saveImageLocally(_imageFile!);
                          } else if (_imageUrl != null &&
                              _imageUrl!.isNotEmpty) {
                            imagePath = _imageUrl;
                          } else {
                            imagePath = widget.client.photo;
                          }

                          final updatedClient = Client(
                            id: widget.client.id,
                            firstname: firstNameController.text,
                            lastname: lastNameController.text,
                            email: emailController.text,
                            address: addressController.text,
                            photo: imagePath,
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

  void _showImageSourceSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Elegir desde galería'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Tomar una foto'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.link),
                title: const Text('Ingresar URL de imagen'),
                onTap: () {
                  Navigator.of(context).pop();
                  _showUrlInputDialog(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _imageUrl = null;
      });
    }
  }

  void _showUrlInputDialog(BuildContext context) {
    final urlController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Ingresar URL de imagen'),
          content: TextField(
            controller: urlController,
            decoration: const InputDecoration(hintText: 'URL de la imagen'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _imageUrl = urlController.text;
                  _imageFile = null;
                });
                Navigator.pop(context);
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  Future<String?> _saveImageLocally(File imageFile) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final fileName = basename(imageFile.path);
      final savedImage = await imageFile.copy('${directory.path}/$fileName');
      return savedImage.path;
    } catch (e) {
      print('Error al guardar la imagen localmente: $e');
      return null;
    }
  }
}
