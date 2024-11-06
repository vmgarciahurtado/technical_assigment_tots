import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thechnical_assignment_tots/domain/login/service/login_service.dart';
import 'package:thechnical_assignment_tots/infrastructure/login/login_repository.dart';

final obscurePasswordProvider = StateProvider<bool>((ref) => true);

final loginProvider = Provider((ref) => LoginServiceProvider(ref));

class LoginServiceProvider {
  final Ref ref;
  LoginServiceProvider(this.ref);

  Future<void> login(
      BuildContext context, String email, String password) async {
    final service = LoginService(iLoginRepository: LoginRepository());

    final result = await service.login({
      'email': email,
      'password': password,
    });
    result.fold(
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error),
            backgroundColor: Colors.red,
          ),
        );
      },
      (data) {
        // Acciones en caso de éxito, como navegación o manejo de datos
      },
    );
  }
}
