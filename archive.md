# Claude Memory File — Archive / Reference (Gameaty)
> Last updated: June 2026 (session: Trello Board Review + Backlog Planning)

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
│   │   ├── get_it_service.dart         (Dio gets BaseOptions, UploadAvatarUseCase registered, SpeechService registered)
│   │   ├── shared_preferences_singleton.dart
│   │   ├── custom_bloc_observer.dart
│   │   ├── database_service.dart      (abstract — unused)
│   │   └── speech_service.dart        ✅ DONE
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
│       ├── terms_and_conditions_sheet.dart
│       └── legal_sheet.dart
└── features/
    ├── browse/ ... (done)
    ├── search/ ... (done — debounce ✅)
    ├── fav/ ... (done — pagination code confirmed correct)
    ├── guide/ ... (done)
    ├── notifications/ ... (done, stable)
    ├── home/
    │   └── presentation/views/widgets/custom_home_app_bar.dart  (wired to ProfileCubit)
    ├── auth/ ... (done)
    │   └── presentation/views/widgets/
    │       ├── login_view_body.dart
    │       ├── setup_view_body.dart
    │       ├── setup_governorate_dropdown.dart
    │       └── terms_and_conditions.dart
    ├── splash/ ... (done)
    ├── on_boarding/ ... (done)
    ├── uni_detail/ ... (done)
    ├── profile/  ✅ FULLY DONE
    │   └── presentation/views/widgets/
    │       ├── profile_view_body.dart
    │       ├── personal_data_view_body.dart
    │       ├── security_view_body.dart
    │       ├── contact_us_view_body.dart
    │       ├── quick_contact.dart              (dummy data — replace when sayed provides)
    │       └── ... (all other profile widgets)
    └── faheem/ ✅ FULLY DONE — chat + history + mic/STT
        └── presentation/views/widgets/
            ├── faheem_chat_view_body.dart
            ├── faheem_history_view_body.dart
            ├── chat_history_card.dart
            ├── chat_history_group_section.dart
            └── chat_input_bar.dart             ✅ updated — uses SpeechService from GetIt
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
  final String studySection;
  final String scientificDepartment;
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

**Pattern:** tap → `AvatarUploadSheet` (camera/gallery) → `pickImage(maxWidth: 1024, maxHeight: 1024)` → local preview + dim + spinner → `ProfileCubit.uploadAvatar(File)` → on success, auto `getMe()` → SnackBar.

**Guards:** `_isPicking` + `_isUploading` locals in `AvatarProfile` state.

---

## 7. scientific_department — Confirmed Backend Behavior

| Sent | Result |
|---|---|
| Key omitted entirely | ✅ 200 |
| `""` | ❌ 422 |
| `null` (JSON) | ❌ 422 |
| Real value | ✅ 200 |

---

## 8. Home AppBar Cold-Start Fix

`getIt<ProfileCubit>().getMe()` added to `MainView.initState()`.

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
→ SpeechService (singleton)          ✅ DONE — initialize() called here, registered last
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

> ✅ Fav Pagination backend bug — **خلص** (sayed side)
> ✅ ChatInputBar mic animation lifecycle bug — **خلص** بـ `SpeechService` singleton

---

## 19. Release Build — Fixes & Decisions

### INTERNET Permission
Must be explicit in `AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.INTERNET" />
```

### `.env` in release
`pubspec.yaml` assets declaration is sufficient — no `aaptOptions` needed.

### App icon & name
- Icon: `flutter_launcher_icons` package
- Name: `android:label="جامعتي"` in `AndroidManifest.xml`

---

## 20. Search Debounce — Implementation

```dart
void _onSearchChanged(String query) {
  _debounce?.cancel();
  _debounce = Timer(const Duration(milliseconds: 500), () {
    context.read<SearchCubit>().search(query: query, filter: searchFilterEntity);
  });
}
```

---

## 21. Faheem History — Full Integration

### Endpoints
| Endpoint | Method | Purpose |
|---|---|---|
| `/aiChat/send` | POST | إرسال رسالة — `message` + `conversation_id` (optional) |
| `/aiChat/getConversations` | GET | قائمة كل المحادثات |
| `/aiChat/messages/{id}` | GET | رسايل محادثة معينة |

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

### FaheemCubit — المتغيرات الجديدة
```dart
int? _currentConversationId;
void startNewConversation()
Future<void> loadConversations()
void loadConversationMessages(int id)
```

