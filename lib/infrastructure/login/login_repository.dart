import 'package:either_dart/either.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:thechnical_assignment_tots/domain/login/interface/i_login.dart';
import 'package:thechnical_assignment_tots/infrastructure/api/api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginRepository extends ILoginRepository {
  final storage = const FlutterSecureStorage();

  @override
  Future<Either<String, dynamic>> login(Map<String, dynamic> data) async {
    try {
      final response = await Api.post('/oauth/token', data);

      int statusCode = response.statusCode!;

      if (statusCode == 200 || statusCode == 201) {
        final token = response.data['access_token'];
        await storage.write(
          key: dotenv.env['TOKEN_VALUE'] ?? '',
          value: token,
        );
        return Right(response.data);
      } else {
        return Left(response.data['message'] ?? 'Unknown error');
      }
    } catch (e) {
      return Left('Error: $e');
    }
  }
}
