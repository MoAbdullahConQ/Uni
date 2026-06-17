# Claude Memory File — Core (Active)
> Last updated: June 2026 (session: splash + onboarding + 401 interceptor + validator fixes)

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
- **Fonts:** `IBMPlexSansArabic` (default in ThemeData — no need to set per TextStyle) + `Palestine` (special use)
- **Colors:** see archive §AppColors — `primaryColor` dark green, `lightPrimaryColor` light green, `secondaryColor` yellow-green, `lightSecondaryColor` very light green bg
- **Added packages:** `url_launcher` (open university website), `pinput` ✅ (added to pubspec.yaml)
- **Code comments:** **English only** (hard rule)

---

## 3. Features Status

| Feature           | Domain | Data | Presentation | Notes                                                                                               |
| ----------------- | ------ | ---- | ------------ | --------------------------------------------------------------------------------------------------- |
| **browse**        | ✅     | ✅   | ✅           | Cursor pagination + FavCubit + per_page=10 + NoInternetWidget + retry                               |
| **fav**           | ✅     | ✅   | ✅           | add/remove + optimistic update + rollback + deduplication + NoInternetWidget + retry                |
| **search**        | ✅     | ✅   | ✅           | Cubit + page-based pagination + recent searches                                                     |
| **home**          | ✅     | ✅   | ✅           | Trending + Recommended + retry on tab switch + retry on didPopNext                                  |
| **notifications** | ✅     | ✅   | ✅           | Global cubit + RouteObserver + unread count + NoInternetWidget + retry + ActionFailure as snackbar  |
| **guide**         | ✅     | ✅   | ✅           | Articles + pagination + UI search filter + retry on failure + NoInternetWidget in GuideArticlesView |
| **uni_detail**    | ✅     | ✅   | ✅           | API integration done — 4 parallel calls via Future.wait + NoInternetWidget + retry + rate + website |
| **auth**          | ✅     | ✅   | ✅           | Complete + polished — see archive §Auth Feature                                                     |
| **splash**        | ✅     | ✅   | ✅           | token check → MainView or OnBoarding or LoginView — DONE this session                               |
| **on_boarding**   | ✅     | ✅   | ✅           | marks seen in SharedPreferences → navigates to LoginView — DONE this session                        |
| **profile**       | ❌     | ❌   | ✅           | 4 screens UI done — API integration not started — **next up**                                       |
| **faheem**        | ✅     | ❌   | ✅           | Chat UI + entities — waiting on backend                                                             |

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
   - `PaginationLoading(currentItems)` — separate state, not a field inside Success
   - `PaginationFailure({errMessage, currentItems})`
   - `_isLoadingMore` flag in the Cubit to prevent duplicate calls
   - Loading indicator = widget below ListView, not an item inside it
9. **Local Update:** API call first → if successful → update locally
10. **Optimistic Update:** Fav only (with rollback for both add and remove)
11. **UI Search:** Guide and Fav filter on existing data — not a Cubit method
12. **API calls in `initState`** — not in `build`
13. **Error handling:** `DioException` caught directly in repo → `ServerFailure.fromDioError(e)` → `left(...)` — NO `CustomExceptions` layer anymore
14. **Data sources:** no try/catch — let `DioException` propagate to repo
15. **Entity rule:** only create an Entity for data shown in UI or used in business logic — pure storage/internal data (e.g. tokens) stays as primitives between layers, no Entity wrapper
16. **Cubit-per-feature, not per-screen:** group screens sharing the same logical flow into one Cubit; split only for genuinely distinct sub-logic (timers, separate polling, etc.)
17. **Selector widgets with multiple options take a `Map<String, IconData>` for icons** — never one shared `icon` reused across all options

> ⚠️ If a new error occurs → always ask for the related file before attempting a fix.

---

## 5. Global app infrastructure — this session additions

**`main.dart` globals:**
```dart
final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
String? pendingSnackBarMessage; // used for 401 session-expired message
```

**401 interceptor in `ApiService`:**
- On 401 → `Prefs.remove('token')` → set `pendingSnackBarMessage` → `navigatorKey.currentState?.pushNamedAndRemoveUntil(LoginView.routeName, ...)`
- Uses `GlobalKey<NavigatorState>` — no context needed
- Decision: `GlobalKey<NavigatorState>` chosen over per-Cubit 401 handling and Stream/EventBus — simplest correct solution

