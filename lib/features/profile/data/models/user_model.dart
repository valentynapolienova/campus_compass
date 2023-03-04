import 'package:int20h/features/profile/domain/entities/user.dart';

class UserModel extends User {
  UserModel({super.email, super.name});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    isTeacher = json['isTeacher'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    return data;
  }
}
