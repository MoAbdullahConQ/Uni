# Claude Memory File — Archive / Reference (Gameaty)
> Last updated: June 2026 (session: mailto fix + Home AppBar fix + scientific_department bug fix + Avatar Upload full integration)

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
│   │   ├── get_it_service.dart         ✅ updated this session — Dio gets BaseOptions, UploadAvatarUseCase registered
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
│   │   ├── api_service.dart            ✅ updated this session — added `postFormData()` for multipart uploads
│   │   └── backend_endpoints.dart      ✅ updated this session — added `addAvatar`
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
    ├── search/ ... (done — debounce next up, not started)
    ├── fav/ ... (done — pagination bug waiting on sayed)
    ├── guide/ ... (done)
    ├── notifications/ ... (done, stable)
    ├── home/
    │   └── presentation/views/widgets/custom_home_app_bar.dart  (wired to ProfileCubit; now populated on cold start via MainView.initState → getMe())
    ├── auth/ ... (done)
    │   └── presentation/views/widgets/
    │       ├── login_view_body.dart     (reads session-expired message from ModalRoute arguments)
    │       ├── setup_view_body.dart     ✅ FIXED this session — scientificDepartment now sent as null when "أدبي" (was always sending a real value, bug)
    │       ├── setup_governorate_dropdown.dart  (imports kGovernorates from constants.dart)
    │       └── terms_and_conditions.dart  (calls TermsAndConditionsSheet.show())
    ├── splash/ ... (done)
    ├── on_boarding/ ... (done)
    ├── uni_detail/ ... (done)
    ├── profile/  ✅ FULLY DONE this session — no open items left
    │   ├── domain/ — reuses auth's GetMeUseCase, SaveStudentInfoUseCase, UpdatePasswordUseCase, UploadAvatarUseCase
    │   └── presentation/
    │       ├── manager/profile_cubit/
    │       │   ├── profile_cubit.dart  ✅ updated this session — uploadAvatar(File) added (no intermediate Loading emit, see §6)
    │       │   └── profile_state.dart
    │       └── views/widgets/
    │           ├── profile_view_body.dart
    │           ├── personal_data_view_body.dart       ✅ FIXED this session — scientificDepartment now sent as null when not "علمي" (was '')
    │           ├── security_view_body.dart
    │           ├── password_section.dart
    │           ├── governorate_dropdown.dart
    │           ├── stats_section.dart
    │           ├── documents_section.dart
    │           ├── personal_data_document_upload_card.dart  (reference pattern for image_picker, gallery-only)
    │           ├── profile_avatar_section.dart
    │           ├── profile_logout_button.dart
    │           ├── personal_data_interests_selector.dart  (UI-only)
    │           ├── avatar_profile.dart                ✅ REBUILT this session — full upload flow, see §6
    │           ├── avatar_upload_sheet.dart            ✅ NEW this session — camera/gallery bottom sheet
    │           ├── logout_confirmation_sheet.dart
    │           ├── contact_us_view_body.dart
    │           ├── quick_contact.dart                  ✅ FIXED this session — AndroidManifest queries for mailto/tel (see §9)
    │           ├── message_form_section.dart
    │           ├── footer.dart
    │           ├── topic_dropdown.dart
    │           ├── details_field.dart
    │           ├── robot_section.dart
    │           ├── contact_us_channel_card.dart
    │           ├── role_badge.dart, profile_header.dart, profile_menu_item.dart,
    │           │   profile_menu_section.dart, version_info.dart  (unchanged)
    └── faheem/ ✅ DONE in a prior session (separate chat) — full integration: domain + data + cubit + view wired
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
  final String scientificDepartment;  // defaults to '' on parse if backend returns null (see §11)
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
  static const String addAvatar = '/auth/addAvatar';        // ✅ NEW this session
  static const String sendMessage = '/aiChat/send';         // faheem (prior session)
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

  // get, post, getList, patch, postWithToken — all unchanged (Map<String, dynamic> JSON)

  // ✅ NEW this session — for multipart/form-data uploads (avatar, future file uploads)
  Future<Map<String, dynamic>> postFormData({
    required String endpoint,
    required FormData data,
  }) async {
    var response = await dio.post('${BackendEndpoints.baseUrl}$endpoint', data: data);
    return response.data;
  }
}
```

**Note:** `apiService.post()` accepts only `Map<String, dynamic>`. For `FormData` (file uploads), use `apiService.postFormData()` (added this session) — same pattern as Faheem's earlier direct-`dio.post()` workaround, but now formalized as a proper `ApiService` method.

**Dio instance (get_it_service.dart) — updated this session:**
```dart
getIt.registerSingleton<Dio>(
  Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 15),
    sendTimeout: const Duration(seconds: 30),   // generous for file uploads
    receiveTimeout: const Duration(seconds: 15),
  )),
);
```
Was a bare `Dio()` with no timeouts before — added for clearer error diagnosis (`DioExceptionType.sendTimeout` etc. instead of `unknown`) after debugging the avatar upload `413`/`unknown` errors (see §6).

**401 SnackBar ordering rule:** any cubit failure listener that shows a SnackBar must first check:
```dart
if (state.errMessage.toLowerCase().contains('unauthenticated')) return;
```
Root cause: the repo's `try/catch` catches the `DioException` before the interceptor redirects — cubit emits `Failure` state first, then interceptor fires. The early return prevents the wrong SnackBar from showing.

---

## 5. Auth Flows (confirmed and working)

**Register flow:** SignUpView → register → OtpView → verifyOtp → save token to Prefs → SetupView → saveStudentInfo → MainView

**Forgot password flow:** ForgotPasswordView → forgetPassword → OtpView → verifyOtp (NOT saved to Prefs) → ResetPasswordView(tempToken) → resetPassword → LoginView

**Login flow:** LoginView → login → MainView

**401 / session expired flow:** interceptor → guard check → Prefs.remove('token') → pushNamedAndRemoveUntil(LoginView, arguments: message) → LoginViewBody reads via ModalRoute arguments

**Logout flow:**
1. User taps logout button → `LogoutConfirmationSheet.show()` appears
2. User taps "أيوه" → `ProfileCubit.logout()` called
3. `logout()` clears token + refresh_token + `_currentUser` → `navigatorKey.pushNamedAndRemoveUntil(LoginView)`
4. No session-expired message shown (clean logout, not expired)

---

## 6. Avatar Upload Feature — Full Design (built this session)

**Backend:** `POST /api/auth/addAvatar` — multipart/form-data, field `avatar` (File, required). Success response has no avatar URL (`{"status":200,"message":"Avatar Updated Successfully"}`) — new URL only available via follow-up `GET /auth/me`.

### AvatarUploadSheet (new)
Bottom sheet with two options (camera / gallery), returns the chosen `ImageSource` via `Navigator.pop`.

### AvatarProfile (rebuilt — StatelessWidget → StatefulWidget)
```dart
class _AvatarProfileState extends State<AvatarProfile> {
  File? _localImage;
  bool _isUploading = false;
  bool _isPicking = false; // guards the picker's own async gap — prevents
                            // PlatformException(already_active) on fast double-tap

