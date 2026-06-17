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
- **Never assume a discussion turn means "implement it"** — I will explicitly call this out if Claude jumps ahead
- **When debugging, don't jump to a fix based on assumption — isolate the root cause step by step first** (add targeted debug prints/logs, confirm what's actually happening, THEN propose the fix). Happened this session: a plausible-sounding cause (global variable timing) was wrong; the real cause (missing `settings: settings` in `MaterialPageRoute`) only surfaced after step-by-step log tracing.
- **When I say "سيبها" (leave it) after a tradeoff discussion → that's a final decision, don't re-raise it unless something changes.** Happened this session with both the duplicate-success-emit question and the `didPopNext`/`_onTabChanged` notifications-refresh duplication.
- **If I ask "اشرح بأسلوب بسيط" (explain simply) → drop technical jargon, use plain short sentences, one concrete question at the end.** A technical explanation given once already wasn't landing — simplify immediately rather than repeating it more thoroughly.
- **Don't forget items I've already flagged as "next up" or waiting** (e.g. Faheem chat) — if I ask "what's next" and a known pending item isn't backend-ready, still mention it in the list with its blocked status, don't drop it silently.

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
- I sometimes ask the same architectural question twice from different angles — answer consistently; if I'm re-asking, give the same answer with the reasoning restated briefly, don't act like it's a new decision
- When I say "تمام" or "ايوة" after an explanation, that's confirmation to proceed — don't ask again
- **I send screenshots of the running app to point out visual/UX bugs** — study the screenshot fully before proposing a fix; identify the actual root cause, not just the symptom
- **I report backend/data quirks I notice in the dashboard or API** — flag the UX implication and tell me if it needs a backend conversation with sayed, don't just patch around it silently
- **When debugging, I run the app myself and paste raw console/log output** (often full Android logcat noise included) — read through the noise, extract the relevant Flutter/Bloc/print lines, and reason from those exact lines rather than guessing
- **I'll explicitly push back mid-debugging** (e.g. "دلوقتي بقا السناك بار بيظهر اول لما ادخل علي التطبيق اصلا") when a fix changes behavior but doesn't fully match what I expected — treat this as a new data point to re-diagnose, not as "the same bug still unfixed"
- **I sometimes paste a whole pasted-chat-transcript-style summary from another session/chat and say "اقرا دا"** — read it fully and absorb it as ground truth context before responding, then summarize back what's understood/resolved vs. still open
- **When I ask to update memory files at the end of a session, I want full continuity** — write the 3 files so a fresh chat with zero prior context can pick up exactly where we left off

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
- When a screen's UI shows a feature with no matching backend endpoint → make it static/UI-only and flag it, don't invent an endpoint or skip silently
- When I upload reference images of screens → study them fully before describing the flow, and proactively map every screen to its specific endpoint(s)
- **When I upload a screenshot of a bug → diagnose the root cause in the underlying widget/framework behavior, not just describe what's visible**
- **When asked "ايه رأيك" on a UX/architecture decision → give one clear recommendation with the reasoning, not a list of pros/cons to choose from**
- **When debugging a "feature not working" report → verify each link in the chain independently with logs/prints BEFORE proposing a fix** (e.g. confirm the trigger fires → confirm the data reaches the next layer → confirm the consuming widget reads it correctly) rather than fixing the first plausible-looking suspect
- **Avoid leaving commented-out dead code as "history"** when superseding a decision (e.g. removing a global variable) — delete cleanly, rely on git history instead

