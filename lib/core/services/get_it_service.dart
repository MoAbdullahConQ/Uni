import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:uni/core/cubits/trending_cubit/trending_cubit.dart';
import 'package:uni/core/services/shared_preferences_singleton.dart';
import 'package:uni/core/data_sources/trending_remote_data_source.dart';
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
import 'package:uni/features/fav/presentation/manager/fav_cubit/fav_cubit.dart';
import 'package:uni/features/home/data/data_sources/recommended_remote_data_source.dart';
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
  // put it auth feature after login
  await Prefs.setString('token', dotenv.env['TOKEN'] ?? '');

  // ApiService
  getIt.registerSingleton<ApiService>(ApiService(getIt<Dio>()));

  // ===== TRENDING =====
  getIt.registerSingleton<TrendingRemoteDataSource>(
    TrendingRemoteDataSourceImpl(getIt<ApiService>()),
  );
  getIt.registerSingleton<TrendingCubit>(
    TrendingCubit(getIt<TrendingRemoteDataSource>()),
  );

  // ===== RECOMMENDED =====
  getIt.registerSingleton<RecommendedRemoteDataSource>(
    RecommendedRemoteDataSourceImpl(getIt<ApiService>()),
  );

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

  // FavCubit
  getIt.registerSingleton<FavCubit>(
    FavCubit(
      getFavsUseCase: getIt<GetFavsUseCase>(),
      addToFavUseCase: getIt<AddToFavUseCase>(),
      removeFromFavUseCase: getIt<RemoveFromFavUseCase>(),
    ),
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
