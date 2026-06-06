import 'package:uni/core/services/shared_preferences_singleton.dart';

class RecentSearchesHelper {
  static const _key = 'recent_searches';
  static const _separator = '||';
  static const _maxItems = 10;

  /// get all recent searches as a list of strings
  static List<String> getAll() {
    final raw = Prefs.getString(_key);
    if (raw.isEmpty) return [];
    return raw.split(_separator).where((s) => s.isNotEmpty).toList();
  }

  /// add new search (if already exists, move to top)
  static Future<void> add(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return;
    var list = getAll();
    list.remove(trimmed);
    list.insert(0, trimmed);
    if (list.length > _maxItems) list = list.sublist(0, _maxItems);
    await Prefs.setString(_key, list.join(_separator));
  }

  /// remove a single search
  static Future<void> remove(String query) async {
    final list = getAll()..remove(query);
    await Prefs.setString(_key, list.join(_separator));
  }

  /// remove all recent searches
  static Future<void> clearAll() async {
    await Prefs.setString(_key, '');
  }
}
