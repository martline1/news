import 'package:get_it/get_it.dart';
import 'package:news_lib/repositories/news_repository.dart';
import 'package:news_lib/repositories/news_repository_local.dart';
import 'package:news_lib/services/news_service.dart';
import 'package:news_lib/services/sqflite_service.dart';

class AppDependencies {
  static init() {
    final GetIt getIt = GetIt.instance;

    getIt.registerSingleton(SqfLiteService());

    // Register repositories
    getIt.registerSingleton(NewsRepositoryLocal(service: getIt()));
    getIt.registerSingleton(NewsRepository());

    getIt.registerSingleton(
      NewsService(
        repository: getIt(),
        repositoryLocal: getIt(),
      ),
    );
  }
}
