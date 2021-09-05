import 'package:vexana/vexana.dart';

class UserModel extends INetworkModel<UserModel> {
  List<Data>? data;

  UserModel({this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data?.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  UserModel fromJson(Map<String, dynamic> json) {
    return UserModel.fromJson(json);
  }
}

class Data extends INetworkModel<Data> {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  String get fullName => '$firstName $lastName';

  bool isValueContains(String key) {
    return fullName.toLowerCase().contains(key.toLowerCase());
  }

  Data({this.id, this.email, this.firstName, this.lastName, this.avatar});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['avatar'] = this.avatar;
    return data;
  }

  @override
  Data fromJson(Map<String, dynamic> json) {
    return Data.fromJson(json);
  }
}
