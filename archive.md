# Claude Memory File — Archive / Reference (Gameaty)
> Last updated: June 2026

---

## 1. Project Structure

```
lib/
├── constants.dart              (kHorizontalPadding=16, kTopPadding=16, kIsOnBoardingViewSeenKey)
├── main.dart                   (routeObserver defined here globally)
├── core/
│   ├── entities/
│   │   ├── uni_entity.dart
│   │   ├── unis_response.dart         (nextCursor + nextPage in the same object)
│   │   ├── trending_uni_entity.dart
│   │   └── guide_video_entity.dart
│   ├── errors/
│   │   ├── failures.dart              (ServerFailure.fromDioError + fromResponse)
│   │   └── custom_exceptions.dart
│   ├── helper_functions/
│   │   ├── get_unis_list.dart
│   │   ├── getDummyEntities.dart
│   │   ├── on_generate_routes.dart
│   │   ├── recent_searches_helper.dart
│   │   ├── calc_strength.dart
│   │   └── build_error_bar.dart
│   ├── services/
│   │   ├── get_it_service.dart
│   │   ├── shared_preferences_singleton.dart (Prefs class)
│   │   ├── custom_bloc_observer.dart
│   │   └── database_service.dart      (abstract — not used currently)
│   ├── cubits/trending_cubit/
│   │   ├── trending_cubit.dart
│   │   └── trending_state.dart
│   ├── data_sources/
│   │   └── trending_remote_data_source.dart
│   ├── models/
│   │   ├── uni_model/uni_model.dart
│   │   └── trending_uni_model/trending_uni_model.dart
│   ├── utils/
│   │   ├── app_colors.dart
│   │   ├── app_text_style.dart
│   │   ├── app_images.dart (Assets class)
│   │   ├── app_fonts.dart
│   │   └── backend_endpoints.dart
│   └── widgets/
│       ├── uni_card.dart
│       ├── uni_card_image.dart
│       ├── uni_card_info.dart
│       ├── uni_card_with_fav.dart       ← wrapper that interacts with FavCubit
│       ├── uni_list_widget.dart         ← accepts optional scrollController — passes id as argument to UniDetailView
│       ├── uni_filter_tab_bar.dart      ← filters: All / Government / Private
│       ├── uni_count_header.dart
│       ├── search_bar_field.dart        ← StatefulWidget, accepts controller/onChanged/onClear/onSubmitted
│       ├── custom_button.dart
│       ├── back_button.dart             (CustomBackButton)
│       ├── filter_button_badge.dart
│       ├── filter_tab_bar_item.dart
│       ├── ask_faheem_button.dart       ← global FAB
│       ├── custom_error_widget.dart
│       ├── custom_progress_hud.dart
│       ├── custom_text_form_field.dart
│       ├── password_field.dart
│       ├── rating.dart
│       ├── type_badge_widget.dart
│       ├── location_widget.dart         ← LocationRow has Expanded on the Text
│       ├── section_header_item.dart
│       ├── featured_guide_video_section.dart
│       ├── guide_video_card.dart
│       ├── guide_video_player.dart
│       ├── guide_video_player_info.dart
│       └── featured_guide_podcasts_section.dart  (dummy data)
└── features/
    ├── browse/
    │   ├── data/
    │   │   ├── data_sources/browse_remote_data_source.dart
    │   │   └── repos/browse_repo_impl.dart
    │   ├── domain/
    │   │   ├── repos/browse_repo.dart
    │   │   └── use_cases/get_unis_use_case.dart
    │   └── presentation/
    │       ├── manager/browse_cubit/ → BrowseCubit, BrowseState
    │       └── views/
    │           ├── browse_view.dart              ← BlocProvider(create: BrowseCubit..getUnis())
    │           └── widgets/
    │               ├── browse_view_body.dart
    │               └── browse_header_and_list_bloc_builder.dart
    ├── search/
    │   ├── data/
    │   │   ├── data_sources/search_remote_data_source.dart
    │   │   ├── models/search_uni_model.dart
    │   │   └── repos/search_repo_impl.dart
    │   ├── domain/
    │   │   ├── entities/search_filter_entity.dart
    │   │   ├── repos/search_repo.dart
    │   │   └── use_cases/ → SearchUnisUseCase, GetSpecialtiesUseCase
    │   └── presentation/
    │       ├── manager/
    │       │   ├── search_cubit/ → SearchCubit, SearchCubitState
    │       │   └── specialties_cubit/ → SpecialtiesCubit, SpecialtiesState
    │       └── views/
    │           ├── search_view.dart              ← MultiBlocProvider(SearchCubit + TrendingCubit)
    │           └── widgets/
    │               ├── search_view_body.dart
    │               ├── search_content_bloc_builder.dart
    │               ├── search_results_bloc_builder.dart
    │               ├── search_results_widget.dart  ← exists but unused (dead code)
    │               ├── search_home_widget.dart
    │               ├── search_empty_widget.dart
    │               ├── search_filter_bottom_sheet.dart
    │               ├── recent_search_item.dart
    │               ├── trending_search_chip.dart
    │               ├── filter_type_checkbox.dart
    │               ├── filter_specialty_chip.dart
    │               ├── fees_range_search_filter_bottom_sheet.dart
    │               ├── header_search_filter_bottom_sheet.dart
    │               ├── results_btn_search_filter_bottom_sheet.dart
    │               ├── specialties_search_filter_bottom_sheet.dart
    │               └── uni_types_search_filter_bottom_sheet.dart
    ├── fav/
    │   ├── data/
    │   │   ├── data_sources/fav_remote_data_source.dart
    │   │   └── repos/fav_repo_impl.dart
    │   ├── domain/
    │   │   ├── repos/fav_repo.dart
    │   │   └── use_cases/ → GetFavsUseCase, AddToFavUseCase, RemoveFromFavUseCase
    │   └── presentation/
    │       ├── manager/fav_cubit/ → FavCubit, FavState
    │       └── views/
    │           ├── fav_view.dart
    │           └── widgets/
    │               ├── fav_view_body.dart
    │               └── fav_header_and_list_bloc_consumer.dart
    ├── guide/
    │   ├── data/
    │   │   ├── data_sources/guide_remote_data_source.dart
    │   │   ├── models/guide_article_model.dart
    │   │   └── repos/guide_repo_impl.dart
    │   ├── domain/
    │   │   ├── entities/ → guide_article_entity.dart, guide_podcast_entity.dart, articles_response.dart
    │   │   ├── repos/guide_repo.dart
    │   │   └── use_cases/get_articles_use_case.dart
    │   └── presentation/
    │       ├── manager/guide_cubit/ → GuideCubit, GuideState
    │       └── views/
    │           ├── guide_view.dart
    │           ├── guide_articles_view.dart     ← BlocProvider.value(getIt<GuideCubit>()..getArticles())
    │           ├── guide_article_detail_view.dart ← receives GuideArticleEntity as argument
    │           ├── guide_videos_view.dart        ← dummy data
    │           ├── guide_podcasts_view.dart      ← dummy data
    │           └── widgets/
    │               ├── guide_view_body.dart      ← search UI filter + take(2) in normal mode
    │               ├── guide_articles_view_body.dart
    │               ├── guide_article_detail_view_body.dart
    │               ├── guide_article_card.dart
    │               ├── guide_podcast_card.dart
    │               └── guide_videos_view_body.dart
    ├── notifications/
    │   ├── data/
    │   │   ├── data_sources/notifications_remote_data_source.dart
    │   │   ├── models/notification_model.dart
    │   │   └── repos/notifications_repo_impl.dart
    │   ├── domain/
    │   │   ├── entities/ → notification_entity.dart, notifications_response.dart
    │   │   ├── repos/notifications_repo.dart
    │   │   └── use_cases/ → GetNotificationsUseCase, GetUnreadNotificationsCountUseCase,
    │   │                     MarkNotificationAsReadUseCase, MarkAllNotificationsAsReadUseCase
    │   └── presentation/
    │       ├── manager/notifications_cubit/ → NotificationsCubit, NotificationsState
    │       └── views/
    │           ├── notifications_view.dart       ← initState calls getNotifications()
    │           └── widgets/
    │               ├── notifications_view_body.dart
    │               ├── notifications_app_bar.dart
    │               ├── notification_card.dart
    │               ├── notification_group_section.dart
    │               └── notification_icon_widget.dart
    ├── home/
    │   ├── data/
    │   │   ├── data_sources/recommended_remote_data_source.dart  ← temporarily uses getTrendingUnis endpoint
    │   │   └── models/recommended_uni_model.dart
    │   ├── domain/
    │   │   └── entities/ → recommended_uni_entity.dart, bottom_navigation_bar_entity.dart
    │   └── presentation/
    │       ├── manager/recommended_cubit/ → RecommendedCubit, RecommendedState
    │       └── views/
    │           ├── main_view.dart               ← late final views + RouteAware
    │           └── widgets/
    │               ├── home_view.dart            ← exists but dead code (MainView uses HomeViewBody directly)
    │               ├── home_view_body.dart
    │               ├── custom_home_app_bar.dart
    │               ├── faheem_banner_widget.dart
    │               ├── browse_tile.dart
    │               ├── trending_unis_section.dart
    │               ├── trending_uni_card.dart
    │               ├── recommended_unis_section.dart
    │               ├── recommended_uni_card.dart
    │               ├── uni_image_section.dart
    │               ├── uni_info_section.dart     ← navigates to UniDetailView with arguments: recommendedUniEntity.id
    │               ├── uni_info_chip.dart
    │               ├── top_tag.dart
    │               ├── glowing_action_button.dart
    │               ├── custom_bottom_navigation_bar.dart
    │               ├── navigation_bar_item.dart
    │               ├── active_item.dart
    │               └── in_active_item.dart
    ├── splash/
    │   └── presentation/views/
    │       ├── splash_view.dart
    │       └── widgets/
    │           ├── splash_view_body.dart
    │           ├── uni_logo_widget.dart
    │           └── uni_text_pocket_widget.dart
    ├── on_boarding/
    │   └── presentation/
    │       ├── on_boarding_data.dart             ← kOnBoardingPages list
    │       └── views/
    │           ├── on_boarding_view.dart
    │           └── widgets/
    │               ├── on_boarding_view_body.dart
    │               ├── on_boarding_page_item.dart
    │               └── on_boarding_bottom_bar.dart
    ├── uni_detail/
    │   ├── domain/
    │   │   ├── entities/
    │   │   │   ├── uni_detail_entity.dart
    │   │   │   ├── uni_faculty_entity.dart       ← has IconData icon field (assigned from name in model)
    │   │   │   └── uni_alumni_entity.dart
    │   │   ├── repos/uni_detail_repo.dart
    │   │   └── use_cases/get_uni_detail_use_case.dart
    │   ├── data/
    │   │   ├── models/
    │   │   │   ├── uni_detail_model.dart         ← assembled from 4 API responses
    │   │   │   ├── uni_faculty_model.dart        ← _iconFromName() maps college name → IconData
    │   │   │   └── uni_alumni_model.dart         ← _formatYear() "1934-06-10" → "دفعة 1934"
    │   │   ├── data_sources/uni_detail_remote_data_source.dart  ← Future.wait 4 calls
    │   │   └── repos/uni_detail_repo_impl.dart
    │   └── presentation/
    │       ├── manager/uni_detail_cubit/
    │       │   ├── uni_detail_cubit.dart
    │       │   └── uni_detail_state.dart
    │       └── views/
    │           ├── uni_detail_view.dart          ← receives int id, BlocProvider(UniDetailCubit..getUniDetail(id))
    │           └── widgets/
    │               ├── uni_detail_view_body.dart ← BlocBuilder + _UniDetailContent + _StickyTabBarDelegate
    │               ├── uni_detail_hero_image.dart  ← Image.network
    │               ├── uni_detail_info_header.dart ← Expanded on name Text, fixed unbounded width
    │               ├── uni_detail_tab_bar.dart
    │               ├── uni_detail_bottom_bar.dart
    │               ├── uni_stats_row.dart
    │               ├── stat_item.dart
    │               ├── uni_overview_tab.dart
    │               ├── uni_faculties_tab.dart
    │               ├── uni_alumni_tab.dart
    │               ├── uni_alumni_card.dart      ← Image.network
    │               ├── campus_photos_grid.dart   ← Image.network
    │               ├── faculty_item.dart
    │               ├── faculty_item_header.dart  ← icon from entity.icon
    │               └── faculty_item_expanded_content.dart ← Expanded on requirement Text
    ├── profile/
    │   └── presentation/views/
    │       ├── profile_view.dart
    │       ├── personal_data_view.dart
    │       ├── security_view.dart
    │       ├── contact_us_view.dart
    │       └── widgets/ → avatar_profile.dart, contact_us_channel_card.dart,
    │                       contact_us_view_body.dart, details_field.dart,
    │                       documents_section.dart, footer.dart,
    │                       governorate_dropdown.dart, message_form_section.dart,
    │                       password_section.dart, percentage_field.dart,
    │                       personal_data_document_upload_card.dart, personal_data_field_label.dart,
    │                       personal_data_interests_selector.dart, personal_data_study_type_selector.dart,
    │                       personal_data_view_body.dart, profile_avatar_section.dart,
    │                       profile_header.dart, profile_logout_button.dart,
    │                       profile_menu_item.dart, profile_menu_section.dart,
    │                       profile_view_body.dart, quick_contact.dart,
    │                       robot_section.dart, role_badge.dart,
    │                       security_strength_indicator.dart, security_view_body.dart,
    │                       stats_section.dart, top_section_security.dart,
    │                       topic_dropdown.dart, version_info.dart
    └── faheem/
        ├── domain/entities/ → chat_history_entity.dart, chat_message_entity.dart, suggestion_item_entity.dart
        └── presentation/views/
            ├── faheem_chat_view.dart
            ├── faheem_history_view.dart
            └── widgets/ → chat_history_card.dart, chat_history_group_section.dart,
                           chat_input_bar.dart, chat_messages_list.dart,
                           faheem_chat_app_bar.dart, faheem_chat_view_body.dart,
                           faheem_history_view_body.dart, faheem_message_bubble.dart,
                           faheem_typing_bubble.dart, faheem_uni_card.dart,
                           faheem_uni_cards_row.dart, faheem_welcome_widget.dart,
                           suggestion_chip.dart, user_message_bubble.dart
```

