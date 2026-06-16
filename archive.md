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
│   │   └── custom_exceptions.dart     (exists but unused — could be deleted later)
│   ├── helper_functions/
│   │   ├── get_unis_list.dart
│   │   ├── getDummyEntities.dart
│   │   ├── on_generate_routes.dart
│   │   ├── recent_searches_helper.dart
│   │   ├── calc_strength.dart
│   │   └── build_error_bar.dart
│   ├── services/
│   │   ├── get_it_service.dart
│   │   ├── shared_preferences_singleton.dart (Prefs class — now has working `remove()`)
│   │   ├── custom_bloc_observer.dart
│   │   └── database_service.dart      (abstract — not used currently; was a Firebase-era leftover, confirmed irrelevant to new auth)
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
│   │   ├── api_service.dart            (now has `postWithToken()` for temp-token calls)
│   │   └── backend_endpoints.dart      (now has all auth endpoints — see §3)
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
│       ├── back_button.dart             (CustomBackButton — used as-is in auth screens too)
│       ├── filter_button_badge.dart
│       ├── filter_tab_bar_item.dart
│       ├── ask_faheem_button.dart       ← global FAB
│       ├── custom_error_widget.dart     ← has optional onRetry (VoidCallback?)
│       ├── no_internet_widget.dart      ← full-screen error: robot illustration + retry + optional onBack
│       ├── empty_state_widget.dart      ← icon + message for empty lists
│       ├── custom_progress_hud.dart
│       ├── custom_text_form_field.dart  ← base for all form fields, used in auth forms too
│       ├── password_field.dart          ← used in auth forms (login, signup, reset password)
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
    ├── browse/ ... (unchanged — see prior structure)
    ├── search/ ... (unchanged)
    ├── fav/ ... (unchanged)
    ├── guide/ ... (unchanged)
    ├── notifications/ ... (unchanged)
    ├── home/ ... (unchanged)
    ├── auth/                                          ← NEW this session
    │   ├── domain/
    │   │   ├── entities/
    │   │   │   └── user_entity.dart
    │   │   ├── repos/
    │   │   │   └── auth_repo.dart
    │   │   └── use_cases/
    │   │       ├── login_use_case.dart
    │   │       ├── register_use_case.dart
    │   │       ├── verify_otp_use_case.dart
    │   │       ├── forget_password_use_case.dart
    │   │       ├── resend_otp_use_case.dart
    │   │       ├── reset_password_use_case.dart
    │   │       ├── save_student_info_use_case.dart
    │   │       ├── update_password_use_case.dart       (used by profile feature later)
    │   │       └── get_me_use_case.dart                 (used by profile feature later)
    │   ├── data/
    │   │   ├── models/
    │   │   │   └── user_model.dart
    │   │   ├── data_sources/
    │   │   │   └── auth_remote_data_source.dart
    │   │   └── repos/
    │   │       └── auth_repo_impl.dart
    │   └── presentation/
    │       ├── manager/
    │       │   ├── auth_cubit/
    │       │   │   ├── auth_cubit.dart
    │       │   │   └── auth_state.dart
    │       │   └── otp_cubit/
    │       │       ├── otp_cubit.dart
    │       │       └── otp_state.dart
    │       └── views/
    │           ├── login_view.dart
    │           ├── sign_up_view.dart
    │           ├── forgot_password_view.dart
    │           ├── otp_view.dart                        (defines OtpArgs{email, isRegister})
    │           ├── reset_password_view.dart              ← PENDING, not yet built
    │           ├── setup_view.dart                       ← PENDING, not yet built
    │           └── widgets/
    │               ├── login_view_body.dart
    │               ├── login_form.dart
    │               ├── auth_header.dart                  ← shared across all auth screens
    │               ├── auth_social_buttons.dart           ← shared, Google/iCloud UI-only
    │               ├── sign_up_view_body.dart
    │               ├── sign_up_form.dart
    │               ├── forgot_password_view_body.dart
    │               ├── otp_view_body.dart                 (uses pinput package)
    │               ├── reset_password_view_body.dart      ← PENDING
    │               └── setup_view_body.dart               ← PENDING
    ├── uni_detail/ ... (unchanged)
    ├── profile/ → presentation/views/ (4 screens UI only — unblocked now that auth domain/data exist, not started)
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

