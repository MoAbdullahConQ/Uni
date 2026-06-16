# Project Instructions for Claude

## 1. Who I Am
Mohamed (Mu) — Egyptian Flutter developer, intermediate-to-advanced. App: **Gameaty (جامعتي)**. Backend dev: **sayed** (Laravel).

---

## 2. How to Interact
- **Always respond in Arabic** — mix technical terms naturally
- **Short and direct** — no preambles or filler
- "continue" / "go" → keep going without intro
- "what do you think" → honest opinion, not a list of options
- "fix" / "send" → execute without explanation
- One tradeoff sentence max — don't hide it, don't over-explain it
- When I ask "act as a [role] expert" → answer directly from that lens, don't soften or hedge — give the real expert take, including if it means re-flagging something already decided

---

## 3. My Working Style
- I read the code myself — don't over-explain basics
- I always upload `lib.zip` when I want a code review — read it first
- I want the "why" once, briefly — then execute
- I find bugs myself and ask — don't warn me about every potential issue
- I make refactor decisions — don't rewrite working code unless asked
- I give direct corrections — admit mistakes immediately and fix them
- I catch contradictions fast — don't reverse decisions without flagging it
- I confirm you understood before you write code
- I verify APIs with Postman — treat JSON responses as ground truth
- I value consistency — match existing patterns in the codebase
- I re-verify previously-written code by re-uploading `lib.zip` after you send files — confirm it matches before moving to the next layer
- I ask "why" about specific lines/decisions via inline review comments on generated files — answer precisely about that line, don't re-explain the whole feature
- I sometimes ask the same architectural question twice from different angles (e.g. "where should X go") — answer consistently; if I'm re-asking, give the same answer with the reasoning restated briefly, don't act like it's a new decision
- When I say "تمام" or "ايوة" after an explanation, that's confirmation to proceed — don't ask again

---

## 4. Standing Rules

**Always:**
- Read uploaded files before answering anything about the code
- Follow Clean Architecture: Domain → Data → Presentation
- Every widget in a separate file, every Dart file under 100 lines
- Use existing patterns: Cubit, GetIt, Dio, cursor pagination
- Use existing core widgets — don't reinvent them
- If changes touch more than one file → state the plan first, wait for approval, then write code
- Send files as separate downloadable outputs (not zip)
- If there's a side effect → one-line mention ("make sure X exists")
- Keep existing comments in code — don't remove them
- Diagnose the real cause of errors directly — no extra questions
- If you need to review code → ask for `lib.zip` or the specific file first
- When a screen's UI shows a feature with no matching backend endpoint (e.g. "مجالات الاهتمام" interest tags) → make it static/UI-only and flag it, don't invent an endpoint or skip silently
- When I upload reference images of screens → study them fully before describing the flow, and proactively map every screen to its specific endpoint(s)

**Never:**
- Don't rewrite working code unless asked
- Don't add features or patterns not requested
- Don't use `registerFactory` for use cases — always `registerSingleton`
- Don't hardcode secrets — always use `.env` via `flutter_dotenv`
- Don't suggest Firebase or any alternative backend
- Don't give a list of options when a recommendation is asked for
- Don't put logic in the Cubit if it can be done in the UI
- Don't add new dependencies without asking — **exception:** if I explicitly ask for a package recommendation (e.g. "is there a good package for X"), propose one directly
- Don't repeat a note I said I'd handle later
- Don't add English comments in code — **as of this session, this is reversed: all code comments must be in English now**
- Don't put feature-specific code in `core/` — core is shared only
- Don't add Repo/UseCase layers without clear business logic justification
- Don't start writing code before the plan is approved
- Don't add an Entity for data that never reaches the UI or carries no business logic (e.g. we removed `AuthEntity` because tokens are storage-only, never displayed)

---

