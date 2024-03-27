import 'package:chillmate/models/exp.dart';
import 'package:chillmate/screen/addIngredient/addIngredientNoDate.dart';
import 'package:chillmate/services/imageUploadService.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DetailEXP extends StatefulWidget {
  final String fridgeNameSave;
  final String id;
  final String? detailClass;
  final String? subClassname;
  final List<String>? subclass;
  final String? PD;
  final String? EXP;
  const DetailEXP(
      {Key? key,
      required this.fridgeNameSave,
      required this.id,
      this.detailClass,
      this.subClassname,
      this.subclass,
      this.PD,
      this.EXP})
      : super(key: key);

  @override
  _DetailEXPState createState() => _DetailEXPState();
}

class _DetailEXPState extends State<DetailEXP> {
  XFile? pickedFile;
  EXPdata? dataEXP;
  ImageUploadService uploadService = ImageUploadService();
  List<String> resultToSent = [];
  String namePredict = '';

  List<String> extractDataInParentheses(List<String> subClassDetail) {
    return subClassDetail.map((item) {
      final match = RegExp(r'\((.*?)\)').firstMatch(item);
      return match?.group(1) ??
          ''; // ถ้าไม่พบข้อมูลในวงเล็บ ให้ return ข้อความว่าง
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
    print(dataEXP);
    List<String> result = extractDataInParentheses(widget.subclass!);
    return Scaffold(
      appBar: AppBar(title: Text('ผลลัพธ์การแสกนวันที่')),
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
              Row(
                children: [
                  Text('PD : '),
                  Text('${widget.PD}'),
                ],
              ),
              Row(
                children: [
                  Text('EXP : '),
                  Text('${widget.EXP}'),
                ],
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
                      //pickedImage();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddIngredientNoDate(
                                  fridgeName: widget.fridgeNameSave,
                                  uuID: widget.id,
                                  predictClass: namePredict,
                                  SubDetail: resultToSent,
                                  PD: widget.PD,
                                  EXP: widget.EXP,
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