  Future<void> _onTap() async {
    if (_isUploading || _isPicking) return;
    _isPicking = true;
    try {
      final source = await AvatarUploadSheet.show(context);
      if (source == null) return;
      final picked = await ImagePicker().pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1024,   // caps file size — fixes 413 / connection-drop errors
        maxHeight: 1024,
      );
      if (picked == null) return;
      setState(() { _localImage = File(picked.path); _isUploading = true; });
      final success = await getIt<ProfileCubit>().uploadAvatar(_localImage!);
      if (!mounted) return;
      setState(() { _isUploading = false; _localImage = null; });
      // SnackBar: success → 'تم تغيير الصورة الشخصية' | failure → 'فشل تغيير الصورة، حاول مرة أخرى'
    } finally {
      _isPicking = false;
    }
  }
}
```
UI: `BlocBuilder<ProfileCubit, ProfileState>` reads `avatarUrl` from `currentUser`. While `_isUploading`: image opacity 0.5 + centered `CircularProgressIndicator` overlay (confirmed UX choice). `_localImage` (local file) takes priority over the network image only during the upload window; cleared immediately after `uploadAvatar()` resolves either way.

### ProfileCubit.uploadAvatar (new)
```dart
// No intermediate ProfileLoading() emitted — would blank out CustomHomeAppBar
// (same singleton cubit) while uploading. Returns plain bool.
Future<bool> uploadAvatar(File image) async {
  final result = await uploadAvatarUseCase.call(image);
  var success = false;
  result.fold((failure) => success = false, (_) => success = true);
  if (success) await getMe(); // refreshes currentUser.avatar everywhere
  return success;
}
```

### Domain/data chain (new, mirrors existing auth use cases)
`UploadAvatarUseCase(AuthRepo)` → `AuthRepo.uploadAvatar(File)` → `AuthRepoImpl` (try/catch DioException → ServerFailure) → `AuthRemoteDataSource.uploadAvatar(File)`:
```dart
Future<void> uploadAvatar(File image) async {
  final formData = FormData.fromMap({'avatar': await MultipartFile.fromFile(image.path)});
  await apiService.postFormData(endpoint: BackendEndpoints.addAvatar, data: formData);
}
```

### Debugging history (resolved)
- First error: `PlatformException(already_active)` on fast double-tap → fixed with `_isPicking` guard around the whole flow.
- Second error: `413 Request Entity Too Large` (nginx) on camera photos → root cause: full-res camera images too large for server's upload limit.
- Third error: `DioExceptionType.unknown`, null response, on a gallery image → same root cause (large file + connection drop), confirmed by same fix resolving it.
- Fix for both: `maxWidth: 1024, maxHeight: 1024` added to `pickImage()`. Also added explicit `BaseOptions` timeouts to `Dio` for clearer future diagnostics.
- Debug `print()` statements in `auth_repo_impl.dart`'s `uploadAvatar` catch block were used to extract the exact `DioExceptionType` and response — **removed by user** after confirming the fix worked.

**Status: ✅ fully working, user-confirmed ("اشتغلت خلاص").**

---

## 7. scientific_department — Confirmed Backend Behavior (resolved this session)

Tested directly via Postman by the user:

| Sent | Result |
|---|---|
| Key omitted from body entirely | ✅ 200 — `scientific_department: null` in response |
| `"scientific_department": ""` | ❌ 422 "The selected scientific department is invalid." |
| `"scientific_department": null` (JSON null) | ❌ 422 same error |
| Real value (`"scientific"` / `"Mathematics"`) | ✅ 200 |

**Rule:** when there's no scientific department (study section = "أدبي"), the key must be omitted from the request map entirely — not sent as `null` or `''`.

**Two bugs fixed (both call sites of `saveStudentInfo`):**
1. `personal_data_view_body.dart` (profile edit) — was sending `''`.
2. `setup_view_body.dart` (initial registration setup) — was sending a real value unconditionally regardless of study section selected (worse bug, found while tracing the fix for #1).

`AuthRemoteDataSourceImpl.saveStudentInfo` now builds the request map conditionally:
```dart
final data = <String, dynamic>{
  'study_section': studySection,
  'governorate_id': governorateId,
  'percentage': percentage,
  'age': age,
};
if (scientificDepartment != null && scientificDepartment.isNotEmpty) {
  data['scientific_department'] = scientificDepartment;
}
```
`scientificDepartment` param is now `String?` end-to-end (data source → repo → use case → AuthCubit → ProfileCubit).

**`StudentInfoModel.fromJson`** already defaulted `scientific_department` to `''` on parse — the receiving side was already safe; only the sending side had the bug.

---

## 8. Home AppBar Cold-Start Fix (resolved this session)

**Symptom:** name/avatar in `CustomHomeAppBar` only populated after visiting Profile tab and returning; never loaded on a fresh app launch.

**Root cause:** `ProfileCubit.getMe()` was never called on app start — only ever triggered as a side effect of visiting the Profile screen.

**Fix:** added to `MainView.initState()`, alongside the other singleton cubit triggers:
```dart
getIt<TrendingCubit>().fetchTrendingUnis();
getIt<FavCubit>().getFavs();
getIt<GuideCubit>().getArticles();
getIt<NotificationsCubit>().getNotifications();
getIt<ProfileCubit>().getMe();  // ✅ added this session
```
Deliberately not added to `didPopNext`/`_onTabChanged` — profile data doesn't need refresh-on-tab-return like trending/fav/guide.

---

## 9. mailto/tel Contact Fix (resolved this session)

**Symptom:** tapping email button in `QuickContact` did nothing on a real device with Gmail installed.

**Root cause:** Android 11+ (API 30+) package visibility restrictions — `canLaunchUrl()` returns `false` for `mailto:`/`tel:` unless declared in `AndroidManifest.xml`'s `<queries>`. Existing `<queries>` only had `PROCESS_TEXT` + generic `https` (why `wa.me` worked but `mailto:`/`tel:` silently failed).

**Fix — added to `<queries>` in `AndroidManifest.xml`:**
```xml
<intent>
    <action android:name="android.intent.action.VIEW" />
    <data android:scheme="mailto" />
