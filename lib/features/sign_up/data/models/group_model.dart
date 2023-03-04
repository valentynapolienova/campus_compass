import 'package:int20h/features/sign_up/domain/entities/group.dart';

class GroupModel extends Group {
  GroupModel({super.id, super.name});

  GroupModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

}