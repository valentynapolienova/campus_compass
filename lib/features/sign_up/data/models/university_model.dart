import 'package:int20h/features/sign_up/domain/entities/university.dart';

class UniversityModel extends University {
  UniversityModel({super.id, super.name});

  UniversityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

}