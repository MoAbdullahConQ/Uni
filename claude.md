# Claude Memory File — Core (Active)
> Last updated: June 2026 (session: SpeechService — DONE ✅)

---

## 1. Personal Information

- **Name:** Mu Abdullah
- **Level:** Intermediate-to-advanced Flutter developer
- **Language preference for Claude responses:** Arabic
- **Environment:** Windows, Android MIUI — project path: `C:/Users/Mu/Downloads/Uni_Guide-main/uni/`
- **Backend:** sayed — `https://back.laraveladvancedsayed101.cloud/api`

---

## 2. Active Project: Gameaty (جامعتي)

Flutter app helping Egyptian high school students choose universities.

- **App name in pubspec:** `uni` — Package: `com.example.uni`
- **Display name (AndroidManifest):** `جامعتي`
- **App icon:** `assets/images/app_icon.png` (configured via `flutter_launcher_icons`)
- **Stack:** Flutter + Dart, Clean Architecture, flutter_bloc (Cubit), Dio + ApiService, GetIt, SharedPreferences (Prefs), flutter_dotenv, dartz (Either)
- **Fonts:** `IBMPlexSansArabic` (default in ThemeData) + `Palestine` (special use)
- **Colors:** see archive §AppColors
- **Added packages:** `url_launcher` ✅, `pinput` ✅, `image_picker` ✅, `flutter_launcher_icons` ✅, `speech_to_text: ^7.4.0` ✅
- **Code comments:** **English only** (hard rule)

---

## 3. Features Status

| Feature           | Domain | Data | Presentation | Notes                                                                                               |
| ----------------- | ------ | ---- | ------------ | --------------------------------------------------------------------------------------------------- |
| **browse**        | ✅     | ✅   | ✅           | Cursor pagination + FavCubit + per_page=10 + NoInternetWidget + retry                               |
| **fav**           | ✅     | ✅   | ✅           | add/remove + optimistic update + rollback + deduplication + NoInternetWidget + retry + pagination ✅ |
| **search**        | ✅     | ✅   | ✅           | Cubit + page-based pagination + recent searches + debounce 500ms ✅                                 |
| **home**          | ✅     | ✅   | ✅           | Trending + Recommended + retry — `CustomHomeAppBar` wired to `ProfileCubit`                        |
| **notifications** | ✅     | ✅   | ✅           | Global cubit + RouteObserver + unread count + NoInternetWidget + retry + ActionFailure as snackbar  |
| **guide**         | ✅     | ✅   | ✅           | Articles + pagination + UI search filter + retry + NoInternetWidget                                 |
| **uni_detail**    | ✅     | ✅   | ✅           | 4 parallel calls via Future.wait + NoInternetWidget + retry + rate + website                        |
| **auth**          | ✅     | ✅   | ✅           | Complete + polished — see archive §Auth Feature                                                     |
| **splash**        | ✅     | ✅   | ✅           | token check → MainView or OnBoarding or LoginView                                                   |
| **on_boarding**   | ✅     | ✅   | ✅           | marks seen in SharedPreferences → navigates to LoginView                                            |
| **profile**       | ✅     | ✅   | ✅           | Fully done — avatar upload ✅, logout ✅, contact us ✅, legal sheet ✅                              |
| **faheem**        | ✅     | ✅   | ✅           | Chat + History + Mic/STT fully done ✅ — see archive §Faheem + §SpeechService                      |

---

## 4. Architecture Rules (strictly followed)

1. `view.dart` = entry point only (Scaffold + SafeArea + ViewBody)
2. `view_body.dart` = all logic and widgets
3. `routeName` = on every view
4. Any widget used in more than one feature → moves to `core/widgets`
5. Every widget in a separate file
6. Dummy data = top-level functions (not static classes)
7. **Cubit Pattern:** Initial → Loading → Success/Failure
8. **Pagination Pattern:**
   - `PaginationLoading(currentItems)` — separate state
   - `PaginationFailure({errMessage, currentItems})`
   - `_isLoadingMore` flag in the Cubit to prevent duplicate calls
   - Loading indicator = widget below ListView, not an item inside it
9. **Local Update:** API call first → if successful → update locally
10. **Optimistic Update:** Fav only (with rollback for both add and remove)
11. **UI Search:** Guide and Fav filter on existing data — not a Cubit method
12. **API calls in `initState`** — not in `build`
13. **Error handling:** `DioException` caught directly in repo → `ServerFailure.fromDioError(e)` → `left(...)` — NO `CustomExceptions` layer
14. **Data sources:** no try/catch — let `DioException` propagate to repo
15. **Entity rule:** only create an Entity for data shown in UI or used in business logic
16. **Cubit-per-feature, not per-screen**
17. **Selector widgets with multiple options take a `Map<String, IconData>` for icons**
18. **Every `onGenerateRoute` case must forward `settings: settings` to `MaterialPageRoute`**
19. **No global mutable variables for cross-screen one-off messages** — pass via route `arguments` instead
20. **401 interceptor must guard against concurrent-request double-redirect** — `_isHandlingUnauthorized` bool flag in `ApiService`
21. **401 SnackBar ordering:** in any cubit failure listener, if `errMessage.toLowerCase().contains('unauthenticated')` → return early, let the interceptor handle the redirect.
22. **SpeechService pattern:** `SpeechToText` instance must live in `SpeechService` singleton (GetIt) — `initialize()` called ONCE at app startup — never re-initialize inside a widget or inside `startListening`.

> ⚠️ If a new error occurs → always ask for the related file before attempting a fix.
> ⚠️ Before proposing a debugging fix → confirm the actual root cause via prints/logs first.

