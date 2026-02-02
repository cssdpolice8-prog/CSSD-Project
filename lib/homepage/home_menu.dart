import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cssd_project/homepage/viewphoto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({super.key});

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  Uint8List? base64_Slip;
  String? name_room, room_id;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: Stream.periodic(const Duration(seconds: 1)),
                  builder: (context, snapshot) {
                    return Card(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          border: Border.all(color: Colors.black, width: 1),
                          image: DecorationImage(
                            image: AssetImage('assets/images/10497893.png'),
                            fit: BoxFit.cover, // cover / contain / fill
                            opacity: 0.3,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "วันที่",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "เวลา",
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "${DateFormat.MMMMd('th').format(DateTime.now())} ${int.parse(DateFormat.y().format(DateTime.now())) + 543}",
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        " ${DateFormat('HH:mm:ss').format(DateTime.now())}",
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                name_room = null;
                                room_id = null;
                              });
                            },
                            child: Card(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Center(child: Text('ห้องส่งล้าง')),
                                ),
                              ),
                            ),
                          ),
                          Divider(),
                          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                            stream: FirebaseFirestore.instance
                                .collection("room_cssd")
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              //  error
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text("Error: ${snapshot.error}"),
                                );
                              }

                              // null safety
                              if (!snapshot.hasData || snapshot.data == null) {
                                return const Center(child: Text("No data"));
                              }

                              final data_room = snapshot.data!.docs;

                              //  empty
                              if (data_room.isEmpty) {
                                return const Center(child: Text("ไม่มีข้อมูล"));
                              }
                              return ListView.builder(
                                // padding: const EdgeInsets.all(8),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: data_room.length,
                                itemBuilder: (context, index) {
                                  final data = data_room[index].data();
                                  final roomname =
                                      data["room_name"]?.toString() ?? "-";
                                  final data_id = data_room[index].id;

                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        name_room = roomname;
                                        room_id = data_id;
                                      });
                                    },
                                    child: Card(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: name_room == roomname
                                              ? Colors.blue.shade100
                                              : Colors.transparent,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 1,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Center(child: Text(roomname)),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              border: Border.all(color: Colors.black, width: 1),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            'ห้อง',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 8,
                                          child: Text(
                                            name_room == null
                                                ? 'เลือกห้องส่งล้าง'
                                                : '$name_room',
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(),
                                Expanded(
                                  flex: 4,
                                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                    stream: FirebaseFirestore.instance
                                        .collection("photo_cssd")
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      final today = DateFormat(
                                        'yyyy-MM-dd',
                                      ).format(DateTime.now());
                                      var data_photo = snapshot.data!.docs.where((
                                        e,
                                      ) {
                                        final createdAt = e["created_at"];
                                        if (createdAt is Timestamp) {
                                          final dateStr = DateFormat(
                                            'yyyy-MM-dd',
                                          ).format(createdAt.toDate());
                                          return dateStr == today
                                              ? e.data()["room_id"] == room_id
                                              : false;
                                        } else if (createdAt is Map &&
                                            createdAt["seconds"] != null) {
                                          final seconds = createdAt["seconds"];
                                          final date =
                                              DateTime.fromMillisecondsSinceEpoch(
                                                seconds * 1000,
                                              );
                                          final dateStr = DateFormat(
                                            'yyyy-MM-dd',
                                          ).format(date);
                                          return dateStr == today
                                              ? e.data()["room_id"] == room_id
                                              : false;
                                        }
                                        return false;

                                        // return e.data()["room_id"] == room_id;
                                      }).toList();

                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 6,
                                                  child: Text(
                                                    'รูปภาพ',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: IconButton(
                                                    onPressed: () {
                                                      if (room_id != null) {
                                                        uploadFile_photo_camera().then((
                                                          _,
                                                        ) async {
                                                          final now =
                                                              DateTime.now();

                                                          final doc_bill =
                                                              now.millisecondsSinceEpoch ~/
                                                              1000;

                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                'photo_cssd',
                                                              )
                                                              .doc("$doc_bill")
                                                              .set(
                                                                {
                                                                  'room_id':
                                                                      room_id,
                                                                  'room_photo':
                                                                      base64_Slip
                                                                          .toString(),
                                                                  'created_at':
                                                                      FieldValue.serverTimestamp(),
                                                                },
                                                                SetOptions(
                                                                  merge: true,
                                                                ),
                                                              )
                                                              .then((e) {
                                                                setState(() {
                                                                  base64_Slip =
                                                                      null;
                                                                });
                                                              });
                                                        });
                                                      } else {
                                                        PanaraInfoDialog.showAnimatedFade(
                                                          context,
                                                          message:
                                                              "กรุณาเลือกห้องล้างก่อนเพิ่มรูปภาพ",
                                                          buttonText: "รับทราบ",
                                                          onTapDismiss: () {
                                                            // _PasswordController.clear();
                                                            Navigator.of(
                                                              context,
                                                              rootNavigator:
                                                                  true,
                                                            ).pop();
                                                          },
                                                          panaraDialogType:
                                                              PanaraDialogType
                                                                  .error,
                                                        );
                                                      }
                                                    },
                                                    icon: Icon(
                                                      Icons.camera_alt_outlined,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: IconButton(
                                                    onPressed: () {
                                                      if (room_id != null) {
                                                        uploadFile_photo_gallery().then((
                                                          _,
                                                        ) async {
                                                          final now =
                                                              DateTime.now();

                                                          final doc_bill =
                                                              now.millisecondsSinceEpoch ~/
                                                              1000;

                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                'photo_cssd',
                                                              )
                                                              .doc("$doc_bill")
                                                              .set(
                                                                {
                                                                  'room_id':
                                                                      room_id,
                                                                  'room_photo':
                                                                      base64_Slip
                                                                          .toString(),
                                                                  'created_at':
                                                                      FieldValue.serverTimestamp(),
                                                                },
                                                                SetOptions(
                                                                  merge: true,
                                                                ),
                                                              )
                                                              .then((e) {
                                                                setState(() {
                                                                  base64_Slip =
                                                                      null;
                                                                });
                                                              });
                                                        });
                                                      } else {
                                                        PanaraInfoDialog.showAnimatedFade(
                                                          context,
                                                          message:
                                                              "กรุณาเลือกห้องล้างก่อนเพิ่มรูปภาพ",
                                                          buttonText: "รับทราบ",
                                                          onTapDismiss: () {
                                                            // _PasswordController.clear();
                                                            Navigator.of(
                                                              context,
                                                              rootNavigator:
                                                                  true,
                                                            ).pop();
                                                          },
                                                          panaraDialogType:
                                                              PanaraDialogType
                                                                  .error,
                                                        );
                                                      }
                                                    },
                                                    icon: Icon(
                                                      Icons.photo_outlined,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Expanded(
                                              flex: 8,
                                              child: GridView.builder(
                                                scrollDirection: Axis.vertical,
                                                itemCount: data_photo.length,
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount:
                                                          MediaQuery.of(
                                                                context,
                                                              ).size.width <
                                                              600
                                                          ? 3
                                                          : 8,
                                                      crossAxisSpacing: 2,
                                                      mainAxisSpacing: 2,
                                                    ),
                                                itemBuilder: (context, index) {
                                                  final data = data_photo[index]
                                                      .data();
                                                  final toolsroom_photo =
                                                      data["room_photo"]
                                                          ?.toString() ??
                                                      "-";
                                                  return GestureDetector(
                                                    onTap: () {
                                                      final url = _byteString(
                                                        toolsroom_photo
                                                            .toString(),
                                                      );
                                                      Navigator.of(
                                                        context,
                                                      ).push(
                                                        MaterialPageRoute(
                                                          builder: (_) =>
                                                              FullscreenImageViewer(
                                                                url: url,
                                                                id: data_photo[index]
                                                                    .id,
                                                              ),
                                                        ),
                                                      );
                                                    },
                                                    child: Card(
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              12,
                                                            ),
                                                        child: Container(
                                                          child: Image.memory(
                                                            _byteString(
                                                              toolsroom_photo
                                                                  .toString(),
                                                            ),
                                                            fit: BoxFit.fill,
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
                                      );
                                    },
                                  ),
                                ),
                                Divider(),
                                Expanded(
                                  flex: 6,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                'รายการรับของ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                'จำนวน',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(),
                                Expanded(
                                  flex: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Row(
                                            children: [
                                              Text(
                                                'อุปรกณ์',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 8,
                                          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                            stream: FirebaseFirestore.instance
                                                .collection("tools_cssd")
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              var data_tools =
                                                  snapshot.data!.docs;

                                              return GridView.builder(
                                                scrollDirection: Axis.vertical,
                                                itemCount: data_tools.length,
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount:
                                                          MediaQuery.of(
                                                                context,
                                                              ).size.width <
                                                              600
                                                          ? 3
                                                          : 8,
                                                      crossAxisSpacing: 2,
                                                      mainAxisSpacing: 2,
                                                    ),
                                                itemBuilder: (context, index) {
                                                  final data = data_tools[index]
                                                      .data();
                                                  final toolsname =
                                                      data["tools_name"]
                                                          ?.toString() ??
                                                      "-";
                                                  return GestureDetector(
                                                    child: Card(
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: const BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                  10,
                                                                ),
                                                            topRight:
                                                                Radius.circular(
                                                                  10,
                                                                ),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                  10,
                                                                ),
                                                            bottomRight:
                                                                Radius.circular(
                                                                  10,
                                                                ),
                                                          ),
                                                          border: Border.all(
                                                            color: Colors.black,
                                                            width: 1,
                                                          ),
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
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Uint8List _byteString(String byteString) {
    List<int> byteList = byteString
        .replaceAll('[', '')
        .replaceAll(']', '')
        .split(',')
        .map((e) => int.parse(e.trim()))
        .toList();
    Uint8List imageBytes = Uint8List.fromList(byteList);
    return imageBytes;
  }

  Future<void> uploadFile_photo_gallery() async {
    // ignore: deprecated_member_use
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 60, // ลดคุณภาพ = เร็วขึ้น
      maxWidth: 1024, // ลดความละเอียด
      maxHeight: 1448,
    );

    if (pickedFile == null) {
      // print('User canceled image selection');
      return;
    } else {
      PanaraCustomDialog.show(
        context,
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        children: [Text('LOADING...', style: TextStyle(color: Colors.white))],
      );
      var imageBytes = await pickedFile.readAsBytes();

      // 3. Encode the image as a base64 string
      // final base64Image = base64Encode(imageBytes);

      setState(() {
        base64_Slip = imageBytes;
        Navigator.of(context, rootNavigator: true).pop();
      });
    }
  }

  Future<void> uploadFile_photo_camera() async {
    // ignore: deprecated_member_use
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 60, // ลดคุณภาพ = เร็วขึ้น
      maxWidth: 1024, // ลดความละเอียด
      maxHeight: 1448,
    );

    if (pickedFile == null) {
      // print('User canceled image selection');
      return;
    } else {
      PanaraCustomDialog.show(
        context,
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        children: [Text('LOADING...', style: TextStyle(color: Colors.white))],
      );
      var imageBytes = await pickedFile.readAsBytes();

      // 3. Encode the image as a base64 string
      // final base64Image = base64Encode(imageBytes);
      setState(() {
        base64_Slip = imageBytes;
        Navigator.of(context, rootNavigator: true).pop();
      });
    }
  }
}
