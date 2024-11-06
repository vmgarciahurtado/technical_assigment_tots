import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:thechnical_assignment_tots/domain/clients/interface/i_client.dart';
import 'package:thechnical_assignment_tots/domain/clients/model/client.dart';
import 'package:thechnical_assignment_tots/infrastructure/api/api.dart';

class ClientRepository extends IClientRepository {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  @override
  Future<List<Client>> getClients() async {
    try {
      final tokenKey = dotenv.env['TOKEN_VALUE'] ?? '';
      final token = await _secureStorage.read(key: tokenKey);

      if (token == null) {
        throw Exception('Token unavailable');
      }

      final headers = {'Authorization': 'Bearer $token'};

      Response response = await Api.get('/clients', headers: headers);
      int statusCode = response.statusCode!;

      if (statusCode == 200 || statusCode == 201) {
        final data = response.data['data'] as List;
        List<Client> clients =
            data.map((json) => Client.fromJson(json)).toList();
        return clients;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
