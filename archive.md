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
│   │   ├── shared_preferences_singleton.dart (Prefs class — has working `remove()`)
│   │   ├── custom_bloc_observer.dart
│   │   └── database_service.dart      (abstract — unused, Firebase-era leftover)
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
│   │   ├── api_service.dart            (has `postWithToken()` + interceptor case-insensitive Authorization check)
│   │   └── backend_endpoints.dart      (has all auth endpoints)
│   └── widgets/
│       ├── uni_card.dart
│       ├── uni_card_image.dart
│       ├── uni_card_info.dart
│       ├── uni_card_with_fav.dart
│       ├── uni_list_widget.dart
│       ├── uni_filter_tab_bar.dart
│       ├── uni_count_header.dart
│       ├── search_bar_field.dart
│       ├── custom_button.dart
│       ├── back_button.dart             (CustomBackButton)
│       ├── filter_button_badge.dart
│       ├── filter_tab_bar_item.dart
│       ├── ask_faheem_button.dart
│       ├── custom_error_widget.dart
│       ├── no_internet_widget.dart
│       ├── empty_state_widget.dart
│       ├── custom_progress_hud.dart
│       ├── custom_text_form_field.dart
│       ├── password_field.dart
│       ├── rating.dart
│       ├── type_badge_widget.dart
│       ├── location_widget.dart
│       ├── section_header_item.dart
│       ├── featured_guide_video_section.dart
│       ├── guide_video_card.dart
│       ├── guide_video_player.dart
│       ├── guide_video_player_info.dart
│       └── featured_guide_podcasts_section.dart
└── features/
    ├── browse/ ... (done)
    ├── search/ ... (done)
    ├── fav/ ... (done)
    ├── guide/ ... (done)
    ├── notifications/ ... (done)
    ├── home/ ... (done)
    ├── auth/                                          ← COMPLETED this session
    │   ├── domain/
    │   │   ├── entities/user_entity.dart
    │   │   ├── repos/auth_repo.dart
    │   │   └── use_cases/
    │   │       ├── login_use_case.dart
    │   │       ├── register_use_case.dart
    │   │       ├── verify_otp_use_case.dart
    │   │       ├── forget_password_use_case.dart
    │   │       ├── resend_otp_use_case.dart
    │   │       ├── reset_password_use_case.dart
    │   │       ├── save_student_info_use_case.dart
    │   │       ├── update_password_use_case.dart
    │   │       └── get_me_use_case.dart
    │   ├── data/
    │   │   ├── models/user_model.dart
    │   │   ├── data_sources/auth_remote_data_source.dart
    │   │   └── repos/auth_repo_impl.dart
    │   └── presentation/
    │       ├── manager/
    │       │   ├── auth_cubit/auth_cubit.dart + auth_state.dart
    │       │   └── otp_cubit/otp_cubit.dart + otp_state.dart
    │       └── views/
    │           ├── login_view.dart
    │           ├── sign_up_view.dart
    │           ├── forgot_password_view.dart
    │           ├── otp_view.dart                    (defines OtpArgs{email, isRegister})
    │           ├── reset_password_view.dart          ✅ built this session
    │           ├── setup_view.dart                   ✅ built this session
    │           └── widgets/
    │               ├── login_view_body.dart
    │               ├── login_form.dart
    │               ├── auth_header.dart
    │               ├── auth_social_buttons.dart
    │               ├── sign_up_view_body.dart
    │               ├── sign_up_form.dart
    │               ├── forgot_password_view_body.dart
    │               ├── otp_view_body.dart
    │               ├── reset_password_view_body.dart ✅ built this session
    │               ├── reset_password_form.dart      ✅ built this session
    │               ├── verified_badge.dart           ✅ built this session
    │               ├── setup_view_body.dart          ✅ built this session
    │               ├── setup_governorate_dropdown.dart ✅ built this session
    │               ├── setup_percentage_field.dart   ✅ built this session
    │               └── setup_age_field.dart          ✅ built this session
    ├── uni_detail/ ... (done)
    ├── profile/ → presentation/views/ (4 screens UI only — API integration pending)
    └── faheem/ → domain/entities/ + presentation/views/ (UI only — waiting on backend)
```

---

## 2. Core Entities

### UniEntity
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
  final String worldRanking;   // String — API may return "غير متاح"
  final String? logoPath;
}
```

