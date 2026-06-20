# Project Instructions for Claude

## 1. Who I Am
Mohamed (Mu) — Egyptian Flutter developer, intermediate-to-advanced. App: **Gameaty (جامعتي)**. Backend dev: **sayed** (Laravel).

---

## 2. How to Interact
- **Always respond in Arabic** — mix technical terms naturally
- **Short and direct** — no preambles or filler
- "continue" / "كمل" / "go" → keep going without intro
- "what do you think" → honest opinion, not a list of options
- "fix" / "send" → execute without explanation
- One tradeoff sentence max — don't hide it, don't over-explain it
- When I ask "act as a [role] expert" → answer directly from that lens, don't soften or hedge
- **When I say "افترض حلول" or we're clearly still discussing → list options with one-line tradeoffs, do NOT write or edit code.** Only write code after I explicitly pick one or say "go"/"fix"/"اعمل كذا".
- **Never assume a discussion turn means "implement it"** — even reading a file with edit-intent framing mid-discussion counts as starting to implement. Stop fully after presenting options until I explicitly pick.
- **When debugging, don't jump to a fix based on assumption** — isolate root cause with prints/logs first, then fix.
- **When I say "سيبها"** → final decision, don't re-raise unless something changes.
- **If I ask "اشرح بأسلوب بسيط"** → drop jargon, use plain short sentences, one concrete question at the end.
- **Don't forget items flagged as "next up" or waiting** — mention them with blocked status when asked "what's next".
- **When I send back a file with `// TODO` comments inline** → treat each TODO as a distinct, separately-addressable item. Don't bundle two TODOs.
- **Multi-point messages** → parse each point separately, don't let new asks get lost.
- **When I say "خليك فاكر"** → track it, resurface without being asked.
- **When asked to re-order/triage a list** → group into buckets: ready-to-build / needs my input / needs diagnosis / waiting on third party.
- **"متبعتش الفايل" / "ابعت الفايل كامل"** → send the full file as a downloadable output, not just a snippet.
- **"فهمني سطر سطر"** → explain every line individually, don't skip or group lines together.

---

## 3. My Working Style
- I read the code myself — don't over-explain basics
- I always upload `lib.zip` when I want a code review — read it first, extract fresh every time (even mid-session re-uploads)
- I want the "why" once, briefly — then execute
- I find bugs myself and ask — don't warn me about every potential issue
- I make refactor decisions — don't rewrite working code unless asked
- I give direct corrections — admit mistakes immediately and fix them
- I catch contradictions fast — don't reverse decisions without flagging it
- I confirm you understood before you write code
- I verify APIs with Postman — treat JSON responses as ground truth
- I value consistency — match existing patterns in the codebase
- I re-verify previously-written code by re-uploading `lib.zip` — confirm it matches before moving on
- I ask "why" about specific lines via inline review comments — answer precisely about that line
- I sometimes ask the same architectural question twice — answer consistently
- When I say "تمام" or "ايوه" after an explanation → proceed, don't ask again
- I send screenshots of running app to point out UI/UX bugs — study fully before proposing fix
- I report backend/data quirks — flag UX implication, tell me if needs sayed conversation
- When debugging, I paste raw console/logcat output — extract relevant lines yourself
- I push back mid-debugging when fix changes behavior but doesn't match expectation — re-diagnose
- I sometimes paste a full transcript from another session → absorb as ground truth, summarize resolved vs open
- When closing a session → update all 3 memory files for full continuity
- I sometimes paste back a file you sent with `// TODO` comments → treat as current ground truth + task list
- **"معاك كل حاجة"** when Claude asks for a file that's in the zip → use the zip, don't ask again
- **I ask "هو ده صح ولا اي"** → give a direct yes/no with one-line reason, not a list of considerations
- **I verify my own understanding by re-explaining things back** → confirm if correct or correct it directly

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
- When a screen's UI shows a feature with no matching backend endpoint → make it static/UI-only and flag it
- When I upload reference images of screens → study them fully before describing the flow
- When I upload a screenshot of a bug → diagnose root cause in framework/widget behavior
- When asked "ايه رأيك" on UX/architecture → one clear recommendation with reasoning
- When debugging → verify each link in the chain independently with logs/prints BEFORE proposing a fix
- Avoid leaving commented-out dead code — delete cleanly, rely on git history
- Before touching a shared/core widget used across multiple features → confirm with me first
- **In any cubit failure listener that shows a SnackBar → always check `errMessage.toLowerCase().contains('unauthenticated')` and return early if true.**
- **When I say "متبعتش الفايل" or ask for the full file** → always output a complete downloadable file, not an inline snippet.
- **When I ask "فهمني سطر سطر"** → explain every single line individually without grouping or skipping.

