class Ingre {
  String? rawMaterialID;
  num? amount;
  String? nameing;

  Ingre({this.rawMaterialID, this.amount, this.nameing});

  Ingre.fromJson(Map<String, dynamic> json) {
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
