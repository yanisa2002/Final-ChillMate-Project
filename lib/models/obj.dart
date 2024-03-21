class OBJ {
  bool? success;
  Message? message;

  OBJ({this.success, this.message});

  OBJ.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message =
        json['message'] != null ? Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {'success': this.success};
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
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  ClassI? classI;

  Data({this.classI});

  Data.fromJson(Map<String, dynamic> json) {
    classI = json['class'] != null ? ClassI.fromJson(json['class']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.classI != null) {
      data['class'] = this.classI!.toJson();
    }
    return data;
  }
}

class ClassI {
  String? imgPath;
  dynamic barcode;
  List<String>? classDetails;
  List<String>? classUnit;
  String? confidence;
  String? predictedClass;
  dynamic productName;
  List<String>? remainingClasses;
  List<String>? remainingSubClasses;
  String? status;
  String? subClass;
  List<String>? subClassDetail;
  UnitClass? subClassUnit;

  ClassI({
    this.imgPath,
    this.barcode,
    this.classDetails,
    this.classUnit,
    this.confidence,
    this.predictedClass,
    this.productName,
    this.remainingClasses,
    this.remainingSubClasses,
    this.status,
    this.subClass,
    this.subClassDetail,
    this.subClassUnit,
  });

  ClassI.fromJson(Map<String, dynamic> json) {
    imgPath = json['Img_path'];
    barcode = json['barcode'];
    classDetails = List<String>.from(json['class_details'] ?? []);
    classUnit = List<String>.from(json['class_unit'] ?? []);
    confidence = json['confidence'];
    predictedClass = json['predicted_class'];
    productName = json['product_name'];
    remainingClasses = List<String>.from(json['remaining_classes'] ?? []);
    remainingSubClasses =
        List<String>.from(json['remaining_sub_classes'] ?? []);
    status = json['status'];
    subClass = json['sub_class'];
    subClassDetail = json['sub_class_detail'] != null
        ? List<String>.from(json['sub_class_detail'])
        : [];
    subClassUnit = json['subclass_unit'] != null
        ? UnitClass.fromJson(json['subclass_unit'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'Img_path': this.imgPath,
      'barcode': this.barcode,
      'class_details': this.classDetails,
      'class_unit': this.classUnit,
      'confidence': this.confidence,
      'predicted_class': this.predictedClass,
      'product_name': this.productName,
      'remaining_classes': this.remainingClasses,
      'remaining_sub_classes': this.remainingSubClasses,
      'status': this.status,
      'sub_class': this.subClass,
      'sub_class_detail': this.subClassDetail,
      'subclass_unit': this.subClassUnit?.toJson(),
    };
    return data;
  }
}

class UnitClass {
  List<String>? animalProduct;
  List<String>? fruit;
  List<String>? vegetable;
  List<String>? other;
  List<String>? drink;
  List<String>? meat;

  UnitClass({
    this.animalProduct,
    this.fruit,
    this.vegetable,
    this.other,
    this.drink,
    this.meat,
  });

  UnitClass.fromJson(Map<String, dynamic> json) {
    animalProduct = List<String>.from(json['ผลิตภัณฑ์แปรรูปจากสัตว์'] ?? []);
    fruit = List<String>.from(json['ผลไม้'] ?? []);
    vegetable = List<String>.from(json['ผัก'] ?? []);
    other = List<String>.from(json['อื่น ๆ'] ?? []);
    drink = List<String>.from(json['เครื่องดื่ม'] ?? []);
    meat = List<String>.from(json['เห็ดหรือเนื้อสัตว์อื่น ๆ'] ?? []);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'ผลิตภัณฑ์แปรรูปจากสัตว์': this.animalProduct,
      'ผลไม้': this.fruit,
      'ผัก': this.vegetable,
      'อื่น ๆ': this.other,
      'เครื่องดื่ม': this.drink,
      'เห็ดและเนื้อสัตว์อื่น ๆ': this.meat,
    };
    return data;
  }
}