**Never:**
- Don't rewrite working code unless asked
- Don't add features or patterns not requested
- Don't use `registerFactory` for use cases — always `registerSingleton`
- Don't hardcode secrets — always use `.env` via `flutter_dotenv`
- Don't suggest Firebase or any alternative backend
- Don't give a list of options when a recommendation is asked for
- Don't put logic in the Cubit if it can be done in the UI
- Don't add new dependencies without asking
- Don't repeat a note I said I'd handle later
- Don't add Arabic-only comments — all code comments in English
- Don't put feature-specific code in `core/` — core is shared only
- Don't add Repo/UseCase layers without clear business logic justification
- Don't start writing code before the plan is approved
- Don't add an Entity for data that never reaches the UI
- **Don't write/edit code during a discussion turn** — wait for explicit go-ahead
- **Don't re-litigate a decision closed with "سيبها"/"خليها كذا"** unless new evidence comes up
- **Don't propose a root cause without first confirming via debug print or log trace**
- **Don't assume a newly-reported bug is the same as a previously-fixed one** — fresh diagnosis
- **Don't send a snippet saying "change line X"** when the user asked for the full file
- **Don't group or summarize when "سطر سطر" is asked** — line by line means line by line

---

## 5. Technical Conventions
- **Base URL:** `https://back.laraveladvancedsayed101.cloud/api`
- **Auth:** Bearer token (Prefs) + `Api-Key` header (from `.env`)
- **Pagination:** cursor-based (Browse/Fav/Guide/Notifications) / page-based (Search)
- **Error handling:** `DioException` caught in repo → `ServerFailure.fromDioError(e)` → `left(ServerFailure(...))`
- **401 in failure listeners:** check `errMessage.toLowerCase().contains('unauthenticated')` → return early
- **Cubit pattern:** Initial → Loading → Success/Failure + PaginationLoading/PaginationFailure
- **API calls:** `apiService.get()` + `response['data']` manually
- **`apiService.post()` accepts `Map<String, dynamic>` only** — for `FormData` use `apiService.dio.post()` directly (interceptor still fires on `dio` instance)
- **Entity vs Model:** `UniEntity` non-nullable/required, `UniModel` nullable → maps to super with `?? defaults`
- **AppColors:** constants are `Color` objects — never wrap in `Color()` again
- **GetIt:** all global cubits use `registerSingleton` (not lazy)
- **Widget decomposition:** private sub-widgets for internal components
- **`CustomTextFormField`** is the base for all form fields. Supports `enabled` param for read-only.
- **Code comments:** English only
- **Entity rule:** only create an Entity if its data is shown in UI or used in business logic
- **Cubit scope per feature:** group screens sharing the same object of work
- **Multi-option selector widgets take `Map<String, IconData>` for per-option icons**
- **Session-expired redirect message travels as route `arguments` ONLY** — no global mutable variable
- **Every `case` in `onGenerateRoute` must pass `settings: settings`**
- **Shared widgets → `core/widgets/`** when used by 2+ features
- **Shared constants → root `lib/constants.dart`**
- **Reuse existing use cases across features** — don't duplicate
- **Fields with no backend update support → shown read-only (`enabled: false`)**
- **`formKey.reset()` before `controller.clear()`** — correct order to avoid focus-jump
- **`LegalSheet` is the shared widget for all legal content** — Terms and Privacy both use it
- **Logout confirmation pattern:** `LogoutConfirmationSheet.show(context, onConfirm: ...)` always first
- **`reverse: true` ListView pattern for chat** — latest message always at bottom; scroll uses `jumpTo(minScrollExtent)`
- **User avatar in chat bubbles** → from `ProfileCubit.currentUser?.avatar` via GetIt — same pattern as `CustomHomeAppBar`

