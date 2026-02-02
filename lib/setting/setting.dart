import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cssd_project/homepage/home_page.dart';
import 'package:flutter/material.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final _formKeyroom = GlobalKey<FormState>();
  final _room_from = TextEditingController();
  final _formKeytools = GlobalKey<FormState>();
  final _tools_from = TextEditingController();
  int page_index = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              IconButton(
                onPressed: () {
                  routToService(HomePage(), false);
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
              Text(
                'Setting',
                // style: TextStyle(color: Colors.white),
                textAlign: TextAlign.start,
              ),
            ],
          ),
          backgroundColor: Colors.lightBlue.shade200,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("room_cssd")
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              var data_room = snapshot.data!.docs;
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.blueAccent.shade700,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                    topLeft: Radius.circular(
                                                      10,
                                                    ),
                                                    topRight: Radius.circular(
                                                      10,
                                                    ),
                                                    bottomLeft: Radius.circular(
                                                      10,
                                                    ),
                                                    bottomRight:
                                                        Radius.circular(10),
                                                  ),
                                              border: Border.all(
                                                color:
                                                    Colors.blueAccent.shade700,
                                                width: 1,
                                              ),
                                            ),
                                            padding: EdgeInsets.all(5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                TextButton.icon(
                                                  onPressed: () async {
                                                    setState(() {
                                                      _room_from.clear();
                                                      if (page_index == 1) {
                                                        page_index = 0;
                                                      } else {
                                                        page_index = 1;
                                                      }
                                                    });
                                                  },
                                                  icon: Icon(
                                                    Icons.add_circle_outline,
                                                    color: Colors.white,
                                                  ),
                                                  label: Text(
                                                    'เพิ่มห้องรับของ',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.deepPurple.shade400,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                    topLeft: Radius.circular(
                                                      10,
                                                    ),
                                                    topRight: Radius.circular(
                                                      10,
                                                    ),
                                                    bottomLeft: Radius.circular(
                                                      10,
                                                    ),
                                                    bottomRight:
                                                        Radius.circular(10),
                                                  ),
                                              border: Border.all(
                                                color:
                                                    Colors.deepPurple.shade400,
                                                width: 1,
                                              ),
                                            ),
                                            padding: EdgeInsets.all(5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                TextButton.icon(
                                                  onPressed: () async {
                                                    setState(() {
                                                      _room_from.clear();
                                                      if (page_index == 2) {
                                                        page_index = 0;
                                                      } else {
                                                        page_index = 2;
                                                      }
                                                    });
                                                  },
                                                  icon: Icon(
                                                    Icons.plumbing_outlined,
                                                    color: Colors.white,
                                                  ),
                                                  label: Text(
                                                    'อุปกรณ์',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      page_index == 1
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                stream: FirebaseFirestore.instance
                                    .collection("room_cssd")
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  var data_room = snapshot.data!.docs;
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Form(
                                              key: _formKeyroom,
                                              child: TextFormField(
                                                controller: _room_from,
                                                validator: (value) {
                                                  if (value == '' ||
                                                      value == null) {
                                                    return 'กรุณากรอก หมวดหมู่';
                                                  }
                                                  return null;
                                                },
                                                onFieldSubmitted: (value) {},
                                                decoration: _decoration(
                                                  'ห้องรับของ',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.orange.shade900,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                      topLeft: Radius.circular(
                                                        10,
                                                      ),
                                                      topRight: Radius.circular(
                                                        10,
                                                      ),
                                                      bottomLeft:
                                                          Radius.circular(10),
                                                      bottomRight:
                                                          Radius.circular(10),
                                                    ),
                                                border: Border.all(
                                                  color: Colors.orange.shade900,
                                                  width: 1,
                                                ),
                                              ),
                                              padding: EdgeInsets.all(5),
                                              child: TextButton.icon(
                                                onPressed: () async {
                                                  if (_formKeyroom.currentState!
                                                      .validate()) {
                                                    final room_id =
                                                        data_room.length == 0
                                                        ? 1
                                                        : int.parse(
                                                                data_room
                                                                    .last["room_id"]
                                                                    .toString(),
                                                              ) +
                                                              1;
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('room_cssd')
                                                        .doc(
                                                          "R${room_id.toString().padLeft(5, '0')}",
                                                        )
                                                        .set(
                                                          {
                                                            'room_id': room_id,
                                                            'room_name':
                                                                _room_from.text,
                                                            'room_on': 0,
                                                            'created_at':
                                                                FieldValue.serverTimestamp(),
                                                          },
                                                          SetOptions(
                                                            merge: true,
                                                          ),
                                                        )
                                                        .then((e) {
                                                          setState(() {
                                                            _room_from.clear();
                                                          });
                                                        });
                                                  }
                                                },
                                                icon: Icon(
                                                  Icons.save_outlined,
                                                  color: Colors.white,
                                                ),
                                                label: Text(
                                                  'บันทึก',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ListView.builder(
                                              padding: const EdgeInsets.all(8),
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: data_room.length,
                                              itemBuilder: (context, index) {
                                                final data = data_room[index]
                                                    .data();
                                                final roomname =
                                                    data["room_name"]
                                                        ?.toString() ??
                                                    "-";
                                                return GestureDetector(
                                                  onTap: () {
                                                    PanaraConfirmDialog.showAnimatedGrow(
                                                      context,
                                                      title:
                                                          "ห้อง ${data_room[index]["room_name"]}",
                                                      message:
                                                          "( ต้องการลบ ใช่ หรือ ไม่ )",
                                                      confirmButtonText:
                                                          "Confirm",
                                                      cancelButtonText:
                                                          "Cancel",
                                                      onTapCancel: () {
                                                        Navigator.of(
                                                          context,
                                                          rootNavigator: true,
                                                        ).pop();
                                                      },
                                                      onTapConfirm: () async {
                                                        // print('${data_table[index]["tablename"]}');
                                                        // print('Document ID: ${data_table[index].id}');
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                              'room_cssd',
                                                            )
                                                            .doc(
                                                              data_room[index]
                                                                  .id,
                                                            )
                                                            .delete()
                                                            .then((e) {
                                                              Navigator.of(
                                                                context,
                                                                rootNavigator:
                                                                    true,
                                                              ).pop();
                                                            });
                                                      },
                                                      panaraDialogType:
                                                          PanaraDialogType
                                                              .warning,
                                                    );
                                                  },
                                                  child: Card(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                            8,
                                                          ),
                                                      child: Center(
                                                        child: Text(roomname),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ),
                            )
                          : page_index == 2
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                stream: FirebaseFirestore.instance
                                    .collection("tools_cssd")
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  var data_tools = snapshot.data!.docs;
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Form(
                                              key: _formKeytools,
                                              child: TextFormField(
                                                controller: _tools_from,
                                                validator: (value) {
                                                  if (value == '' ||
                                                      value == null) {
                                                    return 'กรุณากรอก หมวดหมู่';
                                                  }
                                                  return null;
                                                },
                                                onFieldSubmitted: (value) {},
                                                decoration: _decoration(
                                                  'อุปกรณ์',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.orange.shade900,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                      topLeft: Radius.circular(
                                                        10,
                                                      ),
                                                      topRight: Radius.circular(
                                                        10,
                                                      ),
                                                      bottomLeft:
                                                          Radius.circular(10),
                                                      bottomRight:
                                                          Radius.circular(10),
                                                    ),
                                                border: Border.all(
                                                  color: Colors.orange.shade900,
                                                  width: 1,
                                                ),
                                              ),
                                              padding: EdgeInsets.all(5),
                                              child: TextButton.icon(
                                                onPressed: () async {
                                                  if (_formKeytools
                                                      .currentState!
                                                      .validate()) {
                                                    final tools_id =
                                                        data_tools.length == 0
                                                        ? 1
                                                        : int.parse(
                                                                data_tools
                                                                    .last["tools_id"]
                                                                    .toString(),
                                                              ) +
                                                              1;
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                          'tools_cssd',
                                                        )
                                                        .doc(
                                                          "T${tools_id.toString().padLeft(5, '0')}",
                                                        )
                                                        .set(
                                                          {
                                                            'tools_id':
                                                                tools_id,
                                                            'tools_name':
                                                                _tools_from
                                                                    .text,
                                                            'tools_on': 0,
                                                            'created_at':
                                                                FieldValue.serverTimestamp(),
                                                          },
                                                          SetOptions(
                                                            merge: true,
                                                          ),
                                                        )
                                                        .then((e) {
                                                          setState(() {
                                                            _tools_from.clear();
                                                          });
                                                        });
                                                  }
                                                },
                                                icon: Icon(
                                                  Icons.save_outlined,
                                                  color: Colors.white,
                                                ),
                                                label: Text(
                                                  'บันทึก',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: data_tools.isEmpty
                                                ? SizedBox()
                                                : ListView.builder(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    shrinkWrap: true,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemCount:
                                                        data_tools.length,
                                                    itemBuilder: (context, index) {
                                                      final data =
                                                          data_tools[index]
                                                              .data();
                                                      final toolsname =
                                                          data["tools_name"]
                                                              ?.toString() ??
                                                          "-";
                                                      return GestureDetector(
                                                        onTap: () {
                                                          PanaraConfirmDialog.showAnimatedGrow(
                                                            context,
                                                            title:
                                                                "อุปกรณ์ ${data_tools[index]["tools_name"]}",
                                                            message:
                                                                "( ต้องการลบ ใช่ หรือ ไม่ )",
                                                            confirmButtonText:
                                                                "Confirm",
                                                            cancelButtonText:
                                                                "Cancel",
                                                            onTapCancel: () {
                                                              Navigator.of(
                                                                context,
                                                                rootNavigator:
                                                                    true,
                                                              ).pop();
                                                            },
                                                            onTapConfirm: () async {
                                                              // print('${data_table[index]["tablename"]}');
                                                              // print('Document ID: ${data_table[index].id}');
                                                              await FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                    'tools_cssd',
                                                                  )
                                                                  .doc(
                                                                    data_tools[index]
                                                                        .id,
                                                                  )
                                                                  .delete()
                                                                  .then((e) {
                                                                    Navigator.of(
                                                                      context,
                                                                      rootNavigator:
                                                                          true,
                                                                    ).pop();
                                                                  });
                                                            },
                                                            panaraDialogType:
                                                                PanaraDialogType
                                                                    .warning,
                                                          );
                                                        },
                                                        child: Card(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets.all(
                                                                  8,
                                                                ),
                                                            child: Center(
                                                              child: Text(
                                                                toolsname,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _decoration(String name_type) {
    return InputDecoration(
      contentPadding: EdgeInsets.all(8),
      labelText: name_type,
      errorStyle: TextStyle(height: 1, fontSize: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(color: Colors.black, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(color: Colors.black, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(color: Colors.black, width: 1),
      ),
      labelStyle: TextStyle(color: Colors.black, fontSize: 12),
      hintStyle: TextStyle(color: Colors.black, fontSize: 12),
    );
  }

  void routToService(Widget myWidget, bool _bool) {
    if (!context.mounted) return;
    MaterialPageRoute route = MaterialPageRoute(builder: (context) => myWidget);
    Navigator.pushAndRemoveUntil(context, route, (route) => _bool);
  }
}
