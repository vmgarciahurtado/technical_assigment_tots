import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:thechnical_assignment_tots/domain/clients/model/client.dart';
import 'package:thechnical_assignment_tots/infrastructure/cache/cache_manager.dart';
import 'package:thechnical_assignment_tots/presentation/presentation.dart';

Widget buildClientImage(Client client) {
  if (client.photo != null && client.photo!.isNotEmpty) {
    return CachedNetworkImage(
      cacheManager: CustomCacheManager(),
      imageUrl: client.photo!,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => Image.asset(
        Res.images.noImage,
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