---

## 6. Non-negotiable Patterns

**Ripple on Colored Background:**
```dart
Material(color: Colors.transparent,
  child: InkWell(borderRadius: ..., onTap: onTap,
    child: Ink(decoration: BoxDecoration(color: AppColors.secondaryColor, ...), child: Icon(...))))
```

**UniDetail Scroll (final):**
```
NestedScrollView (ClampingScrollPhysics)
├── SliverToBoxAdapter → HeroImage + InfoHeader
├── SliverPersistentHeader(pinned: true) → TabBar
└── TabBarView → 3x ListView(key: PageStorageKey(...))
```

**Auth token refresh:** hard logout + redirect on 401. Guarded with `_isHandlingUnauthorized` flag.

**Forgot-password temporary token:** held in cubit state, passed as `tempToken` — never written to Prefs.

**Register-flow token persistence:** written to Prefs in `OtpViewBody` before navigating to `SetupView`.

**OTP package:** `pinput`.

**Terms & Conditions / Privacy Policy UX:** `LegalSheet` as `DraggableScrollableSheet`. Both accessible from `Footer` and from auth via `TermsAndConditionsSheet` wrapper.

**Logout UX:** `LogoutConfirmationSheet` → `ProfileCubit.logout()` on confirm.

**Session-expired redirect:** 401 interceptor → `pushNamedAndRemoveUntil(LoginView, arguments: message)`. Failure listeners return early on `'unauthenticated'`.

**Cubit-per-feature:** screens sharing same object of work share one cubit.

**Faheem chat scroll:** `reverse: true` + `messages.reversed.toList()` in `ChatMessagesList`. `_scrollToBottom()` uses `jumpTo(minScrollExtent)`. `FaheemCubit` taken from GetIt directly — NOT in `MultiBlocProvider`.

---

## 7. Error UI Rules

| Situation | Widget |
|---|---|
| Full-screen failure في pushed screen | `NoInternetWidget` مع `onRetry` و `onBack: () => Navigator.pop(context)` |
| Full-screen failure في tab | `NoInternetWidget` مع `onRetry` بس |
| Inline failure في وسط صفحة | `CustomErrorWidget` مع `onRetry` |
| Pagination failure | `CustomErrorWidget` inline أسفل اللست مع `onRetry: loadMore` |
| Empty list | `EmptyStateWidget` |
| Transient success/info message | `SnackBar` (not Toast) |
| 401 during write action | return early in listener — interceptor handles redirect |

---

## 8. Current Focus

**Features done:** browse, fav, search, home, notifications, guide, uni_detail, auth, splash, on_boarding, profile (minus avatar dialog), contact_us, **faheem** ✅

**One remaining profile item:** Avatar dialog — behavior not clarified yet (tap → camera/gallery; backend upload endpoint doesn't exist yet)

**Next up (in order):**
1. Avatar dialog — needs behavior clarification first
2. Search Debounce — 500ms, small task, ready to build
3. Faheem History — waiting on sayed for endpoint
4. Fav Pagination — waiting on sayed backend fix
5. Replace dummy contact data — waiting on sayed

---

## 9. Session Summaries — تاريخي (مرجع)

**جلسة: Auth Polish + UX Fixes**
**جلسة: Splash + Onboarding + 401 + Validator Fixes**
**جلسة: 401 SnackBar Debug + Notifications Trigger Cleanup**
**جلسة: 401 Double-SnackBar Diagnosis + Fix**
**جلسة: Profile API Integration — kickoff**
**جلسة: Profile Feature — all open items** (401 ordering, no-op guard, home AppBar, logout, contact us, legal sheet)

**جلسة: Faheem Feature — full integration ✅**
1. Confirmed `POST /aiChat/send` live — form-data, returns `{role, content}`
2. Built full layer: domain → data → cubit → view
3. Converted `FaheemChatViewBody` from setState → BlocConsumer
4. Fixed scroll with `reverse: true` pattern
5. Added user avatar in `UserMessageBubble` from ProfileCubit via GetIt
6. Registered full Faheem chain in GetIt
7. API is request/response (not streaming) — confirmed
8. `apiService.dio.post()` correct for FormData — interceptor still fires