---

## 2. Core Entities

### UniEntity — no isFav (FavCubit is the single source of truth)

```dart
class UniEntity {
  final int id;
  final String name;
  final String location;
  final String imagePath;       // background_image_url in Browse, Fav, and Search
  final String type;            // 'حكومية' | 'خاصة' | 'معهد عالي'
  final double rating;
  final int worldRanking;
  // final bool isFav;          // commented out — FavCubit is the single source of truth
}
```

### TrendingUniEntity

```dart
class TrendingUniEntity {
  final String name;
  final String worldRanking;   // String because the API may return "غير متاح"
  final String? logoPath;      // from avatar_url
}
```

### RecommendedUniEntity

```dart
class RecommendedUniEntity {
  final int id;
  final String name;
  final String location;
  final String imagePath;      // background_image_url
  final String? logoPath;      // avatar_url
  final String type;
  final String rate;           // String not double — as the API sends it
  final int studentsCount;
}
```

### UnisResponse

```dart
class UnisResponse {
  final List<UniEntity> uniEntities;
  final String? nextCursor;    // Browse & Fav & Guide
  final int? nextPage;         // Search (page-based)
}
```

### NotificationEntity

```dart
class NotificationEntity {
  final int id;
  final String title;
  final String body;           // from 'message' in the API
  final String timeLabel;      // calculated from created_at
  final bool isRead;           // from 'read_status'
  final DateTime createdAt;
}
```