### RecommendedUniEntity
```dart
class RecommendedUniEntity {
  final int id;
  final String name;
  final String location;
  final String imagePath;
  final String? logoPath;
  final String type;
  final String rate;           // String not double
  final int studentsCount;
}
```

### UnisResponse
```dart
class UnisResponse {
  final List<UniEntity> uniEntities;
  final String? nextCursor;
  final int? nextPage;
}
```

### NotificationEntity
```dart
class NotificationEntity {
  final int id;
  final String title;
  final String body;
  final String timeLabel;
  final bool isRead;
  final DateTime createdAt;
}
```

### UserEntity (auth)
```dart
class UserEntity {
  final int id;
  final String name;
  final String email;
  final String? avatar;
  final String type;
}
```
> No `AuthEntity` — tokens never reach UI, handled as plain `String` via Prefs.

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

  // Auth
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

---

## 4. ApiService — Current State

```dart
class ApiService {
  final Dio dio;

  ApiService(this.dio) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers['Accept'] = 'application/json';
        options.headers['Api-Key'] = dotenv.env['API_KEY'] ?? '';

        // case-insensitive check — prevents overwriting manually set Authorization
        // (postWithToken sets its own — containsKey was case-sensitive and failed)
        if (!options.headers.keys.any((k) => k.toLowerCase() == 'authorization')) {
          final token = Prefs.getString('token');
          if (token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
        }
        return handler.next(options);
      },
    ));
  }

  // postWithToken: overrides Authorization with a one-off token
  // used only for reset-Password in forgot-password flow
  Future<Map<String, dynamic>> postWithToken({
    required String endpoint,
    required String token,
    Map<String, dynamic>? data,
  }) async {
    var response = await dio.post(
      '${BackendEndpoints.baseUrl}$endpoint',
      data: data,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return response.data;
  }
}
```

> ⚠️ The original `containsKey('Authorization')` check failed because Dio lowercases header keys internally — fixed to case-insensitive `any((k) => k.toLowerCase() == 'authorization')`.

---

## 5. Auth Flows (confirmed and working)

**Register flow:**
1. `SignUpView` → register → `pushNamed` → `OtpView(OtpArgs(email, isRegister: true))`
2. `OtpView` → verifyOtp ✅ → token in `OtpSuccess` → save token to Prefs → `pushNamedAndRemoveUntil` → `SetupView` + `(route) => false`
3. `SetupView` → saveStudentInfo ✅ → `pushNamedAndRemoveUntil` → `MainView` + `(route) => false`

**Forgot password flow:**
1. `ForgotPasswordView` → forgetPassword ✅ → `pushNamed` → `OtpView(OtpArgs(email, isRegister: false))`
2. `OtpView` → verifyOtp ✅ → token in `OtpSuccess` → `pushReplacementNamed` → `ResetPasswordView(tempToken)`
3. `ResetPasswordView` → resetPassword ✅ → SnackBar "تم تغيير كلمة المرور بنجاح ✓" → `pushNamedAndRemoveUntil` → `LoginView` + `(route) => false`

**Login flow:**
1. `LoginView` → login ✅ → `pushNamedAndRemoveUntil` → `MainView` + `(route) => false`

---

## 6. Auth API Response Structures

**POST /login**
```json
{
  "status": 200,
  "data": {
    "user": { "id": 28, "name": "...", "email": "...", "avatar": null, "type": "user" },
    "access_token": "473|...",
    "refresh_token": "474|..."
  }
}
```

**POST /register**
```json
{
  "status": 200,
  "data": { "otp": 619870, "user": { "name": "...", "email": "...", "id": 31 } }
}
```
> `otp` field is testing-only — will be removed in production.

**POST /verify-Otp**
```json
{
  "status": 200,
  "data": { "access_token": "475|...", "refresh_token": "476|..." }
}
```
> Shared endpoint for register + forgot-password flows. Returns temp token used for reset-Password.

**POST /forget-Password**
```json
{ "status": 200, "data": { "otp": 585294 } }
```

**POST /auth/reset-Password** (requires Bearer temp token from verify-Otp)
```json
{ "status": 200, "message": "Password Has Changed Successfully" }
```

**POST /resendOtp**
```json
{ "status": 200, "data": { "otp": 455398 } }
```

