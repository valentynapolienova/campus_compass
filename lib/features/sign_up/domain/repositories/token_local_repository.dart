import 'package:int20h/core/helper/type_aliases.dart';

abstract class TokenLocalRepository {
  FutureFailable<bool> saveToken(String jwt);
  FutureFailable<bool> deleteToken();
  FutureFailable<String?> getToken();
}
