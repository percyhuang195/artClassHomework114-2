import 'dart:io';

import 'package:app/previewImage.dart';
import 'package:flutter/material.dart';

import 'dataClass.dart';

class designRecords extends StatefulWidget {
  const designRecords({super.key});

  @override
  State<designRecords> createState() => _designRecordsState();
}

class _designRecordsState extends State<designRecords> {

  List<File> fileList = [];

  Future<List<File>> loadHistoryImages() async {
    final exportDir = await getExportDirectory();

    final files = exportDir
        .listSync()
        .whereType<File>()
        .where((file) => file.path.endsWith('.png'))
        .toList().reversed.toList();

    return files;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("圖片編輯紀錄"),
      ),
      body: Column(
        children: [
          Expanded(
            child:
              FutureBuilder(future: loadHistoryImages(), builder: (context,snapshot){
                if (!snapshot.hasData){
                  return const CircularProgressIndicator();
                }
                final files = snapshot.data!;
                return GridView.builder(
                  itemCount: files.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                    itemBuilder: (context,index){
                      return Padding(
                        padding: EdgeInsets.all(4),
                        child:Image.file(
                          files[index],
                          fit: BoxFit.cover,
                        ),
                      );
                });
              })
          ),
        ],
      ),
    );
  }
}
