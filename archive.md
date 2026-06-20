# Claude Memory File — Archive / Reference (Gameaty)
> Last updated: June 2026 (session: Faheem Feature — full integration done)

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
│   │   ├── get_it_service.dart         ✅ updated this session — Faheem chain added
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
│   │   └── backend_endpoints.dart      ✅ updated this session — added sendMessage
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
│       ├── custom_text_form_field.dart
│       ├── age_field.dart
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
    ├── search/ ... (done — debounce pending)
    ├── fav/ ... (done)
    ├── guide/ ... (done)
    ├── notifications/ ... (done)
    ├── home/
    │   └── presentation/views/widgets/custom_home_app_bar.dart  (wired to ProfileCubit)
    ├── auth/ ... (done)
    ├── splash/ ... (done)
    ├── on_boarding/ ... (done)
    ├── uni_detail/ ... (done)
    ├── profile/  (MOSTLY DONE — avatar dialog open)
    │   └── presentation/views/widgets/
    │       ├── avatar_profile.dart            (tap interaction still undefined — OPEN ITEM)
    │       └── ... (all other widgets done)
    └── faheem/  ✅ DONE this session
        ├── domain/
        │   ├── entities/
        │   │   ├── chat_message_entity.dart   (MessageSender enum, isTyping flag, uniCards support)
        │   │   ├── chat_history_entity.dart
        │   │   └── suggestion_item_entity.dart
        │   ├── repos/
        │   │   └── faheem_repo.dart            ✅ NEW
        │   └── use_cases/
        │       └── send_message_use_case.dart  ✅ NEW
        ├── data/
        │   ├── models/
        │   │   └── faheem_message_model.dart   ✅ NEW — fromJson maps 'content' field
        │   ├── data_sources/
        │   │   └── faheem_remote_data_source.dart  ✅ NEW — uses apiService.dio.post + FormData
        │   └── repos/
        │       └── faheem_repo_impl.dart       ✅ NEW
        └── presentation/
            ├── manager/faheem_cubit/
            │   ├── faheem_cubit.dart           ✅ NEW
            │   └── faheem_state.dart           ✅ NEW
            └── views/widgets/
                ├── faheem_chat_view_body.dart  ✅ UPDATED — BlocConsumer + reverse scroll
                ├── chat_messages_list.dart     ✅ UPDATED — reverse: true + reversed list
                ├── user_message_bubble.dart    ✅ UPDATED — avatar from ProfileCubit via GetIt
                ├── faheem_history_view_body.dart  (UI-only — no backend endpoint yet)
                └── ... (all other widgets unchanged)
```

---

## 2. Core Entities

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
  final String studySection;
  final String scientificDepartment;
  final int governorateId;
  final double percentage;
  final int age;
}
```

### ChatMessageEntity
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
  // ... (all existing endpoints)
  // Faheem AI Chat
  static const String sendMessage = '/aiChat/send';
}
```

---

## 4. ApiService — Current State

```dart
class ApiService {
  final Dio dio;
  bool _isHandlingUnauthorized = false;
  // interceptor adds Accept, Api-Key, Authorization headers
  // 401 → guard check → Prefs.remove('token') → pushNamedAndRemoveUntil(LoginView, arguments: message)
}
```

**Note:** `apiService.post()` accepts only `Map<String, dynamic>`. For `FormData` (e.g. Faheem), use `apiService.dio.post()` directly — the interceptor still fires because it's on the `dio` instance.

---

## 5. FaheemCubit — Full Design

```dart
class FaheemCubit extends Cubit<FaheemState> {
  final SendMessageUseCase sendMessageUseCase;
  final List<ChatMessageEntity> _messages = [];
  List<ChatMessageEntity> get messages => List.unmodifiable(_messages);

