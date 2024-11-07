import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:thechnical_assignment_tots/config/config.dart';
import 'package:thechnical_assignment_tots/domain/domain.dart';
import 'package:thechnical_assignment_tots/infrastructure/cache/cache_manager.dart';
import 'package:thechnical_assignment_tots/presentation/presentation.dart';

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
                if (client.photo != null && client.photo!.startsWith('http'))
                  Center(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: CachedNetworkImage(
                            cacheManager: CustomCacheManager(),
                            imageUrl: client.photo!,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) => Image.asset(
                              Res.images.noImage,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ))),
                if (client.photo != null && !client.photo!.startsWith('http'))
                  Center(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Image.file(
                            File(client.photo!),
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ))),
                if (client.photo == null || client.photo == '')
                  Center(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Image.asset(
                            'assets/images/no_image.png',
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ))),
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
