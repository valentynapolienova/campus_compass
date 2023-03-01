
import 'package:int20h/core/helper/type_aliases.dart';
import 'package:int20h/features/sign_up/domain/entities/auth_response.dart';

abstract class SignUpRepository {
  FutureFailable<AuthResponse> signUp(
      String name, String email, String password);
}
