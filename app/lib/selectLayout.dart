import 'dart:convert';
import 'dart:io';

import 'package:app/dataClass.dart';
import 'package:app/designPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'designRecords.dart';
class selectLayout extends StatefulWidget {
  List<File> images = [];

  selectLayout({super.key, required this.images});

  @override
  State<selectLayout> createState() => _selectLayoutState(images: images);
}

class _selectLayoutState extends State<selectLayout> {
  List<File> images = [];
  _selectLayoutState({required this.images});


  List<finalLayoutObject> layoutList = [];
  var screenWidth = 0.0;
  var screenHeight = 0.0;

@override
  void initState() {
    super.initState();
    parseLayoutData();
    setState(() {});
  }

  Future<void> parseLayoutData() async {
    var jsonString = await rootBundle.loadString("assets/layouts.json");
    List<dynamic> tempLayout = jsonDecode(jsonString);
    for (int x = 0; x < tempLayout.length; x++){
      tempLayout[x]["positionList"] = tempLayout[x]["positionList"].map((item) => imageLayout.fromJson(item)).toList();
      print(tempLayout[x]["positionList"]);
      if (tempLayout[x]["positionList"].length == images.length){
        layoutList.add(finalLayoutObject.fromJson(tempLayout[x]));
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("選擇排版版型"),
      ),
      body: Column(
        children: [
          Row(),
          Expanded(
            child: ListView.builder(
                itemCount: layoutList.length + 1,
                itemBuilder: (context,index){
                  var id = 0;
                  if (index == layoutList.length){
                    return Center(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>designPage(images: images,layoutList: layoutList,selectedLayout: -1,)));
                        },
                        child: Container(
                          width: 300,
                          height: 300,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Text('沒有適合的版型?',
                                style: TextStyle(fontSize: 25),),
                              Text('請按此開始自訂',
                                style: TextStyle(fontSize: 25),)
                            ],
                          ),
                        ),
                      ),
                    );
                  }else {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>designPage(images: images,layoutList: layoutList,selectedLayout: index,)));
                          },
                          child: Container(
                            width: 300,
                            height: 300,
                            color: Colors.white,
                            child: Stack(
                              children: [
                                ...layoutList[index].positionList.map((image) {
                                  id += 1;
                                  return Positioned(
                                    top:image.top,
                                    left:image.left,
                                    child: Container(
                                      width: image.width,
                                      height: image.height,
                                      color: Colors.lightBlueAccent,
                                      child: Center(
                                        child: Text(id.toString(),
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.white
                                          ),),
                                      ),
                                    ),
                                  );
                                }
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
            }),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