**Never:**
- Don't rewrite working code unless asked
- Don't add features or patterns not requested
- Don't use `registerFactory` for use cases — always `registerSingleton`
- Don't hardcode secrets — always use `.env` via `flutter_dotenv`
- Don't suggest Firebase or any alternative backend
- Don't give a list of options when a recommendation is asked for
- Don't put logic in the Cubit if it can be done in the UI
- Don't add new dependencies without asking — **exception:** if I explicitly ask for a package recommendation, propose one directly
- Don't repeat a note I said I'd handle later
- Don't add Arabic-only comments — **standing rule: all code comments in English**
- Don't put feature-specific code in `core/` — core is shared only
- Don't add Repo/UseCase layers without clear business logic justification
- Don't start writing code before the plan is approved
- Don't add an Entity for data that never reaches the UI or carries no business logic
- **Don't write/edit code while we're still in a discussion turn ("بنتناقش") — wait for an explicit go-ahead, even if a solution seems obvious**
- **Don't re-litigate a decision I closed with "سيبها"/"خليها كذا" unless new evidence comes up** — happened twice this session (duplicate-emit question, didPopNext/_onTabChanged duplication) and both times the answer was "leave it, it's intentional/fine"
- **Don't propose a root cause without first reproducing/confirming it via a debug print or log trace if the system already has logging infrastructure in place** — guessing wasted a turn this session (assumed timing/global-variable issue before confirming via prints that the real cause was missing `settings:` in route construction)

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
- **Code comments:** English only (standing rule)
- **Entity rule:** only create an Entity if its data is shown in the UI or used in business logic
- **Cubit scope per feature:** group screens sharing the same "object" of work instead of over-splitting
- **Multi-option selector widgets take a `Map<String, IconData>` for per-option icons**
- **Register flow requires the verify-Otp token to be persisted to `Prefs` before navigating onward** — unlike forgot-password flow where the temp token is passed as a navigation argument only
- **Password confirm-field UX pattern:** strength indicator + live match check on both password-setting screens
- **Session-expired / 401 redirect message travels as route `arguments` ONLY — no global mutable variable.** (Decided and implemented this session — see §6 below. Do not reintroduce a global `pendingSnackBarMessage`-style variable for any future cross-screen one-off message; pass it through `pushNamed(...)`'s `arguments` and read via `ModalRoute.of(context)?.settings.arguments` instead.)
- **Every `case` in `onGenerateRoute` must pass `settings: settings` to its `MaterialPageRoute`.** This was a real bug this session — routes that didn't need arguments today still silently drop `ModalRoute.of(context)?.settings.arguments` for any future use if `settings` isn't forwarded. Treat this as a permanent checklist item when adding a new route.
- **`NotificationsCubit.getNotifications()` is intentionally called from multiple places** (`MainView.initState`, `MainView.didPopNext`, `MainView._onTabChanged` when returning to home tab) — this is by design, not a bug, to keep the badge/list fresh across different navigation re-entry points. Confirmed/decided this session — do not "deduplicate" this without being asked.
- **`getNotifications()` legitimately emits `NotificationsSuccess` twice per call** (once after fetching the list, once after `_fetchUnreadCount()` if the count changed) — this is intentional, two separate concerns updating independently. Confirmed this session — do not flag as a bug or try to merge into one emit without being asked.

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
> Note: as currently implemented, 401 triggers a hard redirect to `LoginView` (token removed, no silent refresh-and-retry attempt). If silent refresh-and-retry is still the long-term target, that's a future task, not yet built — current behavior is "log out and redirect," confirmed working this session.

**Forgot-password temporary token (do not suggest alternatives):** `verify-Otp` in the forgot-password flow returns a short-lived token used only for `reset-Password`. It is held in `OtpCubit`/`AuthCubit` state and passed as a method parameter (`tempToken`) — never written to Prefs. `ApiService.postWithToken()` overrides the Authorization header for this one call.

**Register-flow token persistence (do not suggest alternatives):** `verify-Otp` in the register flow (`isRegister: true`) DOES get written to `Prefs` in `OtpViewBody` right before navigating to `SetupView`.

**OTP package:** use `pinput` for all OTP input UI.

**Terms & Conditions UX (decided, do not suggest alternatives):** opens as a `DraggableScrollableSheet` bottom sheet, not a full-page `Navigator.push`. Content is static/hardcoded, written once and treated as final unless asked to change.

**Session-expired redirect (decided this session, do not suggest alternatives):** 401 interceptor in `ApiService` calls `navigatorKey.currentState?.pushNamedAndRemoveUntil(LoginView.routeName, (route) => false, arguments: '<message>')` — message passed as route `arguments` only, no global variable. `LoginViewBody.initState` reads `ModalRoute.of(context)?.settings.arguments as String?` in an `addPostFrameCallback` and shows it as a SnackBar if non-null. No state needs clearing afterward since each navigation owns its own arguments.

**NotificationsCubit trigger point (decided this session, do not suggest alternatives):** `getNotifications()` is NOT called from `main.dart`/`MultiBlocProvider` at app startup. It's called from `MainView.initState()` (covers both "just logged in" and "app restarted while still logged in" cases), `MainView.didPopNext()`, and `MainView._onTabChanged()` when navigating back to the home tab — multiple intentional trigger points, not a bug to fix.

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

**Features done:** browse, fav, search, home, notifications, guide, uni_detail, auth, splash, on_boarding, **401 session-expired flow (fully fixed and confirmed this session)**
**Next up (in order):** Profile API integration → Search Debounce → Faheem (still waiting on backend, sayed hasn't confirmed status as of end of this session — ask next time)

---

## 9. Session Summary — هذا الشات (401 SnackBar Debug + Notifications Trigger Cleanup)

**اللي خلصناه:**
1. **Root cause حقيقي للـ SnackBar:** `onGenerateRoute` كانت بتعمل `MaterialPageRoute` من غير `settings: settings` لكل الـ cases — فالـ `arguments` كانت تضيع دايمًا، مش مشكلة timing أو global variable كما افترضنا الأول
2. **`pendingSnackBarMessage` global اتشال بالكامل** من `main.dart` — الرسالة دلوقتي بتسافر كـ route `arguments` بس، تتقرأ في `LoginViewBody.initState` عبر `ModalRoute.of(context)?.settings.arguments`
3. **كل الـ cases في `on_generate_routes.dart` بقت بتمرر `settings: settings`** — fix شامل مش بس لـ LoginView
4. **بعد الفيكس، اكتشفنا إن السناك بار كانت بتظهر "أول ما يفتح التطبيق"** — اتأكد إنه سلوك صحيح فعليًا (مش bug): `NotificationsCubit.getNotifications()` كانت بتتنادى تلقائي في `main.dart` بتوكن expired فعليًا → 401 حقيقي
5. **اتشال نداء `getNotifications()` من `main.dart`/`MultiBlocProvider` بالكامل** — مفيش نداء تلقائي عند فتح التطبيق
6. **اتضاف نداء `getNotifications()` في `MainView.initState()`** — تتحدث فور ما اليوزر يدخل MainView (بعد لوجن أو restart وهو logged in)
7. **اكتشفنا تكرار الـ `Success` state (مرتين/تلاتة)** — تم تشخيصه وتأكيده إنه سلوك مقصود مش bug:
   - مرتين بعد أول لوجن = `initState` + `didPopNext` (LoginView بتتعمل لها pop فوق MainView)
   - فحصنا `getNotifications()` نفسها كمان: بتعمل `emit(Success)` مرتين منطقيًا — مرة بعد جلب الليست، ومرة بعد `_fetchUnreadCount()` لو العدد اتغير. **قرار: سيبها كذا** — منطقي ومقصود
8. **قرار نهائي: `didPopNext` و `_onTabChanged` يفضلوا الاتنين بينادوا `getNotifications()`** — حالتين مختلفتين (رجوع من شاشة push، ورجوع لتاب الهوم)، مفيش تعارض، اليوزر أكد إنه عايزها "متحدثة دايمًا"

**قرارات مهمة اتاخدت في الشات ده:**
- مفيش global mutable state لرسائل عابرة بين الشاشات — استخدم route arguments دايمًا
- كل route في `onGenerateRoute` لازم يبعت `settings: settings` — حتى لو مش محتاج arguments دلوقتي
- `NotificationsCubit` trigger points: `MainView.initState` + `didPopNext` + `_onTabChanged` (لما يرجع للهوم) — مفيش نداء في `main.dart`
- تكرار الـ `Success` emit في `getNotifications()` (list + unread count) مقصود ومتسيب زي ما هو
- الـ 401 الحالي = logout + redirect فوري (مفيش silent refresh-and-retry لسه — لو ده مطلوب future، محتاج conversation جديدة)

**قاعدة سلوكية جديدة اتلاحظت:**
- لازم نتأكد من الـ root cause بالـ logs/prints قبل أي فيكس، مش نخمن بناءً على الكود اللي شايفينه فقط — افتراض أولي غلط (global variable timing) كلفنا دورة كاملة قبل ما نوصل للسبب الحقيقي (`settings:` ناقصة)