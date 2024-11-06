import 'package:either_dart/either.dart';
import 'package:thechnical_assignment_tots/infrastructure/api/api.dart';
import 'package:thechnical_assignment_tots/domain/users/interface/i_user.dart';

class UserRepository extends IUserRepository {
  @override
  Future<Either<Exception, dynamic>> registerUser(
      Map<String, dynamic> data) async {
    try {
      final response = await Api.post('/users', data);

      final int statusCode;
      if (response.statusCode is String) {
        statusCode =
            int.tryParse(response.statusCode as String, radix: 16) ?? 0;
      } else {
        statusCode = response.statusCode ?? 0;
      }

      if (statusCode == 200 || statusCode == 201) {
        return Right(response.data);
      } else {
        return Left(Exception(response.data['message'] ?? 'Unknown error'));
      }
    } catch (e) {
      return Left(Exception('Error: $e'));
    }
  }
}
