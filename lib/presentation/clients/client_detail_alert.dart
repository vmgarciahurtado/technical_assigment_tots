import 'package:flutter/material.dart';
import 'package:thechnical_assignment_tots/config/config.dart';
import 'package:thechnical_assignment_tots/domain/domain.dart';

class ClientDetailAlert {
  static void show(BuildContext context, Client client) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocale.client_detail.getString(context)),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (client.photo != null)
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Image.network(
                        client.photo is String
                            ? client.photo
                            : 'https://via.placeholder.com/150',
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.person,
                            size: 100,
                          );
                        },
                      ),
                    ),
                  ),
                const SizedBox(height: 20.0),
                _buildDetailRow('ID', client.id?.toString() ?? 'N/A'),
                const SizedBox(height: 8.0),
                _buildDetailRow(AppLocale.first_name.getString(context),
                    client.firstname ?? 'N/A'),
                const SizedBox(height: 8.0),
                _buildDetailRow(AppLocale.last_name.getString(context),
                    client.lastname ?? 'N/A'),
                const SizedBox(height: 8.0),
                _buildDetailRow(
                    AppLocale.mail.getString(context), client.email ?? 'N/A'),
                const SizedBox(height: 8.0),
                _buildDetailRow(AppLocale.address.getString(context),
                    _formatAddress(client.address)),
                const SizedBox(height: 8.0),
                if (client.caption != null)
                  _buildDetailRow(AppLocale.caption.getString(context),
                      client.caption.toString()),
                if (client.caption != null) const SizedBox(height: 8.0),
                _buildDetailRow(
                    AppLocale.created_at.getString(context),
                    client.createdAt != null
                        ? _formatDate(client.createdAt!)
                        : 'N/A'),
                const SizedBox(height: 8.0),
                _buildDetailRow(
                    AppLocale.updated_at.getString(context),
                    client.updatedAt != null
                        ? _formatDate(client.updatedAt!)
                        : 'N/A'),
                const SizedBox(height: 8.0),
                _buildDetailRow('User ID', client.userId?.toString() ?? 'N/A'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocale.close.getString(context)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Expanded(child: Text(value)),
      ],
    );
  }

  static String _formatAddress(dynamic address) {
    if (address == null) return 'N/A';
    if (address is String) return address;
    if (address is Map<String, dynamic>) {
      return address.values.join(', ');
    }
    return address.toString();
  }

  static String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}
