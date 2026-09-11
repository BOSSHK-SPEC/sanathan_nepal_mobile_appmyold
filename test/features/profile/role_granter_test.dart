import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/session/app_role.dart';
import 'package:sanathan_nepal_mobile_app/core/session/permission.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/session/profile_role_granter.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/session/profile_session_source.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/models/user_profile_model.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/entities/user_profile.dart';

void main() {
  late InMemoryKeyValueStore store;
  late ProfileLocalDataSourceImpl local;
  late ProfileRoleGranter granter;

  setUp(() {
    store = InMemoryKeyValueStore();
    local = ProfileLocalDataSourceImpl(
      store,
      const FixedRegionResolver(Region.nepal),
    );
    granter = ProfileRoleGranter(local);
  });

  test('granting astrologer adds to the set without removing admin', () async {
    expect(local.read().roles, {UserRole.admin});

    await granter.grant(AppRole.astrologer);
    final after = local.read().toEntity();
    expect(after.roles, {UserRole.admin, UserRole.astrologer});
    expect(after.isAdmin, isTrue);
    expect(after.isAstrologer, isTrue);
  });

  test('the resulting session holds both sets of permissions', () async {
    await granter.grant(AppRole.astrologer);
    final session = await ProfileSessionSource(local).load();

    expect(session.hasRole(AppRole.astrologer), isTrue);
    expect(session.hasRole(AppRole.superAdmin), isTrue);
    expect(session.can(Permission.viewAstrologerConsole), isTrue);
    expect(session.can(Permission.approveBusiness), isTrue);
    // Both shells are reachable, so the switcher appears. Staff roles are
    // not switchable UI contexts, so superAdmin does not add a third.
    expect(session.canSwitchRole, isTrue);
    expect(session.switchableRoles, [AppRole.seeker, AppRole.astrologer]);
  });

  test('granting twice is a no-op', () async {
    await granter.grant(AppRole.astrologer);
    await granter.grant(AppRole.astrologer);
    expect(local.read().roles, {UserRole.admin, UserRole.astrologer});
  });

  test('revoking removes only that role', () async {
    await granter.grant(AppRole.astrologer);
    await granter.revoke(AppRole.astrologer);
    expect(local.read().roles, {UserRole.admin});
  });

  test('revoking the last role leaves a plain user, never nothing', () async {
    await local.write(
      UserProfileModel.fromEntity(
        local.read().toEntity().copyWith(roles: {UserRole.astrologer}),
      ),
    );
    await granter.revoke(AppRole.astrologer);
    expect(local.read().roles, {UserRole.user});
  });

  test('staff roles are not something the app grants itself', () async {
    await granter.grant(AppRole.superAdmin);
    await granter.grant(AppRole.finance);
    expect(local.read().roles, {UserRole.admin});
  });
}
