import 'package:dio/dio.dart';
import 'package:thechnical_assignment_tots/domain/clients/interface/i_client.dart';
import 'package:thechnical_assignment_tots/domain/clients/model/client.dart';
import 'package:thechnical_assignment_tots/infrastructure/api/api.dart';

class ClientRepository extends IClientRepository {
  @override
  Future<List<Client>> getClients() async {
    try {
      Response response = await Api.get('/clients');

      final int statusCode;
      if (response.statusCode is String) {
        statusCode =
            int.tryParse(response.statusCode as String, radix: 16) ?? 0;
      } else {
        statusCode = response.statusCode ?? 0;
      }

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
