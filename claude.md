# Claude Memory File — Core (Active)
> Last updated: June 2026 (session: Profile Feature — all open items closed except avatar dialog)

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
- **Added packages:** `url_launcher` ✅, `pinput` ✅, `image_picker` ✅
- **Code comments:** **English only** (hard rule)

---

## 3. Features Status

| Feature           | Domain | Data | Presentation | Notes                                                                                               |
| ----------------- | ------ | ---- | ------------ | --------------------------------------------------------------------------------------------------- |
| **browse**        | ✅     | ✅   | ✅           | Cursor pagination + FavCubit + per_page=10 + NoInternetWidget + retry                               |
| **fav**           | ✅     | ✅   | ✅           | add/remove + optimistic update + rollback + deduplication + NoInternetWidget + retry                |
| **search**        | ✅     | ✅   | ✅           | Cubit + page-based pagination + recent searches — debounce still not implemented                    |
| **home**          | ✅     | ✅   | ✅           | Trending + Recommended + retry — `CustomHomeAppBar` now wired to `ProfileCubit` ✅ this session     |
| **notifications** | ✅     | ✅   | ✅           | Global cubit + RouteObserver + unread count + NoInternetWidget + retry + ActionFailure as snackbar  |
| **guide**         | ✅     | ✅   | ✅           | Articles + pagination + UI search filter + retry + NoInternetWidget                                 |
| **uni_detail**    | ✅     | ✅   | ✅           | 4 parallel calls via Future.wait + NoInternetWidget + retry + rate + website                        |
| **auth**          | ✅     | ✅   | ✅           | Complete + polished — see archive §Auth Feature                                                     |
| **splash**        | ✅     | ✅   | ✅           | token check → MainView or OnBoarding or LoginView                                                   |
| **on_boarding**   | ✅     | ✅   | ✅           | marks seen in SharedPreferences → navigates to LoginView                                            |
| **profile**       | ✅     | ✅   | ✅           | **MOSTLY DONE this session** — see §5 for one remaining open item (avatar dialog)                  |
| **faheem**        | ✅     | ❌   | ✅           | Chat UI + entities — waiting on backend; sayed's status still unconfirmed, ask next time            |

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
   - `PaginationLoading(currentItems)` — separate state
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
18. **Every `onGenerateRoute` case must forward `settings: settings` to `MaterialPageRoute`**
19. **No global mutable variables for cross-screen one-off messages** — pass via route `arguments` instead
20. **401 interceptor must guard against concurrent-request double-redirect** — `_isHandlingUnauthorized` bool flag in `ApiService`
21. **401 SnackBar ordering:** in any cubit failure listener, if `errMessage.toLowerCase().contains('unauthenticated')` → return early, let the interceptor handle the redirect. Applied to `SaveStudentInfoFailure` and `UpdatePasswordFailure` ✅ this session

> ⚠️ If a new error occurs → always ask for the related file before attempting a fix.
> ⚠️ Before proposing a debugging fix → confirm the actual root cause via prints/logs first.

---

## 5. Profile Feature — Current State (after this session)

**Scope:** `GET /auth/me` + `POST /student_info` + `POST /auth/update-Password`. Avatar upload deferred (no backend endpoint).

### ✅ Fully done (including this session)
- All items from previous session (see archive §9)
- **401 SnackBar ordering bug** — RESOLVED: `SaveStudentInfoFailure` and `UpdatePasswordFailure` listeners now check for `'unauthenticated'` in `errMessage` and return early, letting the interceptor handle the redirect
- **No-op save guard** — RESOLVED: 5 snapshot variables (`_original*`) saved in `_populateFromUser`, `_hasChanges()` method compares current vs original, shows "لم تقم بتغيير أي بيانات" SnackBar if nothing changed
- **Home page name/avatar** — RESOLVED: `CustomHomeAppBar` now wired to `ProfileCubit` via `getIt`, shows `user.name` and `user.avatar` (with `Image.asset` fallback), `buildWhen` limits rebuilds to `ProfileSuccess`/`ProfileLoading`
- **Logout button** — RESOLVED: `logout()` added to `ProfileCubit` (clears token + refresh_token + `_currentUser`, redirects via `navigatorKey`). `LogoutConfirmationSheet` (new bottom sheet) shows confirmation with robot image before executing logout. `ProfileViewBody` wired to show sheet first.
- **"تواصل مع الدعم"** — RESOLVED: fully interactive UI:
  - `QuickContact`: واتساب + اتصال + إيميل via `url_launcher` (dummy data, replace when sayed provides real contacts)
  - `MessageFormSection`: converted to `StatefulWidget` with controllers, clear-on-submit, SnackBar success — validator removed from name field (manual check in `_submit()` instead to avoid focus-jump after reset)
  - `LegalSheet` (new, `core/widgets/`): shared `DraggableScrollableSheet` for Terms and Privacy Policy
  - `TermsAndConditionsSheet`: converted to thin wrapper over `LegalSheet` — auth flow unchanged
  - `Footer`: both buttons now open `LegalSheet` with correct content
  - Privacy Policy content written from scratch (7 sections)

### 🔶 One remaining open item
- **Avatar dialog** — user flagged "ضبط" for avatar tap interaction, exact behavior not yet clarified. Likely: tap → image picker dialog (camera/gallery). Explicitly deferred — no backend upload endpoint exists yet.

