import 'package:int20h/features/map/domain/entities/classrom.dart';
import 'package:int20h/core/helper/type_aliases.dart';
import 'package:int20h/core/usecase/usecase.dart';
import 'package:int20h/features/map/domain/repositories/map_repository.dart';

class GetClassroomsUsecase extends Usecase<List<Classrom>, int> {
  GetClassroomsUsecase({
    required this.repository,
  });

  final MapRepository repository;

  @override
  FutureFailable<List<Classrom>> call(int id) {
    return repository.getClassrooms(id);
  }
}