### NotificationsResponse (in `features/notifications/domain/entities/`)

```dart
class NotificationsResponse {
  final List<NotificationEntity> notifications;
  final String? nextCursor;
}
```

### ArticlesResponse (in `features/guide/domain/entities/`)

```dart
class ArticlesResponse {
  final List<GuideArticleEntity> articles;
  final String? nextCursor;
}
```

### UniDetailEntity

```dart
class UniDetailEntity {
  final int id;
  final String name;
  final String type;
  final String address;
  final String heroImagePath;      // background_image_url
  final String logoImagePath;      // avatar_url
  final String about;              // public_summary
  final int studentsCount;
  final int foundedYear;           // parsed from "1908-12-21"
  final String worldRanking;       // raw string e.g. "371"
  final String website;
  final double rate;
  final List<UniFacultyEntity> uniFacultyEntities;
  final List<UniAlumniEntity> uniAlumniEntities;
  final List<String> campusPhotoPaths;  // from university_life image_url
}
```

### UniFacultyEntity

```dart
class UniFacultyEntity {
  final int id;
  final String name;
  final String location;
  final String minFees;        // formatted: "1200 EGP"
  final double minGrade;       // min_percentage
  final List<String> requirements;  // admission_requirements
  final IconData icon;         // assigned in UniFacultyModel._iconFromName()
}
```

