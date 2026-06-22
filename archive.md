# Claude Memory File — Archive / Reference (Gameaty)
> Last updated: June 2026 (session: APK release + search debounce + release debug fixes)

---

## 1. Project Structure

```
lib/
├── constants.dart              (kHorizontalPadding=16, kTopPadding=16, kIsOnBoardingViewSeenKey, kGovernorates — 26 governorates)
├── main.dart                   (routeObserver, navigatorKey — MultiBlocProvider: ProfileCubit + FavCubit + NotificationsCubit)
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
│   │   ├── on_generate_routes.dart     (every case passes settings: settings)
│   │   ├── recent_searches_helper.dart
│   │   ├── calc_strength.dart
│   │   └── build_error_bar.dart
│   ├── services/
│   │   ├── get_it_service.dart         (Dio gets BaseOptions, UploadAvatarUseCase registered)
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
│   │   ├── api_service.dart            (postFormData() for multipart uploads)
│   │   └── backend_endpoints.dart      (addAvatar endpoint)
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
│       ├── custom_text_form_field.dart  (added `enabled` param for read-only fields)
│       ├── age_field.dart               (shared between auth/setup and profile/personal_data)
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
│       ├── terms_and_conditions_sheet.dart  (thin wrapper over LegalSheet)
│       └── legal_sheet.dart                 (shared DraggableScrollableSheet for Terms + Privacy)
└── features/
    ├── browse/ ... (done)
    ├── search/ ... (done — debounce ✅ done this session)
    ├── fav/ ... (done — pagination code confirmed correct; backend bug resolved by sayed)
    ├── guide/ ... (done)
    ├── notifications/ ... (done, stable)
    ├── home/
    │   └── presentation/views/widgets/custom_home_app_bar.dart  (wired to ProfileCubit; populated on cold start via MainView.initState → getMe())
    ├── auth/ ... (done)
    │   └── presentation/views/widgets/
    │       ├── login_view_body.dart     (reads session-expired message from ModalRoute arguments)
    │       ├── setup_view_body.dart     (scientificDepartment sent as null when "أدبي")
    │       ├── setup_governorate_dropdown.dart  (imports kGovernorates from constants.dart)
    │       └── terms_and_conditions.dart  (calls TermsAndConditionsSheet.show())
    ├── splash/ ... (done)
    ├── on_boarding/ ... (done)
    ├── uni_detail/ ... (done)
    ├── profile/  ✅ FULLY DONE
    │   ├── domain/ — reuses auth's GetMeUseCase, SaveStudentInfoUseCase, UpdatePasswordUseCase, UploadAvatarUseCase
    │   └── presentation/
    │       ├── manager/profile_cubit/
    │       │   ├── profile_cubit.dart  (uploadAvatar, logout, getMe, saveStudentInfo, updatePassword)
    │       │   └── profile_state.dart
    │       └── views/widgets/
    │           ├── profile_view_body.dart
    │           ├── personal_data_view_body.dart
    │           ├── security_view_body.dart
    │           ├── password_section.dart
    │           ├── governorate_dropdown.dart
    │           ├── stats_section.dart
    │           ├── documents_section.dart
    │           ├── personal_data_document_upload_card.dart
    │           ├── profile_avatar_section.dart
    │           ├── profile_logout_button.dart
    │           ├── personal_data_interests_selector.dart
    │           ├── avatar_profile.dart
    │           ├── avatar_upload_sheet.dart
    │           ├── logout_confirmation_sheet.dart
    │           ├── contact_us_view_body.dart
    │           ├── quick_contact.dart              (dummy data — replace when sayed provides)
    │           ├── message_form_section.dart
    │           ├── footer.dart
    │           ├── topic_dropdown.dart
    │           ├── details_field.dart
    │           ├── robot_section.dart
    │           └── role_badge.dart, profile_header.dart, profile_menu_item.dart,
    │               profile_menu_section.dart, version_info.dart
    └── faheem/ ✅ DONE (separate chat) — full integration: domain + data + cubit + view wired
               history UI done — waiting on sayed for history endpoint
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

### UserEntity
```dart
class UserEntity {
  final int id;
  final String name;
  final String email;
  final String? avatar;
  final String type;
  final StudentInfoEntity? studentInfo;
}
```

### StudentInfoEntity
```dart
class StudentInfoEntity {
  final String studySection;          // Arabic from GetMe, English expected by SaveStudentInfo
  final String scientificDepartment;  // defaults to '' on parse if backend returns null
  final int governorateId;
  final double percentage;
  final int age;
}
```

### ChatMessageEntity (faheem)
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
  static const String addAvatar = '/auth/addAvatar';
  static const String sendMessage = '/aiChat/send';
}
```

