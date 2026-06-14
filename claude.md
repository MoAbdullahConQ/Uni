# Claude Memory File — Core (Active)
> Last updated: June 2026

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
- **Added packages:** `url_launcher` (for opening university website in browser)

---

## 3. Features Status

| Feature | Domain | Data | Presentation | Notes |
|---|---|---|---|---|
| **browse** | ✅ | ✅ | ✅ | Cursor pagination + FavCubit + per_page=10 + NoInternetWidget + retry |
| **fav** | ✅ | ✅ | ✅ | add/remove + optimistic update + rollback + deduplication + NoInternetWidget + retry |
| **search** | ✅ | ✅ | ✅ | Cubit + page-based pagination + recent searches |
| **home** | ✅ | ✅ | ✅ | Trending + Recommended + retry on tab switch + retry on didPopNext |
| **notifications** | ✅ | ✅ | ✅ | Global cubit + RouteObserver + unread count + NoInternetWidget + retry + ActionFailure as snackbar |
| **guide** | ✅ | ✅ | ✅ | Articles + pagination + UI search filter + retry on failure + NoInternetWidget in GuideArticlesView |
| **uni_detail** | ✅ | ✅ | ✅ | API integration done — 4 parallel calls via Future.wait + NoInternetWidget + retry + rate + website |
| **profile** | ❌ | ❌ | ✅ | 4 screens UI done — needs Auth first |
| **faheem** | ✅ | ❌ | ✅ | Chat UI + entities — waiting on backend |
| **auth** | ❌ | ❌ | ❌ | Not started |
| **splash** | ❌ | ❌ | ✅ | Needs Auth first |
| **on_boarding** | ❌ | ❌ | ✅ | Needs Auth first |

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

> ⚠️ If a new error occurs → always ask for the related file before attempting a fix.

---

## 5. Next Steps (in order)

1. **Auth** — Login, Register, OTP, Forgot Password
2. **Splash** — token check → MainView or OnBoarding
3. **OnBoarding** — mark seen in SharedPreferences
4. **Profile — API Integration** — `GET /auth/me` + `POST /student_info`
5. **Faheem/Chat AI** — `POST /aiChat/send` (waiting on backend)
6. **Search Debounce** — 500ms in `search_view_body.dart`
7. **Fav Pagination** — after sayed fixes the backend bug

---

## 6. Preferences & Working Style

- **Sends code and asks "what do you think" or "explain"** — wants to understand, not just copy
- **Finds bugs himself** and comes to ask — doesn't wait to be told
- **Prefers short answers** — no long explanations, get to the point
- **Says "continue"** when he wants to keep going
- **Rejects over-engineering** — like refusing `UniversityModel` nested inside `UniEntity`
- **Asks "why"** before executing — understands the decision first
- **Compares against existing patterns** — "see how we did it in the other feature"
- **Values consistency** — if another feature did something a certain way, he'll do it the same way
- **Gives direct feedback** — like "you're hallucinating" or "you're dumb man" (joking)
- **Confirms before execution** — verifies Claude understood the requirement before writing code
- **Works in Arabic** even for technical topics
- **Uploads lib.zip** with every checkpoint — read the original code before replying
- **Sends API responses as JSON** when debugging — treat them as ground truth
- **Uses Postman** to verify before talking to the team
- **Doesn't like refactoring** after Claude sends code — prefers to stay in control himself
- **Catches contradictions quickly** — "you said above you'd remove the fav cubit"
- **Notices solution inconsistencies** — like `registerLazySingleton` when the whole codebase uses `registerSingleton`
- **Trusts himself** — reviews code himself when in doubt
- **If Claude is wrong** — tells him directly and won't go along with a wrong answer
- **Commands are short and direct:** "fix", "send", "look at the whole code"
- **Doesn't want comments removed** from code
- **Comments in code must be in Arabic** — not English

> ⚠️ **Important note:** If a new error occurs, always ask for the related file before attempting to fix it.

---

> 📂 Full reference (project structure, all entities, all endpoints, code snippets, decisions log) → see `archive.md`