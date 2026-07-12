import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Saved daily ayah/hadith items. Device-local by design: reading habits
/// are personal and there is no server table for them.
abstract class FavouritesStore {
  Future<Set<String>> favourites();
  Future<void> toggle(String id);
}

class PrefsFavouritesStore implements FavouritesStore {
  static const _key = 'daily_item_favourites';

  @override
  Future<Set<String>> favourites() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getStringList(_key) ?? const []).toSet();
  }

  @override
  Future<void> toggle(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final current = await favourites();
    final next = current.contains(id)
        ? ({...current}..remove(id))
        : {...current, id};
    await prefs.setStringList(_key, next.toList());
  }
}

final favouritesStoreProvider = Provider<FavouritesStore>(
  (ref) => PrefsFavouritesStore(),
);