### History View Grouping
اليوم / هذا الأسبوع / أقدم حسب `createdAt`.

---

## 22. ChatInputBar — Speech + Animations ✅ FULLY DONE

### Package
`speech_to_text: ^7.4.0`

### Permissions
```xml
<uses-permission android:name="android.permission.RECORD_AUDIO"/>
```

### Animations
| Animation | Location | Behavior |
|---|---|---|
| Ripple rings | حوالين الزرار | دايرتين بتتمددوا وبتختفوا |
| Waveform bars | جوه الزرار | 5 أعمدة بترقص أثناء التسجيل |

### Colors during listening
- Mic button: `AppColors.secondaryColor` background
- TextField border: `AppColors.lightPrimaryColor` بـ opacity
- TextField background: `AppColors.lightSecondaryColor`
- Waveform bars: `AppColors.primaryColor`

### Root cause of animation lifecycle bug
`speech_to_text` يستخدم **platform channel singleton** على مستوى Android. لما الـ widget يتعمل dispose وينشأ من أول:
- Dart instance جديدة بتتعمل
- الـ native Android listener القديم لسه registered
- `onStatus` callback الجديد مش بيتكال لما التسجيل يوقف
- الأنيميشن بيفضل شغال

### Attempts tried (كلها فشلت)
1. `_stopAnimations()` في `onStatus`
2. `mounted` check
3. `_speech.cancel()` في dispose
4. re-initialize في كل `_startListening`
5. session ID pattern
6. top-level `_micActive` flag
7. `await _speech.listen()` كـ blocking future — مش blocking
8. `SpeechService` singleton + re-initialize داخل `startListening` — فشل كمان لنفس السبب

### الحل النهائي ✅
**`SpeechService` singleton في GetIt + `initialize()` مرة واحدة بس في app startup.**

السر: الـ `onStatus`/`onError` بيتسجلوا على الـ platform channel **مرة واحدة بس** في `initialize()`. الـ `_onStopCallback` pointer instance variable بيتحدث في كل `startListening` — فالـ widget الحالي دايماً هو اللي بياخد الـ callback لما الـ engine يوقف. في `stopListening()` بنعمل `_onStopCallback = null` عشان لو الـ engine بعت `done` بعد الإيقاف اليدوي، مش بيتكال مرتين.

---

## 23. SpeechService — Final Implementation

```dart
class SpeechService {
  SpeechService._();
  static final SpeechService _instance = SpeechService._();
  factory SpeechService() => _instance;

  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _available = false;
  void Function()? _onStopCallback;

  // Called ONCE in setupGetIt()
  Future<void> initialize() async {
    _available = await _speech.initialize(
      onStatus: (status) {
        if (status == 'done' || status == 'notListening') {
          _onStopCallback?.call();
        }
      },
      onError: (error) {
        _onStopCallback?.call();
      },
    );
  }

  bool get isAvailable => _available;
  bool get isListening => _speech.isListening;

  Future<void> startListening({
    required void Function(String words) onResult,
    required void Function() onStop,
  }) async {
    if (!_available || _speech.isListening) return;
    _onStopCallback = onStop;  // update pointer, never re-initialize
    await _speech.listen(
      localeId: 'ar_EG',
      onResult: (result) => onResult(result.recognizedWords),
      listenOptions: stt.SpeechListenOptions(partialResults: true, cancelOnError: true),
    );
  }

  Future<void> stopListening() async {
    _onStopCallback = null;  // prevent double-call if engine fires 'done' after manual stop
    await _speech.stop();
  }
}
```

### ChatInputBar — التغييرات الجوهرية
- حذف `final stt.SpeechToText _speech` من الـ widget
- حذف `_initSpeech()` من `initState`
- أضاف `late final SpeechService _speechService = getIt<SpeechService>()`
- `dispose()` مش بيمس الـ service خالص
- الأنيميشن بيوقف عن طريق `_onSpeechStop()` callback اللي `SpeechService` بيكاله

---

## 24. All Decisions Made