</intent>
<intent>
    <action android:name="android.intent.action.DIAL" />
    <data android:scheme="tel" />
</intent>
```
**Required:** full uninstall + reinstall (not hot reload/restart) for manifest changes to apply.

`mailto:` log warning (`component name is null`) seen before the fix was a red herring at first glance but turned out to correctly indicate the missing manifest declaration — not an unrelated info log.

---

## 10. QuickContact — Dummy Data (replace when sayed provides)

```dart
// in quick_contact.dart
const _kWhatsAppNumber = '201000000000';
const _kPhoneNumber = '+201000000000';
const _kEmail = 'support@gameaty.app';
```

---

## 11. GetIt Service — Full Registration Order

```
Dio (with BaseOptions ✅) → ApiService
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
  → SaveStudentInfoUseCase → UpdatePasswordUseCase → GetMeUseCase → UploadAvatarUseCase ✅ NEW
→ ProfileCubit (singleton) — reuses GetMeUseCase, SaveStudentInfoUseCase, UpdatePasswordUseCase, UploadAvatarUseCase ✅
→ FaheemRemoteDataSource → FaheemRepo → SendMessageUseCase → FaheemCubit (from prior session)
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

`scientificDepartment` now sent as `null` (key omitted) when study section is "أدبي" — confirmed and fixed this session (see §7).

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