---

## 5. Release Build — Current State ✅

**APK builds and runs correctly on real devices.**

### Confirmed working:
- `flutter build apk --release` → output at `build/app/outputs/flutter-apk/app-release.apk`
- App icon configured via `flutter_launcher_icons` — command: `dart run flutter_launcher_icons`
- Display name set in `AndroidManifest.xml` → `android:label="جامعتي"`

### `android/app/build.gradle.kts` — current clean state:
```kotlin
// no aaptOptions block needed
// no isMinifyEnabled / isShrinkResources overrides
// release signingConfig = debug keys (for now)
```

---

## 6. Global app infrastructure — current state

**`main.dart` globals:**
```dart
final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
```
> `MultiBlocProvider` includes `ProfileCubit`, `FavCubit`, `NotificationsCubit`.

**401 interceptor:** `_isHandlingUnauthorized` guard flag — prevents double-redirect from concurrent 401s.

**Logout flow:**
- `ProfileCubit.logout()` — clears token + refresh_token + `_currentUser` → `navigatorKey.pushNamedAndRemoveUntil(LoginView)`
- Triggered via `LogoutConfirmationSheet`

---

## 7. Mic / Speech Feature — DONE ✅

**Feature:** زرار مايك في `ChatInputBar` بيستخدم `speech_to_text: ^7.4.0`

**الحل المطبق:** `SpeechService` singleton في GetIt — `SpeechToText` instance واحدة بتعيش طول عمر الـ app. `initialize()` بيتكال مرة واحدة بس في `setupGetIt()`. الـ `onStatus`/`onError` متسجلين مرة واحدة على الـ platform channel. الـ `_onStopCallback` pointer بيتحدث في كل `startListening` عشان يشاور على الـ widget الحالي.

**الملفات المتأثرة:**
- `core/services/speech_service.dart` ← جديد ✅
- `core/services/get_it_service.dart` ← أضيف تسجيل `SpeechService` في الآخر ✅
- `features/faheem/.../widgets/chat_input_bar.dart` ← بقت بتكلم `SpeechService` من GetIt ✅

**الـ animations في `ChatInputBar` (محلية في الـ widget):**
- **Ripple rings** — دايرتين بتتمددوا من الزرار
- **Waveform bars** — 5 أعمدة جوه الزرار بترقص أثناء التسجيل
- الألوان: `AppColors.secondaryColor` أثناء التسجيل
- الـ TextField بيتغير border وbackground لما التسجيل يبدأ

**RECORD_AUDIO permission** مضاف في `AndroidManifest.xml` ✅

---

## 8. Next Steps (in order)

**كل الـ features خلصت ✅**

**Waiting on sayed:**
1. Real contact data — واتساب + تليفون + إيميل
2. Duplicate-email-unverified edge case

---

## 9. Preferences & Working Style

- **Responds in Arabic** even for technical topics
- **Sends code and asks "what do you think" or "explain"** — wants to understand
- **Prefers short answers** — get to the point
- **Says "continue" / "كمل"** — resume exactly where left off
- **Rejects over-engineering**
- **Confirms before execution**
- **Uploads `lib.zip`** with every checkpoint — read before replying, extract fresh each time
- **Re-uploads mid-session** — always extract fresh, don't assume old extraction is current
- **Sends API responses as JSON** — treat as ground truth
- **Doesn't like refactoring** after Claude sends code
- **Catches contradictions quickly**
- **Commands are short and direct:** "fix", "send", "كمل", "look at the whole code"
- **Doesn't want comments removed** from code
- **Uses inline TODO comments** in pasted code — treat each TODO as a distinct item
- **Multi-point messages** — parse each point separately
- **When debugging:** expects Claude to ask for the relevant file first
- **Prefers SnackBar over Toast**
- **Sends screenshots of UI bugs** — diagnose root cause
- **"سيبها"** = final decision, don't re-raise
- **"تمام" / "ايوه"** after explanation = proceed
- **When I say "افترض حلول"** = list options with tradeoffs, do NOT write code yet
- **Never implement during a discussion turn** — wait for explicit go-ahead
- **When debugging:** don't guess — isolate root cause with prints/logs first
- **Wants Claude to track "waiting on third party" items** and resurface without being asked
- **When asked to re-order open items** — group into buckets (ready / needs input / needs diagnosis / waiting on third party)
- **Sends back files with TODO comments** as his preferred way to request changes
- **Rapid-fire multi-point messages** — don't let new asks get lost among answers to old questions
- **Sometimes pastes full transcript from another session** — absorb as ground truth
- **"معاك كل حاجة"** when Claude asks for a file that's in the zip — use the zip
- **Asks same architectural question twice** — answer consistently
- **"متبعتش الفايل"** = send the full file, not just a snippet
- **When closing a feature/item with "سيبها" + clear reasoning** → accept it, close it
- **Verifies code by reading cubit + view directly**
- **Asks "اشرحلي البروسيس والفلو"** / **"فهمني"** after implementation — wants plain-language summary
- **When sending back a file that came from Claude** — treat it as current ground truth, apply changes on it
- **When asking for animations/UI** — wants to see preview first before building
- **"جربهم بالترتيب"** — يعني اعرضهم واحد واحد للمقارنة
- **بيصحح Claude بشكل مباشر لو قرأ الـ log غلط** — اعترف فوراً وصحح
- **"فهمني بقا انت عملت ايه بالضبط"** بعد ما حاجة تشتغل = يريد شرح المشكلة والحل بأسلوب بسيط، مش technical walkthrough

> 📂 Full reference → see `archive.md`