### UniAlumniEntity

```dart
class UniAlumniEntity {
  final int id;
  final String name;           // popular_name
  final String imagePath;      // avatar
  final String graduationYear; // "دفعة 1934" — parsed from "1934-06-10"
}
```

### API Response Structure (confirmed)
```json
{
  "id": 1,
  "name": "جامعة القاهرة",
  "location": "الجيزة",
  "type": "حكومي",
  "rate": "5.00",
  "is_fav_for_me": "false",
  "avatar_url": "https://.../image.png",
  "background_image_url": "https://.../image.png",
  "world_ranking": "371",
  "website": "https://...",
  "public_summary": "...",
  "foundation_date": "1908-12-21",
  "students_count": 20785
}
```
> ⚠️ `world_ranking` may be a string like `"371"` or a range like `"200-300"` — `parseRanking()` is required
> ⚠️ `is_fav_for_me` exists in the API response but is commented out in `UniEntity`

---

## 3. Backend Endpoints (currently in the codebase)

```dart
class BackendEndpoints {
  static const String baseUrl = 'https://back.laraveladvancedsayed101.cloud/api';

  // Universities
  static const String getUniversities = '/universities';
  static const String getTrendingUnis = '/universities/trendy';
  static String getUniDetail(int id) => '/universities/$id';

  // Colleges
  static const String getColleges = '/colleges';
  static String getCollegesByUni(int universityId) => '/colleges/$universityId';

  // Graduates
  static String getGraduatesByUni(int universityId) => '/graduates/$universityId';

  // University Life
  static String getUniLife(int universityId) => '/university_life/$universityId';

  // Fav
  static const String addToFav = '/university_fav/add';
  static const String removeFromFav = '/university_fav/remove';
  static const String getFavs = '/university_fav';

  // Notifications
  static const String getNotifications = '/notifications';
  static const String getUnreadNotificationsCount = '/notifications/count-unread';
  static String markNotificationAsRead(int id) => '/notifications/mark-as-read/$id';
  static const String markAllNotificationsAsRead = '/notifications/markall';

  // Articles
  static const String getArticles = '/articles';

  // Search
  static const String search = '/search-univ';
}
```

