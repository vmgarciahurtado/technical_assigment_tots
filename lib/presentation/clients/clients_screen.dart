import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:thechnical_assignment_tots/config/config.dart';
import 'package:thechnical_assignment_tots/domain/clients/model/client.dart';
import 'package:thechnical_assignment_tots/infrastructure/cache/cache_manager.dart';
import 'package:thechnical_assignment_tots/presentation/clients/client_provider.dart';
import 'package:thechnical_assignment_tots/presentation/clients/liading_skeleton.dart';
import 'package:thechnical_assignment_tots/presentation/shared/custom_card.dart';
import 'package:thechnical_assignment_tots/presentation/presentation.dart';

class ClientsScreen extends ConsumerWidget {
  const ClientsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clientProviderInstance = ref.watch(clientProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                    flex: 7,
                    child: TextField(
                        onChanged: (value) {
                          ref.read(clientProvider).searchClients(value);
                        },
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              Icons.search,
                              color: const Color(0xFF1D1D35).withOpacity(0.64),
                            ),
                            hintText: AppLocale.search.getString(context),
                            hintStyle: TextStyle(
                              color: const Color(0xFF1D1D35).withOpacity(0.64),
                            ),
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0 * 1.5,
                            ),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)))))),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 4,
                  child: PrimaryCustomButton(
                    onPressed: () {},
                    height: 35,
                    text: AppLocale.add_new.getString(context),
                  ),
                ),
              ],
            ),

            Expanded(
              child: clientProviderInstance.isLoading
                  ? const LoadingSkeleton()
                  : clientProviderInstance.displayedClients.isEmpty
                      ? const Center(child: Text('No se encontraron clientes.'))
                      : ListView.builder(
                          itemCount:
                              clientProviderInstance.displayedClients.length,
                          itemBuilder: (context, index) {
                            final client =
                                clientProviderInstance.displayedClients[index];
                            return CustomCard(
                              padding: const EdgeInsets.all(0.0),
                              body: ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: _buildClientImage(client),
                                ),
                                title: Text(client.firstname ?? ''),
                                subtitle: Text(client.email ?? ''),
                                trailing: PopupMenuButton<String>(
                                  onSelected: (value) {
                                    if (value == 'editar') {
                                      // Lógica para editar
                                    } else if (value == 'eliminar') {
                                      // Lógica para eliminar
                                    }
                                  },
                                  itemBuilder: (BuildContext context) => [
                                    PopupMenuItem<String>(
                                      value: 'editar',
                                      child: Text(
                                          AppLocale.edit.getString(context)),
                                    ),
                                    PopupMenuItem<String>(
                                      value: 'eliminar',
                                      child: Text(
                                          AppLocale.delete.getString(context)),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ),
            // Botón para cargar más clientes
            if (!clientProviderInstance.isLoading &&
                clientProviderInstance.displayedClients.length <
                    clientProviderInstance.totalClientsCount)
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: PrimaryCustomButton(
                  onPressed: () {
                    ref.read(clientProvider).loadMoreClients();
                  },
                  text: AppLocale.load_more.getString(context),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildClientImage(Client client) {
    if (client.photo != null && client.photo!.isNotEmpty) {
      return CachedNetworkImage(
        cacheManager: CustomCacheManager(),
        imageUrl: client.photo!,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => Image.asset(
          'assets/images/no_image.png',
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        'assets/images/no_image.png',
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      );
    }
  }
}
