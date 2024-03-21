class Fridge {
  String? fridgeID;
  String? nameFridge;
  List<AddIngName>? addIngName;

  Fridge({this.fridgeID, this.nameFridge, this.addIngName});

  Fridge.fromJson(Map<String, dynamic> json) {
    fridgeID = json['Fridge_ID'];
    nameFridge = json['NameFridge'];
    if (json['AddIng_name'] != null) {
      addIngName = <AddIngName>[];
      json['AddIng_name'].forEach((v) {
        addIngName!.add(new AddIngName.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Fridge_ID'] = this.fridgeID;
    data['NameFridge'] = this.nameFridge;
    if (this.addIngName != null) {
      data['AddIng_name'] = this.addIngName?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddIngName {
  String? addingID;
  String? type;
  num? amount;
  String? unit;
  String? mFG;
  String? eXP;
  String? addTime;
  num? ntiPeriod;
  String? keeptheplace;
  String? img;
  Raw? raw;

  AddIngName(
      {this.addingID,
      this.type,
      this.amount,
      this.unit,
      this.mFG,
      this.eXP,
      this.addTime,
      this.ntiPeriod,
      this.keeptheplace,
      this.img,
      this.raw});

  AddIngName.fromJson(Map<String, dynamic> json) {
    addingID = json['Adding_ID'];
    type = json['Type'];
    amount = json['Amount'];
    unit = json['Unit'];
    mFG = json['MFG'];
    eXP = json['EXP'];
    addTime = json['AddTime'];
    ntiPeriod = json['NtiPeriod'];
    keeptheplace = json['Keeptheplace'];
    img = json['img'];
    raw = json['Raw'] != null ? new Raw.fromJson(json['Raw']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Adding_ID'] = this.addingID;
    data['Type'] = this.type;
    data['Amount'] = this.amount;
    data['Unit'] = this.unit;
    data['MFG'] = this.mFG;
    data['EXP'] = this.eXP;
    data['AddTime'] = this.addTime;
    data['NtiPeriod'] = this.ntiPeriod;
    data['Keeptheplace'] = this.keeptheplace;
    data['img'] = this.img;
    if (this.raw != null) {
      data['Raw'] = this.raw?.toJson();
    }
    return data;
  }
}

class Raw {
  String? rawMaterialID;
  num? amount;
  String? nameing;

  Raw({this.rawMaterialID, this.amount, this.nameing});

  Raw.fromJson(Map<String, dynamic> json) {
    rawMaterialID = json['Raw_material_ID'];
    amount = json['Amount'];
    nameing = json['Nameing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Raw_material_ID'] = this.rawMaterialID;
    data['Amount'] = this.amount;
    data['Nameing'] = this.nameing;
    return data;
  }
}