**Endpoints that exist in the API but haven't been added to the codebase yet** (for next steps):
```
/login, /register, /verify-Otp, /forget-Password
/auth/reset-Password, /auth/me, /auth/update-Password
/resendOtp, /auth/refresh
/student_info
/aiChat/send
```

---

## 4. ApiService

```dart
class ApiService {
  final Dio dio;

  ApiService(this.dio) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers['Accept'] = 'application/json';
        options.headers['Api-Key'] = dotenv.env['API_KEY'] ?? '';

        final token = Prefs.getString('token');
        if (token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    ));
  }

  Future<Map<String, dynamic>> get({required String endpoint, Map<String, dynamic>? queryParameters})
  Future<Map<String, dynamic>> post({required String endpoint, Map<String, dynamic>? data})
  Future<Map<String, dynamic>> patch({required String endpoint, Map<String, dynamic>? data})
  Future<List<dynamic>> getList({required String endpoint, Map<String, dynamic>? queryParameters})
}
```

---

## 5. .env File

```
API_KEY=your_api_key_here
TOKEN=your_token_here   ← temporary for development, will be removed when Auth is implemented
```

**Header name:** `Api-Key` (not `X-API-KEY`)

---

## 6. GetIt Service (Current State)

**Global Singletons (all `registerSingleton`, not lazy):**
- `Dio`, `ApiService`
- `TrendingRemoteDataSource`, `TrendingCubit`
- `RecommendedRemoteDataSource`
- `BrowseRemoteDataSource`, `BrowseRepo`, `GetUnisUseCase`
- `FavRemoteDataSource`, `FavRepo`, `GetFavsUseCase`, `AddToFavUseCase`, `RemoveFromFavUseCase`, `FavCubit`
- `SearchRemoteDataSource`, `SearchRepo`, `SearchUnisUseCase`, `GetSpecialtiesUseCase`
- `NotificationsRemoteDataSource`, `NotificationsRepo`, `GetNotificationsUseCase`, `GetUnreadNotificationsCountUseCase`, `MarkNotificationAsReadUseCase`, `MarkAllNotificationsAsReadUseCase`, `NotificationsCubit`
- `GuideRemoteDataSource`, `GuideRepo`, `GetArticlesUseCase`, `GuideCubit`
- `UniDetailRemoteDataSource`, `UniDetailRepo`, `GetUniDetailUseCase`

> ⚠️ `UniDetailCubit` is NOT a singleton — created per-screen via `BlocProvider(create:...)` in `UniDetailView`
> ⚠️ The `hardcoded token` in `get_it_service.dart` — for development only, will change with Auth.

**In `main.dart`:**
```dart
final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

// MyApp:
MultiBlocProvider(
  providers: [
    BlocProvider.value(value: getIt<FavCubit>()),
    BlocProvider.value(value: getIt<NotificationsCubit>()..getNotifications()),
  ],
  child: MaterialApp(navigatorObservers: [routeObserver], ...),
)
```

**In `MainView.initState`:**
```dart
getIt<TrendingCubit>().fetchTrendingUnis();
getIt<FavCubit>().getFavs();
getIt<GuideCubit>().getArticles();
views = [
  const HomeViewBody(),
  const GuideViewBody(),
  const FavViewBody(),
  const ProfileViewBody(),
];
```

**In `MainView.build`:**
```dart
MultiBlocProvider(
  providers: [
    BlocProvider.value(value: getIt<TrendingCubit>()),
    BlocProvider.value(value: getIt<GuideCubit>()),
    BlocProvider(create: (_) => RecommendedCubit(getIt<RecommendedRemoteDataSource>())..fetchRecommendedUnis()),
  ],
)
```

**TrendingCubit vs RecommendedCubit:**

| | TrendingCubit | RecommendedCubit |
|---|---|---|
| **Location** | `core/cubits/` | `features/home/` |
| **Reason** | Used in both Home + Search | Home screen only |
| **GetIt** | `registerSingleton` | `BlocProvider(create:...)` in `MainView` |
| **Fetch** | `initState` of `MainView` | `create: (_) => ...fetchRecommendedUnis()` |

> ⚠️ `RecommendedRemoteDataSource` temporarily uses the `getTrendingUnis` endpoint — no recommended endpoint yet.

---

## 7. Notification Feature Details

**States:**
```
NotificationsInitial / NotificationsLoading
NotificationsSuccess { today, yesterday, thisWeek, older, unreadCount }
NotificationsPaginationLoading { today, yesterday, thisWeek, older, unreadCount }
NotificationsPaginationFailure { errMessage, today, yesterday, thisWeek, older, unreadCount }
NotificationsFailure { errMessage }
NotificationsActionFailure { errMessage }
```

