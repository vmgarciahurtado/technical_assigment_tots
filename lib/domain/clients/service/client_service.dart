import 'package:thechnical_assignment_tots/domain/clients/interface/i_client.dart';
import 'package:thechnical_assignment_tots/domain/clients/model/client.dart';

class ClientService {
  final IClientRepository iClientRepository;

  ClientService({required this.iClientRepository});

  Future<List<Client>> getClients() async {
    return await iClientRepository.getClients();
  }
}
