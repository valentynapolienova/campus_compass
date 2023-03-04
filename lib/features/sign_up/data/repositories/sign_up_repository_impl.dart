import 'package:int20h/features/sign_up/domain/entities/group.dart';
import 'package:int20h/features/sign_up/domain/entities/university.dart';

import 'package:int20h/core/error/failures.dart';
import 'package:int20h/core/error/repository_request_handler.dart';
import 'package:int20h/core/helper/type_aliases.dart';
import 'package:int20h/features/sign_up/data/datasource/sign_up_datasourse.dart';
import 'package:int20h/features/sign_up/domain/entities/auth_response.dart';
import 'package:int20h/features/sign_up/domain/repositories/sign_up_repository.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  final SignUpDatasource signUpDatasource;

  SignUpRepositoryImpl({required this.signUpDatasource,});
  @override
  FutureFailable<List<Group>> getGroups(int id) {
    return RepositoryRequestHandler<List<Group>>()(
      request: () => signUpDatasource.getGroups(id),
      defaultFailure: Failure(),
    );
  }
  @override
  FutureFailable<List<University>> getUniversities() {
    return RepositoryRequestHandler<List<University>>()(
      request: () => signUpDatasource.getUniversities(),
      defaultFailure: Failure(),
    );
  }

  @override
  FutureFailable<AuthResponse> signUp(
      String name, String email, String password, int groupId) {
    return RepositoryRequestHandler<AuthResponse>()(
      request: () => signUpDatasource.signUp(name, email, password,  groupId),
      defaultFailure: Failure(),
    );
  }
}
