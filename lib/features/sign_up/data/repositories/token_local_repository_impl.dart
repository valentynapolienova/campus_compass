
import 'package:int20h/core/error/failures.dart';
import 'package:int20h/core/error/repository_request_handler.dart';
import 'package:int20h/core/helper/type_aliases.dart';
import 'package:int20h/features/sign_up/data/datasource/token_local_datasource.dart';
import 'package:int20h/features/sign_up/domain/repositories/token_local_repository.dart';


class TokenLocalRepositoryImpl extends TokenLocalRepository {
  final TokenLocalDatasource tokenLocalDatasource;

  TokenLocalRepositoryImpl({required this.tokenLocalDatasource});

  @override
  FutureFailable<String?> getToken() {
    return RepositoryRequestHandler<String?>()(
      request: () => tokenLocalDatasource.getToken(),
      defaultFailure: Failure(),
    );
  }

  @override
  FutureFailable<bool> saveToken(String jwt) {
    return RepositoryRequestHandler<bool>()(
      request: () => tokenLocalDatasource.saveToken(jwt),
      defaultFailure: Failure(),
    );
  }

  @override
  FutureFailable<bool> deleteToken() {
    return RepositoryRequestHandler<bool>()(
      request: () => tokenLocalDatasource.deleteToken(),
      defaultFailure: Failure(),
    );
  }
}
