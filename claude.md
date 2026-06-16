# Claude Memory File — Core (Active)
> Last updated: June 2026 (session: auth polish + UX fixes)

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
- **Code comments:** **English only** (hard rule — no Arabic comments)

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
| **auth**          | ✅     | ✅   | ✅           | Complete + polished this session — see §5. UX decisions, token-save bug fix, validation fixes done  |
| **profile**       | ❌     | ❌   | ✅           | 4 screens UI done — needs Auth (now done), API integration not started — **next up**                |
| **faheem**        | ✅     | ❌   | ✅           | Chat UI + entities — waiting on backend                                                             |
| **splash**        | ❌     | ❌   | ✅           | Needs token check logic                                                                             |
| **on_boarding**   | ❌     | ❌   | ✅           | Needs SharedPreferences seen flag                                                                   |

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
17. **Selector widgets with multiple options take a `Map<String, IconData>` for icons** — never one shared `icon` reused across all options (fixed this session in `StudyTypeSelector`)

> ⚠️ If a new error occurs → always ask for the related file before attempting a fix.

---

## 5. Auth Feature — Complete & Polished ✅

**Domain layer — ✅ Done**

- `UserEntity` (id, name, email, avatar?, type)
- `AuthRepo` (abstract, 9 methods: login, register, verifyOtp, forgetPassword, resendOtp, resetPassword, saveStudentInfo, updatePassword, getMe)
- Use cases: `LoginUseCase`, `RegisterUseCase`, `VerifyOtpUseCase`, `ForgetPasswordUseCase`, `ResendOtpUseCase`, `ResetPasswordUseCase`, `SaveStudentInfoUseCase`, `UpdatePasswordUseCase`, `GetMeUseCase`
- No `AuthEntity` — tokens have no UI representation

**Data layer — ✅ Done**

- `UserModel extends UserEntity` with `fromJson`
- `AuthRemoteDataSource` (abstract) + `AuthRemoteDataSourceImpl` — no try/catch
- `login()` saves tokens to Prefs directly
- `verifyOtp()` returns access_token as `String` — Cubit/View decides what to do with it
- `AuthRepoImpl implements AuthRepo` — catches `DioException` → `ServerFailure.fromDioError(e)`

**Presentation layer — ✅ Done + polished this session**

Cubits:

- `AuthCubit` — login, register, forgetPassword, resetPassword (takes `tempToken`), saveStudentInfo, logout
- `OtpCubit` — verifyOtp (returns token via `OtpSuccess(token)`), resendOtp, countdown timer (30s)

Views (all built):

- `LoginView` + `LoginViewBody` + `LoginForm` — success → `pushNamedAndRemoveUntil(MainView)`, no SnackBar
- `SignUpView` + `SignUpViewBody` + `SignUpForm` — **updated this session:** password strength indicator + live confirm-match check (border color + text), Terms checkbox opens bottom sheet
- `ForgotPasswordView` + `ForgotPasswordViewBody`
- `OtpView` + `OtpViewBody` — `OtpArgs{email, isRegister}` controls navigation. **Bug fixed this session:** register flow now saves `state.token` to `Prefs` before navigating to `SetupView` (was missing — caused unauthenticated error on `saveStudentInfo`)
- `ResetPasswordView` + `ResetPasswordViewBody` + `ResetPasswordForm` + `VerifiedBadge` — **updated this session:** same live confirm-match recheck behavior as SignUpForm (editing password after confirm is filled re-validates match)
- `SetupView` + `SetupViewBody` + `SetupGovernorateDropdown` + `SetupPercentageField` + `SetupAgeField` — **updated this session:** success SnackBar "تم إنشاء حسابك بنجاح ✓" added before navigating to MainView (this is the true end-of-register-flow success point)
- `AuthHeader` (shared), `AuthSocialButtons` (UI-only placeholders)
- `StudyTypeSelector` (moved to `core/widgets`, was `PersonalDataStudyTypeSelector` in profile) — now takes `Map<String, IconData>` instead of single `icon`
- `TermsAndConditionsSheet` (new, `core/widgets`) — bottom sheet, static content, opened from `TermsAndConditions` widget's "الشروط والأحكام" tap

