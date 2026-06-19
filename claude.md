# Claude Memory File — Core (Active)
> Last updated: June 2026 (session: Profile API Integration — kickoff + first batch of screens)

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
- **Stack:** Flutter + Dart, Clean Architecture, flutter_bloc (Cubit), Dio + ApiService, GetIt, SharedPreferences (Prefs), flutter_dotenv, dartz (Either)
- **Fonts:** `IBMPlexSansArabic` (default in ThemeData) + `Palestine` (special use)
- **Colors:** see archive §AppColors
- **Added packages:** `url_launcher`, `pinput` ✅, `image_picker` ✅ (added this session — needs `pubspec.yaml` entry: `image_picker: ^1.1.2`, no extra Android manifest permissions needed for gallery picks)
- **Code comments:** **English only** (hard rule)

---

## 3. Features Status

| Feature           | Domain | Data | Presentation | Notes                                                                                               |
| ----------------- | ------ | ---- | ------------ | --------------------------------------------------------------------------------------------------- |
| **browse**        | ✅     | ✅   | ✅           | Cursor pagination + FavCubit + per_page=10 + NoInternetWidget + retry                               |
| **fav**           | ✅     | ✅   | ✅           | add/remove + optimistic update + rollback + deduplication + NoInternetWidget + retry                |
| **search**        | ✅     | ✅   | ✅           | Cubit + page-based pagination + recent searches — debounce still not implemented                    |
| **home**          | ✅     | ✅   | 🔶           | Trending + Recommended + retry on tab switch + retry on didPopNext — **CustomHomeAppBar still has hardcoded name/avatar, next up to wire to ProfileCubit** |
| **notifications** | ✅     | ✅   | ✅           | Global cubit + RouteObserver + unread count + NoInternetWidget + retry + ActionFailure as snackbar — fully stable |
| **guide**         | ✅     | ✅   | ✅           | Articles + pagination + UI search filter + retry on failure + NoInternetWidget in GuideArticlesView |
| **uni_detail**    | ✅     | ✅   | ✅           | API integration done — 4 parallel calls via Future.wait + NoInternetWidget + retry + rate + website |
| **auth**          | ✅     | ✅   | ✅           | Complete + polished — see archive §Auth Feature                                                     |
| **splash**        | ✅     | ✅   | ✅           | token check → MainView or OnBoarding or LoginView                                                    |
| **on_boarding**   | ✅     | ✅   | ✅           | marks seen in SharedPreferences → navigates to LoginView                                            |
| **profile**       | ✅     | ✅   | 🔶           | **IN PROGRESS this session — see §5 below for full breakdown of what's done vs open**               |
| **faheem**        | ✅     | ❌   | ✅           | Chat UI + entities — waiting on backend; sayed's status still unconfirmed, ask next time            |

---

## 4. Architecture Rules (strictly followed)

1. `view.dart` = entry point only (Scaffold + SafeArea + ViewBody)
2. `view_body.dart` = all logic and widgets
3. `routeName` = on every view
4. Any widget used in more than one feature → moves to `core/widgets` (applied this session: `AgeField`, formerly `SetupAgeField` in auth, moved to `core/widgets/age_field.dart` since profile now uses it too)
5. Every widget in a separate file
6. Dummy data = top-level functions (not static classes)
7. **Cubit Pattern:** Initial → Loading → Success/Failure
8. **Pagination Pattern:**
   - `PaginationLoading(currentItems)` — separate state, not a field inside Success
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
16. **Cubit-per-feature, not per-screen** — applied this session: one `ProfileCubit` serves `profile`, `personal_data`, and `security` screens (not three separate cubits) — confirmed as the right call via expert-lens question this session
17. **Selector widgets with multiple options take a `Map<String, IconData>` for icons**
18. **Every `onGenerateRoute` case must forward `settings: settings` to `MaterialPageRoute`** (resolved last session)
19. **No global mutable variables for cross-screen one-off messages** — pass via route `arguments` instead (resolved last session)
20. **401 interceptor must guard against concurrent-request double-redirect** — `_isHandlingUnauthorized` bool flag in `ApiService`, reset via `.then()` after `pushNamedAndRemoveUntil` completes (added this session — see §5)

> ⚠️ If a new error occurs → always ask for the related file before attempting a fix.
> ⚠️ Before proposing a debugging fix → confirm the actual root cause via prints/logs first, don't fix the first plausible suspect.

---

## 5. Profile Feature — Current State (this session, in progress)

**Scope locked in for this round:** `GET /auth/me` + `POST /student_info` + `POST /auth/update-Password`. Avatar upload explicitly deferred (no backend endpoint yet — separate future task, not blocking this round).

