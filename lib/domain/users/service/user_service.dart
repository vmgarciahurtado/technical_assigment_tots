import 'package:either_dart/either.dart';
import 'package:thechnical_assignment_tots/domain/users/interface/i_user.dart';

class UserService {
  final IUserRepository iUserRepository;

  UserService({required this.iUserRepository});

  Future<Either<Exception, dynamic>> registerUser(
      Map<String, dynamic> data) async {
    return await iUserRepository.registerUser(data);
  }
}