`TermsAndConditionsSheet` = thin static wrapper → backward compat with auth flow.

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

- **Backend Bug — Fav Pagination:** same items regardless of cursor → deduplication in `FavCubit.loadMore()` (waiting on sayed)
- **Search Debounce:** not implemented — every keystroke triggers search (next up, in progress)
- **`withOpacity` deprecated:** works but newer Flutter suggests `.withValues(alpha:...)`
- **`RecommendedRemoteDataSource`:** temporarily uses `getTrendingUnis` endpoint
- **Auth — duplicate-email-unverified edge case:** needs sayed conversation
- **Faheem History:** no backend endpoint yet — screen is UI-only
- **`current_password` for update-Password:** field removed from UI — needs sayed to add param
- **Real contact info:** dummy data in `quick_contact.dart` — needs sayed to provide

**Resolved this session (moved out of pending):**
- ~~Avatar dialog tap interaction~~ → ✅ fully built and working (see §6)
- ~~Avatar upload endpoint~~ → ✅ done: `POST /api/auth/addAvatar`
- ~~`scientific_department` null vs `''`~~ → ✅ confirmed: omit the key entirely (see §7)
- ~~Home AppBar not loading on cold start~~ → ✅ fixed via `MainView.initState()` (see §8)
- ~~mailto/tel not working on real device~~ → ✅ fixed via AndroidManifest `<queries>` (see §9)

---

## 19. All Decisions Made

