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
- **Added packages:** `url_launcher` (open university website), **`pinput`** (OTP input UI — decided this session, not yet confirmed added to pubspec.yaml)
- **Code comments:** **English only as of this session** (previously Arabic — this is a hard switch going forward)

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
| **auth** | ✅ | ✅ | 🟡 in progress | See §5 below for exact status |
| **profile** | ❌ | ❌ | ✅ | 4 screens UI done — needs Auth first (now unblocked, not started) |
| **faheem** | ✅ | ❌ | ✅ | Chat UI + entities — waiting on backend |
| **splash** | ❌ | ❌ | ✅ | Needs Auth first (now unblocked, not started) |
| **on_boarding** | ❌ | ❌ | ✅ | Needs Auth first (now unblocked, not started) |

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

> ⚠️ If a new error occurs → always ask for the related file before attempting a fix.

---

## 5. Auth Feature — Detailed Status (current focus)

**Domain layer — ✅ Done**
- `UserEntity` (id, name, email, avatar?, type)
- `AuthRepo` (abstract, 8 methods: login, register, verifyOtp, forgetPassword, resendOtp, resetPassword, saveStudentInfo, updatePassword, getMe)
- Use cases: `LoginUseCase`, `RegisterUseCase`, `VerifyOtpUseCase`, `ForgetPasswordUseCase`, `ResendOtpUseCase`, `ResetPasswordUseCase`, `SaveStudentInfoUseCase`, `UpdatePasswordUseCase`, `GetMeUseCase`
- No `AuthEntity` — removed; tokens have no UI representation

**Data layer — ✅ Done**
- `UserModel extends UserEntity` with `fromJson`
- `AuthRemoteDataSource` (abstract) + `AuthRemoteDataSourceImpl` — no try/catch, login() saves tokens to Prefs directly, verifyOtp() returns the access_token as String (doesn't auto-save — repo/cubit decides)
- `AuthRepoImpl implements AuthRepo` — catches `DioException` → `ServerFailure.fromDioError(e)`

**Core file changes made this session:**
- `ApiService.postWithToken({endpoint, token, data})` — added for the forgot-password temp-token flow
- `BackendEndpoints` — added: `login`, `register`, `verifyOtp`, `forgetPassword`, `resendOtp`, `resetPassword`, `saveStudentInfo`, `updatePassword`, `getMe`, `refreshToken`
- `Prefs.remove(key)` — activated (was commented out)

**Presentation layer — 🟡 In progress, paused mid-build**

Cubits (done):
- `AuthCubit` — login, register, forgetPassword, resetPassword (takes `tempToken`), saveStudentInfo, logout (clears Prefs tokens)
- `OtpCubit` — verifyOtp (returns token via `OtpSuccess(token)`), resendOtp, countdown timer (30s, `OtpTick`/`OtpResendEnabled` states)

Views sent so far (12 files):
- `LoginView`, `LoginViewBody`, `LoginForm`
- `AuthHeader` (shared across all auth screens — logo/icon + title + subtitle)
- `AuthSocialButtons` (shared — Google/iCloud buttons, UI only, no backend action)
- `SignUpView`, `SignUpViewBody`, `SignUpForm`
- `ForgotPasswordView`, `ForgotPasswordViewBody`
- `OtpView`, `OtpViewBody` (uses `pinput` package, `OtpArgs{email, isRegister}` controls post-verify navigation)

**Still pending — next steps when resuming:**
1. `ResetPasswordView` + `ResetPasswordViewBody` — receives `tempToken` via route argument, calls `AuthCubit.resetPassword`
2. `SetupView` + `SetupViewBody` — student info form (study_section: "علمي/أدبي" with API values `science`/`literature`, scientific_department with API values `scientific`/`Mathematics`, governorate dropdown, percentage, age) + static "مجالات الاهتمام" interest chips (UI-only, no backend endpoint exists for this yet)
3. Add `pinput` to `pubspec.yaml` (decided, not confirmed written)
4. Register `AuthRepo`, `AuthRemoteDataSource`, all 9 use cases in GetIt (`registerSingleton`, per project convention)
5. Register all 6 auth routes in `on_generate_routes.dart`
6. Confirm `AndroidManifest.xml` / `main.dart` need no further changes for auth (not yet discussed)

---

## 6. Next Steps (in order)

1. **Auth** — 🟡 in progress (see §5) — finish ResetPasswordView, SetupView, GetIt registration, routes
2. **Splash** — token check → MainView or OnBoarding
3. **OnBoarding** — mark seen in SharedPreferences
4. **Profile — API Integration** — `GET /auth/me` (use case already built: `GetMeUseCase`) + `POST /student_info` (already built: `SaveStudentInfoUseCase`) + `POST /auth/update-Password` (already built: `UpdatePasswordUseCase`) — all 3 use cases already exist in `auth` domain, profile just needs to call them
5. **Faheem/Chat AI** — `POST /aiChat/send` (waiting on backend)
6. **Search Debounce** — 500ms in `search_view_body.dart`
7. **Fav Pagination** — after sayed fixes the backend bug

---

## 7. Preferences & Working Style

- **Sends code and asks "what do you think" or "explain"** — wants to understand, not just copy
- **Finds bugs himself** and comes to ask — doesn't wait to be told
- **Prefers short answers** — no long explanations, get to the point
- **Says "continue"** when he wants to keep going
- **Rejects over-engineering** — like refusing `UniversityModel` nested inside `UniEntity`, or refusing extra Cubits when one Cubit can cover a flow
- **Asks "why"** before executing — understands the decision first
- **Compares against existing patterns** — "see how we did it in the other feature"
- **Values consistency** — if another feature did something a certain way, he'll do it the same way
- **Gives direct feedback** — like "you're hallucinating" or "you're dumb man" (joking)
- **Confirms before execution** — verifies Claude understood the requirement before writing code
- **Works in Arabic** even for technical topics
- **Uploads lib.zip** with every checkpoint — read the original code before replying — and **re-uploads it again after receiving files to verify Claude's output landed correctly** before moving to the next layer
- **Sends API responses as JSON** when debugging — treat them as ground truth
- **Uses Postman** to verify before talking to the team
- **Doesn't like refactoring** after Claude sends code — prefers to stay in control himself
- **Catches contradictions quickly** — "you said above you'd remove the fav cubit"
- **Notices solution inconsistencies** — like `registerLazySingleton` when the whole codebase uses `registerSingleton`
- **Trusts himself** — reviews code himself when in doubt
- **If Claude is wrong** — tells him directly and won't go along with a wrong answer
- **Commands are short and direct:** "fix", "send", "look at the whole code"
- **Doesn't want comments removed** from code
- **Comments in code must now be in English** — changed this session (was Arabic-only before)
- **Uses inline review comments on sent files** to ask "why" about a specific line — expects a precise answer about that line, not a re-explanation of the whole file
- **Sometimes re-asks the same architectural question from a different angle** — wants the same consistent answer, treats it as a check not a new question
- **Appreciates being asked "act as an X expert"** and getting the direct expert opinion, even if it slightly second-guesses a recent decision

> ⚠️ **Important note:** If a new error occurs, always ask for the related file before attempting to fix it.

---

> 📂 Full reference (project structure, all entities, all endpoints, code snippets, decisions log) → see `archive.md`