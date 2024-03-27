import 'dart:convert';

import 'package:chillmate/models/exp.dart';
import 'package:chillmate/models/obj.dart';
import 'package:chillmate/pkg/constant/asset.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadService {
  Future<OBJ?> uploadImage(XFile? pickedFile) async {
    try {
      Dio dio = Dio();

      if (pickedFile != null) {
        FormData formData = FormData.fromMap({
          'img': await MultipartFile.fromFile(pickedFile.path,
              filename: 'image.jpg'),
        });

        Response response = await dio.put(
          '${AssetConst.API_URL}model/obj',
          data: formData,
        );

        if (response.statusCode == 200) {
          print('Image uploaded sucessfully');
          print(response.data);
          //final responseBody = jsonDecode(response.data);
          OBJ dataOBJ = OBJ.fromJson(response.data);
          //OBJ dataOBJ = OBJ.fromJson(jsonDecode(response.data));
          print(dataOBJ);
          return dataOBJ;
        } else {
          print('Image upload failed. Error: ${response.statusCode}');
        }
      } else {}
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  Future<EXPdata?> uploadImageExp(XFile? pickedFile) async {
    try {
      Dio dio = Dio();

      if (pickedFile != null) {
        FormData formData = FormData.fromMap({
          'img': await MultipartFile.fromFile(pickedFile.path,
              filename: 'image.jpg'),
        });

        Response response = await dio.put(
          '${AssetConst.API_URL}model/exp',
          data: formData,
        );

        if (response.statusCode == 200) {
          print('Image uploaded sucessfully');
          print(response.data);
          EXPdata dataEXP = EXPdata.fromJson(response.data);
          print(dataEXP);
          return dataEXP;
        } else {
          print('Image upload failed. Error: ${response.statusCode}');
        }
      } else {}
    } catch (e) {
      print('Error uploading image: $e');
    }
  }
}
