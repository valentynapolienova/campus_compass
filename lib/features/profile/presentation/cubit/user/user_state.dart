part of 'user_cubit.dart';

@immutable
abstract class UserState {
  User get user => User();
}

class UserSuccess extends UserState {
  @override
  final User user;

  UserSuccess({required this.user});
}

class UserFailure extends UserState {}

class UserLoading extends UserState {}
