
import 'package:chillmate/models/obj.dart';
import 'package:chillmate/screen/addIngredient/addDetailIngredientPage.dart';
import 'package:chillmate/screen/addIngredient/detailOBJ.dart';
import 'package:chillmate/services/imageUploadService.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddIngredientChoice extends StatefulWidget {
  final String name;
  final String fridgeID;
  const AddIngredientChoice(
      {Key? key, required this.name, required this.fridgeID})
      : super(key: key);

  @override
  _AddIngredientChoiceState createState() => _AddIngredientChoiceState();
}

class _AddIngredientChoiceState extends State<AddIngredientChoice> {
  XFile? pickedFile;
  OBJ? dataOBJ;
  ImageUploadService uploadService = ImageUploadService();

  void pickedImage() async {
    final picker = ImagePicker();
    pickedFile = await picker.pickImage(source: ImageSource.camera);

    BuildContext currentContext = context;

    if (pickedFile != null) {
      try {
        var data = await uploadService.uploadImage(pickedFile!);

        if (data != null) {
          // Use the captured context
          if (mounted) {
            setState(() {
              dataOBJ = data;
            });
          }

          // Use the captured context for navigation
          Navigator.push(
            currentContext,
            MaterialPageRoute(
              builder: (context) => DetailOBJ(
                fridgeNameSave: widget.name,
                id: widget.fridgeID,
                detailClass: dataOBJ?.message?.data?.classI?.predictedClass,
                subclass: dataOBJ?.message?.data?.classI?.subClassDetail,
                subClassname: dataOBJ?.message?.data?.classI?.subClass,
              ),
            ),
          );
        } else {
          print('Error: Data is null');
        }
      } catch (error) {
        print('Error: $error');
      }
    } else {
      print('Error: No image picked');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'เพิ่มวัตถุดิบ',
          style: TextStyle(
              color: Color(0xFFF49D1A),
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
          icon: Icon(Icons.keyboard_arrow_left),
          color: Colors.amber,
          iconSize: 40,
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 300,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      pickedImage();
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: const Center(
                      child: Text(
                        "แสกนข้อมูลผ่านกล้อง",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: 300,
                height: 100,
                decoration: BoxDecoration(
                  color: Color(0xFFB01E68),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddDetailIngredientPage(
                                  fridgeName: widget.name,
                                  uuID: widget.fridgeID,
                                )),
                      );
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: const Center(
                      child: Text(
                        "กรอกข้อมูลวัตถุดิบ",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