**Grouping in Cubit:** today / yesterday / thisWeek / older — using `DateTime.now().difference(createdAt).inDays`
**Sorting:** newest to oldest within each group
**Unread count:** from a separate endpoint — Response: `{ "data": { "total": 10 } }`
**`_fetchUnreadCount()`:** emits only if the count has changed
**RouteObserver:** `MainView` is `RouteAware` — `didPopNext()` calls `getNotifications()`
**BottomNav:** when `index == 0`, calls `getNotifications()` as well
**NotificationsView:** `initState` calls `getNotifications()` every time it opens

**notification_card.dart — Unread Styling:**
- Background: `AppColors.lightSecondaryColor`
- Border: `secondaryColor.withOpacity(0.4)`
- Right indicator: `Stack + Positioned` with `width: 3, top: 9, bottom: 9`
- Small green dot next to the time label
- `NotificationsAppBar` — "Read all (N)" button only shows when there are unread notifications

---

## 8. Fav Feature — Architecture Decisions

**FavCubit as GetIt Singleton:**
- `registerSingleton<FavCubit>` in GetIt — single instance throughout the app
- In `main.dart`: `BlocProvider.value(value: getIt<FavCubit>())`
- `getFavs()` is called in `MainView.initState`

**FavState:**
```
FavInitial / FavLoading
FavSuccess { uniEntities, nextCursor }
FavFailure { errMessage }
FavPaginationLoading { currentUnis }
FavPaginationFailure { errMessage, currentUnis }
FavActionLoading / FavActionSuccess
FavActionFailure { errMessage }
```

**Deduplication in `loadMore()`** (safety net for the backend bug):
```dart
final existingIds = _allFavs.map((u) => u.id).toSet();
final newUnis = response.uniEntities
    .where((u) => !existingIds.contains(u.id))
    .toList();
_allFavs.addAll(newUnis);
_nextCursor = response.nextCursor;
```

**Optimistic Update:**
- `addToFav`: adds to `_favIds` immediately, rollback if API fails
- `removeFromFav`: removes from UI immediately, rollback if API fails

**FavViewBody:**
- `getFavs()` in `initState` — unlike `MainView` which also calls it in initState, calling it in FavViewBody does a reset and refetch
- Has **local search** that filters on `_searchController` and `selectedFilter`
- `_scrollController` on `SingleChildScrollView`, not on the ListView

**FavHeaderAndListBlocConsumer:**
- `BlocConsumer` with `buildWhen` that ignores `FavActionSuccess` and `FavActionLoading`
- `listenWhen` shows a Snackbar on `FavActionFailure`

---

## 9. Browse Feature — Architecture Decisions

**per_page:** `10` in `browse_remote_data_source.dart`

**BrowseViewBody — Scroll pattern:**
```dart
SingleChildScrollView(
  controller: scrollController,
  child: Column(children: [
    SearchBarField(readOnly, onTap → SearchView),
    UniFilterTabBar,
    BrowseHeaderAndListBlocBuilder,
  ]),
)
// onScroll: checks state is! BrowsePaginationLoading
```

**BrowseHeaderAndListBlocBuilder:**
- `BlocListener<FavCubit>` wraps `BlocBuilder<BrowseCubit>` to show Snackbar on FavActionFailure

**UniListWidget:**
```dart
ListView.separated(
  controller: scrollController,
  physics: scrollController != null
      ? AlwaysScrollableScrollPhysics()
      : NeverScrollableScrollPhysics(),
  shrinkWrap: scrollController == null,
)
// onTap: Navigator.pushNamed(context, UniDetailView.routeName, arguments: selectedFilterUniEntities[index].id)
```

---

## 10. Search Feature — Architecture Decisions

**SearchCubit:**
- `_lastQuery`, `_lastFilter`, `_allResults`, `_nextPage`, `_isLoadingMore`
- `search()`: resets everything, if query is empty and no filter → emit SearchInitial
- `loadMore()`: page-based, not cursor

**SearchCubitState:**
```
SearchInitial / SearchLoading / SearchEmpty
SearchSuccess { uniEntities, hasMore }
SearchFailure { errMessage }
SearchPaginationLoading { currentUnis }
SearchPaginationFailure { errMessage, currentUnis }
```

**SearchResultsBlocBuilder:** independent StatefulWidget with its own ScrollController for pagination

**Search API Params:**
```
GET /search-univ
  per_page=10
  name=<query>                     // optional
  type=حكومي|خاص                   // optional, only if one type is selected
  speciality[0]=هندسة              // optional, array
  yearly_Expenses[0]=<min>         // optional, only if changed from defaults
  yearly_Expenses[1]=<max>
  page=2                           // for pagination
```

**SearchFilterEntity (current defaults in codebase):**
```dart
const SearchFilterEntity({
  this.minFees = 10000,
  this.maxFees = 250000,
  this.selectedSpecialties = const [],
  this.selectedTypes = const [],
});
```

---

## 11. Guide Feature — Architecture Decisions

