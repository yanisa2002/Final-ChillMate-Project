import 'package:chillmate/models/exp.dart';
import 'package:chillmate/screen/addIngredient/addIngredientNoDate.dart';
import 'package:chillmate/screen/addIngredient/detailEXP.dart';
import 'package:chillmate/services/imageUploadService.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DetailOBJ extends StatefulWidget {
  final String fridgeNameSave;
  final String id;
  final String? detailClass;
  final String? subClassname;
  final List<String>? subclass;
  const DetailOBJ(
      {Key? key,
      required this.fridgeNameSave,
      required this.id,
      this.detailClass,
      this.subClassname,
      this.subclass})
      : super(key: key);

  @override
  _DetailOBJState createState() => _DetailOBJState();
}

class _DetailOBJState extends State<DetailOBJ> {
  XFile? pickedFile;
  EXPdata? dataEXP;
  ImageUploadService uploadService = ImageUploadService();
  List<String> resultToSent = [];
  String namePredict = '';

  void pickedImageEXP() async {
    final picker = ImagePicker();
    pickedFile = await picker.pickImage(source: ImageSource.gallery);

    BuildContext currentContext = context;

    if (pickedFile != null) {
      try {
        var data = await uploadService.uploadImageExp(pickedFile!);

        if (data != null) {
          // Use the captured context
          if (mounted) {
            setState(() {
              EXPdata? dataEXP = data as EXPdata?;
            });
          }

          print(dataEXP);

          String? Exy = dataEXP?.message?.data?.eXP!.y;
          String? Exd = dataEXP?.message?.data?.eXP!.d;
          String? Exm = dataEXP?.message?.data?.eXP!.m;
          String ExpAll = Exd! + '/' + Exm! + '/' + Exy!;
          String? Py = dataEXP?.message?.data?.pD!.y;
          String? Pd = dataEXP?.message?.data?.pD!.d;
          String? Pm = dataEXP?.message?.data?.pD!.m;
          String pAll = Pd! + '/' + Pm! + '/' + Py!;

          Navigator.push(
            currentContext,
            MaterialPageRoute(
              builder: (context) => DetailEXP(
                fridgeNameSave: widget.fridgeNameSave,
                id: widget.id,
                subclass: resultToSent,
                detailClass: namePredict,
                EXP: ExpAll,
                PD: pAll,
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

  List<String> extractDataInParentheses(List<String> subClassDetail) {
    return subClassDetail.map((item) {
      final match = RegExp(r'\((.*?)\)').firstMatch(item);
      return match?.group(1) ?? '';
    }).toList();
  }

  @override
  void initState() {
    // TODO: implement initState
    namePredict = widget.detailClass!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(namePredict);
    List<String> result = extractDataInParentheses(widget.subclass!);
    return Scaffold(
      appBar: AppBar(title: Text('ผลลัพธ์การแสกนวัตถุดิบ')),
      body: Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.centerLeft,
          child: Column(
            children: [
              Row(
                children: [
                  Text('predicted Class : '),
                  Text('${widget.detailClass}'),
                ],
              ),
              Row(
                children: [
                  Text('Sub Class : '),
                  Text('${widget.subClassname}'),
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Sub Class Detail: ',
                ),
              ),
              Container(padding: EdgeInsets.all(10), child: Text('${result}')),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 300,
                height: 50,
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
                      setState(() {
                        resultToSent = result;
                        print(resultToSent);
                      });
                      pickedImageEXP();
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: const Center(
                      child: Text(
                        "แสกนข้อมูลวันหมดอายุ",
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
                height: 20,
              ),
              Container(
                width: 300,
                height: 50,
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
                      setState(() {
                        resultToSent = result;
                        print(resultToSent);
                      });

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddIngredientNoDate(
                                  fridgeName: widget.fridgeNameSave,
                                  uuID: widget.id,
                                  predictClass: namePredict,
                                  SubDetail: resultToSent,
                                )),
                      );
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: const Center(
                      child: Text(
                        "เพิ่มข้อมูลวัตถุดิบ",
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
          )),
    );
  }
}
