import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

class FullscreenImageViewer extends StatelessWidget {
  const FullscreenImageViewer({super.key, required this.url, required this.id});
  final Uint8List url;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          TextButton.icon(
            onPressed: () async {
              PanaraConfirmDialog.showAnimatedGrow(
                context,
                title: "ลบรูปภาพ",
                message: "( ต้องการลบ ใช่ หรือ ไม่ )",
                confirmButtonText: "Confirm",
                cancelButtonText: "Cancel",
                onTapCancel: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                onTapConfirm: () async {
                  // print('${data_table[index]["tablename"]}');
                  // print('Document ID: ${data_table[index].id}');
                  await FirebaseFirestore.instance
                      .collection('photo_cssd')
                      .doc(id)
                      .delete();
                  Navigator.of(
                    context,
                    rootNavigator: true,
                  ).pop(); // ปิด dialog
                  Navigator.of(context).maybePop(); // ปิดหน้า fullscreen
                },
                panaraDialogType: PanaraDialogType.warning,
              );
            },
            icon: Icon(Icons.remove_circle_outline, color: Colors.white),
            label: Text(
              'ลบรูปภาพ',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Center(
        child: Hero(
          tag: url,
          child: InteractiveViewer(
            panEnabled: true,
            minScale: 1,
            maxScale: 8,
            clipBehavior: Clip.none,
            child: Image.memory(
              url,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const Text(
                'โหลดรูปไม่ได้',
                style: TextStyle(color: Colors.white),
              ),
            ),
            // Image.network(
            //   url,
            //   fit: BoxFit.contain,
            //   errorBuilder: (_, __, ___) => const Text(
            //     'โหลดรูปไม่ได้',
            //     style: TextStyle(color: Colors.white),
            //   ),
            // ),
          ),
        ),
      ),
    );
  }
}
