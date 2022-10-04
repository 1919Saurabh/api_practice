// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  UserData({
    required this.tokenIdentity,
    required this.isNewUser,
    required this.respCode,
    required this.respMsg,
  });

  TokenIdentity tokenIdentity;
  bool isNewUser;
  String respCode;
  String respMsg;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        tokenIdentity: TokenIdentity.fromJson(json["token_identity"]),
        isNewUser: json["is_new_user"],
        respCode: json["resp_code"],
        respMsg: json["resp_msg"],
      );

  Map<String, dynamic> toJson() => {
        "token_identity": tokenIdentity.toJson(),
        "is_new_user": isNewUser,
        "resp_code": respCode,
        "resp_msg": respMsg,
      };
}

class TokenIdentity {
  TokenIdentity({
    required this.userIdentity,
    required this.token,
    required this.firebaseToken,
  });

  UserIdentity userIdentity;
  String token;
  String firebaseToken;

  factory TokenIdentity.fromJson(Map<String, dynamic> json) => TokenIdentity(
        userIdentity: UserIdentity.fromJson(json["user_identity"]),
        token: json["token"],
        firebaseToken: json["firebase_token"],
      );

  Map<String, dynamic> toJson() => {
        "user_identity": userIdentity.toJson(),
        "token": token,
        "firebase_token": firebaseToken,
      };
}

class UserIdentity {
  UserIdentity({
    required this.orgMemberId,
  });

  int orgMemberId;

  factory UserIdentity.fromJson(Map<String, dynamic> json) => UserIdentity(
        orgMemberId: json["org_member_id"],
      );

  Map<String, dynamic> toJson() => {
        "org_member_id": orgMemberId,
      };
}
