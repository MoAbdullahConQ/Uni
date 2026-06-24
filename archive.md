# Claude Memory File — Archive / Reference (Gameaty)
> Last updated: June 2026 (session: Faheem History — full backend integration)

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
│   │   └── backend_endpoints.dart      (getConversations + getConversationMessages added)
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
    ├── search/ ... (done — debounce ✅)
    ├── fav/ ... (done — pagination code confirmed correct)
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
    └── faheem/ ✅ FULLY DONE — chat + history fully integrated
        ├── domain/
        │   ├── entities/
        │   │   ├── chat_message_entity.dart
        │   │   ├── chat_history_entity.dart        (legacy dummy — no longer used in UI)
        │   │   ├── conversation_entity.dart         (NEW)
        │   │   ├── conversation_message_entity.dart (NEW)
        │   │   └── conversation_details_entity.dart (NEW)
        │   ├── repos/faheem_repo.dart
        │   └── use_cases/
        │       ├── send_message_use_case.dart       (updated — conversationId optional param)
        │       ├── get_conversations_use_case.dart  (NEW)
        │       └── get_conversation_messages_use_case.dart (NEW)
        ├── data/
        │   ├── data_sources/faheem_remote_data_source.dart  (updated)
        │   ├── models/
        │   │   ├── faheem_message_model.dart        (updated — reads conversation_id + response.content)
        │   │   ├── conversation_model.dart          (NEW)
        │   │   ├── conversation_message_model.dart  (NEW)
        │   │   └── conversation_details_model.dart  (NEW)
        │   └── repos/faheem_repo_impl.dart          (updated)
        └── presentation/
            ├── manager/faheem_cubit/
            │   ├── faheem_cubit.dart   (updated — _currentConversationId, loadConversations, loadConversationMessages, startNewConversation)
            │   └── faheem_state.dart   (updated — 6 new states for history)
            └── views/widgets/
                ├── faheem_chat_view_body.dart        (updated — handles history open + new chat)
                ├── faheem_history_view_body.dart     (updated — real data + grouping + search + FAB)
                ├── chat_history_card.dart            (updated — uses ConversationEntity)
                └── chat_history_group_section.dart  (updated — uses ConversationEntity)
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

### ConversationEntity (faheem history)
```dart
class ConversationEntity {
  final int id;
  final String title;
  final DateTime createdAt;
}
```

### ConversationMessageEntity (faheem history detail)
```dart
class ConversationMessageEntity {
  final int id;
  final int conversationId;
  final String message;
  final String reply;
  final DateTime createdAt;
}
```

### ConversationDetailsEntity (faheem history detail)
```dart
class ConversationDetailsEntity {
  final int id;
  final String title;
  final List<ConversationMessageEntity> messages;
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
  // Faheem AI Chat
  static const String sendMessage = '/aiChat/send';
  static const String getConversations = '/aiChat/getConversations';
  static String getConversationMessages(int id) => '/aiChat/messages/$id';
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
→ FaheemRemoteDataSource → FaheemRepo
  → SendMessageUseCase → GetConversationsUseCase → GetConversationMessagesUseCase
  → FaheemCubit (singleton)
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

- **`withOpacity` deprecated:** works but newer Flutter suggests `.withValues(alpha:...)`
- **`RecommendedRemoteDataSource`:** temporarily uses `getTrendingUnis` endpoint
- **Auth — duplicate-email-unverified edge case:** needs sayed conversation
- **Real contact info:** dummy data in `quick_contact.dart` — needs sayed to provide
- **Fav Pagination backend bug:** code correct — waiting on sayed

---

## 19. Release Build — Fixes & Decisions

### INTERNET Permission
Flutter debug adds `INTERNET` permission automatically. Release does **not**. Must be explicit in `AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.INTERNET" />
```

### `.env` in release
`pubspec.yaml` assets declaration is sufficient — no `aaptOptions` needed.

### App icon & name
- Icon: `flutter_launcher_icons` package, `dart run flutter_launcher_icons`
- Name: `android:label="جامعتي"` in `AndroidManifest.xml`

---

## 20. Search Debounce — Implementation

**File:** `search_view_body.dart`

```dart
void _onSearchChanged(String query) {
  _debounce?.cancel();
  _debounce = Timer(const Duration(milliseconds: 500), () {
    context.read<SearchCubit>().search(query: query, filter: searchFilterEntity);
  });
}
```

---

## 21. Faheem History — Full Integration (هذه الجلسة)

### Endpoints
| Endpoint | Method | Purpose |
|---|---|---|
| `/aiChat/send` | POST | إرسال رسالة — `message` + `conversation_id` (optional) |
| `/aiChat/getConversations` | GET | قائمة كل المحادثات (بدون pagination) |
| `/aiChat/messages/{id}` | GET | رسايل محادثة معينة (بدون pagination) |

### POST /aiChat/send — Response Structure
```json
{
  "conversation_id": 21,
  "response": {
    "role": "assistant",
    "content": "...",
    "refusal": null,
    "annotations": []
  }
}
```
- `conversation_id` في الـ root
- الـ reply في `response.content`

### Flow
**شات جديد:**
1. بعت بدون `conversation_id`
2. الـ response بيرجع `conversation_id` → الـ cubit يحتفظ بيه في `_currentConversationId`
3. كل رسالة بعد كده بتتبعت مع نفس الـ id

**فتح من الهستوري:**
1. `loadConversations()` → GET `/aiChat/getConversations`
2. يضغط محادثة → `loadConversationMessages(id)` → GET `/aiChat/messages/{id}`
3. كل `ConversationMessageEntity` بيتحول لـ رسالتين: user + faheem
4. `_currentConversationId` = id → أي رسالة جديدة تضاف لنفس الشات

### FaheemCubit — المتغيرات الجديدة
```dart
int? _currentConversationId;  // null = new chat, set after first message or when opening history