### ✅ Done and sent this session
- `StudentInfoEntity` (new) + `StudentInfoModel` (new) — nested under `UserEntity.studentInfo` (nullable)
- `UserEntity`/`UserModel` updated to parse `student_info` from `GET /auth/me` response
- `kGovernorates` (26 governorates, matches backend `governorate_id`) moved from `setup_governorate_dropdown.dart` (auth) into root `lib/constants.dart` as the single shared source — **per user's explicit instruction**, since he already had a constants file and wanted it centralized there
- `setup_governorate_dropdown.dart` updated to import `kGovernorates` from constants instead of a local duplicate list
- `governorate_dropdown.dart` (profile) rebuilt as a real dropdown (was hardcoded to 3 fake governorates) — now takes `selectedId`/`onChanged`, full 26-governorate list
- `AgeField` (was `SetupAgeField`, auth-only) moved to `core/widgets/age_field.dart` since profile now needs it too — `setup_view_body.dart` updated to use the new shared widget
- `ProfileCubit` (new, singleton in GetIt) — single cubit for profile/personal_data/security, wraps `GetMeUseCase` + `SaveStudentInfoUseCase` + `UpdatePasswordUseCase`. States: `ProfileInitial/Loading/Success(user)/Failure` for fetch, plus separate `SavingStudentInfo/StudentInfoSaved/SaveStudentInfoFailure` and `UpdatingPassword/PasswordUpdated/UpdatePasswordFailure` for the two write actions (kept separate from fetch states so a failed save/update doesn't blow away the displayed user data). Exposes `currentUser` getter so screens can read last-known user during intermediate states.
- `ProfileCubit` registered as `registerSingleton` in `get_it_service.dart`, and added to `MultiBlocProvider` in `main.dart`
- `CustomTextFormField` — added `enabled` (bool, default `true`) param, with a dimmed fill color when `false`. Used to show name/email as read-only in `personal_data` (no update-profile endpoint exists, so these are display-only)
- `personal_data_view_body.dart` — fully rebuilt:
  - reads from `ProfileCubit` state, populates form fields (name/email read-only, study section, study track, governorate, percentage, age) from `GetMe` on first successful load
  - Arabic ↔ backend-format mapping for `study_section` (علمي/أدبي ↔ science/literature) and `scientific_department` (علوم/رياضة ↔ scientific/Mathematics) — same pattern as existing `SetupViewBody`
  - "الشعبة العلمية" selector now conditionally shown only when "علمي" is selected (TODO from user, resolved this session)
  - when study section is "أدبي", `scientificDepartment` is now sent as `''` instead of stale leftover value (TODO from user, resolved this session) — **open question: confirm with sayed whether backend wants `null` or empty string here; current code sends `''`**
  - manual age validation (14–30) with a SnackBar shown on submit if out of range, in addition to the existing inline `Form` validator (TODO from user, resolved this session)
  - "تأكيد البيانات" checkbox gates the save button (disabled/dimmed until checked) — same UX pattern as register flow's terms checkbox
  - confirmed-but-not-yet-fixed bug reported by user: a session-expired (401) failure during save currently shows the generic `SaveStudentInfoFailure` SnackBar *before* the 401-redirect SnackBar appears on LoginView — wrong order, **not yet diagnosed, needs step-by-step log trace before any fix** (see Open Items below)
- `security_view_body.dart` — rebuilt: removed the "current password" field (was unconnected to any controller and to no endpoint param — user confirmed asking sayed before reconnecting), wired `updatePassword` call, loading/success/failure states
- `password_section.dart` — removed the unused current-password field; kept new-password + confirm-password with strength indicator and live match check (validator logic re-verified correct, was not actually a bug)
- `profile_view_body.dart` — rebuilt: connects to `ProfileCubit.getMe()` in `initState`, shows loading/failure/success, builds a `role` label (e.g. "طالب - علمي علوم") from `studentInfo` for `ProfileAvatarSection`
- `DocumentsSection` + `PersonalDataDocumentUploadCard` — rebuilt with `image_picker`: tap-to-pick from gallery, local preview, tap-to-clear (X button) — fully UI-only (no backend endpoint for document upload), but now has real interactive feel instead of static placeholders
- `ApiService` 401 interceptor — added `_isHandlingUnauthorized` guard flag to prevent the double-SnackBar bug confirmed via log trace this session (two concurrent 401s — e.g. notifications list + unread count failing together — were each independently triggering `pushNamedAndRemoveUntil`)

### 🔶 Open items (next things to do, in the order the user raised them)
1. **Session-expired SnackBar ordering bug** — `SaveStudentInfoFailure` SnackBar shows before/instead of the proper 401-redirect flow when the token expires during a `personal_data` save. User flagged this explicitly as "needs step-by-step diagnosis, not a guess." **Not yet started** — needs reproduction + log trace next session.
2. **No-op guard on save** — "if the user didn't change anything, don't send a request." User said he already implemented something for this himself and that it's incorrectly showing an error-style SnackBar — **waiting on user to paste his code** so Claude can review/fix rather than rewrite from scratch.
3. **Home page name/avatar still hardcoded** — `CustomHomeAppBar` (`lib/features/home/presentation/views/widgets/custom_home_app_bar.dart`) has `'محمد مجدي عبدالغني'` and a static `Image.asset` for the avatar. Confirmed via code read this session — needs wiring to `ProfileCubit`. **Not yet started.**
4. **Logout button not wired** — `ProfileLogoutButton` widget already accepts an `onPressed` callback but nothing passes one in `profile_view_body.dart`. Found existing dead code: `AuthCubit.logout()` (clears `token` + `refresh_token` from Prefs) already exists but `AuthCubit` is not a GetIt singleton (created per-view, auth-flow only), so it's not reachable from `ProfileViewBody`. **Decision proposed by Claude, awaiting explicit user confirmation:** add a `logout()` method directly to `ProfileCubit` (already a singleton, logically owns "user session state") rather than promoting `AuthCubit` to a singleton (would risk state bleeding across login/register/forgot-password screens that currently share one `AuthState` enum cleanly). **Not yet implemented — waiting on user's go-ahead on this specific approach.**
5. **"تواصل مع الدعم" (Contact Us) screen** — has no backend endpoint (confirmed, same as before), user wants it to feel more interactive/better UX rather than fully static. **Needs user to specify the concrete mechanism** (mailto: link? WhatsApp deep link? copy-to-clipboard for email/phone? something else) before any code is written.
6. **Avatar tap interaction ("حوار صورة البروفايل")** — user flagged this needs to be "ضبط" (sorted out) but the exact intended behavior is **not yet clarified** — likely means tapping the avatar should open an image-picker dialog (camera/gallery), but this needs explicit confirmation before building, especially since actual avatar upload has no backend endpoint yet (see below).
7. **Avatar upload to backend** — explicitly deferred this session per user's "خلينا نأجلها" — no endpoint exists yet, `UserEntity.avatar` field already exists and ready to receive a URL whenever sayed builds the endpoint. Tracked as a distinct future task, not part of this round's scope.

### ⏳ Waiting on sayed (external, not a Claude task)
- Whether `POST /student_info` should receive `null` or `''` for `scientific_department` when `study_section` is "أدبي" — **user said he will ask and wants Claude to remember to follow up.**
- Whether `POST /auth/update-Password` can get a `current_password` param added — needed before the "current password" field could ever be meaningfully reconnected in `security_view_body.dart`. (Field is removed from UI for now either way.)

---

## 6. Global app infrastructure — current state

**`main.dart` globals:**
```dart
final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
```
> `MultiBlocProvider` now includes `ProfileCubit` alongside `FavCubit` and `NotificationsCubit` (added this session).

**401 interceptor in `ApiService` (updated this session — concurrent-request guard added):**
```dart
bool _isHandlingUnauthorized = false;
// ...
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
```
> Root cause confirmed via log trace last session-before-this-one: `NotificationsCubit.getNotifications()` fires two independent API calls (list + unread count) that can both fail with 401 around the same time, each independently calling `pushNamedAndRemoveUntil` and producing a double SnackBar. Fixed with the guard flag above, confirmed via repeated `print` log trace this session (`401 intercepted - calling pushNamedAndRemoveUntil` printed twice before the fix).

**`LoginViewBody`:** unchanged from before — reads session-expired message via `ModalRoute.of(context)?.settings.arguments as String?` inside `addPostFrameCallback`, no global variable involved.

**`on_generate_routes.dart`:** every case passes `settings: settings` (resolved prior session, still correct).

**`MainView` — `NotificationsCubit.getNotifications()` trigger points:** unchanged, still 3 intentional call sites (`initState`, `didPopNext`, `_onTabChanged`) — confirmed correct, not revisited this session.

**Splash flow:** unchanged, still correct (see archive for full snippet).

---

## 7. Next Steps (in order)

1. **Profile — finish open items from §5** (in the order listed there: 401/SnackBar ordering bug → no-op save guard → home page avatar/name → logout wiring → contact-us interactivity → avatar dialog clarification)
2. **Search Debounce** — 500ms in `search_view_body.dart` — small, quick task, still pending, not touched this session
3. **Faheem/Chat AI** — `POST /aiChat/send` (waiting on backend) — ask sayed for status next session, still unconfirmed
4. **Fav Pagination** — after sayed fixes the backend bug — still open, unrelated to this session

**Backend conversation needed with sayed (growing list, see §5 "Waiting on sayed" above for the two new items this session):**
- duplicate-email-but-unverified edge case — no frontend fix possible (unchanged, still open)
- `scientific_department` value when `study_section` is "أدبي" — `null` vs `''`? (new this session)
- `current_password` param for `update-Password` endpoint — needed to ever reconnect that UI field (new this session)

---

## 8. Preferences & Working Style

- **Sends code and asks "what do you think" or "explain"** — wants to understand, not just copy
- **Finds bugs himself** and comes to ask — doesn't wait to be told
- **Prefers short answers** — no long explanations, get to the point
- **Says "continue" / "كمل"** when he wants to keep going — resume exactly where left off, no re-intro
- **Rejects over-engineering**
- **Asks "why"** before executing — understands the decision first
- **Compares against existing patterns**
- **Values consistency**
- **Gives direct feedback** (joking, e.g. "you're hallucinating")
- **Confirms before execution**
- **Works in Arabic** even for technical topics
- **Uploads lib.zip** with every checkpoint — read before replying. Re-uploads it mid-session too, not just at checkpoints (happened this session — extract fresh each time rather than assuming the old extraction is current)
- **Sends API responses as JSON** when debugging — treat as ground truth
- **Uses Postman** to verify before talking to the team
- **Doesn't like refactoring** after Claude sends code
- **Catches contradictions quickly**
- **Commands are short and direct:** "fix", "send", "كمل", "look at the whole code"
- **Doesn't want comments removed** from code
- **Uses inline review comments / TODO comments embedded directly in pasted code** to flag exactly what needs fixing — **this is a recurring pattern this session**: he pastes a full file back with `// TODO ...` comments inline at the exact line that needs a change, sometimes several in one paste. Treat each TODO as a distinct, separately-addressable item — work through them, don't bundle/assume one fix covers two TODOs.
- **Sometimes re-asks the same architectural question twice** — wants consistent answer
- **When debugging:** expects Claude to ask for the relevant file first before guessing
- **When Claude asks for a file and it's in the zip:** will say "معاك كل حاجة" — use the zip
- **Prefers SnackBar over Toast**
- **Sends screenshots of UI bugs** — diagnose root cause in framework/widget behavior
- **Reports backend/data inconsistencies he notices himself**
- **Explicitly calls out if Claude writes/edits code during a discussion turn** — this happened this session (Claude began drafting `ProfileViewBody` changes — viewing the file and reasoning about edits — while the user intended to still be discussing the logout approach; user corrected with "انا مقولتكش ام طبق احنا بنتناقش"). **Reinforced rule: even reading a file with edit-intent framing, mid-discussion, reads as "starting to implement." When a question is open (e.g. "should we do A or B"), stop fully after presenting the options — no file edits, no exploratory edits-in-waiting — until the user explicitly picks.**
- **Catches Claude when it proposes a solution that contradicts itself mid-session**
- **When debugging, sends print log output** — read it carefully before proposing a fix
- **Figures out root cause himself from logs** and points it out directly
- **Runs the app himself, pastes raw console/logcat output** (including noise) — extract the relevant lines yourself
- **Pushes back mid-debugging when a fix changes behavior but doesn't match expectation** — treat as new diagnostic data, re-diagnose, don't assume "still broken"
- **Sometimes pastes a full transcript from another chat/session and says "اقرا دا"** — read fully, absorb as ground truth, summarize resolved vs. open before proceeding
- **When closing a session, wants full memory continuity** — files should let a fresh chat pick up with zero re-explaining
- **Gives rapid-fire multi-point messages** — a single message can contain several distinct decisions/answers/new requests bundled together (happened this session: one message answered 5 pending questions AND added 4 new requests in one go). **Parse each point separately, number them back if helpful, and don't let new asks bleed into or get lost among the answers to old questions.**
- **Wants Claude to track and resurface "waiting on third party" items** (e.g. "اسأل سايد") without being asked — explicitly said "خليك فاكر عشان نخلصها," confirming this expectation.
- **Asks Claude to re-order/triage a growing open-items list on request** ("رتبلي كدا كل البوينتس دي") — when asked, group into clear buckets (e.g. ready-to-build / needs-input-from-user / needs-diagnosis / waiting-on-third-party) rather than a flat list.

---

> 📂 Full reference (project structure, all entities, all endpoints, code snippets, decisions log) → see `archive.md`