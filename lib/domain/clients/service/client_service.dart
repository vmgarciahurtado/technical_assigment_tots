import 'package:thechnical_assignment_tots/domain/clients/interface/i_client.dart';
import 'package:thechnical_assignment_tots/domain/clients/model/client.dart';

class ClientService {
  final IClientRepository iClientRepository;

  ClientService({required this.iClientRepository});

  Future<List<Client>> login() async {
    return await iClientRepository.getClients();
  }
}
