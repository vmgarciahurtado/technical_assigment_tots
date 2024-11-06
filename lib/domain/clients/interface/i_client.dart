import 'package:thechnical_assignment_tots/domain/clients/model/client.dart';

abstract class IClientRepository {
  Future<List<Client>> getClients();
}
