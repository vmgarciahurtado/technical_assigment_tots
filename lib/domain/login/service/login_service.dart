import 'package:either_dart/either.dart';
import 'package:thechnical_assignment_tots/domain/login/interface/i_login.dart';

class LoginService {
  final ILoginRepository iLoginRepository;

  LoginService({required this.iLoginRepository});

  Future<Either<String, dynamic>> login(Map<String, dynamic> data) async {
    return await iLoginRepository.login(data);
  }
}
