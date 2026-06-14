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
│   │   └── custom_exceptions.dart     (DELETED — no longer used)
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
│   │   ├── trending_cubit.dart        (catches DioException directly)
│   │   └── trending_state.dart
│   ├── data_sources/
│   │   └── trending_remote_data_source.dart  (no try/catch)
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
│       ├── uni_list_widget.dart         ← accepts optional scrollController
│       ├── uni_filter_tab_bar.dart      ← filters: All / Government / Private
│       ├── uni_count_header.dart
│       ├── search_bar_field.dart        ← StatefulWidget, accepts controller/onChanged/onClear/onSubmitted
│       ├── custom_button.dart
│       ├── back_button.dart             (CustomBackButton)
│       ├── filter_button_badge.dart
│       ├── filter_tab_bar_item.dart
│       ├── ask_faheem_button.dart       ← global FAB
│       ├── custom_error_widget.dart     ← has optional onRetry (VoidCallback?)
│       ├── no_internet_widget.dart      ← full-screen error: robot illustration + retry + optional onBack
│       ├── empty_state_widget.dart      ← icon + message for empty lists
│       ├── custom_progress_hud.dart
│       ├── custom_text_form_field.dart
│       ├── password_field.dart
│       ├── rating.dart
│       ├── type_badge_widget.dart
│       ├── location_widget.dart         ← LocationRow has Expanded on the Text
│       ├── section_header_item.dart     ← has optional onTap (VoidCallback?) for subtitle
│       ├── featured_guide_video_section.dart
│       ├── guide_video_card.dart
│       ├── guide_video_player.dart
│       ├── guide_video_player_info.dart
│       └── featured_guide_podcasts_section.dart  (dummy data)
└── features/
    ├── browse/
    │   ├── data/
    │   │   ├── data_sources/browse_remote_data_source.dart   (no try/catch)
    │   │   └── repos/browse_repo_impl.dart                   (catches DioException)
    │   ├── domain/
    │   │   ├── repos/browse_repo.dart
    │   │   └── use_cases/get_unis_use_case.dart
    │   └── presentation/
    │       ├── manager/browse_cubit/ → BrowseCubit, BrowseState
    │       └── views/
    │           ├── browse_view.dart
    │           └── widgets/
    │               ├── browse_view_body.dart
    │               └── browse_header_and_list_bloc_builder.dart  ← NoInternetWidget on BrowseFailure
    ├── search/
    │   ├── data/
    │   │   ├── data_sources/search_remote_data_source.dart   (no try/catch)
    │   │   ├── models/search_uni_model.dart
    │   │   └── repos/search_repo_impl.dart                   (catches DioException)
    │   ├── domain/
    │   │   ├── entities/search_filter_entity.dart
    │   │   ├── repos/search_repo.dart
    │   │   └── use_cases/ → SearchUnisUseCase, GetSpecialtiesUseCase
    │   └── presentation/
    │       ├── manager/
    │       │   ├── search_cubit/ → SearchCubit, SearchCubitState
    │       │   └── specialties_cubit/ → SpecialtiesCubit, SpecialtiesState
    │       └── views/
    │           ├── search_view.dart
    │           └── widgets/
    │               ├── search_view_body.dart
    │               ├── search_content_bloc_builder.dart
    │               ├── search_results_bloc_builder.dart
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
    │   │   ├── data_sources/fav_remote_data_source.dart      (no try/catch)
    │   │   └── repos/fav_repo_impl.dart                      (catches DioException)
    │   ├── domain/
    │   │   ├── repos/fav_repo.dart
    │   │   └── use_cases/ → GetFavsUseCase, AddToFavUseCase, RemoveFromFavUseCase
    │   └── presentation/
    │       ├── manager/fav_cubit/ → FavCubit, FavState
    │       └── views/
    │           ├── fav_view.dart
    │           └── widgets/
    │               ├── fav_view_body.dart
    │               └── fav_header_and_list_bloc_consumer.dart  ← NoInternetWidget on FavFailure
    ├── guide/
    │   ├── data/
    │   │   ├── data_sources/guide_remote_data_source.dart    (no try/catch)
    │   │   ├── models/guide_article_model.dart
    │   │   └── repos/guide_repo_impl.dart                    (catches DioException)
    │   ├── domain/
    │   │   ├── entities/ → guide_article_entity.dart, guide_podcast_entity.dart, articles_response.dart
    │   │   ├── repos/guide_repo.dart
    │   │   └── use_cases/get_articles_use_case.dart
    │   └── presentation/
    │       ├── manager/guide_cubit/ → GuideCubit, GuideState
    │       └── views/
    │           ├── guide_view.dart
    │           ├── guide_articles_view.dart
    │           ├── guide_article_detail_view.dart
    │           ├── guide_videos_view.dart
    │           ├── guide_podcasts_view.dart
    │           └── widgets/
    │               ├── guide_view_body.dart      ← CustomErrorWidget + onRetry on GuideFailure
    │               ├── guide_articles_view_body.dart
    │               ├── guide_article_detail_view_body.dart
    │               ├── guide_article_card.dart
    │               ├── guide_podcast_card.dart
    │               └── guide_videos_view_body.dart
    ├── notifications/
    │   ├── data/
    │   │   ├── data_sources/notifications_remote_data_source.dart  (no try/catch)
    │   │   ├── models/notification_model.dart
    │   │   └── repos/notifications_repo_impl.dart                  (catches DioException)
    │   ├── domain/
    │   │   ├── entities/ → notification_entity.dart, notifications_response.dart
    │   │   ├── repos/notifications_repo.dart
    │   │   └── use_cases/ → GetNotificationsUseCase, GetUnreadNotificationsCountUseCase,
    │   │                     MarkNotificationAsReadUseCase, MarkAllNotificationsAsReadUseCase
    │   └── presentation/
    │       ├── manager/notifications_cubit/ → NotificationsCubit, NotificationsState
    │       └── views/
    │           ├── notifications_view.dart
    │           └── widgets/
    │               ├── notifications_view_body.dart    ← BlocConsumer: ActionFailure→snackbar, buildWhen ignores it
    │               ├── notifications_app_bar.dart      ← buildWhen ignores NotificationsActionFailure
    │               ├── notification_card.dart
    │               ├── notification_group_section.dart ← onTap checks isRead before markAsRead
    │               └── notification_icon_widget.dart
    ├── home/
    │   ├── data/
    │   │   ├── data_sources/recommended_remote_data_source.dart  (no try/catch — catches DioException in cubit)
    │   │   └── models/recommended_uni_model.dart
    │   ├── domain/
    │   │   └── entities/ → recommended_uni_entity.dart, bottom_navigation_bar_entity.dart
    │   └── presentation/
    │       ├── manager/recommended_cubit/ → RecommendedCubit (catches DioException directly)
    │       └── views/
    │           ├── main_view.dart
    │           └── widgets/ → home_view_body.dart, custom_home_app_bar.dart, ...
    ├── splash/ → presentation/views/splash_view.dart + widgets/
    ├── on_boarding/ → presentation/views/on_boarding_view.dart + widgets/
    ├── uni_detail/
    │   ├── domain/
    │   │   ├── entities/
    │   │   │   ├── uni_detail_entity.dart    (includes rate: double, website: String)
    │   │   │   ├── uni_faculty_entity.dart
    │   │   │   └── uni_alumni_entity.dart
    │   │   ├── repos/uni_detail_repo.dart
    │   │   └── use_cases/get_uni_detail_use_case.dart
    │   ├── data/
    │   │   ├── models/
    │   │   │   ├── uni_detail_model.dart
    │   │   │   ├── uni_faculty_model.dart
    │   │   │   └── uni_alumni_model.dart
    │   │   ├── data_sources/uni_detail_remote_data_source.dart  (no try/catch — Future.wait 4 calls)
    │   │   └── repos/uni_detail_repo_impl.dart                  (catches DioException)
    │   └── presentation/
    │       ├── manager/uni_detail_cubit/ → UniDetailCubit, UniDetailState
    │       └── views/
    │           ├── uni_detail_view.dart          ← receives int id
    │           └── widgets/
    │               ├── uni_detail_view_body.dart ← NoInternetWidget on failure + retry + onBack
    │               ├── uni_detail_content.dart
    │               ├── uni_detail_hero_image.dart
    │               ├── uni_detail_info_header.dart  ← name + type + Rating(rate) + location
    │               ├── uni_detail_tab_bar.dart
    │               ├── uni_detail_bottom_bar.dart   ← FavCubit.favIds + addToFav/removeFromFav + "قدم الآن" placeholder
    │               ├── uni_stats_row.dart
    │               ├── stat_item.dart
    │               ├── uni_overview_tab.dart         ← about + stats + website (url_launcher)
    │               ├── uni_faculties_tab.dart         ← EmptyStateWidget if empty
    │               ├── uni_alumni_tab.dart            ← EmptyStateWidget if alumni empty
    │               ├── uni_alumni_card.dart
    │               ├── campus_photos_grid.dart        ← EmptyStateWidget if photos empty + tap opens viewer
    │               ├── campus_photos_sheet.dart       ← DraggableScrollableSheet full grid
    │               ├── campus_photo_viewer.dart       ← fullscreen PageView + InteractiveViewer + counter
    │               ├── faculty_item.dart
    │               ├── faculty_item_header.dart
    │               └── faculty_item_expanded_content.dart
    ├── profile/ → presentation/views/ (4 screens UI only)
    └── faheem/ → domain/entities/ + presentation/views/ (UI only)
