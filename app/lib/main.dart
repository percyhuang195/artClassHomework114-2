import 'dart:async';
import 'dart:io';

import 'package:app/designRecords.dart';
import 'package:app/previewImage.dart';
import 'package:app/selectImage.dart';
import 'package:flutter/material.dart';

import 'dataClass.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("相由心生"),
      ),
      body: Stack(
        children: [
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>selectImage()));
            },
            child:Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Color.fromRGBO(238, 238, 238, 1),
                child:Center(
                  child:Column(
                    children: [
                      Spacer(),
                      Icon(Icons.upload,size: 250,color: Color.fromRGBO(138, 138, 138, 1),),
                      Text("點擊畫面空白處",style: TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(138, 138, 138, 1),
                      ),),
                      Text("上傳檔案",style: TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(138, 138, 138, 1),
                      ),),
                      Text("開啟你的相片編輯之旅",style: TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(138, 138, 138, 1),
                      ),),
                      Spacer(),
                      Spacer(),
                      Container(
                        width: 20,
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 40,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:WidgetStatePropertyAll(Color.fromRGBO(251, 219, 149, 1)),
                            ),
                            onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>designRecords()));
                            }, child: Text(
                          "檢視其他紀錄",style:
                        TextStyle(
                            fontSize: 18,
                            color: Colors.black
                        ),
                        )
                        ),
                      ),
                      Container(
                        width: 20,
                        height: 20,
                      ),
                    ],
                  ),
                )
            ),
          ),
          // DraggableScrollableSheet(
          //     minChildSize: 0.4,
          //     maxChildSize: 0.9,
          //     initialChildSize: 0.4,
          //     builder: (context,controller){
          //     return Container(
          //       color: Colors.white,
          //       child: Column(
          //         children: [
          //           Container(
          //             width: 10,
          //             height: 10,
          //           ),
          //           Text("相片編輯紀錄"),
          //           Container(
          //             width: 10,
          //             height: 10,
          //           ),
          //           Expanded(
          //             child: ListView.builder(
          //                 itemCount: 3,
          //                 controller: controller,
          //                 itemBuilder: (context,index){
          //                   return SizedBox(
          //                     width: MediaQuery.of(context).size.width * 0.9,
          //                     height: MediaQuery.of(context).size.width * 0.33,
          //                     child: ListView.builder(
          //                         itemCount: 3,
          //                         scrollDirection: Axis.horizontal,
          //                         itemBuilder: (context,index){
          //                           return Container(
          //                               width: MediaQuery.of(context).size.width * 0.33,
          //                               height: MediaQuery.of(context).size.width * 0.33,
          //                               color: Colors.white,
          //                               child:Center(
          //                                 child: GestureDetector(
          //                                   onTap: (){
          //                                     Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>previewImage(imageId: 0,)));
          //                                   },
          //                                   child: Container(
          //                                     width: MediaQuery.of(context).size.width * 0.28,
          //                                     height: MediaQuery.of(context).size.width * 0.28,
          //                                     color: Color.fromRGBO(217, 217, 217, 1),
          //                                   ),
          //                                 ),
          //                               )
          //                           );
          //                         }),
          //                   );
          //                 }),
          //           ),
          //         ],
          //       ),
          //     );
          // })
        ],
      )
    );
  }
}
