import 'package:hive_flutter/hive_flutter.dart';
import '../constants/hive_box_names.dart';

class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();
    
    // Open all necessary boxes
    await Future.wait([
      Hive.openBox(HiveBoxNames.walletBox),
      Hive.openBox(HiveBoxNames.profileBox),
      Hive.openBox(HiveBoxNames.transactionsBox),
      Hive.openBox(HiveBoxNames.settingsBox),
      Hive.openBox(HiveBoxNames.themeBox),
      Hive.openBox(HiveBoxNames.languageBox),
      Hive.openBox(HiveBoxNames.mpinBox),
      Hive.openBox(HiveBoxNames.qrHistoryBox),
      Hive.openBox(HiveBoxNames.notificationsBox),
      Hive.openBox(HiveBoxNames.merchantHistoryBox),
      Hive.openBox(HiveBoxNames.favoritesBox),
      Hive.openBox(HiveBoxNames.profilePhotoBox),
      Hive.openBox(HiveBoxNames.qrImagesBox),
      Hive.openBox(HiveBoxNames.recentSearchesBox),
      Hive.openBox(HiveBoxNames.dummyUsersBox),
      Hive.openBox(HiveBoxNames.dummyBanksBox),
      Hive.openBox(HiveBoxNames.dummyCardsBox),
      Hive.openBox(HiveBoxNames.dummyReceiptsBox),
    ]);
  }
}
