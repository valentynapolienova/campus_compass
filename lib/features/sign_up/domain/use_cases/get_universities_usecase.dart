import 'package:int20h/features/sign_up/domain/entities/university.dart';
import 'package:int20h/core/helper/type_aliases.dart';
import 'package:int20h/core/usecase/usecase.dart';
import 'package:int20h/features/sign_up/domain/repositories/sign_up_repository.dart';

class GetUniversitiesUsecase extends Usecase<List<University>, NoParams> {
  GetUniversitiesUsecase({
    required this.repository,
  });

  final SignUpRepository repository;

  @override
  FutureFailable<List<University>> call(NoParams param) {
    return repository.getUniversities();
  }
}