---

## 4. ApiService — Current State

```dart
class ApiService {
  final Dio dio;
  bool _isHandlingUnauthorized = false;

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

  // get, post, getList, patch, postWithToken — all unchanged

  Future<Map<String, dynamic>> postFormData({
    required String endpoint,
    required FormData data,
  }) async {
    var response = await dio.post('${BackendEndpoints.baseUrl}$endpoint', data: data);
    return response.data;
  }
}
```

**Dio instance has explicit `BaseOptions`:** connectTimeout 15s, sendTimeout 30s, receiveTimeout 15s.

**401 SnackBar ordering rule:** any cubit failure listener must check:
```dart
if (state.errMessage.toLowerCase().contains('unauthenticated')) return;
```

---

## 5. Auth Flows

**Register:** SignUpView → register → OtpView → verifyOtp → save token → SetupView → saveStudentInfo → MainView

**Forgot password:** ForgotPasswordView → forgetPassword → OtpView → verifyOtp (NOT saved) → ResetPasswordView(tempToken) → resetPassword → LoginView

**Login:** LoginView → login → MainView

**401/session expired:** interceptor → guard → Prefs.remove('token') → pushNamedAndRemoveUntil(LoginView, arguments: message)

**Logout:** LogoutConfirmationSheet → ProfileCubit.logout() → clears token + refresh_token → pushNamedAndRemoveUntil(LoginView)

---

## 6. Avatar Upload Feature

**Backend:** `POST /api/auth/addAvatar` — multipart/form-data, field `avatar`. Success has no URL — follow-up `GET /auth/me` needed.

**Pattern:** tap → `AvatarUploadSheet` (camera/gallery) → `pickImage(maxWidth: 1024, maxHeight: 1024)` → local preview + dim + spinner → `ProfileCubit.uploadAvatar(File)` (no global loading state) → on success, auto `getMe()` → SnackBar.

**Guards:** `_isPicking` + `_isUploading` locals in `AvatarProfile` state — prevents `PlatformException(already_active)`.

---

## 7. scientific_department — Confirmed Backend Behavior

| Sent | Result |
|---|---|
| Key omitted entirely | ✅ 200 |
| `""` | ❌ 422 |
| `null` (JSON) | ❌ 422 |
| Real value | ✅ 200 |

Key must be **omitted entirely** when not applicable. Fixed in both `personal_data_view_body.dart` and `setup_view_body.dart`.

---

## 8. Home AppBar Cold-Start Fix

`getIt<ProfileCubit>().getMe()` added to `MainView.initState()` — was never called on cold start before.

---

## 9. mailto/tel Contact Fix

Android 11+ `<queries>` manifest entries added for `mailto` and `tel` schemes.

---

## 10. QuickContact — Dummy Data

```dart
const _kWhatsAppNumber = '201000000000';
const _kPhoneNumber = '+201000000000';
const _kEmail = 'support@gameaty.app';
```
Replace when sayed provides real info.

---

## 11. GetIt Service — Full Registration Order

```
Dio (with BaseOptions) → ApiService
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
  → SaveStudentInfoUseCase → UpdatePasswordUseCase → GetMeUseCase → UploadAvatarUseCase
→ ProfileCubit (singleton)
→ FaheemRemoteDataSource → FaheemRepo → SendMessageUseCase → FaheemCubit
```