  Future<void> sendMessage(String text) async {
    // 1. add user message
    // 2. add typing indicator (isTyping: true)
    // 3. emit FaheemSending(List.from(_messages))
    // 4. await API
    // 5. remove typing indicator
    // 6. fold: success → add faheem message → emit FaheemMessageReceived
    //          failure → emit FaheemSendFailure(messages, errMessage)
  }
}
```

**States:**
- `FaheemInitial`
- `FaheemSending(List<ChatMessageEntity> messages)`
- `FaheemMessageReceived(List<ChatMessageEntity> messages)`
- `FaheemSendFailure({List<ChatMessageEntity> messages, String errMessage})`

---

## 6. Faheem Scroll Pattern (finalized this session)

`ChatMessagesList` uses `reverse: true` + `messages.reversed.toList()` — the latest message is always at the bottom without any scroll-on-open code.

For new messages (listener): `_scrollController.jumpTo(minScrollExtent)` — because with `reverse: true`, bottom = `minScrollExtent`.

`FaheemCubit` is NOT in `MultiBlocProvider` in `main.dart` — taken from GetIt directly in `FaheemChatViewBody` via `getIt<FaheemCubit>()`.

---

## 7. GetIt Registration Order (full)

```
Dio → ApiService
→ TrendingRemoteDataSource → TrendingCubit
→ RecommendedRemoteDataSource
→ BrowseRemoteDataSource → BrowseRepo → GetUnisUseCase
→ FavRemoteDataSource → FavRepo → 3 use cases → FavCubit
→ SearchRemoteDataSource → SearchRepo → SearchUnisUseCase → GetSpecialtiesUseCase
→ NotificationsRemoteDataSource → NotificationsRepo → 4 use cases → NotificationsCubit
→ GuideRemoteDataSource → GuideRepo → GetArticlesUseCase → GuideCubit
→ UniDetailRemoteDataSource → UniDetailRepo → GetUniDetailUseCase
→ AuthRemoteDataSource → AuthRepo → 9 use cases (Login/Register/VerifyOtp/ForgetPassword/ResendOtp/ResetPassword/SaveStudentInfo/UpdatePassword/GetMe)
→ ProfileCubit (singleton) — reuses GetMe + SaveStudentInfo + UpdatePassword
→ FaheemRemoteDataSource → FaheemRepo → SendMessageUseCase → FaheemCubit ✅ NEW
```

---

## 8. Auth Flows

**Register:** SignUpView → register → OtpView → verifyOtp → save token → SetupView → saveStudentInfo → MainView  
**Forgot password:** ForgotPasswordView → forgetPassword → OtpView → verifyOtp (NOT saved) → ResetPasswordView(tempToken) → resetPassword → LoginView  
**Login:** LoginView → login → MainView  
**401:** interceptor → guard → Prefs.remove('token') → pushNamedAndRemoveUntil(LoginView, arguments: message)  
**Logout:** LogoutConfirmationSheet → ProfileCubit.logout() → clear tokens + _currentUser → pushNamedAndRemoveUntil(LoginView)

---

## 9. ProfileCubit Design

```dart
class ProfileCubit extends Cubit<ProfileState> {
  UserEntity? _currentUser;
  UserEntity? get currentUser => _currentUser;
  Future<void> getMe() async { ... }
  Future<void> saveStudentInfo({...}) async { ... }
  Future<void> updatePassword({...}) async { ... }
  Future<void> logout() async {
    await Prefs.remove('token');
    await Prefs.remove('refresh_token');
    _currentUser = null;
    navigatorKey.currentState?.pushNamedAndRemoveUntil(LoginView.routeName, (route) => false);
  }
}
```

**States:** `ProfileInitial`, `ProfileLoading`, `ProfileSuccess(UserEntity)`, `ProfileFailure(String)`, `SavingStudentInfo`, `StudentInfoSaved`, `SaveStudentInfoFailure(String)`, `UpdatingPassword`, `PasswordUpdated`, `UpdatePasswordFailure(String)`

---

## 10. PersonalDataViewBody — No-op Guard

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

## 11. LegalSheet

```dart
class LegalSheet extends StatelessWidget {
  static void show(BuildContext context, {required String title, required List<LegalSection> sections}) { ... }
}
// kTermsSections + kPrivacySections (7 sections each) defined in legal_sheet.dart
```

`TermsAndConditionsSheet` = thin static wrapper → backward compat with auth flow.

---

## 12. QuickContact — Dummy Data

```dart
const _kWhatsAppNumber = '201000000000';
const _kPhoneNumber = '+201000000000';
const _kEmail = 'support@gameaty.app';
```
Replace when sayed provides real info.

---

## 13. Error Handling Pattern

```
DioException → propagates from data source → caught in repo → left(ServerFailure.fromDioError(e))
→ cubit: result.fold(failure → emit FailureState, ...)
→ UI: if errMessage contains 'unauthenticated' → return early
     else → show SnackBar or error widget
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
| 401 during any write action | return early in listener — interceptor handles redirect |

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

