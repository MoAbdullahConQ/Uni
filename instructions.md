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
- **When I say "افترح حلول" (suggest solutions) or we're clearly still discussing → list options with one-line tradeoffs each, do NOT write or edit code.** Only write code after I explicitly pick one or say "go"/"fix"/"اعمل كذا".
- **Never assume a discussion turn means "implement it"** — I will explicitly call this out if Claude jumps ahead (happened this session: Claude wrote code mid-discussion before being asked)

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
- **I send screenshots of the running app to point out visual/UX bugs** — study the screenshot fully before proposing a fix; identify the actual root cause (e.g. a Flutter framework behavior like reserved error-text space) not just the symptom
- **I report backend/data quirks I notice in the dashboard or API** (e.g. "email shows as registered but not verified") — flag the UX implication and tell me if it needs a backend conversation with sayed, don't just patch around it silently

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
- **When I upload a screenshot of a bug → diagnose the root cause in the underlying widget/framework behavior, not just describe what's visible**
- **When asked "ايه رأيك" on a UX/architecture decision (e.g. bottom sheet vs full screen) → give one clear recommendation with the reasoning, not a list of pros/cons to choose from**

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
- **Don't write/edit code while we're still in a discussion turn ("بنتناقش") — wait for an explicit go-ahead, even if a solution seems obvious**

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
- **Multi-option selector widgets (e.g. study-type selector) take a `Map<String, IconData>` for per-option icons** — never a single shared `icon` param that gets reused across all options
- **Register flow requires the verify-Otp token to be persisted to `Prefs` (key `'token'`) before navigating onward** — unlike forgot-password flow where the temp token is passed as a navigation argument only. Missing this causes "unauthenticated" on the next authenticated call (`saveStudentInfo`).
- **Password confirm-field UX pattern:** strength indicator + live match check (green/red border + "✓ matched" / "not matched" text below) on both password-setting screens (`SignUpForm`, `ResetPasswordForm`). When password is edited after confirm is already filled, match status re-validates against the new password value, not just on confirm's own onChanged.

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

**Register-flow token persistence (do not suggest alternatives):** `verify-Otp` in the register flow (`isRegister: true`) DOES get written to `Prefs` (`Prefs.setString('token', state.token)`) in `OtpViewBody` right before navigating to `SetupView` — unlike the forgot-password flow above. This is required because `SetupView`'s `saveStudentInfo` call needs a real Authorization header from the interceptor.

**OTP package:** use `pinput` for all OTP input UI — matches design, supports custom box decoration and auto-submit. Standard keyboard (no custom numpad) is fine for entry.

**Terms & Conditions UX (decided this session, do not suggest alternatives):** opens as a `DraggableScrollableSheet` bottom sheet (`TermsAndConditionsSheet` in `core/widgets`), not a full-page `Navigator.push`. Reasoning: secondary, short-read content shouldn't break navigation flow. Content is static/hardcoded (no backend endpoint), written once and treated as final unless asked to change.

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

**Features done:** browse, fav, search, home, notifications, guide, uni_detail, **auth (fully complete this session — see archive.md §Auth Feature)**
**Next up:** splash → onboarding → profile API → faheem API (waiting on backend)

**Open item from this session (not yet implemented):** confirm-password validator currently returns an empty string `''` on mismatch to keep the red border without a duplicate message — this still reserves blank line space in the field (Flutter reserves error-line height whenever `errorText != null`, even if empty). Recommended fix (discussed, NOT yet approved/built): move the mismatch check entirely out of `validator` (validator only checks "required"), drive the red border purely from the existing `borderColor` prop, and block submission via an explicit check inside `_submit()` instead of relying on `_formKey.currentState!.validate()` for this specific rule. Applies to `SignUpForm`'s confirm field; decide if `ResetPasswordForm` needs the same fix.

---

## 9. Session Summary — هذا الشات (Auth Polish + UX Fixes)

