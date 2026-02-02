import 'package:cssd_project/homepage/home_menu.dart';
import 'package:cssd_project/setting/setting.dart';
import 'package:flutter/material.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = [];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _widgetOptions.add(HomeMenu());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Row(
            children: [
              Text('Receive CSSD Cleaning', textAlign: TextAlign.start),
            ],
          ),
          backgroundColor: Colors.lightBlue.shade200,
        ),
        drawer: Drawer(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/10497893.png'),
                          fit: BoxFit.cover, // หรือ contain / fill
                        ),
                        // color: Colors.white, // พื้นหลัง DrawerHeader
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(child: Icon(Icons.person, size: 40)),
                          Expanded(
                            child: Text(
                              "CSSD",
                              style: TextStyle(
                                fontSize: 18,
                                // color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "",
                                style: TextStyle(
                                  fontSize: 14,
                                  // color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text("ตั้งค่า"),
                      onTap: () {
                        routToService(Setting(), false);
                        _scaffoldKey.currentState?.closeDrawer();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Container(
          child: _widgetOptions.isNotEmpty
              ? _widgetOptions.elementAt(_selectedIndex)
              : SizedBox(),
        ),
      ),
    );
  }

  void routToService(Widget myWidget, bool _bool) {
    if (!context.mounted) return;
    MaterialPageRoute route = MaterialPageRoute(builder: (context) => myWidget);
    Navigator.pushAndRemoveUntil(context, route, (route) => _bool);
  }
}