**GET /auth/me**
```json
{
  "status": 200,
  "data": { "user": { "id": 28, "name": "...", "email": "...", "avatar": null, "type": "user" } }
}
```

**POST /auth/refresh**
```json
{ "access_token": "479|...", "refresh_token": "480|...", "token_type": "Bearer", "expires_in": 3600 }
```
> No envelope wrapper — handled entirely in Dio interceptor, never exposed to domain layer.

**POST /student_info** request body:
```json
{ "study_section": "science", "scientific_department": "scientific", "governorate_id": 1, "percentage": 60, "age": 20 }
```
> `study_section` API values: `science` | `literature`. `scientific_department` API values: `scientific` | `Mathematics`.

---

## 7. GetIt Service — Full Registration Order

```
Dio → ApiService
→ TrendingRemoteDataSource → TrendingCubit
→ RecommendedRemoteDataSource
→ BrowseRemoteDataSource → BrowseRepo → GetUnisUseCase
→ FavRemoteDataSource → FavRepo → GetFavsUseCase → AddToFavUseCase → RemoveFromFavUseCase → FavCubit
→ SearchRemoteDataSource → SearchRepo → SearchUnisUseCase → GetSpecialtiesUseCase
→ NotificationsRemoteDataSource → NotificationsRepo → 4 use cases → NotificationsCubit
→ GuideRemoteDataSource → GuideRepo → GetArticlesUseCase → GuideCubit
→ UniDetailRemoteDataSource → UniDetailRepo → GetUniDetailUseCase
→ AuthRemoteDataSource → AuthRepo → LoginUseCase → RegisterUseCase → VerifyOtpUseCase
  → ForgetPasswordUseCase → ResendOtpUseCase → ResetPasswordUseCase
  → SaveStudentInfoUseCase → UpdatePasswordUseCase → GetMeUseCase
```

> `AuthCubit` / `OtpCubit` are NOT registered in GetIt — created per-view via `BlocProvider(create: ...)`.

---

## 8. on_generate_routes.dart — All Routes

```
SplashView, OnBoardingView,
LoginView, SignUpView, ForgotPasswordView,
OtpView (arguments: OtpArgs),
ResetPasswordView (arguments: String tempToken),
SetupView,
MainView, HomeView (dead), FavView,
ProfileView, PersonalDataView, SecurityView, ContactUsView,
GuideView, GuideVideosView, GuidePodcastsView, GuideArticlesView,
GuideArticleDetailView (arguments: GuideArticleEntity),
BrowseView, NotificationsView,
FaheemChatView, FaheemHistoryView,
UniDetailView (arguments: int id),
SearchView
```

---

## 9. OtpCubit — Important Behavior

- `startTimer()` — called in `OtpView` via `..startTimer()` on create
- `_timer?.cancel()` inside fold success branch of `verifyOtp` — stops timer only on success, not on wrong OTP
- `buildWhen` in `_ResendSection` excludes `OtpResendLoading` — prevents widget disappearing during resend loading
- `OtpResendLoading` shows a small `CircularProgressIndicator` in place of the resend text

---

## 10. SetupView — Field Mapping

| UI Label | API field | API values |
|---|---|---|
| علمي / أدبي | `study_section` | `science` / `literature` |
| علوم / رياضة | `scientific_department` | `scientific` / `Mathematics` |
| المحافظة | `governorate_id` | int (1–26) |
| النسبة المئوية | `percentage` | double |
| السن | `age` | int |
| مجالات الاهتمام | — | UI-only, no backend endpoint |

`SetupGovernorateDropdown` has all 26 Egyptian governorates hardcoded with their IDs.
Reuses `PersonalDataStudyTypeSelector` and `PersonalDataInterestsSelector` from profile feature.

---

## 11. Error Handling Pattern

```
DioException (from Dio)
  → propagates from data source (no try/catch there)
  → caught in repo: on DioException catch (e) → left(ServerFailure.fromDioError(e))
  → cubit: result.fold(failure → emit FailureState, ...)
  → UI: NoInternetWidget (full-screen) or CustomErrorWidget (inline)
```

---

## 12. Error UI Rules