---

## 12. PersonalDataViewBody — Arabic↔Backend Mapping

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

---

## 13. PersonalDataViewBody — No-op Guard

```dart
String? _originalStudyCategory, _originalStudyTrack;
int? _originalGovernorateId;
String? _originalPercentage, _originalAge;

bool _hasChanges() { /* compares current vs original */ }

// in _submit():
if (!_hasChanges()) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('لم تقم بتغيير أي بيانات')));
  return;
}
```

---

## 14. LegalSheet

```dart
class LegalSheet extends StatelessWidget {
  static void show(BuildContext context, {required String title, required List<LegalSection> sections}) { ... }
}
// kTermsSections + kPrivacySections (7 sections each) defined in legal_sheet.dart
```

---

## 15. Error Handling Pattern

```
DioException → propagates from data source → caught in repo → left(ServerFailure.fromDioError(e))
→ cubit: result.fold(failure → emit FailureState, ...)
→ UI: if errMessage contains 'unauthenticated' → return early
     else → show SnackBar or error widget
```

---

## 16. Error UI Rules

| Situation | Widget |
|---|---|
| Full-screen failure في pushed screen | `NoInternetWidget` مع `onRetry` و `onBack: () => Navigator.pop(context)` |
| Full-screen failure في tab | `NoInternetWidget` مع `onRetry` بس |
| Inline failure في وسط صفحة | `CustomErrorWidget` مع `onRetry` |
| Pagination failure | `CustomErrorWidget` inline أسفل اللست مع `onRetry: loadMore` |
| Empty list | `EmptyStateWidget` |
| Transient success/info message | `SnackBar` (not Toast) |
| 401 during write action | return early in listener — interceptor handles redirect |

---

## 17. AppColors

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

## 18. Known Bugs & Pending Issues (current)

- **Search Debounce:** ✅ DONE this session
- **Fav Pagination backend bug:** ✅ code confirmed correct — was waiting on sayed, now resolved
- **`current_password` for update-Password:** ✅ CLOSED — not needed (token = auth proof)
- **`withOpacity` deprecated:** works but newer Flutter suggests `.withValues(alpha:...)`
- **`RecommendedRemoteDataSource`:** temporarily uses `getTrendingUnis` endpoint
- **Auth — duplicate-email-unverified edge case:** needs sayed conversation
- **Faheem History:** no backend endpoint yet — screen is UI-only
- **Real contact info:** dummy data in `quick_contact.dart` — needs sayed to provide

---

## 19. Release Build — Fixes & Decisions (this session)

### INTERNET Permission
Flutter debug adds `INTERNET` permission automatically. Release does **not**. Must be explicit in `AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.INTERNET" />
```
Root cause was diagnosed via:
1. `flutter build apk --release --verbose 2>&1 | findstr /i "\.env"` — confirmed `.env` included
2. Unzipping APK manually (rename to .zip → open in 7-Zip) — confirmed `.env` in `assets/flutter_assets/`
3. `isMinifyEnabled = false` test — ruled out R8/ProGuard
4. Checking `AndroidManifest.xml` — found missing permission

### `.env` in release
`.env` IS included in release APK correctly without any `aaptOptions` workaround — `pubspec.yaml` assets declaration is sufficient. `aaptOptions` block is NOT needed.

### `build.gradle.kts` — final clean state
No `aaptOptions`, no `isMinifyEnabled`/`isShrinkResources` overrides. Only `signingConfig = debug` for now.

### App icon & name
- Icon: `flutter_launcher_icons` package, `dart run flutter_launcher_icons`, image at `assets/images/app_icon.png`
- Name: `android:label="جامعتي"` in `AndroidManifest.xml`

---

## 20. Search Debounce — Implementation (this session)

**File:** `search_view_body.dart`

**Changes:**
- Added `import 'dart:async'`
- Added `Timer? _debounce` field
- `_onSearchChanged` now cancels previous timer + starts 500ms new one before calling cubit
- `dispose()` cancels timer

