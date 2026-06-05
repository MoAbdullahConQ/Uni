import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:uni/core/services/shared_preferences_singleton.dart';
import 'package:uni/core/utils/api_service.dart';
import 'package:uni/features/browse/data/data_sources/browse_remote_data_source.dart';
import 'package:uni/features/browse/data/repos/browse_repo_impl.dart';
import 'package:uni/features/browse/domain/repos/browse_repo.dart';
import 'package:uni/features/browse/domain/use_cases/get_unis_use_case.dart';
import 'package:uni/features/fav/data/data_sources/fav_remote_data_source.dart';
import 'package:uni/features/fav/data/repos/fav_repo_impl.dart';
import 'package:uni/features/fav/domain/repos/fav_repo.dart';
import 'package:uni/features/fav/domain/use_cases/add_to_fav_use_case.dart';
import 'package:uni/features/fav/domain/use_cases/get_favs_use_case.dart';
import 'package:uni/features/fav/domain/use_cases/remove_from_fav_use_case.dart';
import 'package:uni/features/search/data/data_sources/search_remote_data_source.dart';
import 'package:uni/features/search/data/repos/search_repo_impl.dart';
import 'package:uni/features/search/domain/repos/search_repo.dart';
import 'package:uni/features/search/domain/use_cases/get_specialties_use_case.dart';
import 'package:uni/features/search/domain/use_cases/search_unis_use_case.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Register your services here
  // Example:
  // getIt.registerLazySingleton<YourService>(() => YourServiceImplementation());

  // Dio
  getIt.registerSingleton<Dio>(Dio());

  // TODO: remove before production
  await Prefs.setString(
    'token',
    "327|mfILpHeuSeZYX3z8MWeuK7fnL2FzpPEPxu12BlUL3532e5d7",
  );

  // ApiService
  getIt.registerSingleton<ApiService>(ApiService(getIt<Dio>()));

  // ===== BROWSE =====
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

  // ===== FAV =====

  // FavRemoteDataSource
  getIt.registerSingleton<FavRemoteDataSource>(
    FavRemoteDataSourceImpl(getIt<ApiService>()),
  );

  // FavRepo
  getIt.registerSingleton<FavRepo>(FavRepoImpl(getIt<FavRemoteDataSource>()));

  // Use Cases
  getIt.registerSingleton<GetFavsUseCase>(GetFavsUseCase(getIt<FavRepo>()));
  getIt.registerSingleton<AddToFavUseCase>(AddToFavUseCase(getIt<FavRepo>()));
  getIt.registerSingleton<RemoveFromFavUseCase>(
    RemoveFromFavUseCase(getIt<FavRepo>()),
  );

  // ===== SEARCH =====

  // SearchRemoteDataSource
  getIt.registerSingleton<SearchRemoteDataSource>(
    SearchRemoteDataSourceImpl(getIt<ApiService>()),
  );

  // SearchRepo
  getIt.registerSingleton<SearchRepo>(
    SearchRepoImpl(getIt<SearchRemoteDataSource>()),
  );

  // SearchUnisUseCase
  getIt.registerSingleton<SearchUnisUseCase>(
    SearchUnisUseCase(getIt<SearchRepo>()),
  );

  getIt.registerSingleton<GetSpecialtiesUseCase>(
    GetSpecialtiesUseCase(getIt<SearchRepo>()),
  );
}
