import 'package:flutter/foundation.dart';
import 'package:spsp_mobile/models/user_auth_info.dart';

class UserAuthInfoProvider with ChangeNotifier {
  UserAuthInfo? userAuthInfo;

  void setUserAuthInfo(UserAuthInfo userAuthInfo) {
    userAuthInfo = userAuthInfo;
    notifyListeners();
  }
}