void startNewConversation()           // clears messages + resets _currentConversationId
Future<void> loadConversations()      // emits FaheemConversationsLoading/Success/Failure
void loadConversationMessages(int id) // emits FaheemConversationMessagesLoading/Success/Failure
```

### FaheemState — الـ States الجديدة
```dart
class FaheemConversationsLoading extends FaheemState {}
class FaheemConversationsSuccess extends FaheemState { final List<ConversationEntity> conversations; }
class FaheemConversationsFailure extends FaheemState { final String errMessage; }
class FaheemConversationMessagesLoading extends FaheemState {}
class FaheemConversationMessagesSuccess extends FaheemState { final List<ChatMessageEntity> messages; }
class FaheemConversationMessagesFailure extends FaheemState { final String errMessage; }
```

### History View Grouping
المحادثات بتتقسم: **اليوم / هذا الأسبوع / أقدم** حسب `createdAt`.

### ChatHistoryCard — timeLabel Logic
```
diff == 0  → HH:MM ص/م
diff == 1  → 'أمس'
diff < 7   → اسم اليوم بالعربي
else       → dd/mm/yyyy
```

### Decisions
| Decision | Reason |
|---|---|
| `conversation_id` يييجي في response من الباكند مباشرة | sayed عدل الـ response — مفيش حاجة لـ `getConversations` بعد أول رسالة |
| بدون pagination في getConversations و messages | sayed بيبعت الكل مرة واحدة |
| `startNewConversation()` بدل ما الـ cubit يعمل reset تلقائي | explict و واضح — الـ FAB في History يستدعيه |
| `ChatHistoryEntity` لسه موجودة في المشروع | legacy — مش بتستخدمها في UI بعد كده، لكن متشلتش لتجنب compile errors في ملفات تانية |

---

## 22. All Decisions Made

| Decision | Reason |
|---|---|
| `current_password` not needed for update-Password | Token presence = user is authenticated |
| `aaptOptions` NOT needed for `.env` in release | `pubspec.yaml` assets declaration sufficient |
| `INTERNET` permission must be explicit in release | Flutter debug adds it automatically; release does not |
| Search debounce 500ms via `Timer` in view body | Simple, no cubit changes needed |
| `flutter_launcher_icons` for app icon | Generates all density variants automatically |
| `android:label="جامعتي"` in AndroidManifest | Display name shown under icon on device |
| `apiService.postFormData()` for file uploads | Dedicated multipart method — interceptor still fires |
| `Dio()` given explicit `BaseOptions` | Clearer error diagnosis on uploads |
| `maxWidth`/`maxHeight: 1024` on avatar `pickImage()` | Fixes 413 nginx limit |
| `_isPicking` guard around full avatar tap flow | Prevents `PlatformException(already_active)` |
| `ProfileCubit.uploadAvatar()` emits no intermediate loading | Avoids blanking `CustomHomeAppBar` |
| `getMe()` auto-triggers after avatar upload | Server response has no URL |
| `scientific_department` key omitted when absent | Backend 422s on null or "" |
| `getIt<ProfileCubit>().getMe()` in `MainView.initState()` | Was never called on cold start |
| `<queries>` entries for `mailto`/`tel` | Android 11+ package visibility restrictions |
| Logout → `LogoutConfirmationSheet` | Confirmation before execute |
| `LegalSheet` as shared widget | Terms + Privacy share identical structure |
| No-op save guard via snapshot | 5 `_original*` vars + `_hasChanges()` |
| `logout()` in `ProfileCubit` | Only GetIt singleton owning session state |
| Code comments English-only | Hard rule |
| SnackBar over Toast | Cleaner UX |
| `conversation_id` from response not `getConversations` | sayed added it to response — cleaner, no extra call |
| No pagination for faheem history | sayed returns all at once |

---

## 23. Session Summaries — تاريخي

**جلسة: Auth Polish + UX Fixes**
**جلسة: Splash + Onboarding + 401 Interceptor + Validator Fixes**
**جلسة: 401 SnackBar Debug + Notifications Trigger Cleanup**
**جلسة: 401 Double-SnackBar Diagnosis + Fix**
**جلسة: Profile API Integration — kickoff**
**جلسة: Profile Feature — all open items** (401 ordering, no-op guard, home AppBar, logout, contact us, legal sheet)
**جلسة: Faheem Feature — full integration** (separate chat)
**جلسة: mailto fix + Home AppBar fix + scientific_department fix + Avatar Upload**
**جلسة: APK release + search debounce + release debug fixes**
**جلسة: Faheem History — full backend integration (هذه الجلسة) ✅**
1. تحليل الـ API endpoints الثلاثة مع sayed
2. sayed عدل response من `/aiChat/send` يرجع `conversation_id` في الـ root
3. بنينا كامل الـ domain + data + cubit + presentation للـ history
4. `FaheemMessageModel` يقرأ `conversation_id` من root و `content` من `response.content`
5. `FaheemCubit` يحتفظ بـ `_currentConversationId` ويستخدمه في كل رسالة بعد الأولى
6. History view: real data + grouping (اليوم/هذا الأسبوع/أقدم) + search + FAB لشات جديد
7. Opening history conversation → loads messages → converts to chat pairs → continues seamlessly
8. الباقي waiting on sayed: contact data + duplicate-email edge case + fav pagination