import 'package:either_dart/either.dart';

abstract class ILoginRepository {
  Future<Either<String, dynamic>> login(Map<String, dynamic> data);
}
