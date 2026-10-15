import '../../../../core/storage/key_value_store.dart';
import '../../domain/repositories/birth_star_repository.dart';

class BirthStarRepositoryImpl implements BirthStarRepository {
  const BirthStarRepositoryImpl(this._store);

  // v2 holds a pada, 0–107; v1 held a bare nakshatra and could not fix the
  // birth sign. An old value is simply ignored rather than migrated: reading
  // it as a pada would move most people three signs.
  static const String _key = 'panchanga.birthPada.v2';

  final KeyValueStore _store;

  @override
  int? get padaIndex {
    final value = _store.getInt(_key);
    // A value outside the 108 is treated as unset: a corrupt preference must
    // not index a list and crash the screen.
    if (value == null || value < 0 || value > 107) return null;
    return value;
  }

  @override
  Future<void> save(int padaIndex) async {
    if (padaIndex < 0 || padaIndex > 107) return;
    await _store.setInt(_key, padaIndex);
  }

  @override
  Future<void> clear() => _store.remove(_key).then((_) {});
}
