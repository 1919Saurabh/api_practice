// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

List<Profile> profileFromJson(String str) =>
    List<Profile>.from(json.decode(str).map((x) => Profile.fromJson(x)));

String profileToJson(List<Profile> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Profile {
  Profile({
    required this.orgMember,
    required this.appUpdate,
    required this.respCode,
    this.respMsg,
  });

  OrgMember orgMember;
  AppUpdate appUpdate;
  String respCode;
  String? respMsg;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        orgMember: OrgMember.fromJson(json["org_member"]),
        appUpdate: AppUpdate.fromJson(json["app_update"]),
        respCode: json["resp_code"],
        respMsg: json["resp_msg"],
      );

  Map<String, dynamic> toJson() => {
        "org_member": orgMember.toJson(),
        "app_update": appUpdate.toJson(),
        "resp_code": respCode,
        "resp_msg": respMsg,
      };
}

class AppUpdate {
  AppUpdate({
    required this.androidUpdate,
    required this.iosUpdate,
  });

  Update androidUpdate;
  Update iosUpdate;

  factory AppUpdate.fromJson(Map<String, dynamic> json) => AppUpdate(
        androidUpdate: Update.fromJson(json["android_update"]),
        iosUpdate: Update.fromJson(json["ios_update"]),
      );

  Map<String, dynamic> toJson() => {
        "android_update": androidUpdate.toJson(),
        "ios_update": iosUpdate.toJson(),
      };
}

class Update {
  Update({
    required this.lastRequiredCodeVersion,
    required this.currentCodeVersion,
    required this.appVersion,
  });

  int lastRequiredCodeVersion;
  int currentCodeVersion;
  String appVersion;

  factory Update.fromJson(Map<String, dynamic> json) => Update(
        lastRequiredCodeVersion: json["last_required_code_version"],
        currentCodeVersion: json["current_code_version"],
        appVersion: json["app_version"],
      );

  Map<String, dynamic> toJson() => {
        "last_required_code_version": lastRequiredCodeVersion,
        "current_code_version": currentCodeVersion,
        "app_version": appVersion,
      };
}

class OrgMember {
  OrgMember({
    required this.orgMemberId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.displayName,
    this.dateOfBirth,
    required this.timeZoneId,
    required this.gender,
    this.bloodGroup,
    required this.phoneNumber,
    required this.countryCode,
    required this.mobileNumber,
    required this.expertise,
    required this.eduction,
    required this.experience,
    required this.languages,
    this.locale,
    required this.address,
    required this.country,
    this.state,
    this.city,
    required this.zipCode,
    required this.isEmailVerified,
    required this.isPasswordSet,
    required this.weightUnit,
    this.fbHandler,
    this.instaHandler,
    this.twHandler,
    required imageUrl,
    required about,
  });

  int orgMemberId;
  String firstName;
  String lastName;
  String email;
  String displayName;
  double? dateOfBirth;
  String timeZoneId;
  String gender;
  String? bloodGroup;
  String phoneNumber;
  String countryCode;
  String mobileNumber;
  late String imageUrl;
  late String about;
  String expertise;
  String eduction;
  int experience;
  String languages;
  String? locale;
  String address;
  String? country;
  String? state;
  String? city;
  int zipCode;
  bool isEmailVerified;
  bool isPasswordSet;
  int weightUnit;
  String? fbHandler;
  String? instaHandler;
  String? twHandler;

  factory OrgMember.fromJson(Map<String, dynamic> json) => OrgMember(
        orgMemberId: json["org_member_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        displayName: json["display_name"],
        dateOfBirth: json["date_of_birth"] != null
            ? json["date_of_birth"].toDouble()
            : null,
        timeZoneId: json["time_zone_id"],
        gender: json["gender"],
        bloodGroup: json["blood_group"],
        phoneNumber: json["phone_number"],
        countryCode: json["country_code"],
        mobileNumber: json["mobile_number"],
        imageUrl: json["image_url"],
        about: json["about"],
        expertise: json["expertise"],
        eduction: json["eduction"],
        experience: json["experience"],
        languages: json["languages"],
        locale: json["locale"],
        address: json["address"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        zipCode: json["zip_code"],
        isEmailVerified: json["is_email_verified"],
        isPasswordSet: json["is_password_set"],
        weightUnit: json["weight_unit"],
        fbHandler: json["fb_handler"],
        instaHandler: json["insta_handler"],
        twHandler: json["tw_handler"],
      );

  Map<String, dynamic> toJson() => {
        "org_member_id": orgMemberId,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "display_name": displayName,
        "date_of_birth": dateOfBirth,
        "time_zone_id": timeZoneId,
        "gender": gender,
        "blood_group": bloodGroup,
        "phone_number": phoneNumber,
        "country_code": countryCode,
        "mobile_number": mobileNumber,
        "image_url": imageUrl,
        "about": about,
        "expertise": expertise,
        "eduction": eduction,
        "experience": experience,
        "languages": languages,
        "locale": locale,
        "address": address,
        "country": country,
        "state": state,
        "city": city,
        "zip_code": zipCode,
        "is_email_verified": isEmailVerified,
        "is_password_set": isPasswordSet,
        "weight_unit": weightUnit,
        "fb_handler": fbHandler,
        "insta_handler": instaHandler,
        "tw_handler": twHandler,
      };
}



// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

// import 'dart:convert';

// UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

// String userDataToJson(UserData data) => json.encode(data.toJson());

// class UserData {
//   UserData({
//     required this.tokenIdentity,
//     required this.isNewUser,
//     required this.respCode,
//     required this.respMsg,
//   });

//   late TokenIdentity tokenIdentity;
//   late bool isNewUser;
//   late String respCode;
//   late String? respMsg;

//   UserData.fromJson(Map<String, dynamic> json) {
//     tokenIdentity = TokenIdentity.fromJson(json["token_identity"]);
//     isNewUser = json["is_new_user"];
//     respCode = json["resp_code"];
//     respMsg = json["resp_msg"];
//   }

//   Map<String, dynamic> toJson() => {
//         "token_identity": tokenIdentity.toJson(),
//         "is_new_user": isNewUser,
//         "resp_code": respCode,
//         "resp_msg": respMsg,
//       };
// }

// class TokenIdentity {
//   TokenIdentity({
//     required this.userIdentity,
//     required this.token,
//     required this.firebaseToken,
//   });

//   late UserIdentity userIdentity;
//   late String token;
//   late String firebaseToken;

//   TokenIdentity.fromJson(Map<String, dynamic> json) {
//     userIdentity = UserIdentity.fromJson(json["user_identity"]);
//     token = json["token"];
//     firebaseToken = json["firebase_token"];
//   }

//   Map<String, dynamic> toJson() => {
//         "user_identity": userIdentity.toJson(),
//         "token": token,
//         "firebase_token": firebaseToken,
//       };
// }

// class UserIdentity {
//   UserIdentity({
//     required this.orgMemberId,
//   });

//   int orgMemberId;

//   factory UserIdentity.fromJson(Map<String, dynamic> json) => UserIdentity(
//         orgMemberId: json["org_member_id"],
//       );

//   Map<String, dynamic> toJson() => {
//         "org_member_id": orgMemberId,
//       };
// }