**GuideCubit as GetIt Singleton:**
- `getArticles()` is called in `MainView.initState`
- `GuideArticlesView` does `BlocProvider.value(value: getIt<GuideCubit>()..getArticles())`

**GuideState:**
```
GuideInitial / GuideLoading
GuideSuccess { articles, nextCursor }
GuideFailure { errMessage }
GuidePaginationLoading { currentArticles }
GuidePaginationFailure { errMessage, currentArticles }
```

**GuideViewBody:**
- Normal view: shows `state.articles.take(2).toList()` in the "Latest Articles" section
- Search mode: filters on title and content

**GuideArticlesView:** separate route — calls `getArticles()` fresh when opened

---

## 12. Uni Detail Feature — Architecture Decisions

**4 API calls in parallel via `Future.wait`:**
- `GET /universities/{id}` → university info
- `GET /colleges/{id}` → faculties list
- `GET /graduates/{id}` → alumni list
- `GET /university_life/{id}` → campus photos

**One use case:** `GetUniDetailUseCase` — calls repo which calls data source with all 4 simultaneously.

**No ResponseEntity:** no cursor/pagination on any of these 4 endpoints — full data returned at once.

**`UniDetailCubit` is NOT a GetIt singleton** — created per-screen in `UniDetailView`:
```dart
BlocProvider(
  create: (_) => UniDetailCubit(getIt<GetUniDetailUseCase>())..getUniDetail(id),
  child: ...,
)
```

**Navigation:**
- From `uni_list_widget.dart` (browse/fav/search): `arguments: selectedFilterUniEntities[index].id`
- From `uni_info_section.dart` (home recommended): `arguments: recommendedUniEntity.id`
- In `on_generate_routes.dart`: `final id = settings.arguments as int;`

**`UniFacultyModel._iconFromName()`:** assigns `IconData` from college name keywords (هندسة/طب/حاسبات/etc.) — not from index, not from API.

**`UniAlumniModel._formatYear()`:** `"1934-06-10"` → `"دفعة 1934"`

**Layout fix:** `SliverToBoxAdapter → Column` needs `crossAxisAlignment: CrossAxisAlignment.stretch` to give `LocationRow` a bounded width constraint (prevents unbounded width crash from `Expanded` inside `LocationRow`).

**`UniDetailState`:**
```
UniDetailInitial / UniDetailLoading
UniDetailSuccess { uniDetailEntity }
UniDetailFailure { errMessage }
```

---

## 13. Data Flow — UniModel.parseRanking

```dart
static int parseRanking(dynamic ranking) {
  if (ranking == null) return 0;
  final str = ranking.toString().replaceAll('"', '').trim();
  if (str.contains('-')) {
    return int.tryParse(str.split('-').first.trim()) ?? 0;
  }
  return int.tryParse(str) ?? 0;
}
```
> ✅ Used in: `UniModel.fromJson` and `SearchUniModel.fromJson`
> ❌ `TrendingUniModel` doesn't use it — stores `world_ranking` as String directly

---

## 14. on_generate_routes.dart — Current Routes

```dart
SplashView.routeName        → SplashView
OnBoardingView.routeName    → OnBoardingView
MainView.routeName          → MainView
HomeView.routeName          → HomeView  ← dead code
FavView.routeName           → FavView
ProfileView.routeName       → ProfileView
PersonalDataView.routeName  → PersonalDataView
SecurityView.routeName      → SecurityView
ContactUsView.routeName     → ContactUsView
GuideView.routeName         → GuideView
GuideVideosView.routeName   → GuideVideosView
GuidePodcastsView.routeName → GuidePodcastsView
GuideArticlesView.routeName → GuideArticlesView
GuideArticleDetailView.routeName → GuideArticleDetailView (arguments: GuideArticleEntity)
BrowseView.routeName        → BrowseView
NotificationsView.routeName → NotificationsView
FaheemChatView.routeName    → FaheemChatView
FaheemHistoryView.routeName → FaheemHistoryView
UniDetailView.routeName     → UniDetailView(id: settings.arguments as int)
SearchView.routeName        → SearchView
```

---

## 15. Splash & Onboarding

**Navigation Flow:**
```
SplashView (2 seconds) → check kIsOnBoardingViewSeenKey (SharedPreferences)
  ├── false → OnBoardingView → (onDone: setBool true + pushReplacement MainView)
  └── true  → MainView
```

**OnBoardingView:** sets `Directionality(rtl)` locally — main.dart builder also sets it globally

---

## 16. Faheem/Chat Feature

```dart
enum MessageSender { user, faheem }
enum MessageContentType { text, uniCards }

class ChatMessageEntity {
  final String? text;
  final MessageSender sender;
  final MessageContentType contentType;
  final List<FaheemUniCardEntity>? uniCards;
  final bool isTyping;
}
```

---

## 17. Known Bugs & Pending Issues

