import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/utils/logger.dart';

class IconConverter {
  static final Map<String, IconData> _iconDataMap = {
    'account': CommunityMaterialIcons.account,
    'airplane': CommunityMaterialIcons.airplane,
    'book': CommunityMaterialIcons.book,
    'car': CommunityMaterialIcons.car,
    'cash-multiple': CommunityMaterialIcons.cash_multiple,
    'credit-card': CommunityMaterialIcons.credit_card,
    'food': CommunityMaterialIcons.food,
    'gift': CommunityMaterialIcons.gift,
    'home': CommunityMaterialIcons.home,
    'lightbulb-outline': CommunityMaterialIcons.lightbulb_outline,
    'movie': CommunityMaterialIcons.movie,
    'music': CommunityMaterialIcons.music,
    'phone': CommunityMaterialIcons.phone,
    'rocket': CommunityMaterialIcons.rocket,
    'school': CommunityMaterialIcons.school,
    'shopping': CommunityMaterialIcons.shopping,
    'train': CommunityMaterialIcons.train,
    'umbrella': CommunityMaterialIcons.umbrella,
    'wallet-giftcard': CommunityMaterialIcons.wallet_giftcard,
    'water': CommunityMaterialIcons.water,
    'wallet-membership': CommunityMaterialIcons.wallet_membership,
    'umbrella-outline': CommunityMaterialIcons.umbrella_outline,
    'ticket-account': CommunityMaterialIcons.ticket_account,
    'shopping-music': CommunityMaterialIcons.shopping_music,
    'dots': CommunityMaterialIcons.dots_hexagon,
    'briefcase': CommunityMaterialIcons.briefcase,
    'camera': CommunityMaterialIcons.camera,
    'guitar': CommunityMaterialIcons.guitar_acoustic,
    'medical-bag': CommunityMaterialIcons.medical_bag,
    't-shirt-crew-outline': CommunityMaterialIcons.tshirt_crew_outline,
    'food-apple': CommunityMaterialIcons.food_apple,
    'palette': CommunityMaterialIcons.palette,
    'watch': CommunityMaterialIcons.watch,
    'train-car': CommunityMaterialIcons.train_car,
    'basketball': CommunityMaterialIcons.basketball,
  };

  static IconData getIconFromModel(IconDataModel? icon) {
    return getIconFromString(icon?.name);
  }

  static IconData getIconFromString(String? iconName) {
    if (_iconDataMap[iconName] == null) {
      BudgetLogger.instance.i("icon not found for $iconName");
      return CommunityMaterialIcons.help;
    }
    return _iconDataMap[iconName]!;
  }
}
