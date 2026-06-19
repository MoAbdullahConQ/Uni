# Claude Memory File — Archive / Reference (Gameaty)
> Last updated: June 2026 (session: Profile Feature — all open items closed except avatar dialog)

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
│   │   ├── api_service.dart            (401 interceptor with _isHandlingUnauthorized guard)
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
│       ├── custom_text_form_field.dart  (added `enabled` param for read-only fields)
│       ├── age_field.dart               (moved from auth — shared between auth/setup and profile/personal_data)
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
│       ├── terms_and_conditions_sheet.dart  ✅ now a thin wrapper over LegalSheet — auth flow unchanged
│       └── legal_sheet.dart                 ✅ NEW — shared DraggableScrollableSheet for Terms + Privacy Policy
└── features/
    ├── browse/ ... (done)
    ├── search/ ... (done — debounce still pending)
    ├── fav/ ... (done)
    ├── guide/ ... (done)
    ├── notifications/ ... (done, stable)
    ├── home/
    │   └── presentation/views/widgets/custom_home_app_bar.dart  ✅ wired to ProfileCubit this session
    ├── auth/ ... (done)
    │   └── presentation/views/widgets/
    │       ├── login_view_body.dart     (reads session-expired message from ModalRoute arguments)
    │       ├── setup_view_body.dart     (uses AgeField from core/widgets)
    │       ├── setup_governorate_dropdown.dart  (imports kGovernorates from constants.dart)
    │       └── terms_and_conditions.dart  (calls TermsAndConditionsSheet.show() — unchanged, works via wrapper)
    ├── splash/ ... (done)
    ├── on_boarding/ ... (done)
    ├── uni_detail/ ... (done)
    ├── profile/  ✅ MOSTLY DONE — one open item: avatar dialog
    │   ├── domain/ — reuses auth's GetMeUseCase, SaveStudentInfoUseCase, UpdatePasswordUseCase
    │   └── presentation/
    │       ├── manager/profile_cubit/
    │       │   ├── profile_cubit.dart  (added logout() this session)
    │       │   └── profile_state.dart
    │       └── views/widgets/
    │           ├── profile_view_body.dart            (wired LogoutConfirmationSheet this session)
    │           ├── personal_data_view_body.dart       (401 fix + no-op guard this session)
    │           ├── security_view_body.dart            (401 fix this session)
    │           ├── password_section.dart
    │           ├── governorate_dropdown.dart
    │           ├── stats_section.dart
    │           ├── documents_section.dart
    │           ├── personal_data_document_upload_card.dart
    │           ├── profile_avatar_section.dart
    │           ├── profile_logout_button.dart         (accepts onPressed — wired this session)
    │           ├── personal_data_interests_selector.dart  (UI-only)
    │           ├── avatar_profile.dart                (tap interaction still undefined — OPEN ITEM)
    │           ├── logout_confirmation_sheet.dart      ✅ NEW this session
    │           ├── contact_us_view_body.dart           ✅ fully interactive this session
    │           ├── quick_contact.dart                  ✅ url_launcher wired (dummy data)
    │           ├── message_form_section.dart           ✅ StatefulWidget + clear-on-submit
    │           ├── footer.dart                         ✅ both buttons open LegalSheet
    │           ├── topic_dropdown.dart                 (fixed generic type T → String)
    │           ├── details_field.dart                  (accepts external controller)
    │           ├── robot_section.dart
    │           ├── contact_us_channel_card.dart
    │           ├── role_badge.dart, profile_header.dart, profile_menu_item.dart,
    │           │   profile_menu_section.dart, version_info.dart  (unchanged)
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

### UserEntity (updated prior session)
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

### StudentInfoEntity (new prior session)
```dart
class StudentInfoEntity {
  final String studySection;          // Arabic from GetMe, English expected by SaveStudentInfo
  final String scientificDepartment;
  final int governorateId;
  final double percentage;
  final int age;
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
}
```

