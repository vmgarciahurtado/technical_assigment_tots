// cache_manager.dart
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:thechnical_assignment_tots/infrastructure/cache/timeout_http_client.dart';

class CustomCacheManager extends CacheManager {
  static const key = 'customCache';

  static final CustomCacheManager _instance = CustomCacheManager._internal();

  factory CustomCacheManager() {
    return _instance;
  }

  CustomCacheManager._internal()
      : super(
          Config(
            key,
            stalePeriod: const Duration(days: 7),
            maxNrOfCacheObjects: 100,
            repo: JsonCacheInfoRepository(databaseName: key),
            fileService: HttpFileService(
              httpClient:
                  TimeoutHttpClient(timeout: const Duration(seconds: 5)),
            ),
          ),
        );
}
