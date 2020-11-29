import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Massage massage;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/massage': (context) => MassagePage(),
      },
    );
  }
}

class MassagePage extends StatefulWidget {
  @override
  _MassagePageState createState() => _MassagePageState();
}

class _MassagePageState extends State<MassagePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(massage.image),
              ),
              Container(
                width: 20,
              ),
              Text(massage.name)
            ],
          ),
        ),
        body:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
            child: makeText()),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(35.0),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 3),
                            blurRadius: 5,
                            color: Colors.grey)
                      ],
                    ),
                    child: Row(
                      //crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.face,
                              color: Colors.green,
                            ),
                            onPressed: () {}),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "Type Something...",
                                hintStyle: TextStyle(color: Colors.green),
                                border: InputBorder.none),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.photo_camera,
                              color: Colors.green),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon:
                              Icon(Icons.attach_file, color: Colors.green),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      color: Colors.green, shape: BoxShape.circle),
                  child: InkWell(
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                    onLongPress: () {},
                  ),
                )
              ],
            ),
         ],
       )
    );
  }

  ListView makeText() {
    List containers = List<Align>();

    for (int i = 0; i < massage.massage.length; i++) {
      containers.add(Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(10)),
            child: Text(
              massage.massage[i]['text'],
              style: TextStyle(fontSize: 25, color: Colors.black),
            ),
          )));
    }

    return ListView(
      children: containers,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          centerTitle: true,
          title: Text('BSL'),
        ),
        LList(),
      ],
    ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

class LList extends StatefulWidget {
  @override
  _LListState createState() => _LListState();
}

class _LListState extends State<LList> {
  List<dynamic> jsn;
  bool firs = true;

  void upd() async {
    var resp = await http.post(
        'https://bsl-show.ru/api/userMsg.php?type=spam&ts=andrei',
        body: {'type': 'spam', 'ts': 'andrei'});
    setState(() {
      jsn = json.decode(resp.body);
      print(resp.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (firs == true) {
      upd();
      firs = false;
    }
    return SliverList(
      delegate: SliverChildListDelegate(mkContain(context)),
    );
  }

  List<Container> mkContain(BuildContext context) {
    List containers = List<Container>();
    var size = MediaQuery.of(context).size;
    print(jsn.runtimeType);

    if (jsn == null) {
      containers.add(Container());
      return containers;
    }

    print('gi');

    for (int i = 0; i < jsn.length; i++) {
      String count = jsn[i]['cntChek'].toString();

      containers.add(Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
        height: size.height * 0.15,
        width: size.width * 0.9,
        child: Row(
          children: [
            CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage(jsn[i]['avatar']),
            ),
            Container(
              width: size.width * 0.1,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  jsn[i]['frms'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                ),
                Text(
                  jsn[i]['text'],
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
                      pushMassage(i);
                    },
                  ),
                  Text(count, style: TextStyle(fontWeight: FontWeight.bold))
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

  void pushMassage(int i) async {
    var resp = await http.post('https://bsl-show.ru/api/getmsgonUser.php',
        body: {
          'type': jsn[i]['type'],
          'frms': jsn[i]['frms'],
          'ts': jsn[1]['ts']
        });
    print(resp.body);
    massage = Massage(jsn[i]['avatar'], jsn[i]['frms'], json.decode(resp.body));
    Navigator.pushNamed(context, '/massage');
  }
}

class Massage {
  var image;
  String name;
  var massage;

  Massage(this.image, this.name, this.massage);
}
