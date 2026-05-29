import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:uni/core/services/shared_preferences_singleton.dart';
import 'package:uni/core/utils/api_service.dart';
import 'package:uni/features/browse/data/data_sources/browse_remote_data_source.dart';
import 'package:uni/features/browse/data/repos/browse_repo_impl.dart';
import 'package:uni/features/browse/domain/repos/browse_repo.dart';
import 'package:uni/features/browse/domain/use_cases/get_unis_use_case.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Register your services here
  // Example:
  // getIt.registerLazySingleton<YourService>(() => YourServiceImplementation());

  // Dio
  getIt.registerSingleton<Dio>(Dio());

  // TODO: remove before production
  await Prefs.setString('token', '277|91C9QiwRjkiM2YG3huAPAsA1NBI7mKqb8dQVZvre2857f569');

  // ApiService
  getIt.registerSingleton<ApiService>(ApiService(getIt<Dio>()));

  // BrowseRemoteDataSource
  getIt.registerSingleton<BrowseRemoteDataSource>(
    BrowseRemoteDataSourceImpl(getIt<ApiService>()),
  );

  // BrowseRepo
  getIt.registerSingleton<BrowseRepo>(
    BrowseRepoImpl(getIt<BrowseRemoteDataSource>()),
  );

  // GetUnisUseCase
  getIt.registerSingleton<GetUnisUseCase>(GetUnisUseCase(getIt<BrowseRepo>()));
}
