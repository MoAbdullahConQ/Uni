# Claude Memory File — Core (Active)
> Last updated: June 2026 (session: Faheem Feature — full integration done)

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
| **home**          | ✅     | ✅   | ✅           | Trending + Recommended + retry — `CustomHomeAppBar` wired to `ProfileCubit` ✅                      |
| **notifications** | ✅     | ✅   | ✅           | Global cubit + RouteObserver + unread count + NoInternetWidget + retry + ActionFailure as snackbar  |
| **guide**         | ✅     | ✅   | ✅           | Articles + pagination + UI search filter + retry + NoInternetWidget                                 |
| **uni_detail**    | ✅     | ✅   | ✅           | 4 parallel calls via Future.wait + NoInternetWidget + retry + rate + website                        |
| **auth**          | ✅     | ✅   | ✅           | Complete + polished — see archive §Auth Feature                                                     |
| **splash**        | ✅     | ✅   | ✅           | token check → MainView or OnBoarding or LoginView                                                   |
| **on_boarding**   | ✅     | ✅   | ✅           | marks seen in SharedPreferences → navigates to LoginView                                            |
| **profile**       | ✅     | ✅   | ✅           | MOSTLY DONE — one remaining open item: avatar dialog                                                |
| **faheem**        | ✅     | ✅   | ✅           | **DONE this session** — full integration: domain + data + cubit + view wired. See §5               |

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
21. **401 SnackBar ordering:** in any cubit failure listener, if `errMessage.toLowerCase().contains('unauthenticated')` → return early, let the interceptor handle the redirect

> ⚠️ If a new error occurs → always ask for the related file before attempting a fix.
> ⚠️ Before proposing a debugging fix → confirm the actual root cause via prints/logs first.

---

## 5. Faheem Feature — Current State (after this session)

**Scope:** `POST /aiChat/send` — form-data `message` field → response `{ role, content }`.  
**History screen:** UI-only for now (no backend endpoint).

### ✅ Fully done this session
- **Domain:** `FaheemRepo` (abstract) + `SendMessageUseCase`
- **Data:** `FaheemMessageModel.fromJson` (maps `content` field) + `FaheemRemoteDataSourceImpl` (uses `apiService.dio.post` with `FormData`) + `FaheemRepoImpl`
- **Cubit:** `FaheemCubit` — holds `_messages` list internally, adds user message → typing indicator → API call → removes typing → emits `FaheemMessageReceived` or `FaheemSendFailure`
- **States:** `FaheemInitial`, `FaheemSending(messages)`, `FaheemMessageReceived(messages)`, `FaheemSendFailure(messages, errMessage)`
- **ViewBody:** converted from `setState` → `BlocConsumer`, cubit from GetIt directly
- **Scroll:** `ChatMessagesList` uses `reverse: true` + reversed list → last message always at bottom with no scroll code needed. `_scrollToBottom` uses `jumpTo(minScrollExtent)` for new messages.
- **User avatar:** `UserMessageBubble` reads `ProfileCubit.currentUser?.avatar` from GetIt — same pattern as `CustomHomeAppBar`
- **GetIt:** full chain registered — `FaheemRemoteDataSource → FaheemRepo → SendMessageUseCase → FaheemCubit`
- **`backend_endpoints.dart`:** added `sendMessage = '/aiChat/send'`
- **`FaheemCubit` NOT in `MultiBlocProvider`** — taken from GetIt directly in `FaheemChatViewBody`