### ⚠️ Backend Bug — Fav Pagination:
The backend returns the same items on every call regardless of the cursor.
**Flutter temporary fix:** Deduplication exists in `FavCubit.loadMore()`.
**Real fix:** sayed fixes `cursorPaginate()` in Laravel.

### ⚠️ `HomeView` dead code:
`home_view.dart` + case in `on_generate_routes.dart` exist but `HomeView.routeName` is never called anywhere. `MainView` uses `HomeViewBody` directly.

### ⚠️ `SearchResultsWidget` dead code:
`search_results_widget.dart` exists but is unused. `SearchResultsBlocBuilder` uses `UniListWidget` directly.

### ⚠️ Search `id` issue:
`SearchUniModel.id` is the university ID — but if the API returns college IDs in the future, `favIds.contains(entity.id)` won't work.

### ⚠️ Search Debounce — not implemented:
`_onSearchChanged` in `search_view_body.dart` is called on every keystroke without debounce.

### ⚠️ `_mapTypeToApi` in Search:
Sends `'Public'`/`'Private'` to the API. If the API expects `'حكومي'`/`'خاص'` it'll be a bug — needs confirmation with sayed.

### ⚠️ `SearchFilterEntity` defaults:
The codebase uses `minFees=10000, maxFees=250000`. If government universities don't show in search, the default fees are the reason.

### ⚠️ `RecommendedRemoteDataSource` endpoint:
Uses `getTrendingUnis` not recommended — temporary until a proper endpoint is added.

### ⚠️ `withOpacity` deprecated:
Used in many files — works but newer Flutter suggests `.withValues(alpha: ...)`.

### ⚠️ `is_fav_for_me` not enabled:
Present in the API response but commented out in `UniEntity`.

---

## 18. All Decisions Made

| Decision | Reason |
|---|---|
| `FavCubit` → `registerSingleton` in GetIt | Single instance across the whole app |
| `late final views` in `MainView` | Prevents recreating widgets on every setState |
| `FavViewBody.initState` calls `getFavs()` | To refresh when the user opens the tab |
| Deduplication in `FavCubit.loadMore()` | Safety net for the backend bug |
| `isFav` removed from `UniEntity` | `FavCubit` is the single source of truth |
| `UniCardWithFav` in `core/widgets` | Used in browse, fav, search, and uni_detail |
| `TrendingCubit` in `core/` | Used in both Home + Search |
| `RecommendedCubit` in `features/home/` | Home only |
| `GuideCubit` as singleton | `GuideArticlesView` needs it as a separate route |
| `getArticles()` in `MainView.initState` | Only once so the guide tab is ready |
| `GuideArticlesView` calls `..getArticles()` | Refreshes when opened as a full route |
| Search in Guide and Fav = UI filter | Not state — just a filter on existing data |
| `parseRanking()` in `UniModel` and `SearchUniModel` | API may send ranges like "200-300" |
| `worldRanking` in `TrendingUniEntity` = String | Displayed directly with `#` without parsing |
| `UnisResponse` has both `nextCursor` and `nextPage` | Browse/Fav/Guide = cursor, Search = page |
| Cursor-based pagination in Browse/Fav/Guide | API uses cursor |
| Page-based pagination in Search | `/search-univ` returns `next_page_url` |
| Pagination loading = widget below ListView | Not an item inside it — consistent |
| `per_page=10` in Browse and Fav | Current default |
| `ScrollController` on `BrowseViewBody` | `ListView` has `NeverScrollablePhysics` |
| `if (!mounted) return` in `onScroll` | Prevents StateError after dispose |
| `type` mapping: 'حكومي' → 'حكومية' | API sends masculine, UI displays feminine |
| `read_status` not `is_read` | That's the actual field name in the API |
| `timeLabel` from `created_at` | `updated_at` changes when marked as read |
| `RecentSearchesHelper` is separate | Doesn't modify the Prefs singleton directly |
| `onClear` preserves filters | Clears text only, not the selected filter |
| `SearchBarField` → `StatefulWidget` | So the clear icon shows/hides dynamically |
| `Expanded` on Text in `LocationRow` | Prevents RenderFlex overflow |
| `AskFaheemButton` in `MainView` FAB | Hides on the profile tab (`currentIndex != 3`) |
| `dotenv` for TOKEN temporarily | Until Auth is implemented |
| `UniDetailCubit` NOT a singleton | Each screen creates its own instance, disposed on pop |
| One use case for 4 endpoints in uni_detail | All called together, never independently |
| `Future.wait` in uni_detail data source | 4 calls in parallel — faster than sequential |
| No ResponseEntity in uni_detail | No pagination on any of the 4 endpoints |
| `_iconFromName()` in UniFacultyModel | Icon from college name keywords, not index or API |
| `crossAxisAlignment: stretch` on SliverToBoxAdapter Column | Gives LocationRow bounded width — fixes unbounded constraint crash |
| `arguments: entity.id` in UniListWidget + UniInfoSection | Passes uni id to UniDetailView via named route |