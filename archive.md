# Claude Memory File — Archive / Reference (Gameaty)
> Last updated: June 2026 (session: 401 SnackBar debug + onGenerateRoute settings fix + NotificationsCubit trigger cleanup)

---

## 1. Project Structure

```
lib/
├── constants.dart              (kHorizontalPadding=16, kTopPadding=16, kIsOnBoardingViewSeenKey)
├── main.dart                   (routeObserver, navigatorKey defined here — pendingSnackBarMessage REMOVED this session)
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
│   │   ├── on_generate_routes.dart     ✅ updated this session — every case now passes settings: settings
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
│   │   ├── api_service.dart            ✅ updated this session — 401 interceptor now uses route arguments only, no global variable
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
│       ├── custom_text_form_field.dart  ✅ errorStyle + errorBuilder + errorBorder fixed (prior session)
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
    ├── search/ ... (done — debounce still pending)
    ├── fav/ ... (done)
    ├── guide/ ... (done)
    ├── notifications/ ... (done)
    │   └── presentation/manager/notifications_cubit/
    │       └── notifications_cubit.dart  — confirmed this session: double-emit per call (list + unread count) is intentional
    ├── home/ ... (done)
    │   └── presentation/views/main_view.dart  ✅ updated this session — added getNotifications() call in initState; didPopNext/_onTabChanged calls confirmed intentional (kept)
    ├── auth/ ... (done — see §Auth Feature)
    │   └── presentation/views/widgets/
    │       ├── login_view_body.dart     ✅ updated this session — reads session-expired message from ModalRoute arguments, no global variable, debug prints removed
    │       ├── sign_up_form.dart        (validator fix from prior session — match check in _submit())
    │       └── ...
    ├── splash/
    │   └── presentation/views/widgets/splash_view_body.dart
    ├── on_boarding/
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

## 4. ApiService — Current State (post this session)

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
          // message passed as route arguments only — no global state.
          navigatorKey.currentState?.pushNamedAndRemoveUntil(
            LoginView.routeName,
            (route) => false,
            arguments: 'انتهت صلاحية جلستك، يرجى تسجيل الدخول مجدداً',
          );
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

> ✅ **RESOLVED this session:** session-expired SnackBar now confirmed working reliably. Root cause was `onGenerateRoute` not forwarding `settings: settings` to `MaterialPageRoute` (see §8 Known Bugs — moved here as resolved). `pendingSnackBarMessage` global variable fully removed.

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

**401 / session expired flow (finalized this session):**
1. Any API call returns 401 → interceptor → `Prefs.remove('token')` → `pushNamedAndRemoveUntil(LoginView.routeName, arguments: message)`
2. `LoginViewBody.initState` → reads `ModalRoute.of(context)?.settings.arguments as String?` → shows SnackBar if non-null
3. No cleanup needed — each navigation's arguments are scoped to that route instance only

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
> ⚠️ Known backend quirk: user record created before OTP verification — duplicate email returns generic error. Needs sayed conversation. (Still open — unrelated to this session's work.)

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
> `NotificationsCubit` IS a GetIt singleton, but `getNotifications()` is no longer auto-called at registration/startup time — see §9 MainView trigger points.

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

> ✅ **Fixed this session:** every case now passes `settings: settings` to its `MaterialPageRoute` constructor. Previously omitted everywhere — meant `ModalRoute.of(context)?.settings.arguments` always returned `null` regardless of what was passed to `pushNamed`/`pushNamedAndRemoveUntil`. This was the actual root cause of the session-expired SnackBar not appearing (see §14).

---

## 9. MainView — NotificationsCubit Trigger Points (finalized this session)

```dart
@override
void initState() {
  super.initState();
  // ...other init calls...
  getIt<NotificationsCubit>().getNotifications(); // added this session
}

@override
void didPopNext() {
  getIt<NotificationsCubit>().getNotifications(); // kept — refresh on returning from a pushed screen
  // ...other failure-state reload checks unchanged...
}

