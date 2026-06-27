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
- **Never assume a discussion turn means "implement it"**
- **When debugging, don't jump to a fix based on assumption** — isolate root cause with prints/logs first, then fix.
- **When I say "سيبها"** → final decision, don't re-raise unless something changes.
- **If I ask "اشرح بأسلوب بسيط"** or **"فهمني"** or **"فهمني بقا انت عملت ايه بالضبط"** → explain the problem and solution in plain language — what was wrong, why, and how the fix works. No jargon dumps. Use an analogy if it helps.
- **Don't forget items flagged as "next up" or waiting** — mention them with blocked status when asked "what's next".
- **When I send back a file with `// TODO` comments inline** → treat each TODO as a distinct, separately-addressable item.
- **Multi-point messages** → parse each point separately.
- **When I say "خليك فاكر"** → track it, resurface without being asked.
- **When asked to re-order/triage a list** → group into buckets: ready-to-build / needs my input / needs diagnosis / waiting on third party.
- **"متبعتش الفايل" / "ابعت الفايل كامل"** → send the full file as a downloadable output, not just a snippet.
- **"فهمني سطر سطر"** → explain every line individually, don't skip or group lines together.
- **If I correct your reading of a log/test result directly** → re-read carefully, own the misread plainly, confirm corrected understanding before proceeding.
- **When I close an item with clear reasoning** → accept it, mark it closed, don't re-open unless new evidence.
- **When I say "بص عليه اتأكد"** → read the code, verify correctness, give direct yes/no verdict.
- **When I ask for animation/UI previews** → show a visual preview first before writing any Flutter code.
- **"جربهم بالترتيب"** → اعرض كل option لوحده للمقارنة، مش كلهم مع بعض.
- **When I send back a file that came from Claude** → treat it as current ground truth, apply changes on it exactly.
- **When something works and I ask "فهمني بقا"** → give a plain-language explanation of: (1) what the problem was, (2) why it happened, (3) how the fix solved it. Keep it concise, use simple terms.
- **When I send a Trello JSON export** → parse it carefully, read `closed` field on every card before concluding what's open/done. Don't summarize from names only.
- **When I say "اقرا كويس"** → re-read the raw data again, don't defend the previous reading.
- **When I ask "اي اللي لسه متعملش"** → cross-reference the actual board data (closed=false) not assumptions.

---

