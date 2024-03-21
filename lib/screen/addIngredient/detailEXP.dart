import 'package:chillmate/models/exp.dart';
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
          '';
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
              SizedBox(
                height: 20,
              ),
            ],
          )),
    );
  }
}