| Situation | Widget |
|---|---|
| Full-screen failure في pushed screen | `NoInternetWidget` مع `onRetry` و `onBack: () => Navigator.pop(context)` |
| Full-screen failure في tab | `NoInternetWidget` مع `onRetry` بس |
| Inline failure في وسط صفحة | `CustomErrorWidget` مع `onRetry` |
| Pagination failure | `CustomErrorWidget` inline أسفل اللست مع `onRetry: loadMore` |
| Empty list | `EmptyStateWidget` |
| Transient success message | `SnackBar` (not Toast) |

---

## 13. AppColors

```dart
abstract class AppColors {
  static const Color primaryColor = Color(0xff154618);        // dark green
  static const Color lightPrimaryColor = Color(0xFF6BBF26);   // light green
  static const Color secondaryColor = Color(0xFFAFEC70);      // yellow-green
  static const Color lightSecondaryColor = Color(0xffF6FEEB); // very light green bg
  static const Color shadowColor = Color(0x3FAFEB6F);
  static const Color secondaryShadow = Color(0x33AFEC70);
  static const Color borderColor = Color(0xFFE5E7EB);
  static const Color subtitleColor = Color(0xFF697282);
  static const Color shadowBlack = Color(0x19000000);
  static const Color red = Color(0xFFE7000A);
}
```

---

## 14. Known Bugs & Pending Issues

- **Backend Bug — Fav Pagination:** same items regardless of cursor → deduplication in `FavCubit.loadMore()`
- **`HomeView` dead code:** exists but never navigated to
- **`SearchResultsWidget` dead code:** unused
- **Search Debounce:** not implemented — every keystroke triggers search
- **`withOpacity` deprecated:** works but newer Flutter suggests `.withValues(alpha:...)`
- **`is_fav_for_me`:** in API response but commented out in `UniEntity`
- **`RecommendedRemoteDataSource`:** temporarily uses `getTrendingUnis` endpoint
- **"قدم الآن" button:** placeholder — needs profile API integration
- **`robot_internet.png`:** must be in `assets/images/` and `pubspec.yaml`
- **`custom_exceptions.dart`:** exists but unused
- **Auth — "مجالات الاهتمام":** UI-only, no backend endpoint yet

---

## 15. All Decisions Made

| Decision | Reason |
|---|---|
| `FavCubit` → `registerSingleton` in GetIt | Single instance across the whole app |
| `late final views` in `MainView` | Prevents recreating widgets on every setState |
| No try/catch in data sources | Repos handle errors |
| `DioException` caught in repos directly | Removed `CustomExceptions` middle layer |
| `NoInternetWidget` for full-screen failures | Better UX |
| `EmptyStateWidget` in uni_detail tabs | Better UX than blank screen |
| `url_launcher` for website | Lightweight, opens external browser |
| `NotificationsActionFailure` → snackbar only | No UI rebuild needed |
| `markAsRead` only if `!isRead` | Prevents unread count decrementing on already-read |
| **Code comments English-only** | Hard rule — overrides old Arabic-comments decision |
| **No `AuthEntity`** | Tokens never appear in UI |
| **`verifyOtp` returns `String` (token)** | Same endpoint serves two flows — Cubit decides what to do |
| **`resetPassword` takes `tempToken` param** | No active session during forgot-password flow |
| **`ApiService.postWithToken()` added** | Override Authorization for one-off temp-token call |
| **Interceptor: case-insensitive Authorization check** | Dio lowercases header keys — `containsKey` failed, fixed to `any((k) => k.toLowerCase() == ...)` |
| **`updatePassword` and `getMe` in `auth` feature** | Endpoints are under `/auth/` — repo ownership follows endpoint namespace |
| **2 Cubits for auth only** | `OtpCubit` for timer/resend logic only; everything else in `AuthCubit` |
| **`AuthCubit`/`OtpCubit` NOT GetIt singletons** | Transient flow — each view creates its own instance |
| **"مجالات الاهتمام" static/UI-only** | No backend endpoint exists |
| **`pinput` package for OTP** | Standard keyboard — no custom numpad needed |
| **SnackBar over Toast for success messages** | SnackBar disappears before navigation completes — cleaner UX |
| **Register flow: OTP → SetupView (not LoginView)** | Simpler — no need to detect new vs existing user from API |
| **`pushReplacementNamed` from OtpView → ResetPasswordView** | OTP screen not needed in back stack after verification |