| Decision | Reason |
|---|---|
| `speech_to_text: ^7.4.0` | أشهر package للـ STT في Flutter |
| Arabic locale: `ar_EG` | موجود في الـ device locales |
| Waveform جوه الزرار مش في الـ TextField | طلب Mu |
| ألوان التسجيل: أخضر من ثيم التطبيق | طلب Mu |
| `SpeechService` singleton في GetIt | platform channel singleton bug |
| `SpeechService` في `core/services` مش في FaheemCubit | أنظف معمارياً |
| `initialize()` مرة واحدة بس في `setupGetIt()` | re-initialize بيكسر الـ platform channel callbacks |
| `_onStopCallback` pointer pattern | يخلي الـ widget الحالي دايماً هو اللي بياخد الـ callback |
| `_onStopCallback = null` في `stopListening()` | يمنع double-call لو engine بعت `done` بعد الإيقاف اليدوي |
| `current_password` not needed for update-Password | Token presence = user is authenticated |
| `aaptOptions` NOT needed for `.env` in release | pubspec.yaml assets declaration sufficient |
| `INTERNET` permission must be explicit in release | Flutter debug adds it automatically |
| Search debounce 500ms via `Timer` | Simple, no cubit changes needed |
| `flutter_launcher_icons` for app icon | Generates all density variants |
| `android:label="جامعتي"` in AndroidManifest | Display name shown under icon |
| `apiService.postFormData()` for file uploads | Dedicated multipart method |
| `Dio()` given explicit `BaseOptions` | Clearer error diagnosis |
| `maxWidth`/`maxHeight: 1024` on avatar `pickImage()` | Fixes 413 nginx limit |
| `_isPicking` guard around full avatar tap flow | Prevents `PlatformException(already_active)` |
| `ProfileCubit.uploadAvatar()` emits no intermediate loading | Avoids blanking `CustomHomeAppBar` |
| `getMe()` auto-triggers after avatar upload | Server response has no URL |
| `scientific_department` key omitted when absent | Backend 422s on null or "" |
| `getIt<ProfileCubit>().getMe()` in `MainView.initState()` | Was never called on cold start |
| `<queries>` entries for `mailto`/`tel` | Android 11+ package visibility |
| Logout → `LogoutConfirmationSheet` | Confirmation before execute |
| `LegalSheet` as shared widget | Terms + Privacy share identical structure |
| No-op save guard via snapshot | 5 `_original*` vars + `_hasChanges()` |
| `logout()` in `ProfileCubit` | Only GetIt singleton owning session state |
| Code comments English-only | Hard rule |
| SnackBar over Toast | Cleaner UX |
| `conversation_id` from response not `getConversations` | sayed added it to response |
| No pagination for faheem history | sayed returns all at once |
| Fav pagination backend bug closed | sayed fixed on backend — code was always correct |

---

## 25. Session Summaries — تاريخي

**جلسة: Auth Polish + UX Fixes**
**جلسة: Splash + Onboarding + 401 Interceptor + Validator Fixes**
**جلسة: 401 SnackBar Debug + Notifications Trigger Cleanup**
**جلسة: 401 Double-SnackBar Diagnosis + Fix**
**جلسة: Profile API Integration — kickoff**
**جلسة: Profile Feature — all open items**
**جلسة: Faheem Feature — full integration**
**جلسة: mailto fix + Home AppBar fix + scientific_department fix + Avatar Upload ✅**
**جلسة: APK release + search debounce + release debug fixes ✅**
**جلسة: Faheem History — full backend integration ✅**
**جلسة: Mic Button — Speech + Animations ✅ (جزئياً — animations + STT شغالين، bug مكتشف)**

**جلسة: SpeechService — DONE ✅**
1. Fav pagination bug أُغلق — sayed خلصه من backend
2. قرأنا `chat_input_bar.dart` و`get_it_service.dart` من الـ zip
3. بنينا `SpeechService` singleton — أول نسخة فشلت (re-initialize داخل `startListening`)
4. اكتشفنا إن المشكلة في إن `initialize()` لازم يتكال مرة واحدة بس
5. ثاني نسخة: `initialize()` في `setupGetIt()` فقط + `_onStopCallback` pointer pattern
6. اشتغلت على الجهاز — الأنيميشن بيوقف لوحده صح
7. Mu طلب شرح بسيط للمشكلة والحل

**جلسة: Trello Board Review + Backlog Planning**
1. Mu راجع الـ app وحدد 34 حاجة ناقصة (bugs + refactor + todo + features جديدة)
2. اتعمل تصنيف كامل لكل حاجة: نوعها + اسمها + هل تعتمد على backend
3. Mu بعت Trello board export (JSON) — اتقرأ وتم تحليله
4. اتأكدنا من الـ closed status لكل كارد — Bugs مفتوحة 3 فعلاً، Refactor 8، ToDo 30
5. إجمالي الـ backlog: **41 حاجة**

