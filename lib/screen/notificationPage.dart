import 'package:flutter/material.dart';

class NotiPage extends StatefulWidget {
  const NotiPage({Key? key}) : super(key: key);
  static const route = '/notification-screen';

  @override
  _NotiPageState createState() => _NotiPageState();
}

class _NotiPageState extends State<NotiPage> {


  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'การแจ้งเตือน',
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
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ล่าสุด",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}