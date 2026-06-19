# Claude Memory File — Archive / Reference (Gameaty)
> Last updated: June 2026 (session: Profile API Integration — kickoff + first batch of screens)

---

## 1. Project Structure

```
lib/
├── constants.dart              (kHorizontalPadding=16, kTopPadding=16, kIsOnBoardingViewSeenKey, kGovernorates ✅ NEW this session — 26 governorates, single shared source for auth + profile)
├── main.dart                   (routeObserver, navigatorKey — MultiBlocProvider now includes ProfileCubit ✅ this session)
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
│   │   ├── on_generate_routes.dart     (every case passes settings: settings — resolved prior session)
│   │   ├── recent_searches_helper.dart
│   │   ├── calc_strength.dart
│   │   └── build_error_bar.dart
│   ├── services/
│   │   ├── get_it_service.dart         ✅ updated this session — ProfileCubit registered as singleton
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
│   │   ├── api_service.dart            ✅ updated this session — 401 interceptor now has _isHandlingUnauthorized guard against concurrent double-redirect
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
│       ├── custom_text_form_field.dart  ✅ updated this session — added `enabled` (bool, default true) param with dimmed fill when disabled, used for read-only name/email in personal_data
│       ├── age_field.dart               ✅ NEW this session — moved here from auth's setup_age_field.dart (now shared between auth/setup and profile/personal_data), class renamed SetupAgeField → AgeField
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
    ├── notifications/ ... (done, stable)
    ├── home/ ... (done, but see profile cross-reference below)
    │   └── presentation/views/widgets/custom_home_app_bar.dart  🔶 still hardcoded 'محمد مجدي عبدالغني' + static Image.asset avatar — confirmed via code read this session, needs ProfileCubit wiring — OPEN ITEM, see claude.md §5
    ├── auth/ ... (done — see §Auth Feature)
    │   └── presentation/views/widgets/
    │       ├── login_view_body.dart     (reads session-expired message from ModalRoute arguments — unchanged, still correct)
    │       ├── sign_up_form.dart
    │       ├── setup_view_body.dart      ✅ updated this session — now imports AgeField from core/widgets instead of local setup_age_field.dart
    │       ├── setup_governorate_dropdown.dart  ✅ updated this session — now imports kGovernorates from root constants.dart instead of a local duplicate list
    │       └── (setup_age_field.dart DELETED this session — superseded by core/widgets/age_field.dart)
    ├── splash/
    │   └── presentation/views/widgets/splash_view_body.dart
    ├── on_boarding/
    │   └── presentation/views/on_boarding_view.dart
    ├── uni_detail/ ... (done)
    ├── profile/  🔶 IN PROGRESS — see §9 below for full breakdown
    │   ├── domain/ — reuses auth's GetMeUseCase, SaveStudentInfoUseCase, UpdatePasswordUseCase (no separate profile use cases — confirmed correct, they already lived in auth domain)
    │   └── presentation/
    │       ├── manager/profile_cubit/
    │       │   ├── profile_cubit.dart  ✅ NEW this session
    │       │   └── profile_state.dart  ✅ NEW this session
    │       └── views/widgets/
    │           ├── profile_view_body.dart            ✅ rebuilt this session — connects to ProfileCubit.getMe()
    │           ├── personal_data_view_body.dart       ✅ rebuilt this session — see §9 for full detail
    │           ├── security_view_body.dart            ✅ rebuilt this session — current-password field removed, updatePassword wired
    │           ├── password_section.dart              ✅ updated this session — current-password field removed
    │           ├── governorate_dropdown.dart          ✅ rebuilt this session — real dropdown, was 3 hardcoded fake options
    │           ├── stats_section.dart                 ✅ updated this session — now accepts governorate/percentage/age state from parent instead of being static
    │           ├── documents_section.dart              ✅ rebuilt this session — image_picker integration, internal checkbox now functional
    │           ├── personal_data_document_upload_card.dart  ✅ rebuilt this session — image_picker tap-to-pick/preview/clear
    │           ├── profile_avatar_section.dart        (unchanged — receives name/email/role from parent now)
    │           ├── profile_logout_button.dart         (unchanged widget — accepts onPressed, but nothing wires it yet — OPEN ITEM)
    │           ├── personal_data_interests_selector.dart  (unchanged — confirmed UI-only, no backend endpoint, static selected-set is fine as-is)
    │           ├── avatar_profile.dart                 (unchanged — avatar tap interaction still undefined, OPEN ITEM)
    │           ├── role_badge.dart, profile_header.dart, profile_menu_item.dart, profile_menu_section.dart  (unchanged)
    │           └── contact_us_view_body.dart (or similar — not yet touched, OPEN ITEM, needs UX spec from user)
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

### UserEntity (auth) — ✅ UPDATED this session
```dart
class UserEntity {
  final int id;
  final String name;
  final String email;
  final String? avatar;
  final String type;
  final StudentInfoEntity? studentInfo; // NEW — null until user completes student info
}
```

### StudentInfoEntity — ✅ NEW this session
```dart
class StudentInfoEntity {
  final String studySection;          // raw value as returned by API — may be Arabic ("علمي") from GetMe or English ("science") if echoed back; presentation layer handles mapping both ways
  final String scientificDepartment;  // same caveat as above
  final int governorateId;
  final double percentage;
  final int age;
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
  bool _isHandlingUnauthorized = false; // ✅ NEW this session

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
          // guard against multiple concurrent requests (e.g. notifications list +
          // unread count) each triggering their own redirect when the token expires.
          if (!_isHandlingUnauthorized) {
            _isHandlingUnauthorized = true;
            Prefs.remove('token');
            navigatorKey.currentState
                ?.pushNamedAndRemoveUntil(
                  LoginView.routeName,
                  (route) => false,
                  arguments: 'انتهت صلاحية جلستك، يرجى تسجيل الدخول مجدداً',
                )
                .then((_) => _isHandlingUnauthorized = false);
          }
          return handler.next(error);
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

> ✅ **RESOLVED this session:** double session-expired SnackBar (appeared twice when entering Notifications with an expired token) — root cause confirmed via repeated `print` log trace: two concurrent API calls inside `NotificationsCubit.getNotifications()` (list fetch + `_fetchUnreadCount()`) both received 401 nearly simultaneously, each independently triggering the interceptor's `pushNamedAndRemoveUntil`. Fixed with `_isHandlingUnauthorized` guard flag, reset after navigation completes via `.then()`.
>
> 🔶 **NEW, NOT YET RESOLVED this session:** a *different* SnackBar-ordering issue was flagged during Profile work — when a `personal_data` save request hits 401, the cubit's own `SaveStudentInfoFailure` SnackBar appears (showing a generic error) seemingly before/instead of the proper 401-redirect-and-message flow. This is a distinct bug from the one above. **Needs step-by-step log diagnosis next session before any fix is attempted** — do not assume the same root cause or the same fix applies.

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
1. Any API call returns 401 → interceptor → guard check → `Prefs.remove('token')` → `pushNamedAndRemoveUntil(LoginView.routeName, arguments: message)`
2. `LoginViewBody.initState` → reads `ModalRoute.of(context)?.settings.arguments as String?` → shows SnackBar if non-null
3. No cleanup needed — each navigation's arguments are scoped to that route instance only
4. ✅ Guard flag added this session prevents double-redirect from concurrent 401s (see §4)

**Logout flow — NOT YET WIRED (open item):**
- `AuthCubit.logout()` exists (`Prefs.remove('token')` + `Prefs.remove('refresh_token')`) but `AuthCubit` is not a GetIt singleton (created per-view in auth screens only) — unreachable from `ProfileViewBody`
- Claude's proposed approach (awaiting user confirmation): add a `logout()` method to `ProfileCubit` instead, since it's already a singleton and logically owns user-session state — avoids promoting `AuthCubit` to singleton and risking state bleed across login/register/forgot-password screens

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
> ⚠️ Known backend quirk: user record created before OTP verification — duplicate email returns generic error. Needs sayed conversation. (Still open.)

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

**GET /auth/me** — ✅ confirmed full shape this session (includes nested `student_info` and `favorite_universities`, the latter NOT mapped into `UserEntity` — decided unnecessary since fav has its own dedicated feature/endpoint already)
```json
{
  "status": 200,
  "message": "User retrieved successfully",
  "data": {
    "user": {
      "id": 77,
      "name": "dd",
      "email": "mohamed553231@gmail.com",
      "email_verified_at": "2026-06-17T11:06:04.000000Z",
      "avatar": null,
      "created_at": "...",
      "updated_at": "...",
      "type": "user",
      "student_info": {
        "id": 5,
        "study_section": "علمي",
        "scientific_department": "علوم",
        "governorate_id": 1,
        "user_id": 77,
        "percentage": 60,
        "age": 20,
        "created_at": "...",
        "updated_at": "...",
        "governorate": { "id": 1, "name_ar": "القاهرة", "name_en": "Cairo", "created_at": null, "updated_at": null }
      },
      "favorite_universities": [ /* NOT mapped into UserEntity — fav feature owns this data already */ ]
    }
  }
}
```
> ⚠️ Note: `study_section`/`scientific_department` come back **in Arabic** from this endpoint ("علمي"، "علوم") but `POST /student_info` expects **English** values ("science"، "scientific"). `StudentInfoModel` stores the raw value as-is; the presentation layer (`personal_data_view_body.dart`, `profile_view_body.dart`) does the Arabic↔English mapping in both directions, same pattern as the existing `SetupViewBody`.

**POST /auth/update-Password** — ✅ confirmed this session
```json
{ "status": 200, "message": "Password Updated Successfully" }
```
> No `current_password` param in current endpoint — the "current password" field was removed from `security_view_body.dart`/`password_section.dart` UI this session since it had no backend support and wasn't even wired to a controller. **Open question to sayed: can `current_password` be added?**

**POST /student_info** — ✅ confirmed this session
```json
{
  "status": 200,
  "message": "تم إضافة معلوماتك بنحاج! ",
  "data": {
    "id": 5,
    "study_section": "علمي",
    "scientific_department": "علوم",
    "governorate_id": 1,
    "user_id": 77,
    "percentage": 60,
    "age": 20,
    "created_at": "...",
    "updated_at": "...",
    "governorate": { "id": 1, "name_ar": "القاهرة", "name_en": "Cairo", "created_at": null, "updated_at": null }
  }
}
```
> ⚠️ Open question to sayed (this session): when `study_section` is "أدبي" (literature), what should `scientific_department` be sent as? Frontend currently sends `''` (empty string) — needs confirmation this is acceptable, or whether `null` is required (would need a signature change: `SaveStudentInfoUseCase`/`AuthRepo.saveStudentInfo`/data source would need `scientificDepartment` to become nullable).

---

## 7. GetIt Service — Full Registration Order (updated this session)

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
→ ProfileCubit ✅ NEW this session — reuses GetMeUseCase, SaveStudentInfoUseCase, UpdatePasswordUseCase already registered above
```

> `AuthCubit` / `OtpCubit` are NOT registered in GetIt — created per-view via `BlocProvider(create: ...)`. This is now relevant to the open logout-wiring question (see §5 above).
> `NotificationsCubit` IS a GetIt singleton, `getNotifications()` called from `MainView` only (not at app startup) — unchanged.
> `ProfileCubit` IS a GetIt singleton — accessed directly via `getIt<ProfileCubit>()` from view bodies, no `BlocProvider` needed in the three profile views (`ProfileView`, `PersonalDataView`, `SecurityView` all confirmed to correctly omit `BlocProvider` this session, consistent with the singleton pattern).

---

## 8. NotificationsCubit — Internal Emit Behavior (confirmed, not a bug)

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

This makes two **independent Dio calls** per `getNotifications()` invocation — relevant context for the 401-guard fix in §4, since both calls can fail with 401 close together in time. Double-emit behavior itself confirmed intentional, unchanged.

---

## 9. ProfileCubit — Full Design (NEW this session)

```dart
class ProfileCubit extends Cubit<ProfileState> {
  final GetMeUseCase getMeUseCase;
  final SaveStudentInfoUseCase saveStudentInfoUseCase;
  final UpdatePasswordUseCase updatePasswordUseCase;