## 3. My Working Style
- I read the code myself — don't over-explain basics
- I always upload `lib.zip` when I want a code review — read it first, extract fresh every time
- I want the "why" once, briefly — then execute
- I find bugs myself and ask — don't warn me about every potential issue
- I make refactor decisions — don't rewrite working code unless asked
- I give direct corrections — admit mistakes immediately and fix them
- I catch contradictions fast — don't reverse decisions without flagging it
- I confirm you understood before you write code
- I verify APIs with Postman — treat results as ground truth, read them precisely
- I value consistency — match existing patterns in the codebase
- I re-verify previously-written code by re-uploading `lib.zip`
- I ask "why" about specific lines via inline review comments — answer precisely about that line
- When I say "تمام" or "ايوه" after an explanation → proceed, don't ask again
- I send screenshots of running app to point out UI/UX bugs
- I report backend/data quirks — flag UX implication
- When debugging, I paste raw console/logcat output — extract relevant lines yourself
- I push back mid-debugging when fix changes behavior but doesn't match expectation — re-diagnose
- I sometimes paste a full transcript from another session → absorb as ground truth
- I sometimes paste back a file you sent with `// TODO` comments → treat as current ground truth + task list
- **"معاك كل حاجة"** when Claude asks for a file that's in the zip → use the zip, don't ask again
- **I ask "هو ده صح ولا اي"** → give a direct yes/no with one-line reason
- **I verify my own understanding by re-explaining things back** → confirm if correct or correct it directly
- **I confirm a fix worked tersely** ("اشتغلت خلاص", "تمام اتحلت") — treat this as sufficient to close
- **When I ask for animation/UI options** → I want to see them visually before deciding
- **When debugging native/platform issues** → don't propose fixes before seeing logs. Read logs precisely before concluding anything.
- **"اشتغلت زي الفل"** = feature confirmed working, close it
- **I send Trello board JSON exports** → parse them to understand the real state of the backlog — always check `closed` field

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
- When asked for animation/UI options → show visual previews via the visualizer tool before writing Flutter code
- **In any cubit failure listener that shows a SnackBar → always check `errMessage.toLowerCase().contains('unauthenticated')` and return early if true.**
- **When I say "متبعتش الفايل" or ask for the full file** → always output a complete downloadable file.
- **When I ask "فهمني سطر سطر"** → explain every single line individually.
- **When tracing a call chain to fix a reported bug, if you find a second related bug → surface it and fix it too.**
- **For release build issues → always check `AndroidManifest.xml` for missing permissions early.**
- **When asked "كان فاضلنا اي" or "اي اللي بعدو"** → list items grouped by: ready-to-build / waiting on sayed / needs clarification.
- **When debugging platform/native issues** → always ask for logs first, read them precisely, don't assume root cause before seeing them.
- **When a fix works and I ask for explanation** → explain: problem → root cause → fix, in plain Arabic, concisely.
- **When I send a Trello JSON export** → parse the `closed` field on every card. Only cards with `closed=false` are open. Don't guess from names or list position.
- **When I say "اقرا الفايل كويس"** or correct a reading → re-parse the raw data immediately, acknowledge the error, give corrected output.

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
- **Don't write/edit code during a discussion turn**
- **Don't re-litigate a decision closed with "سيبها"/"خليها كذا"**
- **Don't propose a root cause without first confirming via debug print or log trace**
- **Don't assume a newly-reported bug is the same as a previously-fixed one**
- **Don't send a snippet saying "change line X"** when the user asked for the full file
- **Don't group or summarize when "سطر سطر" is asked**
- **Don't leave debug `print()` statements in place once a bug is confirmed fixed**
- **Don't assume `INTERNET` permission exists in release**
- **Don't propose animation/UI code before showing a visual preview when options are being discussed**
- **Don't call `initialize()` on `SpeechToText` more than once — ever. Not in `startListening`, not in a widget.**
- **Don't read Trello card status from names alone — always check the `closed` boolean field**

---

## 5. Technical Conventions
- **Base URL:** `https://back.laraveladvancedsayed101.cloud/api`
- **Auth:** Bearer token (Prefs) + `Api-Key` header (from `.env`)
- **Pagination:** cursor-based (Browse/Fav/Guide/Notifications) / page-based (Search)
- **Error handling:** `DioException` caught in repo → `ServerFailure.fromDioError(e)` → `left(ServerFailure(...))`
- **401 in failure listeners:** check `errMessage.toLowerCase().contains('unauthenticated')` → return early
- **Cubit pattern:** Initial → Loading → Success/Failure + PaginationLoading/PaginationFailure
- **API calls:** `apiService.get()` + `response['data']` manually
- **`apiService.post()` accepts `Map<String, dynamic>` only** — for `FormData` use `apiService.postFormData()`
- **Entity vs Model:** `UniEntity` non-nullable/required, `UniModel` nullable → maps to super with `?? defaults`
- **AppColors:** constants are `Color` objects — never wrap in `Color()` again
- **GetIt:** all global cubits use `registerSingleton` (not lazy)
- **Widget decomposition:** private sub-widgets for internal components
- **Code comments:** English only
- **Entity rule:** only create an Entity if its data is shown in UI or used in business logic
- **Shared widgets → `core/widgets/`** when used by 2+ features
- **Shared constants → root `lib/constants.dart`**
- **Speech:** `SpeechToText` instance must live in `SpeechService` singleton (GetIt) — `initialize()` called ONCE in `setupGetIt()` — never call `initialize()` again anywhere else
- **`_onStopCallback` pattern:** `SpeechService` holds a nullable `void Function()?` that gets updated on every `startListening` call — this is how the current widget gets notified without re-registering platform callbacks

---

## 6. Non-negotiable Patterns

