import 'package:bloc/bloc.dart';
import 'package:int20h/features/sign_up/domain/entities/group.dart';
import 'package:int20h/features/sign_up/domain/entities/university.dart';
import 'package:int20h/features/sign_up/domain/repositories/sign_up_repository.dart';
import 'package:meta/meta.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({required this.repository}) : super(SignUpInitial());

  final SignUpRepository repository;

  void setEmailValidationError() {
    emit(SignUpFailure(message: 'Invalid email format', groupId: state.groupId, universities: state.universities, groups: state.groups, universityId: state.universityId));
  }

  Future signUp(String name, String email, String password, int groupId) async {
    emit(SignUpLoading(groupId: state.groupId, universities: state.universities, groups: state.groups, universityId: state.universityId));
    final result = await repository.signUp(name, email, password, groupId);
    emit(result.fold((error) => SignUpFailure(message: error.errorMessage, groupId: state.groupId, universities: state.universities, groups: state.groups, universityId: state.universityId),
        (data) {
      if (data.isError == false) {
        return SignUpSuccess(token: data.token ?? '',groupId: state.groupId, universities: state.universities, groups: state.groups, universityId: state.universityId);
      } else {
        return SignUpFailure(
            message: data.errorMessage ?? 'Unexpected error occurred', groupId: state.groupId, universities: state.universities, groups: state.groups, universityId: state.universityId);
      }
    }));
  }

  Future getUniversities() async{
    final result = await repository.getUniversities();
    emit(result.fold((error) => SignUpFailure(message: error.errorMessage, groupId: state.groupId, universities: state.universities, groups: state.groups, universityId: state.universityId),
            (data) {
            return SignUpInitial(universities: data);
        }));
  }

  Future getGroupsByUniversity(int id) async{
    final result = await repository.getGroups(id);
    emit(result.fold((error) => SignUpFailure(message: error.errorMessage, groupId: state.groupId, universities: state.universities, groups: state.groups, universityId: state.universityId),
            (data) {
          return SignUpInitial(groups: data, universities: state.universities, groupId: state.groupId, universityId: state.universityId);
        }));
  }

  void chooseUniversity(int id) {
    getGroupsByUniversity(id);
    emit(SignUpInitial(groups: state.groups, universities: state.universities, groupId: state.groupId, universityId: id));
  }

  void chooseGroup(int id) {
    emit(SignUpInitial(groups: state.groups, universities: state.universities, groupId: id, universityId: state.universityId));
  }

}
