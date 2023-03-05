import 'package:int20h/features/map/domain/entities/comment.dart';
import 'package:int20h/features/profile/data/models/user_model.dart';
import 'package:int20h/features/profile/domain/entities/user.dart';

class CommentModel extends Comment {
  CommentModel({super.user, super.text, super.id, super.isMyComment});

  CommentModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    isMyComment = json["isSameUser"];
    text = json["text"];
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['user'] = this.user;
    data['isSameUser'] = this.isMyComment;
    return data;
  }
}