**Ripple on Colored Background:**
```dart
Material(color: Colors.transparent,
  child: InkWell(borderRadius: ..., onTap: onTap,
    child: Ink(decoration: BoxDecoration(color: AppColors.secondaryColor, ...), child: Icon(...))))
```

**Auth token refresh:** hard logout + redirect on 401. Guarded with `_isHandlingUnauthorized` flag.

**Forgot-password temporary token:** held in cubit state, passed as `tempToken` — never written to Prefs.

**Register-flow token persistence:** written to Prefs in `OtpViewBody` before navigating to `SetupView`.

**OTP package:** `pinput`.

**Terms & Conditions / Privacy Policy UX:** `LegalSheet` as `DraggableScrollableSheet`.

**Logout UX:** `LogoutConfirmationSheet` → `ProfileCubit.logout()` on confirm.

**Session-expired redirect:** 401 interceptor → `pushNamedAndRemoveUntil(LoginView, arguments: message)`.

**Cubit-per-feature:** screens sharing same object of work share one cubit.

**Faheem chat scroll:** `reverse: true` + `messages.reversed.toList()`. `FaheemCubit` taken from GetIt directly.

**Avatar upload:** tap → `AvatarUploadSheet` → `pickImage(maxWidth: 1024, maxHeight: 1024)` → local preview + spinner → `ProfileCubit.uploadAvatar(File)` → on success, auto `getMe()` → SnackBar.

**Optional/nullable backend fields:** omit the key from the request map entirely when not applicable.

**Search debounce:** `Timer? _debounce` in view body state. Cancel + restart on every `onChanged`. Cancel in `dispose()`.

**Speech pattern:** `SpeechService` singleton in GetIt. `initialize()` once in `setupGetIt()`. Widget calls `startListening({onResult, onStop})` and `stopListening()`. Widget handles animations locally via `onStop` callback. Never call `initialize()` in widget or inside `startListening`.

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

**Features done:** browse, fav, search, home, notifications, guide, uni_detail, auth, splash, on_boarding, profile, faheem, mic/STT ✅

**Backlog (41 حاجة):** 3 bugs + 8 refactor + 30 todo — تفاصيل في archive §Trello Backlog

**Waiting on sayed:**
1. Real contact data — واتساب + تليفون + إيميل
2. Duplicate-email-unverified edge case
3. Backend endpoints لعدة features جديدة

---

## 9. Session Summaries — تاريخي (مرجع)

**جلسة: Auth Polish + UX Fixes**
**جلسة: Splash + Onboarding + 401 + Validator Fixes**
**جلسة: 401 SnackBar Debug + Notifications Trigger Cleanup**
**جلسة: 401 Double-SnackBar Diagnosis + Fix**
**جلسة: Profile API Integration — kickoff**
**جلسة: Profile Feature — all open items**
**جلسة: Faheem Feature — full integration**
**جلسة: mailto fix + Home AppBar fix + scientific_department fix + Avatar Upload ✅**
**جلسة: APK release + search debounce + release debug fixes ✅**
**جلسة: Faheem History — full backend integration ✅**
**جلسة: Mic Button — Speech + Animations ✅ (جزئياً)**
**جلسة: SpeechService — DONE ✅**
- Fav pagination bug closed (sayed)
- `SpeechService` singleton بُني وشغّل
- الـ bug الأساسي: re-initialize بيكسر الـ platform channel callbacks
- الحل: `initialize()` مرة واحدة + `_onStopCallback` pointer
- اشتغلت على الجهاز ✅

**جلسة: Trello Board Review + Backlog Planning**
- Mu حدد 34 حاجة ناقصة في الـ app
- اتعمل تصنيف كامل: نوع + اسم + backend dependency لكل حاجة
- Mu بعت Trello JSON export — اتقرأ وتم تحليل الـ closed status بدقة
- النتيجة النهائية: 3 bugs + 8 refactor + 30 todo = **41 حاجة مفتوحة**
- Claude قرأ الـ board غلط في البداية (مش اتحقق من closed field) — Mu صحح مباشرة