import 'package:chillmate/screen/setting/editGroupRefrPage.dart';
import 'package:chillmate/screen/setting/setting.dart';
import 'package:flutter/material.dart';

class GroupRefriPage extends StatefulWidget {
  const GroupRefriPage({Key? key}) : super(key: key);

  @override
  _GroupRefriPageState createState() => _GroupRefriPageState();
}

class _GroupRefriPageState extends State<GroupRefriPage> {
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'กลุ่มผู้ใช้',
          style: TextStyle(
              color: Color(0xFFF49D1A),
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Setting()),
            );
          },
          icon: Icon(Icons.keyboard_arrow_left),
          color: Colors.amber,
          iconSize: 40,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const EditGroupRefriPage()),
              );
            },
            icon: Icon(Icons.edit),
            color: Colors.amber,
            iconSize: 25,
          ),
        ],
      ),
      body: ListsWithCards(),
    );
  }
}

class ListsWithCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<List<String>> listsData = [
      ['ตู้ในบ้าน', 'User1', 'User2'],
      ['ตู้นอกบ้าน', 'User1', 'User2', 'User3'],
    ];

    return ListView.builder(
      itemCount: listsData.length,
      itemBuilder: (context, index) {
        return CardList(listData: listsData[index]);
      },
    );
  }
}

class CardList extends StatefulWidget {
  final List<String> listData;

  CardList({required this.listData});

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  bool isExpand = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      color: Color.fromARGB(255, 255, 243, 182),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              setState(() {
                isExpand = !isExpand;
              });
            },
            //trailing: ,
            title: Text('List ${widget.listData[0]}'),
          ),
          if (isExpand)
            Column(
              children: [
                Divider(),
                ListView.builder(
                  itemCount: widget.listData.length - 1,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(widget.listData[index + 1]),
                    );
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }
}