**401 SnackBar ordering rule (finalized this session):** any cubit failure listener that shows a SnackBar must first check:
```dart
if (state.errMessage.toLowerCase().contains('unauthenticated')) return;
```
Applied to `SaveStudentInfoFailure` and `UpdatePasswordFailure`. Root cause: the repo's `try/catch` catches the `DioException` before the interceptor redirects — cubit emits `Failure` state first, then interceptor fires. The early return prevents the wrong SnackBar from showing.

---

## 5. Auth Flows (confirmed and working)

**Register flow:** SignUpView → register → OtpView → verifyOtp → save token to Prefs → SetupView → saveStudentInfo → MainView

**Forgot password flow:** ForgotPasswordView → forgetPassword → OtpView → verifyOtp (NOT saved to Prefs) → ResetPasswordView(tempToken) → resetPassword → LoginView

**Login flow:** LoginView → login → MainView

**401 / session expired flow:** interceptor → guard check → Prefs.remove('token') → pushNamedAndRemoveUntil(LoginView, arguments: message) → LoginViewBody reads via ModalRoute arguments

**Logout flow (finalized this session):**
1. User taps logout button → `LogoutConfirmationSheet.show()` appears
2. User taps "أيوه" → `ProfileCubit.logout()` called
3. `logout()` clears token + refresh_token + `_currentUser` → `navigatorKey.pushNamedAndRemoveUntil(LoginView)`
4. No session-expired message shown (clean logout, not expired)

---

## 6. ProfileCubit — Full Design

```dart
class ProfileCubit extends Cubit<ProfileState> {
  final GetMeUseCase getMeUseCase;
  final SaveStudentInfoUseCase saveStudentInfoUseCase;
  final UpdatePasswordUseCase updatePasswordUseCase;

  UserEntity? _currentUser;
  UserEntity? get currentUser => _currentUser;

  Future<void> getMe() async { ... }

  Future<void> saveStudentInfo({...}) async {
    emit(SavingStudentInfo());
    // on success: emit StudentInfoSaved() then await getMe() to refresh
  }

  Future<void> updatePassword({...}) async {
    emit(UpdatingPassword());
    // on success: emit PasswordUpdated()
  }

  // added this session — lives here because ProfileCubit is the only
  // GetIt singleton that owns user-session state
  Future<void> logout() async {
    await Prefs.remove('token');
    await Prefs.remove('refresh_token');
    _currentUser = null;
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      LoginView.routeName,
      (route) => false,
    );
  }
}
```

**States:** `ProfileInitial`, `ProfileLoading`, `ProfileSuccess(UserEntity)`, `ProfileFailure(String)`, `SavingStudentInfo`, `StudentInfoSaved`, `SaveStudentInfoFailure(String)`, `UpdatingPassword`, `PasswordUpdated`, `UpdatePasswordFailure(String)`

---

## 7. PersonalDataViewBody — No-op Guard (new this session)

```dart
// snapshot saved in _populateFromUser()
String? _originalStudyCategory;
String? _originalStudyTrack;
int? _originalGovernorateId;
String? _originalPercentage;
String? _originalAge;

bool _hasChanges() {
  return _originalStudyCategory != studyCategory ||
      _originalStudyTrack != studyTrack ||
      _originalGovernorateId != selectedGovernorateId ||
      _originalPercentage != _percentageController.text ||
      _originalAge != _ageController.text;
}

// in _submit(), before validation:
if (!_hasChanges()) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('لم تقم بتغيير أي بيانات')),
  );
  return;
}
```

---

## 8. LegalSheet — Structure (new this session)

```dart
// in core/widgets/legal_sheet.dart
class LegalSheet extends StatelessWidget {
  static void show(BuildContext context, {required String title, required List<LegalSection> sections}) { ... }
}

class LegalSection {
  const LegalSection({required this.title, required this.body});
  final String title;
  final String body;
}

// content constants (also in legal_sheet.dart):
const kTermsSections = [ ... ];   // 7 sections
const kPrivacySections = [ ... ]; // 7 sections — written this session
```