void _onTabChanged(int index) {
  if (index == 0 && currentIndex != 0) {
    getIt<NotificationsCubit>().getNotifications(); // kept — refresh when returning to home tab
    // ...
  }
  setState(() => currentIndex = index);
}
```

All three trigger points are intentional and confirmed — covers "just logged in," "app restarted while logged in," "returned from a pushed screen," and "switched back to home tab." `main.dart`/`MultiBlocProvider` no longer calls `getNotifications()` at all (removed — was firing on a possibly-expired token at cold start, causing an unwanted/confusing 401 redirect immediately on app open).

---

## 10. NotificationsCubit — Internal Emit Behavior (confirmed this session, not a bug)

`getNotifications()` body (relevant part):
```dart
Future<void> getNotifications() async {
  _allNotifications = [];
  _nextCursor = null;
  if (state is! NotificationsSuccess) emit(NotificationsLoading());

  final result = await getNotificationsUseCase.call();
  result.fold((failure) => emit(NotificationsFailure(failure.message)), (data) {
    _allNotifications = data.notifications;
    _nextCursor = data.nextCursor;
    _emitSuccess();           // <-- emit #1
  });

  await _fetchUnreadCount();  // <-- may trigger emit #2 internally, if count changed
}
```

`_fetchUnreadCount()` emits a second `NotificationsSuccess` (with updated `unreadCount`) only if the count actually changed from before. This means a single `getNotifications()` call can legitimately produce two `Success` states in the log — confirmed as intentional (list and unread-count are independent concerns), left unchanged by explicit decision.

---

## 11. OtpCubit — Important Behavior

- `startTimer()` — called in `OtpView` via `..startTimer()` on create
- `_timer?.cancel()` inside fold success branch of `verifyOtp` — stops timer only on success
- `buildWhen` in `_ResendSection` excludes `OtpResendLoading`
- `OtpViewBody` listener (register branch) saves token to Prefs before navigating

---

## 12. SetupView — Field Mapping

| UI Label | API field | API values |
|---|---|---|
| علمي / أدبي | `study_section` | `science` / `literature` |
| علوم / رياضة | `scientific_department` | `scientific` / `Mathematics` |
| المحافظة | `governorate_id` | int (1–26) |
| النسبة المئوية | `percentage` | double |
| السن | `age` | int |
| مجالات الاهتمام | — | UI-only, no backend endpoint |

---

## 13. Error Handling Pattern

```
DioException → propagates from data source → caught in repo → left(ServerFailure.fromDioError(e))
→ cubit: result.fold(failure → emit FailureState, ...)
→ UI: NoInternetWidget (full-screen) or CustomErrorWidget (inline)
```

---

## 14. Error UI Rules

| Situation | Widget |
|---|---|
| Full-screen failure في pushed screen | `NoInternetWidget` مع `onRetry` و `onBack: () => Navigator.pop(context)` |
| Full-screen failure في tab | `NoInternetWidget` مع `onRetry` بس |
| Inline failure في وسط صفحة | `CustomErrorWidget` مع `onRetry` |
| Pagination failure | `CustomErrorWidget` inline أسفل اللست مع `onRetry: loadMore` |
| Empty list | `EmptyStateWidget` |
| Transient success message | `SnackBar` (not Toast) |

---

## 15. AppColors

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

## 16. Known Bugs & Pending Issues (current — resolved items moved to §17)

- **Backend Bug — Fav Pagination:** same items regardless of cursor → deduplication in `FavCubit.loadMore()`
- **`HomeView` dead code:** exists but never navigated to
- **`SearchResultsWidget` dead code:** unused
- **Search Debounce:** not implemented — every keystroke triggers search — **next up**
- **`withOpacity` deprecated:** works but newer Flutter suggests `.withValues(alpha:...)`
- **`is_fav_for_me`:** in API response but commented out in `UniEntity`
- **`RecommendedRemoteDataSource`:** temporarily uses `getTrendingUnis` endpoint
- **"قدم الآن" button:** placeholder — needs profile API integration
- **`custom_exceptions.dart`:** exists but unused
- **Auth — "مجالات الاهتمام":** UI-only, no backend endpoint yet
- **Backend — duplicate-email-unverified edge case:** needs sayed conversation
- **Faheem `/aiChat/send`:** waiting on backend — sayed's current status unconfirmed, ask next session

---

## 17. All Decisions Made

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
| **Splash → LoginView (not OnBoarding) when token missing but onboarding seen** | Correct flow |
| **OnBoarding → LoginView (not MainView)** | Was a bug — fixed in a prior session |
| **Login fields not cleared on failed login** | User may have typo in password only — clearing all fields forces re-typing email |
| **`pendingSnackBarMessage` global REMOVED — message travels via route `arguments` only** | Global mutable state caused a "leftover message" bug across unrelated navigations; route arguments are scoped per-navigation, no cleanup needed |
| **Every `onGenerateRoute` case must pass `settings: settings`** | Root cause of the SnackBar arguments always being `null` — omission silently breaks any future use of route arguments too |
| **`NotificationsCubit.getNotifications()` removed from `main.dart`/`MultiBlocProvider` startup call** | Was firing with a possibly-expired token at cold start, causing a confusing immediate 401 redirect on app open |
| **`NotificationsCubit.getNotifications()` added to `MainView.initState()`** | Ensures fresh notifications right after login or app restart while logged in |
| **`didPopNext()` and `_onTabChanged()` notification refresh calls kept (not deduplicated)** | User wants notifications "always fresh" across all re-entry points to MainView — intentional, not a bug |
| **`getNotifications()` double-emit (list + unread count) left as-is** | Two independent concerns updating separately is intentional, not a bug to merge |

---

## 18. CustomTextFormField — Validation & Error Style (final state)

- `errorStyle: TextStyles.regular12.copyWith(color: AppColors.red)` — matches strength indicator style
- `errorBuilder` used to align error text right: `Align(alignment: Alignment.centerRight, child: Text(errorText, style: ...))`
- `errorBorder: buildBorder(borderColor ?? AppColors.red)` — red border on error even without explicit `borderColor`
- `focusedErrorBorder: buildFocusedBorder(borderColor ?? AppColors.red)`
- `autovalidateMode: AutovalidateMode.onUserInteraction`
- Confirm-password `validator` → "required" only; match check in `_submit()` via explicit equality check

---

## 19. Session Summary — جلسات سابقة (مرجع تاريخي)

**جلسة: Auth Polish + UX Fixes**
1. Register success UX: `AuthSuccess` بعد register → `OtpView` بدون SnackBar
2. Login success UX: فوري بدون SnackBar
3. "تم إنشاء حسابك بنجاح ✓" بعد `saveStudentInfo` في `SetupView`
4. Backend quirk: duplicate-email-unverified — يحتاج نقاش مع سايد (لسه مفتوح)
5. `StudyTypeSelector` → core widget بـ `Map<String, IconData>`
6. Bug: `OtpViewBody` register flow كانت مش بتحفظ التوكن في Prefs قبل `SetupView` — تم الفيكس
7. `SignUpForm` + `ResetPasswordForm`: password strength + live match check
8. Terms & Conditions → bottom sheet، محتوى ثابت
9. Validation bug: `errorStyle` صفري كانت بتخفي كل رسائل الخطأ — تم الفيكس
10. تكرار رسائل الخطأ (validator + match Text) — اتحل بـ `errorBuilder` + match check في `_submit()`

**جلسة: Splash + Onboarding + 401 Interceptor (أول نسخة) + Validator Fixes**
1. Validator fix (confirm-password) — موضّح في §18
2. `SecurityStrengthIndicator` — يظهر لما الباسورد مش فاضي
3. `CustomTextFormField` error alignment — `errorBuilder` + `Align(centerRight)`
4. `errorBorder` fix
5. Splash feature: `executeNavigation()` — تم بناؤها
6. OnBoarding bug fix: كانت بتروح `MainView` بدل `LoginView`
7. أول نسخة من 401 interceptor: `GlobalKey<NavigatorState>` + `pendingSnackBarMessage` global — **هذه النسخة استُبدلت بالكامل في الجلسة التالية (انظر §20)**
8. `LoginViewBody`: تحويل لـ `StatefulWidget`
9. Login fields on failure: قرار عدم المسح

---

## 20. Session Summary — هذا الشات (401 SnackBar Debug + Notifications Trigger Cleanup) — RESOLVED

1. **شخّصنا السبب الحقيقي للـ SnackBar مش بتظهر:** ليس `pendingSnackBarMessage` timing كما افترضنا أول مرة — السبب الفعلي: `onGenerateRoute` كانت بتعمل `MaterialPageRoute` من غير `settings: settings`، فـ `ModalRoute.of(context)?.settings.arguments` كانت ترجع `null` دايمًا لكل route، مش بس `LoginView`
2. **اتشال `pendingSnackBarMessage` global بالكامل من `main.dart`** — الرسالة بقت تتبعت كـ route `arguments` فقط
3. **`ApiService` 401 interceptor:** بقى يبعت الرسالة في `arguments` مباشرة بدون global variable
4. **`LoginViewBody`:** بقت تقرأ من `ModalRoute.of(context)?.settings.arguments as String?` بس — مفيش حاجة تتمسح بعد القراءة
5. **`on_generate_routes.dart`:** كل الـ cases بقت بتمرر `settings: settings` — fix شامل، مش بس لصفحة اللوجن
6. **بعد الفيكس، السناك بار ظهرت "أول ما يفتح التطبيق"** — تم التأكد إنه سلوك صحيح (مش leftover bug): `NotificationsCubit.getNotifications()` كانت بتتنادى تلقائيًا في `main.dart` بتوكن expired فعلي من جلسة سابقة → 401 حقيقي
7. **اتشال نداء `getNotifications()` من `main.dart`/`MultiBlocProvider`** بالكامل
8. **اتضاف نداء `getNotifications()` في `MainView.initState()`** — تحديث فوري بعد لوجن أو restart وهو logged in
9. **اكتُشف تكرار `Success` (مرتين/تلاتة) عبر اللوج** — تم تتبعه وتأكيده كسلوك مقصود:
   - تكرار على مستوى `MainView`: `initState` + `didPopNext` (LoginView بتتعمل لها pop) — **قرار: سيبهم زي ما هم**، حالات استخدام مختلفة
   - تكرار داخلي في `getNotifications()` نفسها: `_emitSuccess()` بعد الليست + emit تاني بعد `_fetchUnreadCount()` لو العدد اتغير — **قرار: سيبها**، مفهومين مختلفين منطقيًا
10. **`didPopNext()` و `_onTabChanged()` في `MainView`:** قرار نهائي بالحفاظ على نداء `getNotifications()` في الاتنين — اليوزر عايز الإشعارات "متحدثة دايمًا" مهما كانت نقطة الدخول لـ `MainView`

**النتيجة:** كل الـ debugging thread ده مقفول بالكامل ومؤكد إنه شغال. مفيش open items من هذا الشات.