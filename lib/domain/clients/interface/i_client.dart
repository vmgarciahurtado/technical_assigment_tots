import 'package:either_dart/either.dart';
import 'package:thechnical_assignment_tots/domain/clients/model/client.dart';

abstract class IClientRepository {
  Future<List<Client>> getClients();
  Future<Either<String, dynamic>> createClient(Map<String, dynamic> data);
  Future<Either<String, dynamic>> updateClient(int clientId, Client client);
  Future<Either<String, dynamic>> deleteClient(int clientId);
}
