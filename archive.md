# Claude Memory File — Archive / Reference (Gameaty)
> Last updated: June 2026 (session: splash + onboarding + 401 interceptor + validator fixes)

---

## 1. Project Structure

```
lib/
├── constants.dart              (kHorizontalPadding=16, kTopPadding=16, kIsOnBoardingViewSeenKey)
├── main.dart                   (routeObserver, navigatorKey, pendingSnackBarMessage defined here globally)
├── core/
│   ├── entities/
│   │   ├── uni_entity.dart
│   │   ├── unis_response.dart
│   │   ├── trending_uni_entity.dart
│   │   └── guide_video_entity.dart
│   ├── errors/
│   │   ├── failures.dart
│   │   └── custom_exceptions.dart     (exists but unused)
│   ├── helper_functions/
│   │   ├── get_unis_list.dart
│   │   ├── getDummyEntities.dart
│   │   ├── on_generate_routes.dart
│   │   ├── recent_searches_helper.dart
│   │   ├── calc_strength.dart
│   │   └── build_error_bar.dart
│   ├── services/
│   │   ├── get_it_service.dart
│   │   ├── shared_preferences_singleton.dart
│   │   ├── custom_bloc_observer.dart
│   │   └── database_service.dart      (abstract — unused)
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
│   │   ├── app_images.dart
│   │   ├── app_fonts.dart
│   │   ├── api_service.dart            ✅ updated this session — onError 401 interceptor added
│   │   └── backend_endpoints.dart
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
│       ├── back_button.dart
│       ├── filter_button_badge.dart
│       ├── filter_tab_bar_item.dart
│       ├── ask_faheem_button.dart
│       ├── custom_error_widget.dart
│       ├── no_internet_widget.dart
│       ├── empty_state_widget.dart
│       ├── custom_progress_hud.dart
│       ├── custom_text_form_field.dart  ✅ errorStyle + errorBuilder + errorBorder fixed
│       ├── password_field.dart
│       ├── rating.dart
│       ├── type_badge_widget.dart
│       ├── location_widget.dart
│       ├── section_header_item.dart
│       ├── featured_guide_video_section.dart
│       ├── guide_video_card.dart
│       ├── guide_video_player.dart
│       ├── guide_video_player_info.dart
│       ├── featured_guide_podcasts_section.dart
│       ├── study_type_selector.dart
│       └── terms_and_conditions_sheet.dart
└── features/
    ├── browse/ ... (done)
    ├── search/ ... (done)
    ├── fav/ ... (done)
    ├── guide/ ... (done)
    ├── notifications/ ... (done)
    ├── home/ ... (done)
    ├── auth/ ... (done — see §Auth Feature)
    │   └── presentation/views/widgets/
    │       ├── login_view_body.dart     ✅ StatefulWidget + pendingSnackBarMessage SnackBar
    │       ├── sign_up_form.dart        ✅ validator fix — match check moved to _submit()
    │       └── ...
    ├── splash/                          ✅ DONE this session
    │   └── presentation/views/widgets/splash_view_body.dart
    ├── on_boarding/                     ✅ DONE this session
    │   └── presentation/views/on_boarding_view.dart
    ├── uni_detail/ ... (done)
    ├── profile/ → presentation/views/ (4 screens UI only — API integration pending — NEXT UP)
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

        if (!options.headers.keys.any((k) => k.toLowerCase() == 'authorization')) {
          final token = Prefs.getString('token');
          if (token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
        }
        return handler.next(options);
      },
      onError: (error, handler) {
        if (error.response?.statusCode == 401) {
          Prefs.remove('token');
          pendingSnackBarMessage = 'انتهت صلاحية جلستك، يرجى تسجيل الدخول مجدداً';
          Future.microtask(() {
            navigatorKey.currentState?.pushNamedAndRemoveUntil(
              LoginView.routeName,
              (route) => false,
              arguments: pendingSnackBarMessage,
            );
          });
        }
        return handler.next(error);
      },
    ));
  }

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

> ⚠️ **Open issue:** session-expired SnackBar still not showing reliably at end of session. `LoginViewBody.initState` reads `pendingSnackBarMessage` via `addPostFrameCallback` — verify next session.

---

## 5. Auth Flows (confirmed and working)

**Register flow:**
1. `SignUpView` → register → `pushNamed` → `OtpView(OtpArgs(email, isRegister: true))`
2. `OtpView` → verifyOtp ✅ → `Prefs.setString('token', state.token)` → `pushNamedAndRemoveUntil` → `SetupView`
3. `SetupView` → saveStudentInfo ✅ → SnackBar "تم إنشاء حسابك بنجاح ✓" → `pushNamedAndRemoveUntil` → `MainView`

**Forgot password flow:**
1. `ForgotPasswordView` → forgetPassword → `pushNamed` → `OtpView(OtpArgs(email, isRegister: false))`
2. `OtpView` → verifyOtp ✅ → NOT saved to Prefs → `pushReplacementNamed` → `ResetPasswordView(tempToken)`
3. `ResetPasswordView` → resetPassword ✅ → SnackBar → `pushNamedAndRemoveUntil` → `LoginView`

**Login flow:**
1. `LoginView` → login ✅ → `pushNamedAndRemoveUntil` → `MainView` — no SnackBar

**401 / session expired flow:**
1. Any API call returns 401 → interceptor → `Prefs.remove('token')` → `pendingSnackBarMessage` set → `pushNamedAndRemoveUntil` → `LoginView`
2. `LoginViewBody.initState` → reads `pendingSnackBarMessage` → shows SnackBar → clears it

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
> ⚠️ Known backend quirk: user record created before OTP verification — duplicate email returns generic error. Needs sayed conversation.

**POST /verify-Otp**
```json
{ "status": 200, "data": { "access_token": "475|...", "refresh_token": "476|..." } }
```

**POST /forget-Password**
```json
{ "status": 200, "data": { "otp": 585294 } }
```

**POST /auth/reset-Password**
```json
{ "status": 200, "message": "Password Has Changed Successfully" }
```

**POST /resendOtp**
```json
{ "status": 200, "data": { "otp": 455398 } }
```

**GET /auth/me**
```json
{ "status": 200, "data": { "user": { "id": 28, "name": "...", "email": "...", "avatar": null, "type": "user" } } }
```

**POST /student_info** request body:
```json
{ "study_section": "science", "scientific_department": "scientific", "governorate_id": 1, "percentage": 60, "age": 20 }
```

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
- `_timer?.cancel()` inside fold success branch of `verifyOtp` — stops timer only on success
- `buildWhen` in `_ResendSection` excludes `OtpResendLoading`
- `OtpViewBody` listener (register branch) saves token to Prefs before navigating

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

---

## 11. Error Handling Pattern

```
DioException → propagates from data source → caught in repo → left(ServerFailure.fromDioError(e))
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
  static const Color primaryColor = Color(0xff154618);
  static const Color lightPrimaryColor = Color(0xFF6BBF26);
  static const Color secondaryColor = Color(0xFFAFEC70);
  static const Color lightSecondaryColor = Color(0xffF6FEEB);
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
- **`custom_exceptions.dart`:** exists but unused
- **Auth — "مجالات الاهتمام":** UI-only, no backend endpoint yet
- **Backend — duplicate-email-unverified edge case:** needs sayed conversation
- **Session-expired SnackBar:** implemented but not confirmed working at end of session — verify next session

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
| **Code comments English-only** | Hard rule |
| **No `AuthEntity`** | Tokens never appear in UI |
| **`verifyOtp` returns `String` (token)** | Same endpoint serves two flows |
| **`resetPassword` takes `tempToken` param** | No active session during forgot-password flow |
| **`ApiService.postWithToken()` added** | Override Authorization for one-off temp-token call |
| **Interceptor: case-insensitive Authorization check** | Dio lowercases header keys |
| **`updatePassword` and `getMe` in `auth` feature** | Endpoints under `/auth/` |
| **2 Cubits for auth only** | `OtpCubit` for timer/resend; everything else in `AuthCubit` |
| **`AuthCubit`/`OtpCubit` NOT GetIt singletons** | Transient flow |
| **"مجالات الاهتمام" static/UI-only** | No backend endpoint |
| **`pinput` package for OTP** | Standard keyboard, no custom numpad |
| **SnackBar over Toast** | Cleaner UX |
| **Register flow: OTP → SetupView** | Simpler flow |
| **`pushReplacementNamed` from OtpView → ResetPasswordView** | OTP not needed in back stack |
| **Register `AuthSuccess` → no SnackBar** | Mid-flow |
| **Setup `AuthSuccess` → SnackBar + navigate** | True end of register flow |
| **Login `AuthSuccess` → no SnackBar** | Immediate full success |
| **Register-flow token saved to Prefs in `OtpViewBody`** | Required for `saveStudentInfo` to be authenticated |
| **`StudyTypeSelector` takes `Map<String, IconData>`** | Single icon was a bug |
| **Terms & Conditions = bottom sheet** | Secondary content, doesn't break flow |
| **Terms & Conditions content static/hardcoded** | No backend endpoint |
| **`CustomTextFormField` errorStyle removed** | Was hiding ALL validation errors app-wide |
| **`autovalidateMode: onUserInteraction`** | Live error clearing |
| **`errorBuilder` in `CustomTextFormField`** | Aligns error text to right via `Align(alignment: Alignment.centerRight)` |
| **`errorBorder`/`focusedErrorBorder` use `AppColors.red` as fallback** | `borderColor ?? AppColors.red` |
| **Confirm-password match check moved to `_submit()`** | Removes reserved blank error-line space, validator only checks "required" |
| **`SecurityStrengthIndicator` shows when `_passwordController.text.isNotEmpty`** | Smooth UX, no sudden appear/disappear |
| **`GlobalKey<NavigatorState>` for 401 redirect** | Simplest correct solution — no context needed in interceptor |
| **`pendingSnackBarMessage` global in `main.dart`** | Passes session-expired message to `LoginView` without route arguments timing issues |
| **Splash → LoginView (not OnBoarding) when token missing but onboarding seen** | Correct flow |
| **OnBoarding → LoginView (not MainView)** | Was a bug — fixed this session |
| **Login fields not cleared on failed login** | User may have typo in password only — clearing all fields forces re-typing email |

