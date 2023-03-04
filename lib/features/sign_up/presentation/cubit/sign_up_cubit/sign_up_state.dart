part of 'sign_up_cubit.dart';

@immutable
abstract class SignUpState {
  int? get groupId => null;
  int? get universityId => null;
  List<University> get universities => [];
  List<Group> get groups => [];
}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {
  @override
  final int? groupId;
  @override
  final int? universityId;
  @override
  List<University> universities;
  @override
  List<Group> groups;

  SignUpLoading({required this.groupId, required this.groups, required this.universities, required this.universityId});
}

class SignUpSuccess extends SignUpState {
  final String token;
  @override
  final int? groupId;
  @override
  final int? universityId;
  @override
  List<University> universities;
  @override
  List<Group> groups;

  SignUpSuccess({required this.token, required this.groupId, required this.universityId, required this.universities, required this.groups});
}

class SignUpFailure extends SignUpState {
  final String message;
  @override
  final int? groupId;
  @override
  final int? universityId;
  @override
  List<University> universities;
  @override
  List<Group> groups;

  SignUpFailure({required this.message, required this.groupId, required this.universityId, required this.universities, required this.groups});
}