### ⏳ Waiting on sayed
- Whether `POST /student_info` should receive `null` or `''` for `scientific_department` when `study_section` is "أدبي" — current code sends `''`
- Whether `POST /auth/update-Password` can get a `current_password` param added
- Real contact info (WhatsApp number, phone, email) to replace dummy data in `quick_contact.dart`
- `POST /aiChat/send` (Faheem) — status still unconfirmed, ask next session

---

## 6. Global app infrastructure — current state

**`main.dart` globals:**
```dart
final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
```
> `MultiBlocProvider` includes `ProfileCubit`, `FavCubit`, `NotificationsCubit`.

**401 interceptor:** `_isHandlingUnauthorized` guard flag — prevents double-redirect from concurrent 401s. Any failure listener that catches `'unauthenticated'` should return early (see rule 21 above).

**Logout flow (finalized this session):**
- `ProfileCubit.logout()` — clears `token` + `refresh_token` from Prefs, nulls `_currentUser`, redirects via `navigatorKey.currentState?.pushNamedAndRemoveUntil(LoginView.routeName, ...)`
- Triggered via `LogoutConfirmationSheet` which shows first, calls `onConfirm` only if user taps "أيوه"

---

## 7. New Files This Session

| File | Location | Notes |
|------|----------|-------|
| `logout_confirmation_sheet.dart` | `profile/presentation/views/widgets/` | Bottom sheet with robot SVG + confirm/cancel |
| `legal_sheet.dart` | `core/widgets/` | Shared DraggableScrollableSheet, holds `kTermsSections` + `kPrivacySections` |

**Updated files this session:**
- `profile_cubit.dart` — added `logout()`
- `profile_view_body.dart` — wired `LogoutConfirmationSheet`
- `custom_home_app_bar.dart` — wired to `ProfileCubit`
- `personal_data_view_body.dart` — 401 fix + no-op guard
- `security_view_body.dart` — 401 fix
- `terms_and_conditions_sheet.dart` — now a thin wrapper over `LegalSheet`
- `footer.dart` — both buttons open `LegalSheet`
- `quick_contact.dart` — `url_launcher` wired (dummy data)
- `message_form_section.dart` — `StatefulWidget` + controllers + clear-on-submit

---

## 8. Next Steps (in order)

1. **Avatar dialog** — clarify intended behavior, then build (tap avatar → camera/gallery picker; actual upload deferred until sayed builds endpoint)
2. **Search Debounce** — 500ms in `search_view_body.dart` — small, quick task
3. **Faheem/Chat AI** — `POST /aiChat/send` — ask sayed for status next session
4. **Fav Pagination** — after sayed fixes backend bug
5. **Replace dummy contact data** in `quick_contact.dart` when sayed provides real info

**Backend items needed from sayed:**
- `scientific_department` value when `study_section` is "أدبي" — `null` vs `''`?
- `current_password` param for `update-Password` endpoint
- Real WhatsApp number, phone, email for contact page
- Faheem `/aiChat/send` status
- Avatar upload endpoint (future)
- Duplicate-email-unverified edge case fix (old, still open)

---

## 9. Preferences & Working Style

- **Responds in Arabic** even for technical topics
- **Sends code and asks "what do you think" or "explain"** — wants to understand
- **Prefers short answers** — get to the point
- **Says "continue" / "كمل"** — resume exactly where left off
- **Rejects over-engineering**
- **Confirms before execution**
- **Uploads `lib.zip`** with every checkpoint — read before replying, extract fresh each time
- **Re-uploads mid-session** — always extract fresh, don't assume old extraction is current
- **Sends API responses as JSON** — treat as ground truth
- **Doesn't like refactoring** after Claude sends code
- **Catches contradictions quickly**
- **Commands are short and direct:** "fix", "send", "كمل", "look at the whole code"
- **Doesn't want comments removed** from code
- **Uses inline TODO comments** in pasted code — treat each TODO as a distinct item
- **Multi-point messages** — parse each point separately
- **When debugging:** expects Claude to ask for the relevant file first
- **Prefers SnackBar over Toast**
- **Sends screenshots of UI bugs** — diagnose root cause
- **"سيبها"** = final decision, don't re-raise
- **"تمام" / "ايوه"** after explanation = proceed
- **When I say "افترض حلول"** = list options with tradeoffs, do NOT write code yet
- **Never implement during a discussion turn** — wait for explicit go-ahead
- **When debugging:** don't guess — isolate root cause with prints first
- **Wants Claude to track "waiting on third party" items** and resurface without being asked
- **When asked to re-order open items** — group into buckets (ready / needs input / needs diagnosis / waiting on third party)
- **Sends back files with TODO comments** as his preferred way to request changes — treat the pasted file as ground truth
- **Rapid-fire multi-point messages** — don't let new asks get lost among answers to old questions
- **Sometimes pastes full transcript from another session** — absorb as ground truth
- **"معاك كل حاجة"** when Claude asks for a file that's in the zip — use the zip
- **Asks same architectural question twice** — answer consistently
- **"متبعتش الفايل"** = send the full file, not just a snippet ✅ new pattern this session

> 📂 Full reference → see `archive.md`