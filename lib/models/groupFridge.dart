class GroupFridge {
  String? fridgeID;
  String? nameFridge;
  List<Member>? member;

  GroupFridge({this.fridgeID, this.nameFridge, this.member});

  GroupFridge.fromJson(Map<String, dynamic> json) {
    fridgeID = json['Fridge_ID'];
    nameFridge = json['NameFridge'];
    if (json['Member'] != null) {
      member = <Member>[];
      json['Member'].forEach((v) {
        member!.add(new Member.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Fridge_ID'] = this.fridgeID;
    data['NameFridge'] = this.nameFridge;
    if (this.member != null) {
      data['Member'] = this.member!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Member {
  String? userID;
  String? userName;
  String? name;
  String? email;
  String? password;
  String? image;
  String? timeAT;
  List<String>? interest;
  List<String>? allogre;
  int? role;

  Member(
      {this.userID,
      this.userName,
      this.name,
      this.email,
      this.password,
      this.image,
      this.timeAT,
      this.interest,
      this.allogre,
      this.role});

  Member.fromJson(Map<String, dynamic> json) {
    userID = json['User_ID'];
    userName = json['UserName'];
    name = json['Name'];
    email = json['Email'];
    password = json['Password'];
    image = json['Image'];
    timeAT = json['TimeAT'];
    interest = json['Interest'].cast<String>();
    allogre = json['Allogre'].cast<String>();
    role = json['Role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['User_ID'] = this.userID;
    data['UserName'] = this.userName;
    data['Name'] = this.name;
    data['Email'] = this.email;
    data['Password'] = this.password;
    data['Image'] = this.image;
    data['TimeAT'] = this.timeAT;
    data['Interest'] = this.interest;
    data['Allogre'] = this.allogre;
    data['Role'] = this.role;
    return data;
  }
}
