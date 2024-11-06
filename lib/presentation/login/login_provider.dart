// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:thechnical_assignment_tots/config/config.dart';
import 'package:thechnical_assignment_tots/domain/login/service/login_service.dart';
import 'package:thechnical_assignment_tots/infrastructure/login/login_repository.dart';
import 'package:thechnical_assignment_tots/presentation/shared/custom_loading.dart';

final obscurePasswordProvider = StateProvider<bool>((ref) => true);

final loginProvider = Provider((ref) => LoginServiceProvider(ref));

class LoginServiceProvider {
  final Ref ref;
  LoginServiceProvider(this.ref);

  Future<void> login(
      BuildContext context, String email, String password) async {
    final service = LoginService(iLoginRepository: LoginRepository());
    CustomLoading(
        title: AppLocale.loading.getString(context), context: context);
    final result = await service.login({
      'email': email,
      'password': password,
    });

    Navigator.pop(context);
    result.fold(
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error),
            backgroundColor: Colors.red.shade300,
          ),
        );
      },
      (data) {
        context.go('/home');
      },
    );
  }
}
