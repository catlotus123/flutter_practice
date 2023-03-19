class UserLoginRequestEntity {
  String username;
  String password;
  UserLoginRequestEntity({required this.username, required this.password});

  factory UserLoginRequestEntity.fromJson(Map<String, dynamic> json) =>
      UserLoginRequestEntity(
          username: json['username'], password: json['password']);

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
      };
}

class LoginInfo {
  int id;
  String nickname;

  LoginInfo({this.id = 0, this.nickname = ''});
  factory LoginInfo.fromJson(Map<String, dynamic> json) => LoginInfo(
        id: json["id"],
        nickname: json["nickname"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nickname": nickname,
      };
}

class LoginResponse {
  int errorCode;
  String? errorMsg;
  LoginInfo? data;
  LoginResponse({required this.errorCode, required this.errorMsg, this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        errorCode: json["errorCode"],
        errorMsg: json["errorMsg"],
        data: LoginInfo.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "errorCode": errorCode,
        "errorMsg": errorMsg,
        "data": data?.toJson(),
      };
}

class UserRegisterRequestEntity {
  String username;
  String password;
  String repassword;
  UserRegisterRequestEntity(
      {required this.username,
      required this.password,
      required this.repassword});

  factory UserRegisterRequestEntity.fromJson(Map<String, dynamic> json) =>
      UserRegisterRequestEntity(
          username: json['username'],
          password: json['password'],
          repassword: json['repassword']);

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
        'repassword': repassword,
      };
}

class UserInfo {
  bool admin;
  int id;
  String nickname;
  String token;
  String username;
  UserInfo(
      {this.admin = false,
      this.id = 0,
      this.nickname = '',
      this.token = '',
      this.username = ''});
  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        admin: json["admin"],
        id: json["id"],
        nickname: json["nickname"],
        token: json["token"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "admin": admin,
        "id": id,
        "nickname": nickname,
        "token": token,
        "username": username,
      };
}

class RegisterResponse {
  int errorCode;
  String errorMsg;
  UserInfo? data;
  RegisterResponse(
      {required this.errorCode, required this.errorMsg, this.data});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
        errorCode: json["errorCode"],
        errorMsg: json["errorMsg"],
        data: UserInfo.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "errorCode": errorCode,
        "errorMsg": errorMsg,
        "data": data?.toJson(),
      };
}
