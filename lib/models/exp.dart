class EXPdata {
  bool? success;
  Message? message;

  EXPdata({this.success, this.message});

  EXPdata.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message =
        json['message'] != null ? new Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    return data;
  }
}

class Message {
  Data? data;

  Message({this.data});

  Message.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  EXP? eXP;
  String? imgPath;
  EXP? pD;
  String? status;

  Data({this.eXP, this.imgPath, this.pD, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    eXP = json['EXP'] != null ? new EXP.fromJson(json['EXP']) : null;
    imgPath = json['Img_path'];
    pD = json['PD'] != null ? new EXP.fromJson(json['PD']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.eXP != null) {
      data['EXP'] = this.eXP!.toJson();
    }
    data['Img_path'] = this.imgPath;
    if (this.pD != null) {
      data['PD'] = this.pD!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class EXP {
  String? y;
  String? d;
  String? m;

  EXP({this.y, this.d, this.m});

  EXP.fromJson(Map<String, dynamic> json) {
    y = json['Y'];
    d = json['d'];
    m = json['m'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Y'] = this.y;
    data['d'] = this.d;
    data['m'] = this.m;
    return data;
  }
}