---

## 16. CustomTextFormField — Validation & Error Style (final state)

- `errorStyle: TextStyles.regular12.copyWith(color: AppColors.red)` — matches strength indicator style
- `errorBuilder` used to align error text right: `Align(alignment: Alignment.centerRight, child: Text(errorText, style: ...))`
- `errorBorder: buildBorder(borderColor ?? AppColors.red)` — red border on error even without explicit `borderColor`
- `focusedErrorBorder: buildFocusedBorder(borderColor ?? AppColors.red)`
- `autovalidateMode: AutovalidateMode.onUserInteraction`
- Confirm-password `validator` → "required" only; match check in `_submit()` via explicit equality check

---

## 17. Session Summary — هذا الشات

1. **Validator fix (confirm-password):** moved match check out of `validator` entirely → `_submit()` explicit check → no reserved blank space
2. **`SecurityStrengthIndicator`:** shows when `_passwordController.text.isNotEmpty` — smooth UX
3. **`CustomTextFormField` error alignment:** tried `textDirection`, `Directionality`, `errorStyle` textAlign (doesn't exist) → settled on `errorBuilder` with `Align(centerRight)`
4. **`errorBorder` fix:** `buildBorder(borderColor ?? AppColors.red)` — red border shows correctly on error state
5. **Splash feature:** `executeNavigation()` checks token → onboarding seen → routes correctly
6. **OnBoarding bug fix:** was navigating to `MainView` → fixed to `LoginView`
7. **401 interceptor:** `GlobalKey<NavigatorState>` + `pendingSnackBarMessage` global → redirect to `LoginView` on any 401
8. **`LoginViewBody`:** converted to `StatefulWidget` — reads `pendingSnackBarMessage` in `initState` via `addPostFrameCallback`
9. **Session-expired SnackBar:** still not confirmed working at end of session — open issue for next session
10. **Login fields on failure:** decided NOT to clear fields — user may have typo in password only