```

---

## 2. Core Entities

### UniEntity — no isFav (FavCubit is the single source of truth)

```dart
class UniEntity {
  final int id;
  final String name;
  final String location;
  final String imagePath;
  final String type;
  final double rating;
  final int worldRanking;
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
  final String heroImagePath;  // background_image_url
  final String logoImagePath;// avatar_url
  final String about; // public_summary
  final int studentsCount;
  final int foundedYear;  // parsed from "1908-12-21"
  final String worldRanking;// raw string e.g. "371"
  final String website;        // opens via url_launcher
  final double rate;           // shown in UniDetailInfoHeader via Rating widget
  final List<UniFacultyEntity> uniFacultyEntities;
  final List<UniAlumniEntity> uniAlumniEntities;
  final List<String> campusPhotoPaths;// from university_life image_url
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

## 3. Backend Endpoints

```dart
class BackendEndpoints {
  static const String baseUrl = 'https://back.laraveladvancedsayed101.cloud/api';

  static const String getUniversities = '/universities';
  static const String getTrendingUnis = '/universities/trendy';
  static String getUniDetail(int id) => '/universities/$id';

  static const String getColleges = '/colleges';
  static String getCollegesByUni(int universityId) => '/colleges/$universityId';
  static String getGraduatesByUni(int universityId) => '/graduates/$universityId';
  static String getUniLife(int universityId) => '/university_life/$universityId';

  static const String addToFav = '/university_fav/add';
  static const String removeFromFav = '/university_fav/remove';
  static const String getFavs = '/university_fav';

  static const String getNotifications = '/notifications';
  static const String getUnreadNotificationsCount = '/notifications/count-unread';
  static String markNotificationAsRead(int id) => '/notifications/mark-as-read/$id';
  static const String markAllNotificationsAsRead = '/notifications/markall';

  static const String getArticles = '/articles';
  static const String search = '/search-univ';
}
```

**Not yet in codebase:**
```
/login, /register, /verify-Otp, /forget-Password
/auth/reset-Password, /auth/me, /auth/update-Password
/resendOtp, /auth/refresh
/student_info
/aiChat/send
```

---

## 4. Error Handling Pattern (UPDATED)

```
DioException (from Dio)
  → propagates from data source (no try/catch there)
  → caught in repo: on DioException catch (e) → left(ServerFailure.fromDioError(e))
  → cubit: result.fold(failure → emit FailureState, ...)
  → UI: NoInternetWidget (full-screen) or CustomErrorWidget (inline)
```

**`custom_exceptions.dart` is DELETED — not used anywhere.**

**Repos that catch DioException:**
- `browse_repo_impl`, `fav_repo_impl`, `search_repo_impl`, `guide_repo_impl`, `notifications_repo_impl`, `uni_detail_repo_impl`

**Cubits that catch DioException directly (no repo):**
- `TrendingCubit`, `RecommendedCubit`

---

## 5. Error UI Widgets

### `NoInternetWidget` (core/widgets) — full screen
```dart
NoInternetWidget({
  required VoidCallback onRetry,
  VoidCallback? onBack,   // shows "العودة للصفحة السابقة" if provided
})
```
Used in: `BrowseFailure`, `FavFailure`, `NotificationsFailure`, `UniDetailFailure`
- Browse/Fav: no `onBack` (tabs)
- Notifications/UniDetail: `onBack: () => Navigator.pop(context)`

### `CustomErrorWidget` (core/widgets) — inline
```dart
CustomErrorWidget({
  required String message,
  VoidCallback? onRetry,  // shows retry button if provided
})
```
Used in: Guide failure, pagination errors

### `EmptyStateWidget` (core/widgets) — empty list
```dart
EmptyStateWidget({
  required String message,
  IconData icon = Icons.inbox_outlined,
})
```
Used in: `UniFacultiesTab`, `UniAlumniTab`, `CampusPhotosGrid`

---

## 6. ApiService

```dart
class ApiService {
  final Dio dio;
  // interceptor: adds Accept, Api-Key, Authorization (Bearer token from Prefs)
  Future<Map<String, dynamic>> get(...)
  Future<Map<String, dynamic>> post(...)
  Future<Map<String, dynamic>> patch(...)
  Future<List<dynamic>> getList(...)
}
```

---

## 7. .env File

```
API_KEY=your_api_key_here
TOKEN=your_token_here   ← temporary for development
```

---

## 8. GetIt Service

**All `registerSingleton`:**
- `Dio`, `ApiService`
- `TrendingRemoteDataSource`, `TrendingCubit`
- `RecommendedRemoteDataSource`
- `BrowseRemoteDataSource`, `BrowseRepo`, `GetUnisUseCase`
- `FavRemoteDataSource`, `FavRepo`, `GetFavsUseCase`, `AddToFavUseCase`, `RemoveFromFavUseCase`, `FavCubit`
- `SearchRemoteDataSource`, `SearchRepo`, `SearchUnisUseCase`, `GetSpecialtiesUseCase`
- `NotificationsRemoteDataSource`, `NotificationsRepo`, `GetNotificationsUseCase`, `GetUnreadNotificationsCountUseCase`, `MarkNotificationAsReadUseCase`, `MarkAllNotificationsAsReadUseCase`, `NotificationsCubit`
- `GuideRemoteDataSource`, `GuideRepo`, `GetArticlesUseCase`, `GuideCubit`
- `UniDetailRemoteDataSource`, `UniDetailRepo`, `GetUniDetailUseCase`

> ⚠️ `UniDetailCubit` NOT a singleton — created per-screen via `BlocProvider` in `UniDetailView`
> ⚠️ `RecommendedCubit` NOT a singleton — created in `MainView.build` via `BlocProvider(create:...)`

---

## 9. Notification Feature Details

**States:** NotificationsInitial / NotificationsLoading / NotificationsSuccess / NotificationsPaginationLoading / NotificationsPaginationFailure / NotificationsFailure / NotificationsActionFailure

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

**NotificationsActionFailure handling:**
- `notifications_view_body.dart` uses `BlocConsumer` — `listenWhen: ActionFailure` → snackbar, `buildWhen: not ActionFailure`
- `notifications_app_bar.dart` uses `BlocBuilder` with `buildWhen: not ActionFailure` — prevents "قراءة الكل" button from disappearing

**notification_group_section.dart:** `onTap` checks `!notifications[i].isRead` before calling `markAsRead` — prevents unread count decrementing on already-read notifications

---

## 10. Fav Feature Details
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
**Optimistic Update:** add/remove updates UI immediately, rollback if API fails
**Deduplication in `loadMore()`:** safety net for backend bug
**FavCubit.favIds:** Set<int> — single source of truth for fav state across app
**FavViewBody:**
- `getFavs()` in `initState` — unlike `MainView` which also calls it in initState, calling it in FavViewBody does a reset and refetch
- Has **local search** that filters on `_searchController` and `selectedFilter`
- `_scrollController` on `SingleChildScrollView`, not on the ListView

**FavHeaderAndListBlocConsumer:**
- `BlocConsumer` with `buildWhen` that ignores `FavActionSuccess` and `FavActionLoading`
- `listenWhen` shows a Snackbar on `FavActionFailure`

---

## 11. UniDetail Feature Details

**4 parallel API calls via `Future.wait`:**
- `GET /universities/{id}` → info
- `GET /colleges/{id}` → faculties
- `GET /graduates/{id}` → alumni
- `GET /university_life/{id}` → campus photos

**UI additions in this session:**
- `UniDetailInfoHeader`: added `rate` field → `Rating` widget below `TypeBadgeWidget`
- `UniOverviewTab`: added website row with `url_launcher` (opens externally)
- `UniFacultiesTab`: `EmptyStateWidget` if `uniFacultyEntities.isEmpty`
- `UniAlumniTab`: `EmptyStateWidget` if `uniAlumniEntities.isEmpty`
- `CampusPhotosGrid`: header always shows; grid replaced by `EmptyStateWidget` if `photoPaths.isEmpty`
- `CampusPhotosGrid`: tap on image → `CampusPhotoViewer` (fullscreen PageView)
- `CampusPhotosSheet`: tap on image → `CampusPhotoViewer`
- `CampusPhotoViewer`: fullscreen `PageView` + `InteractiveViewer` + close button + page counter
- `UniDetailBottomBar`: `isFav` from `FavCubit.favIds` — "قدم الآن" is placeholder
- `UniAlumniCard`: image + name + graduation year badge (تاج تحت الاسم)
- `UniDetailViewBody`: receives `id` as param, `NoInternetWidget` on failure

**`url_launcher` package added** — requires `<queries>` in AndroidManifest for Android 11+:
```xml
<queries>
  <intent>
    <action android:name="android.intent.action.VIEW" />
    <data android:scheme="https" />
  </intent>
</queries>
```

---

## 12. Browse Feature

**Scroll pattern:** `SingleChildScrollView(controller)` → `Column` → `UniListWidget(NeverScrollablePhysics)`
**`BrowseFailure`:** `SizedBox(height: screenHeight - padding - 300)` wrapping `NoInternetWidget`
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

## 13. Search Feature

**Page-based pagination** — `next_page_url` parsed for next page number
**`SearchFailure`:** `CustomErrorWidget` (no retry — user just searches again)
**Known issues:**
- `_mapTypeToApi` sends `'Public'`/`'Private'` — may need `'حكومي'`/`'خاص'`
- Default fees `minFees=10000, maxFees=250000` may hide government unis
- Search debounce not implemented yet

---

## 14. Guide Feature

**GuideCubit singleton** — called in `MainView.initState`
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
**`GuideFailure`:** `CustomErrorWidget` with `onRetry: () => getIt<GuideCubit>().getArticles()`

---

## 15. on_generate_routes.dart — Current Routes

```dart
SplashView, OnBoardingView, MainView, HomeView (dead), FavView,
ProfileView, PersonalDataView, SecurityView, ContactUsView,
GuideView, GuideVideosView, GuidePodcastsView, GuideArticlesView,
GuideArticleDetailView (arguments: GuideArticleEntity),
BrowseView, NotificationsView, FaheemChatView, FaheemHistoryView,
UniDetailView (arguments: int id), SearchView
```

---

## 16. Known Bugs & Pending Issues

- **Backend Bug — Fav Pagination:** same items returned regardless of cursor → deduplication in `FavCubit.loadMore()`
- **`HomeView` dead code:** exists but never navigated to
- **`SearchResultsWidget` dead code:** exists but unused
- **Search Debounce:** not implemented — every keystroke triggers search
- **`withOpacity` deprecated:** used in many files — works but newer Flutter suggests `.withValues(alpha:...)`
- **`is_fav_for_me`:** present in API response but commented out in `UniEntity`
- **`RecommendedRemoteDataSource`:** temporarily uses `getTrendingUnis` endpoint
- **"قدم الآن" button:** placeholder — no action until auth + profile API done
- **`robot_internet.png`:** custom illustration for `NoInternetWidget` — must be added to `assets/images/` and `pubspec.yaml`

---

## 17. All Decisions Made

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
| No try/catch in data sources | Data sources only fetch/map — error handling is the repo's job |
| `DioException` caught in repos directly | Removed `CustomExceptions` middle layer — simpler and correct |
| `TrendingCubit`/`RecommendedCubit` catch `DioException` directly | No repo layer — direct data source call |
| `NoInternetWidget` for full-screen failures | Better UX than plain text error |
| `onBack` only in pushed screens | Browse/Fav are tabs — no back navigation |
| `EmptyStateWidget` in uni_detail tabs | Better UX than blank screen |
| `CampusPhotoViewer` as push route | Full-screen PageView better than bottom sheet for image viewing |
| `url_launcher` for website | Lightweight, opens external browser — no WebView needed |
| `NotificationsActionFailure` → snackbar only | No UI rebuild — `buildWhen` ignores it |
| `buildWhen: not ActionFailure` in NotificationsAppBar | Prevents "قراءة الكل" disappearing on action failure |
| `markAsRead` only if `!isRead` | Prevents unread count decrementing on already-read items |
| `UniDetailBottomBar` uses `context.watch<FavCubit>()` | Reacts to fav state changes globally |
| `UniDetailViewBody` receives `id` param | Needed for retry button to re-call `getUniDetail(id)` |
| `rate` shown in `UniDetailInfoHeader` | Consistent with card-level rating display |
| `website` shown in `UniOverviewTab` | Natural place for university info |
| Comments in code must be Arabic | Project convention |