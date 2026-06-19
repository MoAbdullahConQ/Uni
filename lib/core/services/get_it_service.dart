import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:uni/core/cubits/trending_cubit/trending_cubit.dart';
import 'package:uni/core/data_sources/trending_remote_data_source.dart';
import 'package:uni/core/utils/api_service.dart';
import 'package:uni/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:uni/features/auth/data/repos/auth_repo_impl.dart';
import 'package:uni/features/auth/domain/repos/auth_repo.dart';
import 'package:uni/features/auth/domain/use_cases/forget_password_use_case.dart';
import 'package:uni/features/auth/domain/use_cases/get_me_use_case.dart';
import 'package:uni/features/auth/domain/use_cases/login_use_case.dart';
import 'package:uni/features/auth/domain/use_cases/register_use_case.dart';
import 'package:uni/features/auth/domain/use_cases/resend_otp_use_case.dart';
import 'package:uni/features/auth/domain/use_cases/reset_password_use_case.dart';
import 'package:uni/features/auth/domain/use_cases/save_student_info_use_case.dart';
import 'package:uni/features/auth/domain/use_cases/update_password_use_case.dart';
import 'package:uni/features/auth/domain/use_cases/verify_otp_use_case.dart';
import 'package:uni/features/browse/data/data_sources/browse_remote_data_source.dart';
import 'package:uni/features/browse/data/repos/browse_repo_impl.dart';
import 'package:uni/features/browse/domain/repos/browse_repo.dart';
import 'package:uni/features/browse/domain/use_cases/get_unis_use_case.dart';
import 'package:uni/features/faheem/data/data_sources/faheem_remote_data_source.dart';
import 'package:uni/features/faheem/data/repos/faheem_repo_impl.dart';
import 'package:uni/features/faheem/domain/repos/faheem_repo.dart';
import 'package:uni/features/faheem/domain/use_cases/send_message_use_case.dart';
import 'package:uni/features/faheem/presentation/manager/faheem_cubit/faheem_cubit.dart';
import 'package:uni/features/fav/data/data_sources/fav_remote_data_source.dart';
import 'package:uni/features/fav/data/repos/fav_repo_impl.dart';
import 'package:uni/features/fav/domain/repos/fav_repo.dart';
import 'package:uni/features/fav/domain/use_cases/add_to_fav_use_case.dart';
import 'package:uni/features/fav/domain/use_cases/get_favs_use_case.dart';
import 'package:uni/features/fav/domain/use_cases/remove_from_fav_use_case.dart';
import 'package:uni/features/fav/presentation/manager/fav_cubit/fav_cubit.dart';
import 'package:uni/features/guide/data/data_sources/guide_remote_data_source.dart';
import 'package:uni/features/guide/data/repos/guide_repo_impl.dart';
import 'package:uni/features/guide/domain/repos/guide_repo.dart';
import 'package:uni/features/guide/domain/use_cases/get_articles_use_case.dart';
import 'package:uni/features/guide/presentation/manager/guide_cubit/guide_cubit.dart';
import 'package:uni/features/home/data/data_sources/recommended_remote_data_source.dart';
import 'package:uni/features/notifications/data/data_sources/notifications_remote_data_source.dart';
import 'package:uni/features/notifications/data/repos/notifications_repo_impl.dart';
import 'package:uni/features/notifications/domain/repos/notifications_repo.dart';
import 'package:uni/features/notifications/domain/use_cases/get_notifications_use_case.dart';
import 'package:uni/features/notifications/domain/use_cases/get_unread_notifications_count_use_case.dart';
import 'package:uni/features/notifications/domain/use_cases/mark_all_notifications_as_read_use_case.dart';
import 'package:uni/features/notifications/domain/use_cases/mark_notification_as_read_use_case.dart';
import 'package:uni/features/notifications/presentation/manager/notifications_cubit/notifications_cubit.dart';
import 'package:uni/features/profile/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:uni/features/search/data/data_sources/search_remote_data_source.dart';
import 'package:uni/features/search/data/repos/search_repo_impl.dart';
import 'package:uni/features/search/domain/repos/search_repo.dart';
import 'package:uni/features/search/domain/use_cases/get_specialties_use_case.dart';
import 'package:uni/features/search/domain/use_cases/search_unis_use_case.dart';
import 'package:uni/features/uni_detail/data/data_sources/uni_detail_remote_data_source.dart';
import 'package:uni/features/uni_detail/data/repos/uni_detail_repo_impl.dart';
import 'package:uni/features/uni_detail/domain/repos/uni_detail_repo.dart';
import 'package:uni/features/uni_detail/domain/use_cases/get_uni_detail_use_case.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio
  getIt.registerSingleton<Dio>(Dio());

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
  getIt.registerSingleton<BrowseRemoteDataSource>(
    BrowseRemoteDataSourceImpl(getIt<ApiService>()),
  );
  getIt.registerSingleton<BrowseRepo>(
    BrowseRepoImpl(getIt<BrowseRemoteDataSource>()),
  );
  getIt.registerSingleton<GetUnisUseCase>(GetUnisUseCase(getIt<BrowseRepo>()));

  // ===== FAV =====
  getIt.registerSingleton<FavRemoteDataSource>(
    FavRemoteDataSourceImpl(getIt<ApiService>()),
  );
  getIt.registerSingleton<FavRepo>(FavRepoImpl(getIt<FavRemoteDataSource>()));
  getIt.registerSingleton<GetFavsUseCase>(GetFavsUseCase(getIt<FavRepo>()));
  getIt.registerSingleton<AddToFavUseCase>(AddToFavUseCase(getIt<FavRepo>()));
  getIt.registerSingleton<RemoveFromFavUseCase>(
    RemoveFromFavUseCase(getIt<FavRepo>()),
  );
  getIt.registerSingleton<FavCubit>(
    FavCubit(
      getFavsUseCase: getIt<GetFavsUseCase>(),
      addToFavUseCase: getIt<AddToFavUseCase>(),
      removeFromFavUseCase: getIt<RemoveFromFavUseCase>(),
    ),
  );

  // ===== SEARCH =====
  getIt.registerSingleton<SearchRemoteDataSource>(
    SearchRemoteDataSourceImpl(getIt<ApiService>()),
  );
  getIt.registerSingleton<SearchRepo>(
    SearchRepoImpl(getIt<SearchRemoteDataSource>()),
  );
  getIt.registerSingleton<SearchUnisUseCase>(
    SearchUnisUseCase(getIt<SearchRepo>()),
  );
  getIt.registerSingleton<GetSpecialtiesUseCase>(
    GetSpecialtiesUseCase(getIt<SearchRepo>()),
  );

  // ===== NOTIFICATIONS =====
  getIt.registerSingleton<NotificationsRemoteDataSource>(
    NotificationsRemoteDataSourceImpl(getIt<ApiService>()),
  );
  getIt.registerSingleton<NotificationsRepo>(
    NotificationsRepoImpl(getIt<NotificationsRemoteDataSource>()),
  );
  getIt.registerSingleton<GetNotificationsUseCase>(
    GetNotificationsUseCase(getIt<NotificationsRepo>()),
  );
  getIt.registerSingleton<GetUnreadNotificationsCountUseCase>(
    GetUnreadNotificationsCountUseCase(getIt<NotificationsRepo>()),
  );
  getIt.registerSingleton<MarkNotificationAsReadUseCase>(
    MarkNotificationAsReadUseCase(getIt<NotificationsRepo>()),
  );
  getIt.registerSingleton<MarkAllNotificationsAsReadUseCase>(
    MarkAllNotificationsAsReadUseCase(getIt<NotificationsRepo>()),
  );
  getIt.registerSingleton<NotificationsCubit>(
    NotificationsCubit(
      getNotificationsUseCase: getIt<GetNotificationsUseCase>(),
      getUnreadCountUseCase: getIt<GetUnreadNotificationsCountUseCase>(),
      markAsReadUseCase: getIt<MarkNotificationAsReadUseCase>(),
      markAllAsReadUseCase: getIt<MarkAllNotificationsAsReadUseCase>(),
    ),
  );

  // ===== GUIDE =====
  getIt.registerSingleton<GuideRemoteDataSource>(
    GuideRemoteDataSourceImpl(getIt<ApiService>()),
  );
  getIt.registerSingleton<GuideRepo>(
    GuideRepoImpl(getIt<GuideRemoteDataSource>()),
  );
  getIt.registerSingleton<GetArticlesUseCase>(
    GetArticlesUseCase(getIt<GuideRepo>()),
  );
  getIt.registerSingleton<GuideCubit>(GuideCubit(getIt<GetArticlesUseCase>()));

  // ===== UNI DETAIL =====
  getIt.registerSingleton<UniDetailRemoteDataSource>(
    UniDetailRemoteDataSourceImpl(getIt<ApiService>()),
  );
  getIt.registerSingleton<UniDetailRepo>(
    UniDetailRepoImpl(getIt<UniDetailRemoteDataSource>()),
  );
  getIt.registerSingleton<GetUniDetailUseCase>(
    GetUniDetailUseCase(getIt<UniDetailRepo>()),
  );

  // ===== AUTH =====
  getIt.registerSingleton<AuthRemoteDataSource>(
    AuthRemoteDataSourceImpl(getIt<ApiService>()),
  );
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(getIt<AuthRemoteDataSource>()),
  );
  getIt.registerSingleton<LoginUseCase>(LoginUseCase(getIt<AuthRepo>()));
  getIt.registerSingleton<RegisterUseCase>(RegisterUseCase(getIt<AuthRepo>()));
  getIt.registerSingleton<VerifyOtpUseCase>(
    VerifyOtpUseCase(getIt<AuthRepo>()),
  );
  getIt.registerSingleton<ForgetPasswordUseCase>(
    ForgetPasswordUseCase(getIt<AuthRepo>()),
  );
  getIt.registerSingleton<ResendOtpUseCase>(
    ResendOtpUseCase(getIt<AuthRepo>()),
  );
  getIt.registerSingleton<ResetPasswordUseCase>(
    ResetPasswordUseCase(getIt<AuthRepo>()),
  );
  getIt.registerSingleton<SaveStudentInfoUseCase>(
    SaveStudentInfoUseCase(getIt<AuthRepo>()),
  );
  getIt.registerSingleton<UpdatePasswordUseCase>(
    UpdatePasswordUseCase(getIt<AuthRepo>()),
  );
  getIt.registerSingleton<GetMeUseCase>(GetMeUseCase(getIt<AuthRepo>()));

  // ===== PROFILE =====
  // reuses the same auth use cases registered above (getMe, saveStudentInfo, updatePassword)
  getIt.registerSingleton<ProfileCubit>(
    ProfileCubit(
      getMeUseCase: getIt<GetMeUseCase>(),
      saveStudentInfoUseCase: getIt<SaveStudentInfoUseCase>(),
      updatePasswordUseCase: getIt<UpdatePasswordUseCase>(),
    ),
  );

  // ===== FAHEEM =====
  getIt.registerSingleton<FaheemRemoteDataSource>(
    FaheemRemoteDataSourceImpl(getIt<ApiService>()),
  );
  getIt.registerSingleton<FaheemRepo>(
    FaheemRepoImpl(getIt<FaheemRemoteDataSource>()),
  );
  getIt.registerSingleton<SendMessageUseCase>(
    SendMessageUseCase(getIt<FaheemRepo>()),
  );
  getIt.registerSingleton<FaheemCubit>(
    FaheemCubit(getIt<SendMessageUseCase>()),
  );
}