---

## 26. Trello Backlog — الحالة الكاملة

> Board: https://trello.com/b/jy2eXHMj/uniguide
> آخر تحديث: June 27, 2026

### 🐛 Bugs (3 مفتوحة)

| الكارد | يعتمد على Backend؟ |
|---|---|
| صور فهيم بطيئة | ❌ |
| History Scroll بطيء | ❌ |
| Faheem Navigation بطيء | ❌ |

> Bugs مغلقة (closed): Navigator from home to GuideView، press in bottom navigation

### 🔧 Refactor (8 مفتوحة)

| الكارد | يعتمد على Backend؟ |
|---|---|
| UniDetail Content تحت AppBar | ❌ |
| فلتر التخصص Static | ❌ |
| Bottom Nav Hit Area | ❌ |
| Smooth Scroll | ❌ |
| Keyboard Scroll (Password Field) | ❌ |
| refactor DetailsField reuse | ❌ |
| unAuthenticated → no internet widget (مش snackbar) | ❌ |
| GovernorateDropdown --- SetupGovernorateDropdown | ❌ |

> Refactor مغلقة (closed): make search widget reuse، PersonalDataViewBody TODOs (5 حاجات)، reuse SearchTextField/FavSearchBar/GuideSearchBar، calcStrength in password register، make badge widget reuse، make location widget reuse

### 📋 ToDo (30 مفتوحة)

| # | الكارد | النوع | Backend؟ |
|---|---|---|---|
| 1 | UI/UX Splash Screen Animation | UI/UX | ❌ |
| 2 | Feat Google Sign-In | Feat | ✅ |
| 3 | Feat Facebook Login | Feat | ✅ |
| 4 | UI/UX Avatar → Navigate Profile | UI/UX | ❌ |
| 5 | UI/UX Home UI تحسين | UI/UX | ❌ |
| 6 | UI/UX "الذهاب للدليل" Navigation | UI/UX | ❌ |
| 7 | Feat Push Notifications | Feat | ✅ |
| 8 | Feat Share جامعة | Feat | ✅ (لو في لينك) |
| 9 | Feat مقارنة جامعات | Feat | ✅ |
| 10 | UI/UX Ripple على زرار فهيم | UI/UX | ❌ |
| 11 | Feat Faheem Welcome Cards → Controller | Feat | ❌ |
| 12 | Feat New Chat Button أثناء الدردشة | Feat | ❌ |
| 13 | Feat Onboarding حقيقي | Feat | ❌ |
| 14 | Feat Empty States مخصصة | Feat | ❌ |
| 15 | Feat Skeleton Loading | Feat | ❌ |
| 16 | Feat Advanced Filter في البحث | Feat | ✅ |
| 17 | Feat APK Protection | Feat | ❌ |
| 18 | Feat App Security Hardening | Feat | ❌ |
| 19 | Feat Testing / Unit Tests | Feat | ❌ |
| 20 | Feat Faheem AI Harness | Feat | ✅ |
| 21 | Feat زرار "قدم الآن" | Feat | ✅ |
| 22 | Feat زرار "المزيد من التفاصيل" | Feat | ✅ |
| 23 | [Logic] Guide Podcast Audio Player | Feat | ✅ |
| 24 | [Logic] Guide Video Player | Feat | ✅ |
| 25 | Feat Offline Mode | Feat | ✅ (caching) |
| 26 | [Infra] Local DB — Hive / Drift | Infra | ❌ |
| 27 | [Infra] Offline Mode & Connectivity | Infra | ❌ |
| 28 | Make Fav Sort | Feat | ✅ |
| 29 | fading widgets (shimmer on load) | Refactor | ❌ |
| 30 | Maps | Feat | ❌ |

> ToDo مغلقة (closed): كل الـ UI screens، كل الـ Logic items، كل الـ Infra items القديمة — كلها اتعملت

### ⏳ Waiting on sayed
- Real contact data (واتساب + تليفون + إيميل)
- Duplicate-email-unverified edge case
- Backend endpoints لـ: Google Sign-In، Facebook Login، Push Notifications، Share جامعة، مقارنة جامعات، Advanced Filter، زرار "قدم الآن"، زرار "المزيد من التفاصيل"، Guide Podcast/Video، Offline caching، Make Fav Sort، Faheem AI Harness