import 'package:equatable/equatable.dart';
import 'package:int20h/core/helper/type_aliases.dart';

abstract class Usecase<Type, Params> {
  FutureFailable<Type> call(Params param);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}