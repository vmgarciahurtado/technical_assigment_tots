import 'package:either_dart/either.dart';
import 'package:thechnical_assignment_tots/domain/clients/interface/i_client.dart';
import 'package:thechnical_assignment_tots/domain/clients/model/client.dart';

class ClientService {
  final IClientRepository iClientRepository;

  ClientService({required this.iClientRepository});

  Future<List<Client>> getClients() async {
    return await iClientRepository.getClients();
  }

  Future<Either<String, dynamic>> createClient(
      Map<String, dynamic> data) async {
    return await iClientRepository.createClient(data);
  }

  Future<Either<String, dynamic>> updateClient(
      int clientId, Client client) async {
    return await iClientRepository.updateClient(clientId, client);
  }

  Future<Either<String, dynamic>> deleteClient(int clientId) async {
    return await iClientRepository.deleteClient(clientId);
  }
}
