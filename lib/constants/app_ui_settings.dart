import 'package:fuodz/constants/app_strings.dart';

class AppUISettings extends AppStrings {
  //CHAT UI
  static bool get canVendorChat {
    if (AppStrings.env('ui') == null || AppStrings.env('ui')["chat"] == null) {
      return true;
    }
    return AppStrings.env('ui')['chat']["canVendorChat"] == "1";
  }

  static bool get canCustomerChat {
    if (AppStrings.env('ui') == null || AppStrings.env('ui')["chat"] == null) {
      return true;
    }
    return AppStrings.env('ui')['chat']["canCustomerChat"] == "1";
  }

  static bool get canDriverChat {
    if (AppStrings.env('ui') == null || AppStrings.env('ui')["chat"] == null) {
      return true;
    }
    return AppStrings.env('ui')['chat']["canDriverChat"] == "1";
  }

  static bool get enableDriverTypeSwitch {
    if (AppStrings.env('enableDriverTypeSwitch') == null) {
      return false;
    }
    final canSwitch = AppStrings.env('enableDriverTypeSwitch');
    if (canSwitch is bool) {
      return canSwitch;
    } else if (canSwitch is int) {
      return canSwitch == 1;
    } else {
      return int.parse("$canSwitch") == 1;
    }
  }
}
