import 'package:dio/dio.dart';
import 'package:int20h/features/sign_up/domain/repositories/token_local_repository.dart';

class TokenInterceptor extends Interceptor {
  TokenInterceptor({
    required this.tokenLocalRepository,
  });

  final TokenLocalRepository tokenLocalRepository;

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await tokenLocalRepository.getToken();
    token.fold(
          (failure) => null, // throw GetTokenException(),
          (data) => {
        if (options.headers.containsKey('Authorization'))
          {options.headers['Authorization'] = '$data'}
        else
          {
            options.headers.putIfAbsent('Authorization', () => '$data'),
          }
      },
    );
    super.onRequest(options, handler);
  }
}
