import 'package:int20h/features/profile/domain/entities/user.dart';
import 'package:int20h/core/helper/type_aliases.dart';
import 'package:int20h/core/usecase/usecase.dart';
import 'package:int20h/features/profile/domain/repositories/profile_repository.dart';

class GetUserUsecase extends Usecase<User, NoParams> {
  GetUserUsecase({
    required this.repository,
  });

  final ProfileRepository repository;

  @override
  FutureFailable<User> call(NoParams param) {
    return repository.getUser();
  }
}