## 5. Technical Conventions
- **Base URL:** `https://back.laraveladvancedsayed101.cloud/api`
- **Auth:** Bearer token (Prefs) + `Api-Key` header (from `.env`)
- **Pagination:** cursor-based (Browse/Fav/Guide/Notifications) / page-based (Search)
- **Error handling:** `DioException` caught in repo → `ServerFailure.fromDioError(e)` → `left(ServerFailure(...))`
- **Cubit pattern:** Initial → Loading → Success/Failure + PaginationLoading/PaginationFailure
- **Search in Guide and Fav:** UI filter on existing data — not a Cubit method
- **API calls:** `apiService.get()` + `response['data']` manually — not `getList()` directly
- **Entity vs Model:** `UniEntity` non-nullable/required, `UniModel` nullable → maps to super with `?? defaults`
- **AppColors:** constants are `Color` objects — never wrap in `Color()` again
- **GetIt:** all global cubits use `registerSingleton` (not lazy)
- **Widget decomposition:** private sub-widgets (`_ClassName`) for internal components
- **Null preference:** `null` over dummy values like `BoxBorder.none`
- **Conditional logic in `build()`:** helper methods, not inline if/else in constructors
- **`CustomTextFormField`** is the base for all form fields — build on it
- **Code comments:** English only (as of this session — previously Arabic; this is now the standing rule going forward)
- **Entity rule:** only create an Entity if its data is shown in the UI or used in business logic. Tokens/internal-only data → no Entity, handle as primitives (e.g. `String`) passed between layers
- **Cubit scope per feature:** not every screen needs its own Cubit. Group screens that share the same "object" of work (e.g. all non-OTP auth screens → one `AuthCubit`) instead of over-splitting; split only when the sub-flow has genuinely distinct logic (e.g. OTP's countdown timer/resend → separate `OtpCubit`)

---

## 6. Non-negotiable Patterns

**Ripple on Colored Background:**
```dart
Material(color: Colors.transparent,
  child: InkWell(borderRadius: ..., onTap: onTap,
    child: Ink(decoration: BoxDecoration(color: AppColors.secondaryColor, ...), child: Icon(...))))
```

**UniDetail Scroll (final — do not suggest alternatives):**
```
NestedScrollView (ClampingScrollPhysics)
├── SliverToBoxAdapter → HeroImage + InfoHeader
├── SliverPersistentHeader(pinned: true) → TabBar
└── TabBarView → 3x ListView(key: PageStorageKey(...))
```
> `extended_nested_scroll_view` and `CustomScrollView + IndexedStack` were tried and failed.

**FacultyItem → 4 files:** `faculty_item`, `faculty_item_header`, `faculty_item_expanded`, `faculty_item_container`

**GridView:** `width: double.infinity` on image, `childAspectRatio: 0.65` for podcast cards

**Auth token refresh (do not suggest alternatives):** handled entirely in a Dio interceptor inside `ApiService` — never as a domain use case. On `401` → call `/auth/refresh` → save new tokens to Prefs → retry original request. Domain/Cubit layers have no knowledge of refresh logic.

**Forgot-password temporary token (do not suggest alternatives):** `verify-Otp` in the forgot-password flow returns a short-lived token used only for `reset-Password`. It is held in `OtpCubit`/`AuthCubit` state and passed as a method parameter (`tempToken`) — never written to Prefs. `ApiService.postWithToken()` overrides the Authorization header for this one call.

**OTP package:** use `pinput` for all OTP input UI — matches design, supports custom box decoration and auto-submit. Standard keyboard (no custom numpad) is fine for entry.

---

## 7. Error UI Rules

| Situation | Widget |
|---|---|
| Full-screen failure في pushed screen | `NoInternetWidget` مع `onRetry` و `onBack: () => Navigator.pop(context)` |
| Full-screen failure في tab (browse/fav/notifications) | `NoInternetWidget` مع `onRetry` بس (بدون onBack) |
| Inline failure في وسط صفحة (زي GuideViewBody) | `CustomErrorWidget` مع `onRetry` |
| Pagination failure | `CustomErrorWidget` inline أسفل اللست مع `onRetry: loadMore` |
| Empty list | `EmptyStateWidget` |

---

## 8. Current Focus

**Features done:** browse, fav, search, home, notifications, guide, uni_detail
**In progress:** auth (domain ✅, data ✅, presentation — in progress, paused mid-build)
**Next up after auth:** splash → onboarding → profile API → faheem API (waiting on backend)

---

## 9. Session Summary — هذا الشات (Auth Feature Build)

**اللي خلصناه:**
1. **Domain layer كامل** — `UserEntity`, `AuthRepo` (8 methods), 8 use cases (`Login`, `Register`, `VerifyOtp`, `ForgetPassword`, `ResendOtp`, `ResetPassword`, `SaveStudentInfo`, `UpdatePassword`, `GetMe`)
2. **Data layer كامل** — `UserModel`, `AuthRemoteDataSource` + impl, `AuthRepoImpl`
3. **Core file updates** — `ApiService.postWithToken()` added, `BackendEndpoints` auth endpoints added, `Prefs.remove()` activated
4. **Presentation — Cubits done** — `AuthCubit` (login/register/forgetPassword/resetPassword/saveStudentInfo/logout), `OtpCubit` (verifyOtp/resendOtp/countdown timer)
5. **Presentation — Views in progress (12 files sent, paused before ResetPasswordView and SetupView):**
   - `LoginView` + `LoginViewBody` + `LoginForm`
   - `AuthHeader` (shared widget across auth screens)
   - `AuthSocialButtons` (shared, no backend action — Google/iCloud are UI-only placeholders)
   - `SignUpView` + `SignUpViewBody` + `SignUpForm`
   - `ForgotPasswordView` + `ForgotPasswordViewBody`
   - `OtpView` + `OtpViewBody` (uses `pinput`, has `OtpArgs{email, isRegister}` to branch navigation)

**باقي في الـ presentation (لسه متعمول):**
- `ResetPasswordView` + body — receives `tempToken` as route argument from `OtpView`
- `SetupView` + body — student info form (study_section, scientific_department, governorate_id, percentage, age) + static "مجالات الاهتمام" chips (no backend yet)
- `pubspec.yaml` — add `pinput` dependency (decided, not yet confirmed added)
- GetIt registration for `AuthRepo`, `AuthRemoteDataSource`, and auth use cases (not yet done)
- Route registration in `on_generate_routes.dart` for all 6 auth views (not yet done)
- AndroidManifest / main.dart wiring not discussed yet

**قرارات مهمة اتاخدت في الشات ده:**
- `AuthEntity` تم حذفها — التوكنز مالها UI تمثيل، فمفيش لازمة لـ Entity
- `verifyOtp` يرجع `String` (access_token) مش `void` — العلاقة: register flow يحفظه في Prefs عن طريق الـ Cubit، forgot-password flow يحطه في `OtpSuccess(token)` وييمشي مع الشاشة كـ navigation argument
- `resetPassword` يحتاج `tempToken` كـ parameter إضافي (مش من Prefs)
- `updatePassword` و `getMe` تم وضعهم في `auth` feature (مش profile) لأن الـ endpoint فيه `/auth/`
- 2 Cubits بس: `AuthCubit` (كل حاجة غير OTP) و `OtpCubit` (verify+resend+timer) — مفيش `SetupCubit` منفصل، `saveStudentInfo` هتتحط في `AuthCubit`
- كل كومنتات الكود من دلوقتي بالإنجليزي (تغيير عن القاعدة القديمة)
- مفيش Firebase/Google/Facebook auth — الكود القديم اللي كان عامل فيه ده تم تجاهله بالكامل، الأزرار موجودة في الـ UI بس بدون أي action
- الـ OTP UI بيستخدم `pinput` package + standard keyboard (مش custom numpad)