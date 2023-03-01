import 'package:int20h/core/helper/type_aliases.dart';
import 'package:int20h/features/profile/domain/entities/user.dart';

abstract class ProfileRepository{

  FutureFailable<User> getUser();

}