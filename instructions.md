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
- Don't add English comments in code — Arabic only
- Don't put feature-specific code in `core/` — core is shared only
- Don't add Repo/UseCase layers without clear business logic justification
- Don't start writing code before the plan is approved

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
**Next up (in order):** auth → splash → onboarding → profile API → faheem API (waiting on backend)

---

## 9. Session Summary — آخر شات

**اللي عملناه:**
1. **`GuideArticlesViewBody`** — غيّرنا `GuideFailure` من `CustomErrorWidget` لـ `NoInternetWidget` مع `onRetry` و `onBack`
2. **`MainView`** — إصلاح مشكلة إن البيانات مش بتتحدث لو النت اتقطع:
   - `RecommendedCubit` اتنقل من `build` لـ `late final` في `initState` + `close()` في `dispose`
   - `BlocProvider.value` بدل `BlocProvider(create:...)` للـ recommended
   - `didPopNext` بيعمل retry للـ cubits الفاشلة + دايماً بيحدث notifications
   - `_onTabChanged` method منفصلة بتعمل retry للـ TrendingCubit و RecommendedCubit لو فاشلين لما يرجع لـ tab 0