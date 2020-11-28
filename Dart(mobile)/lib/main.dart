import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green,
        accentColor: Colors.grey,
      ),
      title: 'SberChat',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/settings': (context) => SettingPage()
      },
    ));

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _curIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(_curIndex, context),
      backgroundColor: Colors.white,
      //backgroundColor: Color.fromARGB(253, 60, 63, 72),
      body: Stack(
        children: <Widget>[
          getBody(_curIndex),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: BatNav(context),
          ),
        ],
      ),
      //bottomNavigationBar: ,
    );
  }

  Widget getAppBar(int i, BuildContext context) {
    if (i == 0) {
      return null;
    } else if (i == 1) {
      return AppBar(title: Text('Сообщение'), shape: getShape());
    } else if (i == 2) {
      return AppBar(title: Text('Categoris'), shape: getShape());
    } else if (i == 3) {
      return AppBar(
          title: Text('Profile'),
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.pushNamed(context, "/settings");
              },
            )
          ],
          shape: getShape());
    }
  }

  ContinuousRectangleBorder getShape() {
    return ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)));
  }

  Widget getBody(int i) {
    if (i == 0) {
      return MassageList();
    } else if (i == 1) {
      return Container();
    } else if (i == 2) {
      return Container();
    } else if (i == 3) {
      return Container();
    }
    return null;
  }

  Widget BatNav(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
          topLeft: Radius.circular(40),
          // bottomRight: Radius.circular(40),
          // bottomLeft: Radius.circular(40),
        ),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Дом')),
            BottomNavigationBarItem(
                icon: Icon(Icons.mail), title: Text('Почта')),
            BottomNavigationBarItem(
                icon: Icon(Icons.list), title: Text('Категории')),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), title: Text('Профиль')),
          ],
          backgroundColor: Color.fromARGB(200, 60, 63, 72),
          currentIndex: _curIndex,
          unselectedItemColor:
              Color.fromARGB(253, 49, 201, 103), //R: 49 G: 201 B: 103
          selectedItemColor: Colors.black,
          showUnselectedLabels: true,
          onTap: (index) {
            setState(() {
              _curIndex = index;
              print(_curIndex);
            });
          },
        ));
  }
}

class MassageList extends StatefulWidget {
  MassageList({Key key}) : super(key: key);

  @override
  _MassageListState createState() => _MassageListState();
}

class _MassageListState extends State<MassageList> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          elevation: 0,
          title: Text('SberChat'),
          centerTitle: true,
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40))),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
              //containers(size)
              [Ctinr()]),
        )
      ],
    );
  }

  List<Container> containers(Size size) {
    var containers = new List<Container>();
    List<dynamic> resp;
    getPersons().then((value) => {resp = value});
    //Image img = Image.network(resp[0]['avatar']);

    //while (resp == null) {}
    for (int i = 0; i < 100; i++) {
      var circleAvatar = CircleAvatar(
        radius: 40,
        // backgroundImage: NetworkImage(resp[0]['avatar']),
      );
      containers.add(Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
        height: size.height * 0.15,
        width: size.width * 0.9,
        child: Row(
          children: [
            circleAvatar,
            Container(
              width: size.width * 0.1,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Name',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                ),
                Text(
                  'massage',
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: size.width * 0.20),
              alignment: Alignment.centerRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.mail),
                    onPressed: () {
                      print(resp[0]['type']);
                    },
                  ),
                  Text('5', style: TextStyle(fontWeight: FontWeight.bold))
                ],
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
            //color: Colors.greenAccent,
            borderRadius: BorderRadius.circular(10)),
      ));
    }
    return containers;
  }

  Future<List> getPersons() async {
    var response = await http.post(
        'https://bsl-show.ru/api/userMsg.php?type=spam&ts=andrei',
        body: {'name': 'test', 'num': '10'});
    return json.decode(response.body);
  }
}

class Ctinr extends StatefulWidget {
  Ctinr({Key key}) : super(key: key);

  @override
  _CtinrState createState() => _CtinrState();
}

class _CtinrState extends State<Ctinr> {
  NetworkImage img = null;
  String name = '';
  String massage = '';
  int countMassage = 0;

  Future dowloadState() async {
    var response = await http.post(
        'https://bsl-show.ru/api/userMsg.php?type=spam&ts=andrei',
        body: {'name': 'test', 'num': '10'});
    var rs = json.decode(response.body);
    setState(() {
      img = NetworkImage(rs[0]['avatar']);
      name = rs[0]['frms'];
      massage = rs[0]['text'];
      countMassage = rs[0]['cntChek'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    dowloadState();

    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
      height: size.height * 0.15,
      width: size.width * 0.9,
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: img,
          ),
          Container(
            width: size.width * 0.1,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
              ),
              Text(
                massage,
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: size.width * 0.20),
            alignment: Alignment.centerRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.mail),
                  onPressed: () {
                    //print(resp[0]['type']);
                  },
                ),
                Text('$countMassage',
                    style: TextStyle(fontWeight: FontWeight.bold))
              ],
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
          //color: Colors.greenAccent,
          borderRadius: BorderRadius.circular(10)),
    );
  }
}

class SettingPage extends StatelessWidget {
  const SettingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Настройки'),
      ),
      body: Container(),
    );
  }
}
