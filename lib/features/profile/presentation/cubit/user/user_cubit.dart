import 'package:bloc/bloc.dart';
import 'package:int20h/features/profile/domain/entities/user.dart';
import 'package:int20h/features/profile/domain/repositories/profile_repository.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({required this.repository}) : super(UserLoading());

  final ProfileRepository repository;

  Future getUser() async {
    final response = await repository.getUser();
    emit(response.fold(
        (failure) => UserFailure(), (data) => UserSuccess(user: data)));
  }
}