`TermsAndConditionsSheet` in `core/widgets/` is now a thin static wrapper:
```dart
class TermsAndConditionsSheet {
  static void show(BuildContext context) {
    LegalSheet.show(context, title: 'الشروط والأحكام', sections: kTermsSections);
  }
}
```
Auth's `terms_and_conditions.dart` unchanged — still calls `TermsAndConditionsSheet.show()`.

---

## 9. QuickContact — Dummy Data (replace when sayed provides)

```dart
// in quick_contact.dart
const _kWhatsAppNumber = '201000000000';
const _kPhoneNumber = '+201000000000';
const _kEmail = 'support@gameaty.app';
```

`mailto:` warning (`component name is null`) on real device = no default mail app set. Not a code bug.

---

## 10. GetIt Service — Full Registration Order

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
→ ProfileCubit (singleton) — reuses GetMeUseCase, SaveStudentInfoUseCase, UpdatePasswordUseCase
```

---

## 11. PersonalDataViewBody — Arabic↔Backend Mapping

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

`scientificDepartment` sent as `''` when study section is "أدبي" — pending sayed confirmation on whether `null` is required.

---

## 12. Error Handling Pattern

```
DioException → propagates from data source → caught in repo → left(ServerFailure.fromDioError(e))
→ cubit: result.fold(failure → emit FailureState, ...)
→ UI: if errMessage contains 'unauthenticated' → return early (interceptor handles it)
     else → show SnackBar or error widget
