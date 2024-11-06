import 'package:either_dart/either.dart';

abstract class IUserRepository {
  Future<Either<Exception, dynamic>> registerUser(Map<String, dynamic> data);
}
