// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thechnical_assignment_tots/config/config.dart';
import 'package:thechnical_assignment_tots/domain/users/interface/i_user.dart';
import 'package:thechnical_assignment_tots/domain/users/service/user_service.dart';
import 'package:thechnical_assignment_tots/infrastructure/users/user_repository.dart';
import 'package:thechnical_assignment_tots/presentation/shared/custom_loading.dart';

final userRepositoryProvider =
    Provider<IUserRepository>((ref) => UserRepository());

final userRegistrationProvider = Provider((ref) => UserRegistrationService());

class UserRegistrationService {
  Future<void> registerUser(BuildContext context, String email, String password,
      String firstname) async {
    CustomLoading(
        title: AppLocale.loading.getString(context), context: context);
    final service = UserService(iUserRepository: UserRepository());
    final result = await service.registerUser({
      'email': email,
      'password': password,
      'firstname': firstname,
    });

    Navigator.pop(context);
    result.fold(
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
            backgroundColor: Colors.red.shade300,
          ),
        );
      },
      (data) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocale.success_user_register.getString(context)),
          backgroundColor: Colors.green.shade300,
        ));

        Future.delayed(
            const Duration(milliseconds: 500), () => Navigator.pop(context));
      },
    );
  }
}