  UserEntity? _currentUser;
  UserEntity? get currentUser => _currentUser; // exposed for intermediate states

  Future<void> getMe() async {
    emit(ProfileLoading());
    final result = await getMeUseCase.call();
    result.fold((failure) => emit(ProfileFailure(failure.message)), (user) {
      _currentUser = user;
      emit(ProfileSuccess(user));
    });
  }

  Future<void> saveStudentInfo({...}) async {
    emit(SavingStudentInfo());
    final result = await saveStudentInfoUseCase.call(...);
    result.fold(
      (failure) => emit(SaveStudentInfoFailure(failure.message)),
      (_) async {
        emit(StudentInfoSaved());
        await getMe(); // refresh local user so ProfileSuccess reflects saved values
      },
    );
  }

  Future<void> updatePassword({...}) async {
    emit(UpdatingPassword());
    final result = await updatePasswordUseCase.call(...);
    result.fold(
      (failure) => emit(UpdatePasswordFailure(failure.message)),
      (_) => emit(PasswordUpdated()),
    );
  }
}
```

**States:** `ProfileInitial`, `ProfileLoading`, `ProfileSuccess(UserEntity)`, `ProfileFailure(String)` for fetch; `SavingStudentInfo`, `StudentInfoSaved`, `SaveStudentInfoFailure(String)` for the student-info save; `UpdatingPassword`, `PasswordUpdated`, `UpdatePasswordFailure(String)` for password update. Save/update states kept deliberately separate from fetch states so a failed write doesn't blow away currently-displayed user data — screens read `currentUser` getter during intermediate/failure states of the write actions.

**Used by:** `profile_view_body.dart` (getMe only), `personal_data_view_body.dart` (getMe + saveStudentInfo), `security_view_body.dart` (updatePassword only) — single cubit, all three screens, per the "Cubit-per-feature not per-screen" architecture rule. Confirmed as correct design via explicit expert-opinion question this session (user asked Claude to "act as flutter expert" on cubit-splitting decision).

---

## 10. PersonalDataViewBody — Arabic↔Backend Mapping (NEW this session)

```dart
const Map<String, String> kStudySectionMap = {'علمي': 'science', 'أدبي': 'literature'};
const Map<String, String> kStudySectionMapReversed = {
  'science': 'علمي', 'علمي': 'علمي', 'literature': 'أدبي', 'أدبي': 'أدبي',
};
const Map<String, String> kScientificDepartmentMap = {'علوم': 'scientific', 'رياضة': 'Mathematics'};
const Map<String, String> kScientificDepartmentMapReversed = {
  'scientific': 'علوم', 'علوم': 'علوم', 'Mathematics': 'رياضة', 'رياضة': 'رياضة',
};
```
Same pattern as existing `SetupViewBody` — reversed maps handle the fact that `GetMe` returns Arabic values while `SaveStudentInfo` expects English ones, and both maps include identity entries (Arabic→Arabic) as a defensive fallback in case raw values vary.

**Conditional field visibility (resolved this session, was a TODO):** "الشعبة العلمية" selector only renders when `studyCategory == 'علمي'`:
```dart
if (studyCategory == 'علمي') ...[
  const FieldLabel(label: 'الشعبة العلمية'),
  const SizedBox(height: 6),
  StudyTypeSelector(options: const ['علوم', 'رياضة'], selected: studyTrack, onSelected: (v) => setState(() => studyTrack = v)),
  const SizedBox(height: 16),
],
```

**Submit payload when "أدبي" (resolved this session, was a TODO):**
```dart
scientificDepartment: studyCategory == 'علمي'
    ? (kScientificDepartmentMap[studyTrack] ?? 'scientific')
    : '',
```
🔶 Sends `''` currently — **unconfirmed with backend, see §6 open question.**

**Manual age validation before submit (resolved this session, was a TODO)** — in addition to the existing inline `Form`/`AgeField` validator:
```dart
final age = int.tryParse(_ageController.text);
if (age == null || age < 14 || age > 30) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('من فضلك اختر عمر مناسب (من 14 إلى 30)')),
  );
  return;
}
```

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

> Same field mapping now reused in `PersonalDataViewBody` (profile) — see §10 above.

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
| Profile fetch failure | `CustomErrorWidget` with `onRetry: () => getIt<ProfileCubit>().getMe()` — confirmed this session |

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

## 16. Known Bugs & Pending Issues (current)

- **Backend Bug — Fav Pagination:** same items regardless of cursor → deduplication in `FavCubit.loadMore()`
- **`HomeView` dead code:** exists but never navigated to
- **`SearchResultsWidget` dead code:** unused
- **Search Debounce:** not implemented — every keystroke triggers search — still pending
- **`withOpacity` deprecated:** works but newer Flutter suggests `.withValues(alpha:...)`
- **`is_fav_for_me`:** in API response but commented out in `UniEntity`
- **`RecommendedRemoteDataSource`:** temporarily uses `getTrendingUnis` endpoint
- **`custom_exceptions.dart`:** exists but unused
- **Auth — "مجالات الاهتمام":** UI-only, no backend endpoint — same status confirmed for profile's copy of this widget
- **Backend — duplicate-email-unverified edge case:** needs sayed conversation
- **Faheem `/aiChat/send`:** waiting on backend — sayed's current status unconfirmed, ask next session
- **NEW this session — session-expired SnackBar ordering bug in personal_data save flow:** see §4 above, not yet diagnosed
- **NEW this session — "قدم الآن" button still placeholder:** unchanged status, profile API integration now underway should eventually unblock this
- **NEW this session — Home page name/avatar hardcoded:** see §1 (`custom_home_app_bar.dart`), open item
- **NEW this session — Logout button not wired:** see §5, open item awaiting user confirmation on approach
- **NEW this session — Contact Us screen UX:** needs concrete mechanism spec from user before any code

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
| **`AuthCubit`/`OtpCubit` NOT GetIt singletons** | Transient flow — now directly relevant to the open logout-wiring question |
| **"مجالات الاهتمام" static/UI-only** | No backend endpoint (confirmed again this session for profile's copy) |
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
| **OnBoarding → LoginView (not MainView)** | Was a bug — fixed prior session |
| **Login fields not cleared on failed login** | User may have typo in password only — re-confirmed this session as deliberate, not a bug, after user asked Claude to evaluate it explicitly |
| **`pendingSnackBarMessage` global REMOVED — message travels via route `arguments` only** | Global mutable state caused a "leftover message" bug across unrelated navigations |
| **Every `onGenerateRoute` case must pass `settings: settings`** | Root cause of the SnackBar arguments always being `null` |
| **`NotificationsCubit.getNotifications()` removed from `main.dart`/`MultiBlocProvider` startup call** | Was firing with a possibly-expired token at cold start |
| **`NotificationsCubit.getNotifications()` added to `MainView.initState()`** | Ensures fresh notifications right after login or app restart while logged in |
| **`didPopNext()` and `_onTabChanged()` notification refresh calls kept (not deduplicated)** | User wants notifications "always fresh" |
| **`getNotifications()` double-emit (list + unread count) left as-is** | Two independent concerns updating separately is intentional |
| **`_isHandlingUnauthorized` guard flag added to `ApiService` 401 interceptor** | Confirmed via log trace this session: concurrent 401s (list + unread-count calls both failing) were each independently triggering the redirect, causing a double SnackBar |
| **Single `ProfileCubit` for profile/personal_data/security (not 3 separate cubits)** | Same "object" of work (current user's data) — consistent with `AuthCubit` covering 5 auth screens; confirmed via explicit "act as Flutter expert" question this session |
| **`kGovernorates` moved to root `lib/constants.dart`** | User's explicit instruction — single shared source instead of duplicated in auth and profile separately |
| **`SetupAgeField` renamed to `AgeField` and moved to `core/widgets/`** | Now used by both auth (setup) and profile (personal_data) — per architecture rule 4 |
| **`CustomTextFormField` gained an `enabled` param** | Needed to show name/email as read-only in personal_data (no update-profile endpoint exists) — backward-compatible, default `true` |
| **Name/email fields in `personal_data` are read-only, not submitted** | No `update-profile` endpoint exists — only `student_info` fields are submitted; flagged as UI-only display rather than silently dropped or invented |
| **`favorite_universities` from `GetMe` response NOT mapped into `UserEntity`** | Fav feature already has its own dedicated endpoint/state — redundant to duplicate here, confirmed with user this session |
| **Current-password field removed from `security_view_body.dart`/`password_section.dart`** | User is already authenticated via bearer token; `update-Password` endpoint has no `current_password` param; field was previously unconnected to any controller anyway |
| **`image_picker` added as a new dependency** | For `DocumentsSection`/`PersonalDataDocumentUploadCard` — explicitly approved by user this session for better UX on the UI-only document upload cards (no backend endpoint, but tap-to-pick/preview/clear feels more complete than static placeholders) |
| **Avatar upload to backend explicitly deferred** | No endpoint exists yet; opening that scope now would expand this round significantly; tracked as a separate future task per user's "خلينا نأجلها" |
| **"الشعبة العلمية" selector conditionally rendered only when "علمي" selected** | Doesn't make sense to show a science-track sub-selector for the literature track — user-flagged TODO, resolved this session |
| **`scientificDepartment` sent as `''` (not omitted) when study section is "أدبي"** | Best guess pending sayed's confirmation on what the backend actually expects (`null` vs `''`) — flagged as open/unconfirmed, not a final decision |
| **Manual 14–30 age check with SnackBar added before submit, in addition to inline Form validator** | User wanted an explicit SnackBar nudge on top of the existing silent inline validation error |
| **Logout method proposed for `ProfileCubit` rather than promoting `AuthCubit` to a GetIt singleton** | Avoids state-bleed risk across auth's 5 screens sharing one `AuthState` enum; `ProfileCubit` already owns user-session-shaped state — proposed by Claude, **awaiting explicit user confirmation, not yet implemented** |

---

## 18. CustomTextFormField — Validation & Error Style (final state, updated this session)

- `errorStyle: TextStyles.regular12.copyWith(color: AppColors.red)` — matches strength indicator style
- `errorBuilder` used to align error text right: `Align(alignment: Alignment.centerRight, child: Text(errorText, style: ...))`
- `errorBorder: buildBorder(borderColor ?? AppColors.red)` — red border on error even without explicit `borderColor`
- `focusedErrorBorder: buildFocusedBorder(borderColor ?? AppColors.red)`
- `autovalidateMode: AutovalidateMode.onUserInteraction`
- Confirm-password `validator` → "required" only; match check in `_submit()` via explicit equality check
- ✅ NEW this session: `enabled` (bool, default `true`) param — when `false`, field is non-interactive and fill color dims to `Color(0xFFEFF1F1)` instead of the default `Color(0xFFF9FAFA)`

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
7. أول نسخة من 401 interceptor: `GlobalKey<NavigatorState>` + `pendingSnackBarMessage` global — استُبدلت بالكامل لاحقًا
8. `LoginViewBody`: تحويل لـ `StatefulWidget`
9. Login fields on failure: قرار عدم المسح

**جلسة: 401 SnackBar Debug + Notifications Trigger Cleanup (RESOLVED)**
1. شخّصنا السبب الحقيقي للـ SnackBar مش بتظهر: `onGenerateRoute` كانت بتعمل `MaterialPageRoute` من غير `settings: settings`
2. اتشال `pendingSnackBarMessage` global بالكامل، الرسالة بقت تتبعت كـ route `arguments` فقط
3. كل الـ cases في `on_generate_routes.dart` بقت بتمرر `settings: settings`
4. اتشال نداء `getNotifications()` من `main.dart`، اتضاف في `MainView.initState()`
5. تكرار الـ `Success` state (مرتين/تلاتة) — تم تأكيده كسلوك مقصود مش bug
6. `didPopNext`/`_onTabChanged` notification refresh — قرار نهائي بالحفاظ عليهم

**جلسة: Login Fields Bug Review (RESOLVED, no actual bug found)**
1. اليوزر سأل عن سبب مسح فيلدز اللوجن بعد فشل المحاولة — Claude فحص `login_form.dart` و `login_view_body.dart` كاملين، اتأكد إن مفيش أي كود بيمسح الفيلدز فعليًا — القرار الأصلي (عدم المسح) لسه قائم وصحيح، مفيش تناقض في الكود

**جلسة: 401 Double-SnackBar Diagnosis + Fix (RESOLVED)**
1. اليوزر لاحظ السناك بار بتظهر مرتين عند دخول صفحة الإشعارات بتوكن منتهي
2. تم تتبعه بـ `print` logs — اتأكد إن النداء بيحصل مرتين فعليًا (مش افتراض)
3. السبب: `getNotifications()` بتعمل نداءين API مستقلين (list + unread count)، الاتنين بيفشلوا بـ 401 في نفس الوقت تقريبًا
4. الفيكس: `_isHandlingUnauthorized` guard flag في `ApiService`، بيتصفّر بعد ما الـ navigation تخلص

**جلسة: Profile API Integration — هذا الشات (IN PROGRESS، مش مقفولة بالكامل)**
انظر §9 و §10 أعلاه للتفاصيل التقنية الكاملة. ملخص سريع:
1. خطة كاملة اتعملت ومُتفق عليها: `GetMe` + `SaveStudentInfo` + `UpdatePassword` فقط، الـ avatar upload مؤجل
2. `kGovernorates` اتنقلت لـ `constants.dart` المشترك بدل تكرارها — بناءً على طلب صريح من اليوزر
3. `ProfileCubit` واحدة اتعملت للتلاتة شاشات (مش 3 منفصلة) — قرار اتأكد بسؤال "act as flutter expert"
4. `StudentInfoEntity`/`StudentInfoModel` جداد، `UserEntity` اتحدثت
5. الشاشات التلاتة (`profile`, `personal_data`, `security`) اتربطت بالكيوبت
6. `image_picker` اتضافت للمستندات بموافقة صريحة من اليوزر
7. حقل "كلمة المرور الحالية" اتشال (مفيش endpoint param وكان مش متربط بحاجة أصلاً)
8. اليوزر بعت كود فيه TODOs جوا الكومنتات، اتحلت اتنين منهم (إظهار الشعبة العلمية شرطيًا، إرسال scientificDepartment فاضي لما أدبي) — رد فعل صحيح من Claude على نمط "TODO comments" اللي اليوزر بيستخدمه
9. تم اكتشاف bug جديد (مش نفس الـ 401 القديم): ترتيب غلط للسناك بار وقت فشل حفظ بسبب 401 في `personal_data` — **لسه مش متشخّص**
10. اليوزر صحح Claude مرة وحدة لما بدأ يقرا/يلمس كود `profile_view_body.dart` وسط نقاش لسه مفتوح عن طريقة عمل الـ logout — درس اتسجل في التفضيلات
11. **العناصر المفتوحة الستة** (بالترتيب اللي طلبه اليوزر): تشخيص 401 ordering bug → مراجعة كود الـ no-op-save بتاع اليوزر → ربط اسم/صورة الهوم بيدج → ربط زرار اللوج آوت (مستني تأكيد على الـ approach) → تحديد شكل صفحة "تواصل مع الدعم" → توضيح المقصود بـ "avatar dialog"
12. **سؤالين مفتوحين لسايد**: قيمة `scientific_department` لما أدبي (`null` ولا `''`)، وإمكانية إضافة `current_password` لـ `update-Password` endpoint

**النتيجة:** الجلسة دي **لسه مفتوحة** — فيه شغل قائم ومفيش إغلاق نهائي زي الجلسات اللي فاتت. الـ session summary هنا بيوثق كل اللي اتعمل لحد دلوقتي عشان أي شات جديد يكمل من نفس النقطة.