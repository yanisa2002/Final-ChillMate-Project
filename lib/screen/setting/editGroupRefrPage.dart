import 'package:chillmate/screen/setting/groupRefriPage.dart';
import 'package:flutter/material.dart';

class EditGroupRefriPage extends StatefulWidget {
  const EditGroupRefriPage({Key? key}) : super(key: key);

  @override
  _EditGroupRefriPageState createState() => _EditGroupRefriPageState();
}

class _EditGroupRefriPageState extends State<EditGroupRefriPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'แก้ไขกลุ่มผู้ใช้',
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
              // MaterialPageRoute(builder: (context) => const Nav()),
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
                MaterialPageRoute(builder: (context) => const GroupRefriPage()),
              );
            },
            icon: Icon(Icons.done),
            color: Colors.amber,
            iconSize: 40,
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
    // Sample data for three lists
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
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('List ${widget.listData[0]}'),
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text('แก้ไขชื่อตู้เย็น'),
                                content: TextField(
                                  autofocus: true,
                                  decoration:
                                      InputDecoration(hintText: 'ชื่อตู้เย็น'),
                                  //controller: addUsercontroller,
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        addUser();
                                      },
                                      child: Text('บันทึก')),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('ยกเลิก'))
                                ],
                              ));
                    },
                    icon: Icon(Icons.edit))
              ],
            ),
            trailing: IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          actions: [
                            TextButton(
                              onPressed: () async {
                                print("Deleate fridge----------");
                              },
                              child: Text('ตกลง'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('ยกเลิก'),
                            ),
                          ],
                          title: const Text('ลบตู้เย็น'),
                          contentPadding: const EdgeInsets.all(20.0),
                          content:
                              const Text('คุณต้องการลบ "ตู้ในบ้าน" ใช่หรือไม่'),
                        ));
              },
              icon: Icon(Icons.delete),
            ),
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
                      trailing: IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    actions: [
                                      TextButton(
                                        onPressed: () async {
                                          print("Deleate User----------");
                                        },
                                        child: Text('ตกลง'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('ยกเลิก'),
                                      ),
                                    ],
                                    title: const Text('ลบสมาชิก'),
                                    contentPadding: const EdgeInsets.all(20.0),
                                    content: const Text(
                                        'คุณต้องการลบ "xxxxxx" ออกจาก "ตู้ในบ้าน" ใช่หรือไม่'),
                                  ));
                        },
                        icon: Icon(Icons.cancel),
                      ),
                    );
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text('เพิ่มสมาชิก'),
                              content: TextField(
                                autofocus: true,
                                decoration:
                                    InputDecoration(hintText: 'ชื่อผู้ใช้'),
                                //controller: addUsercontroller,
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      addUser();
                                    },
                                    child: Text('ส่ง')),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('ยกเลิก'))
                              ],
                            ));
                  },
                  child: Text("เพิ่มสมาชิก"),
                )
              ],
            ),
        ],
      ),
    );
  }

  void addUser() {
    //Navigator.of(context).pop(addUsercontroller.text);
  }
}
