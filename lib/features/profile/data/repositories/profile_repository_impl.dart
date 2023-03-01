import 'package:int20h/core/error/repository_request_handler.dart';
import 'package:int20h/core/error/failures.dart';
import 'package:int20h/core/helper/type_aliases.dart';
import 'package:int20h/features/profile/domain/entities/user.dart';
import 'package:int20h/features/profile/data/datasource/profile_datasource.dart';
import 'package:int20h/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileDatasource profileDatasource;

  ProfileRepositoryImpl({required this.profileDatasource,});
  @override
  FutureFailable<User> getUser() {
    return RepositoryRequestHandler<User>()(
      request: () => profileDatasource.getUser(),
      defaultFailure: Failure(),
    );
  }

}