**اللي خلصناه:**
1. **Register success UX decided:** `AuthSuccess` بعد `register()` → ينقل لـ `OtpView` من غير SnackBar (مفيش "نجاح" حقيقي لسه، لسه في نص الفلو)
2. **Login success UX decided:** `AuthSuccess` بعد `login()` → `pushNamedAndRemoveUntil` لـ `MainView` من غير SnackBar (نجاح كامل وفوري، مفيش لازمة لرسالة إضافية)
3. **Setup/register-flow completion SnackBar:** اتفقنا إن "تم إنشاء حسابك بنجاح ✓" يظهر بعد `saveStudentInfo` في `SetupView` (آخر خطوة فعلية في الفلو الكامل)، مكتوب وتسلم في `setup_view_body.dart`
4. **Backend quirk اكتشفناه:** الإيميل بيتسجل في الداتابيز من `/register` نفسه (قبل OTP) — لو اليوزر قفل التطبيق قبل verify، السيرفر هيرفض إعادة التسجيل بنفس الإيميل برسالة "مستخدم بالفعل" من غير تمييز بين verified/unverified. **محتاج نقاش مع سايد** — لسه مفيش حل من ناحية الباك إند
5. **PersonalDataStudyTypeSelector → StudyTypeSelector:** تم نقلها لـ `core/widgets` (مستخدمة في auth وفي profile) وتم تغيير الـ `icon` (واحد) لـ `icons: Map<String, IconData>` — كل option بيجيب أيقونته بنفسه
6. **Bug حقيقي اتلقط ومتصلح:** في الـ register flow، `OtpViewBody` كانت بتنقل لـ `SetupView` من غير ما تحفظ التوكن في `Prefs` — يعني `saveStudentInfo` كانت بترجع unauthenticated. الفيكس: `Prefs.setString('token', state.token)` قبل الـ navigation. (الـ forgot-password flow كانت تمام لأنها بتمرر التوكن كـ argument مش لازم تتحفظ)
7. **SignUpForm — أضيف فيها password strength + match check** زي `ResetPasswordForm` بالظبط: `calcStrength()` + `SecurityStrengthIndicator` تحت password field، و match check (border أخضر/أحمر + رسالة "✓ متطابقتان"/"غير متطابقتين") تحت confirm field. تم تطبيق نفس التعديل على `ResetPasswordForm` كمان (لو الباسورد الأساسي يتغير بعد ما الكونفيرم متعبي، الماتش بيتعمل recheck فورًا)
8. **Terms & Conditions UX:** قررنا إنها bottom sheet (`DraggableScrollableSheet`) مش شاشة كاملة — اتكتب `TermsAndConditionsSheet` في `core/widgets` بمحتوى ثابت (7 أقسام: استخدام التطبيق، الحساب الشخصي، دقة المعلومات، الخصوصية، سلوك المستخدم، التعديلات، التواصل)
9. **Validation bug من screenshot:** `errorStyle: TextStyle(fontSize:0, height:0)` في `CustomTextFormField` كانت بتخفي كل رسائل الخطأ خالص (مش بس مشكلة محددة) — شيلناها، وأضفنا `autovalidateMode: AutovalidateMode.onUserInteraction` عشان الفورم تعمل revalidate لحظي بدل ما تفضل عارضة error قديم لحد submit تاني
10. **مشكلة تكرار النص اتلقطت:** بعد شيل الـ `errorStyle` الصفري، ظهر تكرار — رسالة الـ `validator` ("كلمة المرور غير متطابقة") + رسالة الـ match Text اليدوية ("كلمتا المرور غير متطابقتين") كانوا بيظهروا مع بعض. تم تجربة حل مؤقت (`validator` يرجع `''` بدل نص) لكن لسه فيه مشكلة: المساحة المحجوزة لسطر الـ error بتفضل موجودة حتى لو النص فاضي (سلوك Flutter framework) — **ده الـ open item في §8، الحل المقترح (نقل الـ match check برا الـ validator) لسه متناقش بس مش متبني**

**قرارات مهمة اتاخدت في الشات ده:**
- Register success ≠ SnackBar فورًا — السكسس الحقيقي بعد Setup بس
- Login success = فوري بدون SnackBar
- محتاجين نتكلم مع سايد عن duplicate-email-unverified edge case
- `StudyTypeSelector` بقت core widget بـ icons map بدل icon واحد
- Terms & Conditions = bottom sheet دايمًا، محتوى ثابت دايمًا
- **قاعدة سلوكية جديدة:** لو إحنا لسه في نقاش (مش "اعمل" أو "fix")، Claude ما ينفذش كود من غير إذن واضح — ده كان فيه احتكاك في الشات ده لازم يتجنب