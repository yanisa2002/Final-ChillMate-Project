import 'package:flutter/material.dart';

class MethodsSection extends StatefulWidget {
  const MethodsSection({ Key? key }) : super(key: key);

  @override
  _MethodsSectionState createState() => _MethodsSectionState();
}

class _MethodsSectionState extends State<MethodsSection> {
  final fields = [];

  void _addField() {
    fields.add('');
    setState(() {
      print(fields);
    });
  }

  void _removeField(int index) {
    fields.removeAt(index);
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Text(
        //   'วิธีทำ',
        // ),
        // SizedBox(
        //   height: 15,
        // ),
        for (var i = 0; i < fields.length; i++)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: 'วิธีทำ',
                      //label: Text('Name'),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                
                IconButton(
                    onPressed: () {
                      _removeField(i);
                    },
                    icon: const Icon(
                      Icons.remove_circle,
                      color: Colors.red,
                      size: 30,
                    )),
              ],
            ),
          ),
        ElevatedButton(
          onPressed: () {
            _addField();
          },
          child: Text('Add'),
          style: ElevatedButton.styleFrom(
              minimumSize: Size(327, 50),
              backgroundColor: Colors.amber,
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              )),
        ),
      ],
    );
  }
}