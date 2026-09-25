import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/enums.dart';
import '../models/models.dart';
import '../supabase/errors.dart';

class ShopRepository {
  ShopRepository(this._db);
  final SupabaseClient _db;
  String get _uid => _db.auth.currentUser!.id;

  Future<Voucher> redeemReward(String rewardId) => guard(() async {
        final row = await _db.rpc('redeem_reward', params: {'p_reward': rewardId});
        return Voucher.fromJson(Map<String, dynamic>.from(row as Map));
      });

  Future<List<Voucher>> myVouchers() => guard(() async {
        final rows = await _db
            .from('vouchers')
            .select('*, reward:rewards(*)')
            .eq('user_id', _uid)
            .order('created_at', ascending: false);
        return rows.map(Voucher.fromJson).toList();
      });

  Future<void> purchaseItem(String itemId) => guard(() => _db.rpc('purchase_item', params: {'p_item': itemId}));

  Future<List<UserItem>> myItems() => guard(() async {
        final rows = await _db.from('user_items').select().eq('user_id', _uid);
        return rows.map(UserItem.fromJson).toList();
      });

  Future<List<Equipment>> myEquipment() => guard(() async {
        final rows = await _db.from('equipment').select().eq('user_id', _uid);
        return rows.map(Equipment.fromJson).toList();
      });

  Future<void> equip(String itemId) => guard(() => _db.rpc('equip_item', params: {'p_item': itemId}));

  Future<void> unequip(ItemSlot slot) => guard(() => _db.rpc('unequip_slot', params: {'p_slot': enumWire(slot)}));

  // ---- staff ----
  Future<VoucherLookup?> lookupVoucher(String code) => guard(() async {
        final res = await _db.rpc('lookup_voucher', params: {'p_code': code});
        if (res == null) return null;
        return VoucherLookup.fromJson(Map<String, dynamic>.from(res as Map));
      });

  Future<Voucher> confirmVoucher(String code, {String? venueId}) => guard(() async {
        final row = await _db.rpc('confirm_voucher', params: {'p_code': code, 'p_venue': venueId});
        return Voucher.fromJson(Map<String, dynamic>.from(row as Map));
      });
}