```dart
void _onSearchChanged(String query) {
  _debounce?.cancel();
  _debounce = Timer(const Duration(milliseconds: 500), () {
    context.read<SearchCubit>().search(query: query, filter: searchFilterEntity);
  });
}
```

Note: `_onSearchSubmitted` still calls `_onSearchChanged` directly (intentional — submit should trigger search even if within 500ms window, but the debounce timer handles it anyway).

---

## 21. All Decisions Made

| Decision | Reason |
|---|---|
| `current_password` not needed for update-Password | Token presence = user is authenticated — no extra verification needed |
| `aaptOptions` NOT needed for `.env` in release | `pubspec.yaml` assets declaration is sufficient — Gradle doesn't strip it |
| `INTERNET` permission must be explicit in release | Flutter debug adds it automatically; release does not |
| Search debounce 500ms via `Timer` in view body | Simple, no cubit changes needed |
| `flutter_launcher_icons` package for app icon | Generates all density variants automatically |
| `android:label="جامعتي"` in AndroidManifest | Display name shown under icon on device |
| `apiService.postFormData()` for file uploads | Dedicated multipart method — interceptor still fires |
| `Dio()` given explicit `BaseOptions` | Clearer error diagnosis on uploads |
| `maxWidth`/`maxHeight: 1024` on avatar `pickImage()` | Fixes 413 nginx limit |
| `_isPicking` guard around full avatar tap flow | Prevents `PlatformException(already_active)` |
| `ProfileCubit.uploadAvatar()` emits no intermediate loading | Avoids blanking `CustomHomeAppBar` |
| `getMe()` auto-triggers after avatar upload | Server response has no URL — only way to get new URL |
| `scientific_department` key omitted (not null/'') when absent | Confirmed via Postman — backend 422s on both |
| `getIt<ProfileCubit>().getMe()` in `MainView.initState()` | Was never called on cold start |
| `<queries>` entries for `mailto`/`tel` | Android 11+ package visibility restrictions |
| Logout → `LogoutConfirmationSheet` | Confirmation before execute |
| `LegalSheet` as shared widget | Terms + Privacy share identical structure |
| No-op save guard via snapshot | 5 `_original*` vars + `_hasChanges()` |
| `logout()` in `ProfileCubit` | Only GetIt singleton owning session state |
| Code comments English-only | Hard rule |
| SnackBar over Toast | Cleaner UX |

---

## 22. Session Summaries — تاريخي

**جلسة: Auth Polish + UX Fixes**
**جلسة: Splash + Onboarding + 401 Interceptor + Validator Fixes**
**جلسة: 401 SnackBar Debug + Notifications Trigger Cleanup**
**جلسة: 401 Double-SnackBar Diagnosis + Fix**
**جلسة: Profile API Integration — kickoff**
**جلسة: Profile Feature — all open items** (401 ordering, no-op guard, home AppBar, logout, contact us, legal sheet)
**جلسة: Faheem Feature — full integration** (separate chat)
**جلسة: mailto fix + Home AppBar fix + scientific_department fix + Avatar Upload**
**جلسة: APK release + search debounce + release debug fixes (هذه الجلسة)**
1. **App icon** — `flutter_launcher_icons` configured, `dart run flutter_launcher_icons` run successfully
2. **App display name** — `android:label="جامعتي"` set in AndroidManifest
3. **Search Debounce** — 500ms `Timer` added to `search_view_body.dart` — confirmed working
4. **Fav pagination** — reviewed code, confirmed correct implementation, no changes needed
5. **`current_password`** — closed: token presence = auth proof, not needed
6. **Release APK "No Internet Connection" bug** — diagnosed and fixed: missing `INTERNET` permission in `AndroidManifest.xml`. Flutter debug adds it automatically; release does not. Ruled out: `.env` path, R8/ProGuard, API key issues.
7. Next up: waiting on sayed for Faheem history + contact data + duplicate-email edge case.