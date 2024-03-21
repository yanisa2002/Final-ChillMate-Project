import 'package:flutter/material.dart';

class IngredientsSection extends StatefulWidget {
  const IngredientsSection({Key? key}) : super(key: key);

  @override
  _IngredientsSectionState createState() => _IngredientsSectionState();
}

class _IngredientsSectionState extends State<IngredientsSection> {
  List<String> nameItems = <String>[
    'แอปเปิ้ล',
    'กล้วย',
    'เมล่อน',
  ];
  final fields = [];

  void _addField() {
    fields.add('');
    setState(() {
      print(fields);
    });
  }

  void _removeField(int index) {
    fields.removeAt(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < fields.length; i++)
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                Expanded(
                  child: Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return const Iterable<String>.empty();
                      }
                      return nameItems.where((String item) {
                        return item.contains(textEditingValue.text);
                      });
                    },
                    onSelected: (String item) {
                      print('$item ถูกเลือก');
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: 'จำนวน',
                      //label: Text('Name'),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text('กรัม'),
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