### UserEntity (NEW — features/auth/domain/entities/)

```dart
class UserEntity {
  final int id;
  final String name;
  final String email;
  final String? avatar;
  final String type;
}
```
> Used by `GetMeUseCase` (profile feature consumer). No `AuthEntity` exists — tokens never reach the UI, so they're handled as plain `String`/Prefs values, not wrapped in an Entity.

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

### Auth API Response Structures (confirmed via Postman, this session)

**POST /login**
```json
{
  "status": 200,
  "message": "User Logged In Successfully",
  "data": {
    "user": { "id": 28, "name": "...", "email": "...", "email_verified_at": null, "avatar": null, "created_at": "...", "updated_at": "...", "type": "user" },
    "access_token": "473|...",
    "refresh_token": "474|...",
    "token_type": "Bearer",
    "expires_in": 3600
  }
}
```

**POST /register**
```json
{
  "status": 200,
  "message": "User Register Successfully , OTP has been sent to your email",
  "data": {
    "otp": 619870,
    "user": { "name": "...", "email": "...", "updated_at": "...", "created_at": "...", "id": 31 }
  }
}
```
> ⚠️ `otp` field is testing-only — backend confirmed it will be removed; in production OTP arrives by email only. `RegisterUseCase` returns `void`, not the OTP value.

**POST /verify-Otp**
```json
{
  "status": 200,
  "message": "User verified successfully.",
  "data": {
    "access_token": "475|...",
    "refresh_token": "476|...",
    "token_type": "Bearer",
    "expires_in": 3600
  }
}
```
> Shared endpoint for both register-flow and forgot-password-flow OTP verification. `VerifyOtpUseCase` returns `Either<Failure, String>` (the access_token) — the Cubit/view decides what to do with it based on context (`OtpArgs.isRegister`).

**POST /forget-Password**
```json
{ "status": 200, "message": " OTP has been sent successfully", "data": { "otp": 585294 } }
```
> `otp` field is testing-only, same as register. `ForgetPasswordUseCase` returns `void`.

**POST /auth/reset-Password** (requires Bearer temp token from verify-Otp)
```json
{ "status": 200, "message": "Password Has Changed Successfully" }
```

**POST /resendOtp**
```json
{ "status": 200, "message": "The Otp Resend Successfully", "data": { "otp": 455398 } }
```
> `otp` testing-only. `ResendOtpUseCase` returns `void`.

**GET /auth/me**
```json
{
  "status": 200,
  "message": "User retrieved successfully",
  "data": { "user": { "id": 28, "name": "...", "email": "...", "email_verified_at": null, "avatar": null, "created_at": "...", "updated_at": "...", "type": "user" } }
}
```

**POST /auth/refresh**
```json
{ "access_token": "479|...", "refresh_token": "480|...", "token_type": "Bearer", "expires_in": 3600 }
```
> No envelope (no `status`/`message`/`data` wrapper) unlike other auth endpoints — confirmed from Postman. Handled entirely inside the Dio interceptor, not exposed to domain layer.

**POST /auth/update-Password** (used by profile, requires normal Bearer token from Prefs)
```json
{ "status": 200, "message": "Password Updated Successfully" }
```

