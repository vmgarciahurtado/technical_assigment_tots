import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:thechnical_assignment_tots/config/config.dart';
import 'package:thechnical_assignment_tots/presentation/clients/client_detail_alert.dart';
import 'package:thechnical_assignment_tots/presentation/presentation.dart';

class ClientsScreen extends ConsumerWidget {
  const ClientsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);

    final clientProviderInstance = ref.watch(clientProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        Positioned(
          left: 0,
          top: 0,
          child: Image.asset(
            Res.images.usersTopGradient,
            height: size.height * 0.3,
            width: size.width * 0.5,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          right: 0,
          top: size.height * 0.25,
          child: Image.asset(
            Res.images.usersCenterRightGradient,
            height: size.height * 0.4,
            width: size.width * 0.4,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          child: Image.asset(
            Res.images.usersBottomLeftGradient,
            height: size.height * 0.4,
            width: size.width * 0.4,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Image.asset(
            Res.images.usersBottomRightGradient,
            height: size.height * 0.4,
            width: size.width * 0.6,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          right: 10,
          top: 20,
          child: InkWell(
            onTap: () => ref.read(clientProvider).closeSession(context),
            child: Row(
              children: [
                Text(
                  'close session',
                  style: TextStyles.bodyUnderLineStyle(),
                ),
                const SizedBox(
                  width: 5,
                ),
                const Icon(Icons.exit_to_app_outlined),
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 30),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(height: 50, width: 60, Res.images.logo),
              Text(
                AppLocale.clients.getString(context),
                style: TextStyles.bodyStyle(),
              ),
              const SizedBox(
                height: 20,
              ),
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
                                color:
                                    const Color(0xFF1D1D35).withOpacity(0.64),
                              ),
                              hintText: AppLocale.search.getString(context),
                              hintStyle: TextStyle(
                                color:
                                    const Color(0xFF1D1D35).withOpacity(0.64),
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
                      onPressed: () => context.push('/client_register'),
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
                        ? const Center(
                            child: Text('No se encontraron clientes.'))
                        : ListView.builder(
                            itemCount:
                                clientProviderInstance.displayedClients.length,
                            itemBuilder: (context, index) {
                              final client = clientProviderInstance
                                  .displayedClients[index];
                              return Column(
                                children: [
                                  CustomCard(
                                    padding: const EdgeInsets.all(0.0),
                                    body: ListTile(
                                      onTap: () => ClientDetailAlert.show(
                                          context, client),
                                      leading: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        child: buildClientImage(client),
                                      ),
                                      title: Text(client.firstname ?? ''),
                                      subtitle: Text(client.email ?? ''),
                                      trailing: PopupMenuButton<String>(
                                        onSelected: (value) {
                                          if (value == 'editar') {
                                            context.push('/client_update',
                                                extra: client);
                                          } else if (value == 'eliminar') {
                                            ref
                                                .read(clientProvider)
                                                .deleteClient(
                                                    context, client.id!);
                                          }
                                        },
                                        itemBuilder: (BuildContext context) => [
                                          PopupMenuItem<String>(
                                            value: 'editar',
                                            child: Text(AppLocale.edit
                                                .getString(context)),
                                          ),
                                          PopupMenuItem<String>(
                                            value: 'eliminar',
                                            child: Text(AppLocale.delete
                                                .getString(context)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  )
                                ],
                              );
                            },
                          ),
              ),
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
      ]),
    );
  }
}
