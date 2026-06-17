# Claude Memory File — Core (Active)
> Last updated: June 2026 (session: 401 SnackBar debug + onGenerateRoute settings fix + NotificationsCubit trigger cleanup)

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
- **Added packages:** `url_launcher`, `pinput` ✅
- **Code comments:** **English only** (hard rule)

---

## 3. Features Status

| Feature           | Domain | Data | Presentation | Notes                                                                                               |
| ----------------- | ------ | ---- | ------------ | --------------------------------------------------------------------------------------------------- |
| **browse**        | ✅     | ✅   | ✅           | Cursor pagination + FavCubit + per_page=10 + NoInternetWidget + retry                               |
| **fav**           | ✅     | ✅   | ✅           | add/remove + optimistic update + rollback + deduplication + NoInternetWidget + retry                |
| **search**        | ✅     | ✅   | ✅           | Cubit + page-based pagination + recent searches — **debounce still not implemented (next up)**      |
| **home**          | ✅     | ✅   | ✅           | Trending + Recommended + retry on tab switch + retry on didPopNext                                  |
| **notifications** | ✅     | ✅   | ✅           | Global cubit + RouteObserver + unread count + NoInternetWidget + retry + ActionFailure as snackbar — trigger points finalized this session (see §5) |
| **guide**         | ✅     | ✅   | ✅           | Articles + pagination + UI search filter + retry on failure + NoInternetWidget in GuideArticlesView |
| **uni_detail**    | ✅     | ✅   | ✅           | API integration done — 4 parallel calls via Future.wait + NoInternetWidget + retry + rate + website |
| **auth**          | ✅     | ✅   | ✅           | Complete + polished — see archive §Auth Feature                                                     |
| **splash**        | ✅     | ✅   | ✅           | token check → MainView or OnBoarding or LoginView                                                    |
| **on_boarding**   | ✅     | ✅   | ✅           | marks seen in SharedPreferences → navigates to LoginView                                            |
| **profile**       | ❌     | ❌   | ✅           | 4 screens UI done — API integration not started — **next up, top priority**                         |
| **faheem**        | ✅     | ❌   | ✅           | Chat UI + entities — waiting on backend; sayed's status unconfirmed as of end of this session       |

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
13. **Error handling:** `DioException` caught directly in repo → `ServerFailure.fromDioError(e)` → `left(...)` — NO `CustomExceptions` layer
14. **Data sources:** no try/catch — let `DioException` propagate to repo
15. **Entity rule:** only create an Entity for data shown in UI or used in business logic
16. **Cubit-per-feature, not per-screen**
17. **Selector widgets with multiple options take a `Map<String, IconData>` for icons**
18. **Every `onGenerateRoute` case must forward `settings: settings` to `MaterialPageRoute`** — fixed this session after this exact omission silently broke `ModalRoute.of(context)?.settings.arguments` reads (see §5/§6)
19. **No global mutable variables for cross-screen one-off messages** — pass via route `arguments` instead (see §5/§6)

> ⚠️ If a new error occurs → always ask for the related file before attempting a fix.
> ⚠️ Before proposing a debugging fix → confirm the actual root cause via prints/logs first, don't fix the first plausible suspect.

---

## 5. Global app infrastructure — current state (post this session)

**`main.dart` globals:**
```dart
final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
// pendingSnackBarMessage REMOVED this session — no longer exists.
```
> `MultiBlocProvider` in `main.dart` no longer calls `getIt<NotificationsCubit>().getNotifications()` at startup — moved to `MainView.initState()`.

**401 interceptor in `ApiService` (final, working, confirmed this session):**
```dart
onError: (error, handler) {
  if (error.response?.statusCode == 401) {
    Prefs.remove('token');
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      LoginView.routeName,
      (route) => false,
      arguments: 'انتهت صلاحية جلستك، يرجى تسجيل الدخول مجدداً',
    );
  }
  return handler.next(error);
},
```

**`LoginViewBody` (final, working, confirmed this session):**
- `StatefulWidget`, reads message via `ModalRoute.of(context)?.settings.arguments as String?` inside `addPostFrameCallback`
- No global variable involved — each navigation owns its own arguments, nothing to clear afterward

