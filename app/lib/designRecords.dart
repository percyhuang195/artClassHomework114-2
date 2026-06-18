import 'package:app/previewImage.dart';
import 'package:flutter/material.dart';

class designRecords extends StatefulWidget {
  const designRecords({super.key});

  @override
  State<designRecords> createState() => _designRecordsState();
}

class _designRecordsState extends State<designRecords> {
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
            child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context,index){
                  return SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.width * 0.33,
                      child: ListView.builder(
                          itemCount: 3,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context,index){
                            return Container(
                              width: MediaQuery.of(context).size.width * 0.33,
                              height: MediaQuery.of(context).size.width * 0.33,
                              color: Colors.white,
                              child:Center(
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>previewImage(imageId: 0,)));
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.28,
                                    height: MediaQuery.of(context).size.width * 0.28,
                                    color: Color.fromRGBO(217, 217, 217, 1),
                                  ),
                                ),
                              )
                            );
                          }),
                    );
                }),
          ),
        ],
      ),
    );
  }
}