**POST /student_info**
```json
{
  "status": 200,
  "message": "تم إضافة معلوماتك بنجاح",
  "data": {
    "id": 1, "study_section": "علمي", "scientific_department": "علوم",
    "governorate_id": 1, "user_id": 28, "percentage": 60, "age": 20,
    "created_at": "...", "updated_at": "...",
    "governorate": { "id": 1, "name_ar": "القاهرة", "name_en": "Cairo", "created_at": null, "updated_at": null }
  }
}
```
> Request body confirmed via Postman:
```json
{ "study_section": "science", "scientific_department": "scientific", "governorate_id": 1, "percentage": 60, "age": 20 }
```
> `study_section` API values: `science` | `literature` (UI labels: علمي / أدبي). `scientific_department` API values: `scientific` | `Mathematics` (UI labels: علوم / رياضة — needs final confirmation when building SetupView).

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

  // Auth — added this session, confirmed in BackendEndpoints
  static const String login = '/login';
  static const String register = '/register';
  static const String verifyOtp = '/verify-Otp';
  static const String forgetPassword = '/forget-Password';
  static const String resendOtp = '/resendOtp';
  static const String resetPassword = '/auth/reset-Password';
  static const String saveStudentInfo = '/student_info';
  static const String updatePassword = '/auth/update-Password';
  static const String getMe = '/auth/me';
  static const String refreshToken = '/auth/refresh';
}
```

**No longer pending** (all confirmed and wired into the codebase this session):
```
/login, /register, /verify-Otp, /forget-Password,
/auth/reset-Password, /auth/me, /auth/update-Password,
/resendOtp, /auth/refresh, /student_info
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

**`custom_exceptions.dart` exists but is unused anywhere — including the new auth feature, which uses the same DioException pattern as the rest of the app.**

**Repos that catch DioException:**
- `browse_repo_impl`, `fav_repo_impl`, `search_repo_impl`, `guide_repo_impl`, `notifications_repo_impl`, `uni_detail_repo_impl`, **`auth_repo_impl`** (new)

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
Used in: `BrowseFailure`, `FavFailure`, `NotificationsFailure`, `UniDetailFailure`, `GuideArticlesFailure`
- Browse/Fav: no `onBack` (tabs)
- Notifications/UniDetail/GuideArticles: `onBack: () => Navigator.pop(context)`

### `CustomErrorWidget` (core/widgets) — inline
```dart
CustomErrorWidget({
  required String message,
  VoidCallback? onRetry,  // shows retry button if provided
})
```
Used in: `GuideViewBody` failure (inline في الهوم), pagination errors

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

  // NEW this session — overrides Authorization header with a one-off token
  // instead of the Prefs-stored one. Used only for reset-Password in the
  // forgot-password flow, where the user has no normal session token yet.
  Future<Map<String, dynamic>> postWithToken({
    required String endpoint,
    required String token,
    Map<String, dynamic>? data,
  })
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