| Decision | Reason |
|---|---|
| `apiService.postFormData()` for file uploads | New dedicated multipart method on ApiService — interceptor still fires (same `dio` instance) |
| `Dio()` given explicit `BaseOptions` | Was unlimited/unclear timeouts — added for clearer error diagnosis on uploads |
| `maxWidth`/`maxHeight: 1024` on avatar `pickImage()` | Fixes `413 Request Entity Too Large` from nginx + `DioExceptionType.unknown` connection drops on large camera/gallery photos |
| `_isPicking` guard around full avatar tap→pick→upload flow | Fast double-tap during picker's own async gap threw `PlatformException(already_active)` |
| `ProfileCubit.uploadAvatar()` emits no intermediate loading state | Avoids blanking `CustomHomeAppBar` (same singleton cubit) while avatar screen is mid-upload; local `_isUploading` bool in `AvatarProfile` handles UI instead |
| Avatar upload auto-triggers on pick (no separate "save" button) | Single-purpose action, consistent with how document upload cards work |
| Avatar upload failure reverts to last known server avatar | Confirmed UX with user — local preview cleared on both success and failure paths |
| `getMe()` called automatically after successful avatar upload | Server response has no avatar URL — `getMe()` is the only way to get the new URL, and it refreshes everywhere (Home AppBar included) for free |
| `scientific_department` key omitted (not `null`/`''`) when absent | Confirmed via direct Postman testing — backend 422s on both `null` and `''` |
| `getIt<ProfileCubit>().getMe()` added to `MainView.initState()` | Was never called on cold start — only via Profile screen visit — Home AppBar name/avatar were blank until first Profile visit |
| `<queries>` entries added for `mailto`/`tel` schemes | Android 11+ package visibility restrictions block `canLaunchUrl()` without explicit declaration |
| `FavCubit` → `registerSingleton` | Single instance across app |
| No try/catch in data sources | Repos handle errors |
| `DioException` caught in repos directly | Removed `CustomExceptions` middle layer |
| `NoInternetWidget` for full-screen failures | Better UX |
| Single `ProfileCubit` for 3 screens (now 4 incl. avatar) | Same object of work |
| `kGovernorates` in root `constants.dart` | Shared between auth + profile |
| `AgeField` in `core/widgets/` | Used by auth/setup and profile/personal_data |
| Logout → `LogoutConfirmationSheet` | Confirmation before execute |
| `LegalSheet` as shared widget | Terms + Privacy share identical structure |
| `TermsAndConditionsSheet` as thin wrapper | Backward compat with auth flow |
| No-op save guard via snapshot | 5 `_original*` vars + `_hasChanges()` |
| `logout()` in `ProfileCubit` | Only GetIt singleton owning session state |
| Code comments English-only | Hard rule |
| SnackBar over Toast | Cleaner UX |

---

## 20. Session Summaries — تاريخي

**جلسة: Auth Polish + UX Fixes**
**جلسة: Splash + Onboarding + 401 Interceptor + Validator Fixes**
**جلسة: 401 SnackBar Debug + Notifications Trigger Cleanup**
**جلسة: 401 Double-SnackBar Diagnosis + Fix**
**جلسة: Profile API Integration — kickoff**
**جلسة: Profile Feature — all open items** (401 ordering, no-op guard, home AppBar wiring, logout, contact us, legal sheet)
**جلسة: Faheem Feature — full integration** (separate chat — domain/data/cubit/view, GetIt chain, scroll pattern)

**جلسة: mailto fix + Home AppBar fix + scientific_department bug fix + Avatar Upload (هذه الجلسة)**
1. **mailto/tel bug** — diagnosed as Android 11+ package visibility restriction, not a code/url_launcher bug. Fixed via `AndroidManifest.xml` `<queries>` additions for `mailto`/`tel` schemes.
2. **Home AppBar cold-start bug** — `ProfileCubit.getMe()` was never called on app start. Added to `MainView.initState()`.
3. **scientific_department bug (two instances)** — backend confirmed via Postman: key must be omitted entirely (not `null`/`''`) when no department applies. Fixed in `personal_data_view_body.dart` (was sending `''`) AND `setup_view_body.dart` (was sending a real value unconditionally — worse bug, found while tracing the first fix). 8 files updated end-to-end (`String` → `String?` for `scientificDepartment` param).
4. **Avatar upload — full feature, built and confirmed working.** `POST /auth/addAvatar` multipart endpoint confirmed live by sayed. Built `AvatarUploadSheet`, rebuilt `AvatarProfile` as StatefulWidget, added `ApiService.postFormData()`, `UploadAvatarUseCase`, `ProfileCubit.uploadAvatar()`. Debugged through 3 real-device errors (`already_active` PlatformException, `413` nginx limit, `DioExceptionType.unknown`) down to root causes (concurrent picker calls; oversized images) and fixed both with `_isPicking` guard + `maxWidth`/`maxHeight` caps + explicit `Dio` `BaseOptions`. User confirmed working; debug prints removed.
5. Next up: **Search Debounce** (500ms) — file requested from user, in progress at session's end.