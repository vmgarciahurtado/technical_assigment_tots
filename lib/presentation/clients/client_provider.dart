import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thechnical_assignment_tots/config/config.dart';
import 'package:thechnical_assignment_tots/domain/clients/interface/i_client.dart';
import 'package:thechnical_assignment_tots/domain/domain.dart';
import 'package:thechnical_assignment_tots/infrastructure/infrastructure.dart';
import 'package:thechnical_assignment_tots/presentation/shared/custom_loading.dart';

class ClientProvider extends ChangeNotifier {
  final ClientService _clientService;
  List<Client> _allClients = [];
  List<Client> displayedClients = [];
  String _searchQuery = '';
  bool isLoading = true;
  int _clientsToShow = 5;

  ClientProvider(this._clientService) {
    loadClients();
  }

  int get totalClientsCount => _allClients.length;

  Future<void> loadClients() async {
    isLoading = true;
    notifyListeners();
    try {
      _allClients = await _clientService.getClients();
      displayedClients = _allClients.take(_clientsToShow).toList();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
    }
  }

  void searchClients(String query) {
    _searchQuery = query.toLowerCase();
    if (_searchQuery.isEmpty) {
      displayedClients = _allClients.take(_clientsToShow).toList();
    } else {
      displayedClients = _allClients
          .where((client) =>
              (client.firstname ?? '').toLowerCase().contains(_searchQuery))
          .toList();
    }
    notifyListeners();
  }

  void loadMoreClients() {
    _clientsToShow += 5;
    if (_clientsToShow > _allClients.length) {
      _clientsToShow = _allClients.length;
    }
    if (_searchQuery.isEmpty) {
      displayedClients = _allClients.take(_clientsToShow).toList();
    } else {
      displayedClients = _allClients
          .take(_clientsToShow)
          .where((client) => client.firstname!
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  Future<void> updateClient(
      BuildContext context, int clientId, Client updatedClient) async {
    CustomLoading(
      title: AppLocale.loading.getString(context),
      context: context,
    );

    final result = await _clientService.updateClient(clientId, updatedClient);
    Navigator.pop(context);
    result.fold(
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error),
            backgroundColor: Colors.red.shade300,
          ),
        );
      },
      (data) {
        final updatedData = Client.fromJson(data['data']);

        int index =
            _allClients.indexWhere((client) => client.id == updatedData.id);
        if (index != -1) {
          _allClients[index] = updatedData;
          searchClients(_searchQuery);
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocale.success_client_updated.getString(context)),
            backgroundColor: Colors.green.shade300,
          ),
        );
      },
    );
  }

  Future<void> deleteClient(BuildContext context, int clientId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocale.confirm_delete_title.getString(context)),
        content: Text(AppLocale.confirm_delete_message.getString(context)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(AppLocale.cancel.getString(context)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(AppLocale.delete.getString(context)),
          ),
        ],
      ),
    );

    if (confirm != true) {
      return;
    }

    CustomLoading(
      title: AppLocale.loading.getString(context),
      context: context,
    );

    final result = await _clientService.deleteClient(clientId);
    Navigator.pop(context);

    result.fold(
      (error) {
        // Mostrar mensaje de error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error),
            backgroundColor: Colors.red.shade300,
          ),
        );
      },
      (data) {
        _allClients.removeWhere((client) => client.id == clientId);
        displayedClients.removeWhere((client) => client.id == clientId);
        notifyListeners();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocale.success_client_deleted.getString(context)),
            backgroundColor: Colors.green.shade300,
          ),
        );
      },
    );
  }
}

final clientProvider = ChangeNotifierProvider<ClientProvider>((ref) {
  final service = ClientService(
    iClientRepository: ClientRepository(),
  );
  return ClientProvider(service);
});

// ignore_for_file: use_build_context_synchronously

final userRepositoryProvider =
    Provider<IClientRepository>((ref) => ClientRepository());

final clientRegistrationProvider =
    Provider((ref) => ClientRegistrationService());

class ClientRegistrationService {
  Future<void> registerClient(
      BuildContext context,
      String firstname,
      String lastName,
      String email,
      String address,
      String photo,
      String caption) async {
    CustomLoading(
        title: AppLocale.loading.getString(context), context: context);
    final service = ClientService(iClientRepository: ClientRepository());
    final result = await service.createClient({
      "firstname": firstname,
      "lastname": lastName,
      "email": email,
      "address": address,
      "photo": photo,
      "caption": caption
    });

    Navigator.pop(context);
    result.fold(
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
            backgroundColor: Colors.red.shade300,
          ),
        );
      },
      (data) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocale.success_client_registered.getString(context)),
          backgroundColor: Colors.green.shade300,
        ));

        Future.delayed(
            const Duration(milliseconds: 500), () => Navigator.pop(context));
      },
    );
  }
}