**`on_generate_routes.dart`:** every single case now passes `settings: settings` to its `MaterialPageRoute` — this was the actual root cause of the SnackBar bug (arguments were silently dropped for every route, not just LoginView).

**`MainView` — `NotificationsCubit.getNotifications()` trigger points (decided final, all 3 intentional):**
1. `initState()` — covers "just logged in" + "app restarted while still logged in"
2. `didPopNext()` — covers returning from a pushed screen
3. `_onTabChanged()` — covers returning to the home tab specifically
> Confirmed this session: NOT a bug that it's called from 3 places. User explicitly wants notifications "always fresh."

**`NotificationsCubit.getNotifications()` internal behavior (confirmed, not a bug):**
- Emits `NotificationsSuccess` once after fetching the list
- Emits `NotificationsSuccess` again after `_fetchUnreadCount()` IF the unread count changed
- Two emits per call is intentional (two independent concerns) — left as-is by explicit decision

**Splash flow (`splash_view_body.dart`)** — unchanged from before, still correct:
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

---

## 6. Next Steps (in order)

1. **Profile — API Integration** — `GET /auth/me` + `POST /student_info` + `POST /auth/update-Password` — all use cases already in `auth` domain — **top priority, not yet started**
2. **Search Debounce** — 500ms in `search_view_body.dart` — small, quick task
3. **Faheem/Chat AI** — `POST /aiChat/send` (waiting on backend) — ask sayed for status next session
4. **Fav Pagination** — after sayed fixes the backend bug

**Backend conversation needed with sayed:** duplicate-email-but-unverified edge case — no frontend fix possible (unchanged, still open).

**No open debugging items from this session** — 401/SnackBar/Notifications trigger work is fully resolved and confirmed working.

---

## 7. Preferences & Working Style

- **Sends code and asks "what do you think" or "explain"** — wants to understand, not just copy
- **Finds bugs himself** and comes to ask — doesn't wait to be told
- **Prefers short answers** — no long explanations, get to the point
- **Says "continue"** when he wants to keep going
- **Rejects over-engineering**
- **Asks "why"** before executing — understands the decision first
- **Compares against existing patterns**
- **Values consistency**
- **Gives direct feedback** (joking, e.g. "you're hallucinating")
- **Confirms before execution**
- **Works in Arabic** even for technical topics
- **Uploads lib.zip** with every checkpoint — read before replying
- **Sends API responses as JSON** when debugging — treat as ground truth
- **Uses Postman** to verify before talking to the team
- **Doesn't like refactoring** after Claude sends code
- **Catches contradictions quickly**
- **Commands are short and direct:** "fix", "send", "look at the whole code"
- **Doesn't want comments removed** from code
- **Uses inline review comments** to ask "why" about a specific line
- **Sometimes re-asks the same architectural question** — wants consistent answer
- **When debugging:** expects Claude to ask for the relevant file first before guessing
- **When Claude asks for a file and it's in the zip:** will say "معاك كل حاجة" — use the zip
- **Prefers SnackBar over Toast**
- **Sends screenshots of UI bugs** — diagnose root cause in framework/widget behavior
- **Reports backend/data inconsistencies he notices himself**
- **Will explicitly call out if Claude writes code during a discussion turn**
- **Catches Claude when it proposes a solution that contradicts itself mid-session**
- **When debugging, sends print log output** — read it carefully before proposing a fix
- **Figures out root cause himself from logs** and points it out directly
- **Runs the app himself, pastes raw console/logcat output** (including noise) — extract the relevant lines yourself
- **Pushes back mid-debugging when a fix changes behavior but doesn't match expectation** — treat as new diagnostic data, re-diagnose, don't assume "still broken"
- **Sometimes pastes a full transcript from another chat/session and says "اقرا دا"** — read fully, absorb as ground truth, summarize resolved vs. open before proceeding
- **When closing a session, wants full memory continuity** — files should let a fresh chat pick up with zero re-explaining

> ⚠️ **Important note:** If a new error occurs, always ask for the related file before attempting to fix it. If lib.zip was uploaded, read it from there.
> ⚠️ **Debugging discipline:** confirm root cause via logs/prints before proposing a fix — don't fix the first plausible-looking suspect.

---

> 📂 Full reference (project structure, all entities, all endpoints, code snippets, decisions log) → see `archive.md`