**⏳ NOT yet registered (pending — next step in auth build):**
- `AuthRemoteDataSource`, `AuthRepo`, and all 9 auth use cases (`LoginUseCase`, `RegisterUseCase`, `VerifyOtpUseCase`, `ForgetPasswordUseCase`, `ResendOtpUseCase`, `ResetPasswordUseCase`, `SaveStudentInfoUseCase`, `UpdatePasswordUseCase`, `GetMeUseCase`)
- `AuthCubit` and `OtpCubit` are NOT GetIt singletons by design — each view creates its own instance via `BlocProvider(create: ...)`, since auth screens are transient (not persistent across the app's lifetime like FavCubit/NotificationsCubit)

> ⚠️ `UniDetailCubit` NOT a singleton — created per-screen via `BlocProvider` in `UniDetailView`
> ⚠️ `RecommendedCubit` NOT a singleton — created as `late final` in `MainView._MainViewState.initState` و بيتـclose في `dispose`
> ⚠️ `AuthCubit` / `OtpCubit` NOT singletons — created per-view via `BlocProvider(create: ...)`, same reasoning as above but for auth screens specifically (transient flow, not persistent app state)

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

**UI:**
- `UniDetailInfoHeader`: name + type + `Rating(rate)` + location
- `UniOverviewTab`: about + stats + website (url_launcher)
- `UniFacultiesTab`: `EmptyStateWidget` if `uniFacultyEntities.isEmpty`
- `UniAlumniTab`: `EmptyStateWidget` if `uniAlumniEntities.isEmpty`
- `CampusPhotosGrid`: header always shows; grid replaced by `EmptyStateWidget` if `photoPaths.isEmpty` + tap opens viewer
- `CampusPhotosSheet`: DraggableScrollableSheet full grid + tap opens viewer
- `CampusPhotoViewer`: fullscreen `PageView` + `InteractiveViewer` + close button + page counter
- `UniDetailBottomBar`: `isFav` from `FavCubit.favIds` — "قدم الآن" is placeholder
- `UniAlumniCard`: image + name + graduation year badge
- `UniDetailViewBody`: receives `id` as param, `NoInternetWidget` on failure + onBack

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
- Normal view: shows `state.articles.take(2).toList()` في "أحدث المقالات"
- Search mode: filters on title and content
- `GuideFailure` → `CustomErrorWidget` مع `onRetry`

**GuideArticlesView:** separate route — calls `getArticles()` fresh when opened
**`GuideArticlesViewBody`:**
- `GuideFailure` → `NoInternetWidget` مع `onRetry` و `onBack: () => Navigator.pop(context)`
- `GuidePaginationFailure` → `CustomErrorWidget` inline أسفل اللست مع `onRetry: loadMore`

---

## 15. MainView Details

**`_MainViewState`:**
- `late final List<Widget> views` — created once in `initState`
- `late final RecommendedCubit _recommendedCubit` — created in `initState`، بيتـclose في `dispose`
- `BlocProvider.value` للـ 3 cubits في `build`

**`initState` يشتغل:**
```dart
_recommendedCubit = RecommendedCubit(...)..fetchRecommendedUnis();
getIt<TrendingCubit>().fetchTrendingUnis();
getIt<FavCubit>().getFavs();
getIt<GuideCubit>().getArticles();
```

**`didPopNext` — retry لو فاشل:**
```dart
getIt<NotificationsCubit>().getNotifications(); // دايماً
if TrendingFailure → fetchTrendingUnis()
if FavFailure → getFavs()
if GuideFailure → getArticles()
if RecommendedFailure → fetchRecommendedUnis()
```

**`_onTabChanged` — لما يرجع لـ tab 0:**
```dart
getIt<NotificationsCubit>().getNotifications(); // دايماً
if TrendingFailure → fetchTrendingUnis()
if RecommendedFailure → fetchRecommendedUnis()
// FavCubit و GuideCubit مش محتاجينهم هنا — عندهم initState خاص بيهم
```

---

## 16. on_generate_routes.dart — Current Routes

```dart
SplashView, OnBoardingView, MainView, HomeView (dead), FavView,
ProfileView, PersonalDataView, SecurityView, ContactUsView,
GuideView, GuideVideosView, GuidePodcastsView, GuideArticlesView,
GuideArticleDetailView (arguments: GuideArticleEntity),
BrowseView, NotificationsView, FaheemChatView, FaheemHistoryView,
UniDetailView (arguments: int id), SearchView
```

**⏳ Pending additions (auth views built but not yet registered in routes):**
```
LoginView, SignUpView, ForgotPasswordView,
OtpView (arguments: OtpArgs),
ResetPasswordView (arguments: String tempToken) — view not built yet,
SetupView — view not built yet
```

---

## 17. Known Bugs & Pending Issues

- **Backend Bug — Fav Pagination:** same items returned regardless of cursor → deduplication in `FavCubit.loadMore()`
- **`HomeView` dead code:** exists but never navigated to
- **`SearchResultsWidget` dead code:** exists but unused
- **Search Debounce:** not implemented — every keystroke triggers search
- **`withOpacity` deprecated:** used in many files — works but newer Flutter suggests `.withValues(alpha:...)`
- **`is_fav_for_me`:** present in API response but commented out in `UniEntity`
- **`RecommendedRemoteDataSource`:** temporarily uses `getTrendingUnis` endpoint
- **"قدم الآن" button:** placeholder — no action until auth + profile API done (auth domain/data now ready, presentation in progress)
- **`robot_internet.png`:** custom illustration for `NoInternetWidget` — must be added to `assets/images/` and `pubspec.yaml`
- **`custom_exceptions.dart`:** exists but unused — could be deleted later
- **Auth — "مجالات الاهتمام" interest chips in SetupView:** no backend endpoint exists for this field — confirmed with backend dev, will stay static/UI-only until an endpoint is added
- **Auth — pending pubspec.yaml change:** `pinput` package decided but not yet confirmed added
- **Auth — pending GetIt registrations:** AuthRepo, AuthRemoteDataSource, all 9 use cases not yet registered
- **Auth — pending route registrations:** all 6 auth views not yet added to `on_generate_routes.dart`
- **Auth — ResetPasswordView and SetupView:** not yet built (next immediate step)

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
| Comments in code must be Arabic | **SUPERSEDED this session — now English only, see §below** |
| `RecommendedCubit` → `late final` في `initState` | منع إعادة إنشاء الـ cubit في كل `build` |
| `_recommendedCubit.close()` في `dispose` | منع memory leak |
| retry في `didPopNext` و `_onTabChanged` | تحديث البيانات الفاشلة لما المستخدم يرجع للهوم |
| `NoInternetWidget` في `GuideArticlesViewBody` | consistent مع باقي الـ pushed screens |
| `GuideViewBody` يفضل `CustomErrorWidget` | inline error مش full-screen لأنه tab مش pushed screen |
| **Code comments switched to English-only** (this session) | Standing rule going forward — overrides the older Arabic-comments decision above |
| **No `AuthEntity`** | Tokens never appear in the UI and carry no business logic — handled as plain `String` values passed between Cubit/repo, not wrapped in an Entity |
| **`verifyOtp` returns `String` (token), not `void`** | Same endpoint serves two flows (register vs forgot-password) with different consequences for the returned token; the Cubit/view decides what to do with it based on context, rather than the repo silently saving it to Prefs every time |
| **`resetPassword` takes `tempToken` param, not from Prefs** | User has no active session during forgot-password flow; the temp token from `verify-Otp` is short-lived and scoped only to this one call |
| **`ApiService.postWithToken()` added** | Needed a way to override the Authorization header for the one-off temp-token call without touching Prefs |
| **`updatePassword` and `getMe` placed in `auth` feature, not `profile`** | Both endpoints are under `/auth/` — repo ownership follows endpoint namespace, not UI feature grouping |
| **Only 2 Cubits for auth (`AuthCubit`, `OtpCubit`), no `SetupCubit`** | `saveStudentInfo` doesn't need separate logic from the rest of `AuthCubit`; OTP gets its own Cubit only because of the countdown-timer/resend logic, which is genuinely distinct |
| **`AuthCubit`/`OtpCubit` are NOT GetIt singletons** | Unlike `FavCubit`/`NotificationsCubit`, auth screens are a one-time transient flow — no need to persist cubit instances across the app's lifetime |
| **"مجالات الاهتمام" interest chips are static/UI-only in SetupView** | No backend endpoint exists yet for this field; confirmed with backend dev (sayed) it's not implemented |
| **OTP UI uses `pinput` package with standard keyboard** | Matches the 4-6 digit boxed design without building a custom numpad widget; standard keyboard is acceptable since the original screenshots' custom numpad isn't a hard requirement |
| **Old Firebase auth code (Google/Facebook/Firestore) fully discarded** | New backend is Laravel REST API; the previous `FirebaseAuthService`/`FirestoreService`/`DatabaseService` pattern has no equivalent need — `ApiService` covers everything. Social login buttons remain in the UI only as inactive placeholders |