**GetIt — ✅ Registered:**
`AuthRemoteDataSource`, `AuthRepo`, `LoginUseCase`, `RegisterUseCase`, `VerifyOtpUseCase`, `ForgetPasswordUseCase`, `ResendOtpUseCase`, `ResetPasswordUseCase`, `SaveStudentInfoUseCase`, `UpdatePasswordUseCase`, `GetMeUseCase`

**Routes — ✅ Registered:**
`LoginView`, `SignUpView`, `ForgotPasswordView`, `OtpView(OtpArgs)`, `ResetPasswordView(String tempToken)`, `SetupView`

**Auth flow (confirmed working):**

- Register → OtpView(isRegister:true) → token saved to Prefs → SetupView → saveStudentInfo (authenticated ✅) → SnackBar success → MainView
- ForgotPassword → OtpView(isRegister:false) → ResetPasswordView(tempToken as nav argument, NOT saved to Prefs) → LoginView
- Login → MainView (no SnackBar, immediate)

**Core fixes made for auth (cumulative):**

- `ApiService.postWithToken()` — overrides Authorization header for temp-token calls
- Interceptor fix: `options.headers.keys.any((k) => k.toLowerCase() == 'authorization')` — case-insensitive check
- `Prefs.remove(key)` — activated
- **This session:** `Prefs.setString('token', state.token)` added in `OtpViewBody` for the register-flow branch
- **This session:** `CustomTextFormField`'s `errorStyle: TextStyle(fontSize:0, height:0)` removed (was hiding ALL validation error text app-wide) + `autovalidateMode: AutovalidateMode.onUserInteraction` added

**Known UX decisions (do not revisit unless asked):**
- Register `AuthSuccess` → no SnackBar (mid-flow, not real completion)
- Setup `AuthSuccess` → SnackBar + navigate (real completion point)
- Login `AuthSuccess` → no SnackBar, immediate navigate
- Terms & Conditions → bottom sheet, not full page, static content

---

## 6. Next Steps (in order)

1. **Splash** — token check → MainView or OnBoarding
2. **OnBoarding** — mark seen in SharedPreferences
3. **Profile — API Integration** — `GET /auth/me` (`GetMeUseCase`) + `POST /student_info` (`SaveStudentInfoUseCase`) + `POST /auth/update-Password` (`UpdatePasswordUseCase`) — all use cases already in `auth` domain
4. **Faheem/Chat AI** — `POST /aiChat/send` (waiting on backend)
5. **Search Debounce** — 500ms in `search_view_body.dart`
6. **Fav Pagination** — after sayed fixes the backend bug

**Open item (discussed, not yet decided/built):** confirm-password validator mismatch case currently returns `''` to suppress duplicate text but still reserves blank error-line space (Flutter behavior). Proposed fix: move mismatch check fully out of `validator`, drive red border via existing `borderColor` prop only, block submit via explicit check in `_submit()`. Not yet approved — discuss before implementing. Decide if this also applies to `ResetPasswordForm`.

**Backend conversation needed with sayed:** duplicate-email-but-unverified edge case — `/register` creates the user record immediately (before OTP verification), so if a user abandons the flow pre-OTP, retrying registration with the same email gets a generic "already registered" error with no way to distinguish verified vs unverified accounts. No frontend fix possible without a backend change (either allow re-registration for unverified emails, or return a distinguishable error/status).

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
- **Reports backend/data inconsistencies he notices himself** (dashboard, Postman) — treat as a flag for a sayed conversation, not something to silently work around
- **Will explicitly call out if Claude writes code during a discussion turn** — only implement after an explicit go-ahead ("fix", "go", a clear choice between options)

> ⚠️ **Important note:** If a new error occurs, always ask for the related file before attempting to fix it. If lib.zip was uploaded, read it from there.

---

> 📂 Full reference (project structure, all entities, all endpoints, code snippets, decisions log) → see `archive.md`