import 'package:int20h/features/profile/domain/entities/user.dart';

class Comment {

  int? id;
  User? user;
  String? text;
  bool? isMyComment;

  Comment({this.user, this.id, this.text, this.isMyComment});

}