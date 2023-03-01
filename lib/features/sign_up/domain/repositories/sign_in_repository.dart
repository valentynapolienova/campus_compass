
import 'package:int20h/core/helper/type_aliases.dart';
import 'package:int20h/features/sign_up/domain/entities/auth_response.dart';

abstract class SignInRepository {
  FutureFailable<AuthResponse> signIn(String email, String password);
  FutureFailable<bool> setFirebaseToken(String token);
  FutureFailable<bool> deleteFirebaseToken(String token);
}