**`LoginViewBody`:**
- Converted to `StatefulWidget` (was `StatelessWidget`)
- `initState` reads `pendingSnackBarMessage` via `addPostFrameCallback` → shows SnackBar → sets to `null`
- Normal login flow: `pendingSnackBarMessage` is null → no SnackBar shown

**Splash flow (`splash_view_body.dart`):**
```dart
void executeNavigation() {
  final token = Prefs.getString('token');
  final isOnBoardingViewSeen = Prefs.getBool(kIsOnBoardingViewSeenKey);
  Future.delayed(const Duration(seconds: 2), () {
    if (!mounted) return;
    if (token.isNotEmpty) {
      Navigator.pushReplacementNamed(context, MainView.routeName);
    } else if (isOnBoardingViewSeen) {
      Navigator.pushReplacementNamed(context, LoginView.routeName);
    } else {
      Navigator.pushReplacementNamed(context, OnBoardingView.routeName);
    }
  });
}
```

**OnBoarding flow (`on_boarding_view.dart`):**
- On done/skip → `Prefs.setBool(kIsOnBoardingViewSeenKey, true)` → `pushReplacementNamed(LoginView.routeName)`
- Was incorrectly navigating to `MainView` — fixed this session

---

## 6. Next Steps (in order)

1. **Profile — API Integration** — `GET /auth/me` + `POST /student_info` + `POST /auth/update-Password` — all use cases already in `auth` domain
2. **Faheem/Chat AI** — `POST /aiChat/send` (waiting on backend)
3. **Search Debounce** — 500ms in `search_view_body.dart`
4. **Fav Pagination** — after sayed fixes the backend bug

**Open item — session-expired SnackBar:** `pendingSnackBarMessage` approach is implemented but SnackBar was still not showing reliably at end of session. The `addPostFrameCallback` in `LoginViewBody.initState` reads `pendingSnackBarMessage` directly (not via `ModalRoute.arguments`). Last known state: still debugging — verify first thing next session.

**Backend conversation needed with sayed:** duplicate-email-but-unverified edge case — no frontend fix possible.

---

## 7. Preferences & Working Style

- **Sends code and asks "what do you think" or "explain"** — wants to understand, not just copy
- **Finds bugs himself** and comes to ask — doesn't wait to be told
- **Prefers short answers** — no long explanations, get to the point
- **Says "continue"** when he wants to keep going
- **Rejects over-engineering**
- **Asks "why"** before executing — understands the decision first
- **Compares against existing patterns** — "see how we did it in the other feature"
- **Values consistency** — if another feature did something a certain way, he'll do it the same way
- **Gives direct feedback** — like "you're hallucinating" or "you're dumb man" (joking)
- **Confirms before execution** — verifies Claude understood the requirement before writing code
- **Works in Arabic** even for technical topics
- **Uploads lib.zip** with every checkpoint — read before replying — re-uploads after receiving files to verify output
- **Sends API responses as JSON** when debugging — treat them as ground truth
- **Uses Postman** to verify before talking to the team
- **Doesn't like refactoring** after Claude sends code
- **Catches contradictions quickly**
- **Notices solution inconsistencies**
- **Commands are short and direct:** "fix", "send", "look at the whole code"
- **Doesn't want comments removed** from code
- **Uses inline review comments** to ask "why" about a specific line — answer precisely, not re-explain the whole file
- **Sometimes re-asks the same architectural question** — wants consistent answer, not a new decision
- **When debugging:** expects Claude to ask for the relevant file first before guessing
- **When Claude asks for a file and it's in the zip:** will say "معاك كل حاجة" — use the zip
- **Prefers SnackBar over Toast** for transient success messages
- **Sends screenshots of UI bugs** — diagnose root cause in framework/widget behavior, not just symptom
- **Reports backend/data inconsistencies he notices himself** — treat as a flag for a sayed conversation
- **Will explicitly call out if Claude writes code during a discussion turn** — only implement after explicit go-ahead
- **Catches Claude when it proposes a solution that contradicts itself mid-session** — stay consistent
- **When debugging, sends print log output** — read it carefully before proposing a fix
- **Figures out root cause himself from logs** and points it out directly — Claude should confirm, not re-explain

> ⚠️ **Important note:** If a new error occurs, always ask for the related file before attempting to fix it. If lib.zip was uploaded, read it from there.

---

> 📂 Full reference (project structure, all entities, all endpoints, code snippets, decisions log) → see `archive.md`