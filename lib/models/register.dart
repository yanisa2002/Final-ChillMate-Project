import 'dart:convert';

Register registerFromJson(String str) => Register.fromJson(json.decode(str));

String registerToJson(Register data) => json.encode(data.toJson());

class Register {
  String email;
  String userName;
  String password;
  String name;
  DateTime timeAt;
  List<String> interest;
  List<String> allogre;
  String userId;
  String image;
  int role;

  Register({
    required this.email,
    required this.userName,
    required this.password,
    required this.name,
    required this.timeAt,
    required this.interest,
    required this.allogre,
    required this.userId,
    required this.image,
    required this.role,
  });

  factory Register.fromJson(Map<String, dynamic> json) => Register(
        email: json["Email"],
        userName: json["UserName"],
        password: json["Password"],
        name: json["Name"],
        timeAt: DateTime.parse(json["TimeAT"]),
        interest: json["Interest"] == null
            ? []
            : List<String>.from(json["Interest"].map((x) => x)),
        allogre: json["Allogre"] == null
            ? []
            : List<String>.from(json["Allogre"].map((x) => x)),
        userId: json["User_ID"],
        image: json["Image"],
        role: json["Role"],
      );

  Map<String, dynamic> toJson() => {
        "Email": email,
        "UserName": userName,
        "Password": password,
        "Name": name,
        "TimeAT": timeAt.toIso8601String(),
        "Interest": List<dynamic>.from(interest.map((x) => x)),
        "Allogre": List<dynamic>.from(allogre.map((x) => x)),
        "User_ID": userId,
        "Image": image,
        "Role": role,
      };
}
