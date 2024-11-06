import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thechnical_assignment_tots/domain/users/interface/i_user.dart';
import 'package:thechnical_assignment_tots/domain/users/service/user_service.dart';
import 'package:thechnical_assignment_tots/infrastructure/users/user_repository.dart';

final userRepositoryProvider =
    Provider<IUserRepository>((ref) => UserRepository());

final userRegistrationProvider = Provider((ref) => UserRegistrationService());

class UserRegistrationService {
  Future<void> registerUser(BuildContext context, String email, String password,
      String firstname) async {
    final service = UserService(iUserRepository: UserRepository());
    final result = await service.registerUser({
      'email': email,
      'password': password,
      'firstname': firstname,
    });

    result.fold(
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
            backgroundColor: Colors.red,
          ),
        );
      },
      (data) {
        Navigator.pop(context); // Regresar al Login en caso de éxito
      },
    );
  }
}
