import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvironmentConfig {
  static final CLIENT_ID_VALUE = dotenv.env['CLIENT_ID_VALUE'] ?? '';
  static final SECRET_KEY_VALUE = dotenv.env['SECRET_KEY_VALUE'] ?? '';
}