### ℹ️ Design decisions
- `apiService.dio.post()` used instead of `apiService.post()` because the endpoint needs `FormData` and `apiService.post()` only accepts `Map<String, dynamic>`. The Dio interceptor still fires (it's on the `dio` instance).
- `uniCards` content type kept in `ChatMessagesList` — backend may return cards in the future.
- API is request/response (not streaming) — backend returns full answer in one shot.

### ⏳ Waiting on sayed
- History endpoint for `FaheemHistoryView` — screen is UI-only for now

---

## 6. Profile Feature — Current State

**Scope:** `GET /auth/me` + `POST /student_info` + `POST /auth/update-Password`. Avatar upload deferred.

### 🔶 One remaining open item
- **Avatar dialog** — tap interaction not yet clarified. Likely: tap → image picker (camera/gallery). Deferred — no backend upload endpoint exists yet.

### ⏳ Waiting on sayed
- `scientific_department` value when `study_section` is "أدبي" — `null` vs `''`?
- `current_password` param for `update-Password`
- Real contact info (WhatsApp, phone, email) for `quick_contact.dart`
- Avatar upload endpoint (future)

---

## 7. Global app infrastructure — current state

**`main.dart` globals:**
```dart
final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
```
> `MultiBlocProvider` includes `ProfileCubit`, `FavCubit`, `NotificationsCubit`.  
> `FaheemCubit` is NOT in MultiBlocProvider — used via GetIt directly.

**401 interceptor:** `_isHandlingUnauthorized` guard flag.

**Logout flow:** `LogoutConfirmationSheet` → `ProfileCubit.logout()` → clears token + refresh_token + `_currentUser` → `navigatorKey.pushNamedAndRemoveUntil(LoginView)`.

---

## 8. New Files This Session

| File | Location |
|------|----------|
| `faheem_repo.dart` | `faheem/domain/repos/` |
| `send_message_use_case.dart` | `faheem/domain/use_cases/` |
| `faheem_message_model.dart` | `faheem/data/models/` |
| `faheem_remote_data_source.dart` | `faheem/data/data_sources/` |
| `faheem_repo_impl.dart` | `faheem/data/repos/` |
| `faheem_state.dart` | `faheem/presentation/manager/faheem_cubit/` |
| `faheem_cubit.dart` | `faheem/presentation/manager/faheem_cubit/` |

**Updated files this session:**
- `faheem_chat_view_body.dart` — converted from setState → BlocConsumer + reverse scroll
- `chat_messages_list.dart` — `reverse: true` + reversed list
- `user_message_bubble.dart` — avatar from ProfileCubit via GetIt
- `backend_endpoints.dart` — added `sendMessage`
- `get_it_service.dart` — added full Faheem chain

---

## 9. Next Steps (in order)

1. **Avatar dialog** — clarify intended behavior, then build
2. **Search Debounce** — 500ms in `search_view_body.dart`
3. **Faheem History** — waiting on sayed for endpoint
4. **Fav Pagination** — waiting on sayed backend fix
5. **Replace dummy contact data** in `quick_contact.dart`

**Backend items needed from sayed:**
- `scientific_department` value when "أدبي" — `null` vs `''`?
- `current_password` param for `update-Password`
- Real WhatsApp, phone, email for contact page
- Faheem history endpoint
- Avatar upload endpoint (future)
- Duplicate-email-unverified edge case fix

---

## 10. Preferences & Working Style

- **Responds in Arabic** even for technical topics
- **Short answers** — get to the point
- **Says "continue" / "كمل"** — resume exactly where left off
- **Rejects over-engineering**
- **Confirms before execution**
- **Uploads `lib.zip`** with every checkpoint — extract fresh each time
- **Re-uploads mid-session** — always extract fresh
- **Sends API responses as JSON** — treat as ground truth
- **Doesn't like refactoring** after Claude sends code
- **Catches contradictions quickly**
- **Commands are short and direct:** "fix", "send", "كمل"
- **Doesn't want comments removed** from code
- **Uses inline TODO comments** — treat each TODO as a distinct item
- **Multi-point messages** — parse each point separately
- **When debugging:** expects Claude to ask for the relevant file first
- **Prefers SnackBar over Toast**
- **"سيبها"** = final decision, don't re-raise
- **"تمام" / "ايوه"** after explanation = proceed
- **"افترض حلول"** = list options with tradeoffs, do NOT write code yet
- **Never implement during a discussion turn**
- **When debugging:** don't guess — isolate root cause with prints first
- **"متبعتش الفايل"** = send the full file, not a snippet
- **"معاك كل حاجة"** = file is in the zip, use it

> 📂 Full reference → see `archive.md`