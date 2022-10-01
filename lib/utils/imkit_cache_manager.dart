import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class IMKitCacheManager extends CacheManager with ImageCacheManager {
  static const key = 'IMKitCachedData';

  static final IMKitCacheManager _instance = IMKitCacheManager._();
  factory IMKitCacheManager() => _instance;

  IMKitCacheManager._()
      : super(
          Config(
            key,
            stalePeriod: const Duration(days: 30),
            maxNrOfCacheObjects: 1000,
            repo: JsonCacheInfoRepository(databaseName: key),
            // fileSystem: IOFileSystem(key),
            fileService: HttpFileService(),
          ),
        );
}