## 16. Known Bugs & Pending Issues

- **Backend Bug — Fav Pagination:** same items regardless of cursor → deduplication in `FavCubit.loadMore()`
- **Search Debounce:** not implemented — every keystroke triggers search
- **`withOpacity` deprecated:** works but newer Flutter suggests `.withValues(alpha:...)`
- **`RecommendedRemoteDataSource`:** temporarily uses `getTrendingUnis` endpoint
- **Auth — duplicate-email-unverified edge case:** needs sayed conversation
- **Faheem History:** no backend endpoint yet — screen is UI-only
- **Avatar dialog:** tap interaction undefined — needs clarification before building
- **`scientific_department` when "أدبي":** sends `''` — needs sayed confirmation
- **`current_password` for update-Password:** field removed from UI
- **Real contact info:** dummy data in `quick_contact.dart`
- **Avatar upload:** no endpoint yet

---

## 17. All Decisions Made

| Decision | Reason |
|---|---|
| `apiService.dio.post()` for Faheem | `apiService.post()` only accepts `Map`, not `FormData`. Interceptor still fires on `dio` instance. |
| `reverse: true` in ChatMessagesList | Eliminates scroll-on-open complexity — list always starts at bottom |
| `jumpTo(minScrollExtent)` for new messages | With `reverse: true`, bottom = minScrollExtent |
| `uniCards` content type kept | Backend may return cards in the future |
| `FaheemCubit` NOT in MultiBlocProvider | Taken from GetIt directly — no broadcast needed |
| Faheem API is request/response (not streaming) | Backend returns full answer in one shot |
| User avatar in `UserMessageBubble` from `ProfileCubit` via GetIt | Single source of truth — same pattern as `CustomHomeAppBar` |
| `FavCubit` → `registerSingleton` | Single instance across app |
| No try/catch in data sources | Repos handle errors |
| `DioException` caught in repos directly | Removed `CustomExceptions` middle layer |
| `NoInternetWidget` for full-screen failures | Better UX |
| Single `ProfileCubit` for 3 screens | Same object of work |
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

## 18. Session Summaries — تاريخي

**جلسة: Auth Polish + UX Fixes**
**جلسة: Splash + Onboarding + 401 Interceptor + Validator Fixes**
**جلسة: 401 SnackBar Debug + Notifications Trigger Cleanup**
**جلسة: 401 Double-SnackBar Diagnosis + Fix**
**جلسة: Profile API Integration — kickoff**
**جلسة: Profile Feature — all open items** (401 ordering, no-op guard, home AppBar, logout, contact us, legal sheet)

**جلسة: Faheem Feature — full integration (هذه الجلسة)**
1. Confirmed `POST /aiChat/send` endpoint is live (form-data, returns `{role, content}`)
2. Built full layer: domain → data → cubit → view
3. Converted `FaheemChatViewBody` from setState → BlocConsumer
4. Fixed scroll-to-bottom with `reverse: true` pattern
5. Added user avatar in `UserMessageBubble` from ProfileCubit
6. Registered full Faheem chain in GetIt
7. Clarified: API is request/response not streaming; `apiService.dio.post()` correct for FormData