```

---

## 13. Error UI Rules

| Situation | Widget |
|---|---|
| Full-screen failure في pushed screen | `NoInternetWidget` مع `onRetry` و `onBack: () => Navigator.pop(context)` |
| Full-screen failure في tab | `NoInternetWidget` مع `onRetry` بس |
| Inline failure في وسط صفحة | `CustomErrorWidget` مع `onRetry` |
| Pagination failure | `CustomErrorWidget` inline أسفل اللست مع `onRetry: loadMore` |
| Empty list | `EmptyStateWidget` |
| Transient success message | `SnackBar` (not Toast) |
| 401 during any write action | return early in listener — interceptor handles redirect |

---

## 14. AppColors

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

## 15. Known Bugs & Pending Issues (current)

- **Backend Bug — Fav Pagination:** same items regardless of cursor → deduplication in `FavCubit.loadMore()`
- **Search Debounce:** not implemented — every keystroke triggers search
- **`withOpacity` deprecated:** works but newer Flutter suggests `.withValues(alpha:...)`
- **`RecommendedRemoteDataSource`:** temporarily uses `getTrendingUnis` endpoint
- **Auth — duplicate-email-unverified edge case:** needs sayed conversation
- **Faheem `/aiChat/send`:** waiting on backend — ask sayed next session
- **Avatar dialog:** tap interaction undefined — needs clarification before building
- **`scientific_department` when "أدبي":** sends `''` — needs sayed confirmation on `null` vs `''`
- **`current_password` for update-Password:** field removed from UI — needs sayed to add param
- **Real contact info:** dummy data in `quick_contact.dart` — needs sayed to provide
- **Avatar upload:** no endpoint yet — deferred

---

## 16. All Decisions Made

| Decision | Reason |
|---|---|
| `FavCubit` → `registerSingleton` | Single instance across app |
| No try/catch in data sources | Repos handle errors |
| `DioException` caught in repos directly | Removed `CustomExceptions` middle layer |
| `NoInternetWidget` for full-screen failures | Better UX |
| `url_launcher` for website | Lightweight, opens external browser |
| No `AuthEntity` | Tokens never appear in UI |
| `verifyOtp` returns `String` (token) | Same endpoint serves two flows |
| `resetPassword` takes `tempToken` param | No active session during forgot-password flow |
| `ApiService.postWithToken()` added | Override Authorization for one-off temp-token call |
| 401 interceptor concurrent-redirect guard | Prevents double SnackBar from parallel failing requests |
| **401 SnackBar ordering fix** | Failure listeners check for 'unauthenticated' and return early |
| Single `ProfileCubit` for 3 screens | Same object of work — consistent with AuthCubit covering 5 screens |
| `kGovernorates` in root `constants.dart` | Single shared source for auth + profile |
| `AgeField` moved to `core/widgets/` | Used by both auth/setup and profile/personal_data |
| `CustomTextFormField` `enabled` param | Read-only display for name/email (no update-profile endpoint) |
| `favorite_universities` NOT mapped into `UserEntity` | Fav feature owns this data already |
| Current-password field removed from security screen | No endpoint param, not connected to controller |
| `image_picker` added | Real gallery pick/preview/clear for document cards |
| Avatar upload deferred | No backend endpoint yet |
| "الشعبة العلمية" shown conditionally | Only when study section is "علمي" |
| `scientificDepartment` sent as `''` when "أدبي" | Pending sayed confirmation |
| **No-op save guard via snapshot** | 5 `_original*` vars + `_hasChanges()` — no local DB needed |
| **`logout()` in `ProfileCubit`** | Only GetIt singleton owning session state — avoids promoting AuthCubit to singleton |
| **`LogoutConfirmationSheet` as bottom sheet** | More natural on mobile than center dialog; consistent with Terms & Conditions pattern |
| **`LegalSheet` as shared widget in `core/widgets/`** | Terms + Privacy share identical structure — avoid duplication |
| **`TermsAndConditionsSheet` as thin wrapper** | Backward compat with auth flow — no changes needed in auth screens |
| **`MessageFormSection` validator removed from name field** | Manual check in `_submit()` prevents focus-jump after `formKey.reset()` |
| **`formKey.reset()` before `controller.clear()`** | Correct order to fully clear form without re-triggering focus |
| **No password no-op guard** | Current password not available in UI — backend handles duplicate-password rejection |
| Code comments English-only | Hard rule |
| SnackBar over Toast | Cleaner UX |
| Every `onGenerateRoute` case passes `settings: settings` | Prevents arguments from being dropped |
| `pushNamedAndRemoveUntil` for logout/401 | Full stack clear — no back navigation to authenticated screens |

---

## 17. Session Summaries — تاريخي

**جلسة: Auth Polish + UX Fixes** — register/login flow, StudyTypeSelector, Terms sheet, validation fixes

**جلسة: Splash + Onboarding + 401 Interceptor + Validator Fixes** — splash, onboarding, first 401 interceptor, OTP/password UX

**جلسة: 401 SnackBar Debug + Notifications Trigger Cleanup** — root cause: missing `settings: settings` in routes. Removed global `pendingSnackBarMessage`. Notifications trigger cleanup.

**جلسة: 401 Double-SnackBar Diagnosis + Fix** — concurrent 401s from `getNotifications()` (list + unread count). Fixed with `_isHandlingUnauthorized` guard.

**جلسة: Profile API Integration — kickoff** — `ProfileCubit`, `StudentInfoEntity`, `UserEntity` update, `kGovernorates` to constants, `AgeField` to core, personal_data/security/profile screens wired

**جلسة: Profile Feature — all open items (this session)**
1. **401 SnackBar ordering** — diagnosed via logs: repo catch fires before interceptor redirect. Fix: early return in listener if `'unauthenticated'` in errMessage. Applied to `SaveStudentInfoFailure` + `UpdatePasswordFailure`.
2. **No-op save guard** — snapshot vars + `_hasChanges()`. Decided against local DB (overkill). Password screen doesn't need it (backend handles).
3. **Home AppBar** — `CustomHomeAppBar` wired to `ProfileCubit` via `getIt`, `buildWhen` limits rebuilds.
4. **Logout** — `ProfileCubit.logout()` + `LogoutConfirmationSheet` (bottom sheet, robot SVG, "أيوه"/"لا خلاص").
5. **Contact Us** — fully interactive: `QuickContact` with `url_launcher`, `MessageFormSection` as StatefulWidget, `LegalSheet` shared widget, `TermsAndConditionsSheet` as wrapper, `Footer` wired, Privacy Policy written from scratch.
6. **Avatar dialog** — still open, behavior not yet clarified.