import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thechnical_assignment_tots/domain/clients/model/client.dart';
import 'package:thechnical_assignment_tots/domain/clients/service/client_service.dart';
import 'package:thechnical_assignment_tots/infrastructure/clients/client_repository.dart';

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
      displayedClients = displayedClients
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
}

final clientProvider = ChangeNotifierProvider<ClientProvider>((ref) {
  final service = ClientService(
    iClientRepository: ClientRepository(),
  );
  return ClientProvider(service);
});
