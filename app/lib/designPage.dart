import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dataClass.dart';

class designPage extends StatefulWidget {
  List<File> images = [];

  designPage({super.key, required this.images});

  @override
  State<designPage> createState() => _designPageState(images: images);
}

class _designPageState extends State<designPage> {
  List<File> images = [];
  _designPageState({required this.images});

  final GlobalKey repaintKey = GlobalKey();
  var inputController = TextEditingController();

  List<IconData> functionList = [
    Icons.arrow_upward,
    Icons.edit,
    Icons.text_fields,
    Icons.shape_line,
    Icons.grid_3x3
  ];

  List<Color> colorList = [
    Colors.white,
    Colors.red,
    Colors.yellow,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.black
  ];

  List<IconData> shapeList = [
    Icons.rectangle,
    Icons.circle,
    Icons.play_arrow,
  ];

  int selectedFunction = 0;
  int selectedColor = 0;
  int selectedShape = 0;
  List<imageObject> objectList = [];
  List<textObject> textList = [];
  int index = 0;
  List<paintPoint> points = [];
  var selection = ["image","text"];
  var lastSelect = Map();

  @override
  void initState() {
    super.initState();
    for (int x = 0; x < images.length; x++) {
      objectList.add(imageObject(
          x: 100 * (x % 3).toDouble(),
          y: 100 * (x / 3).toInt().toDouble(),
          width: 100,
          height: 100,
          objectType: 0,
          sourceIndex: x));
    }
    setState(() {});
  }

  Future<Uint8List> exportCanvasImage() async {
    final boundary =
    repaintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    final image = await boundary.toImage(pixelRatio: 3.0);
    final byteData = await image.toByteData(format: ImageByteFormat.png);

    return byteData!.buffer.asUint8List();
  }

  Future<void> saveAndShare() async {
    final bytes = await exportCanvasImage();
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/canvas.png');
    await file.writeAsBytes(bytes);

    await Share.shareXFiles([XFile(file.path)]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Text("設計"),
              Spacer(),
              IconButton(onPressed: () {
                saveAndShare();
              }, icon: Icon(Icons.save))
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              width: 10,
              height: 10,
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color.fromRGBO(217, 217, 217, 1),
                ),
                clipBehavior: Clip.antiAlias,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 60,
                  child: ListView.builder(
                      itemCount: functionList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Container(
                              width: 5,
                              height: 5,
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 5,
                                  height: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    selectedFunction = index;
                                    setState(() {});
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: selectedFunction == index
                                          ? Color.fromRGBO(153, 153, 153, 1)
                                          : Colors.white,
                                    ),
                                    child: Icon(
                                      functionList[index],
                                      color: selectedFunction == index
                                          ? Colors.white
                                          : Color.fromRGBO(153, 153, 153, 1),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 5,
                                  height: 5,
                                ),
                              ],
                            ),
                            Container(
                              width: 5,
                              height: 5,
                            ),
                          ],
                        );
                      }),
                )),
            Container(
              width: 10,
              height: 10,
            ),
            Visibility(
              visible: selectedFunction == 0,
              child: Column(
                children: [
                  Container(
                    width: 50,
                    height: 20,
                  ),
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: IconButton(onPressed: (){
                      if (lastSelect["type"] == 0){
                        objectList.removeAt(lastSelect["index"]);
                      }else if (lastSelect["type"] == 1) {
                        textList.removeAt(lastSelect["index"]);
                      }
                      setState(() {});
                    }, icon: Icon(Icons.delete)),
                  ),
                ],
              )
            ),
            Visibility(
              visible: selectedFunction != 0 && selectedFunction != 4,
              child: Column(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color.fromRGBO(217, 217, 217, 1),
                      ),
                      child: Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 40,
                          child: ListView.builder(
                              itemCount: colorList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Container(
                                      width: 5,
                                      height: 5,
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          width: 5,
                                          height: 5,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            selectedColor = index;
                                            setState(() {});
                                          },
                                          child: Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(15),
                                                color: colorList[index],
                                              ),
                                              child: Visibility(
                                                  visible: selectedColor == index,
                                                  child: Icon(Icons.check))),
                                        ),
                                        Container(
                                          width: 5,
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: 5,
                                      height: 5,
                                    ),
                                  ],
                                );
                              }),
                        ),
                      )),
                  Container(
                    width: 50,
                    height: 10,
                  ),
                ],
              ),
            ),
            Visibility(
              visible: selectedFunction == 2,
              child: Column(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color.fromRGBO(217, 217, 217, 1),
                      ),
                      child: Center(
                        child:
                          Row(
                            children: [
                              Container(
                                width: 15,
                                height: 5,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.65,
                                height: 25,
                                child:TextField(
                                  controller: inputController,
                                  style: TextStyle(
                                      fontSize: 20
                                  ),
                                ),
                              ),
                              IconButton(onPressed: (){
                                textList.add(textObject(position: Offset(0, 0), color: colorList[selectedColor], text: inputController.text));
                                setState(() {});
                              }, icon: Icon(Icons.add)),
                            ],
                          ),
                      )),
                  Container(
                    width: 5,
                    height: 5,
                  ),
                ],
              ),
            ),
            Visibility(
              visible: selectedFunction == 3,
              child: Column(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color.fromRGBO(217, 217, 217, 1),
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 40,
                              child: ListView.builder(
                                  itemCount: shapeList.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        Container(
                                          width: 5,
                                          height: 5,
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              width: 5,
                                              height: 5,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                selectedShape = index;
                                                setState(() {});
                                              },
                                              child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(15),
                                                    color: selectedShape == index ? Colors.grey : Colors.white,
                                                  ),
                                                  child: Icon(
                                                    shapeList[index],
                                                    color: selectedShape == index ? Colors.white : Colors.grey,
                                                  ),
                                              ),
                                            ),
                                            Container(
                                              width: 5,
                                              height: 5,
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: 5,
                                          height: 5,
                                        ),
                                      ],
                                    );
                                  }),
                            ),
                            Spacer(),
                            IconButton(onPressed: (){
                              objectList.add(
                                imageObject(
                                  x: 0,
                                  y: 0,
                                  objectType:selectedShape + 1,
                                  color: colorList[selectedColor],
                                )
                              );
                              setState(() {});
                            }, icon: Icon(Icons.add)),
                          ],
                        ),
                      )),
                  Container(
                    width: 5,
                    height: 5,
                  ),
                ],
              ),
            ),
            Container(
              width: 50,
              height: 15,
            ),
            Center(
              child: RepaintBoundary(
                key: repaintKey,
                child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.width,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Stack(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.width,
                        child: GestureDetector(
                          onPanUpdate: (details) {
                            setState(() {
                              if (selectedFunction == 1) {
                                points.add(paintPoint(
                                    position: details.localPosition,
                                    color: colorList[selectedColor],
                                    stop: false));
                              }
                            });
                          },
                          onPanEnd: (details) {
                            points.add(paintPoint(
                                position: details.localPosition,
                                color: colorList[selectedColor],
                                stop: true));
                          },
                          child: CustomPaint(
                            painter: DrawPainter(points),
                            size: Size.infinite,
                          ),
                        ),
                      ),
                      ...objectList.map((object) {
                        if (object.objectType == 0){
                          return Positioned(
                            left: object.x,
                            top: object.y,
                            child: GestureDetector(
                              onScaleUpdate: (details) {
                                setState(() {
                                  lastSelect["type"] = 0;
                                  lastSelect["index"] = objectList.indexOf(object);
                                  if (selectedFunction == 0) {
                                    object.x += details.focalPointDelta.dx;
                                    object.y += details.focalPointDelta.dy;
                                    if (details.scale != 1.0) {
                                      if (details.scale >= object.scale) {
                                        object.scale = details.scale;
                                      } else if (details.scale <= object.scale) {
                                        object.scale = details.scale;
                                      }
                                    }
                                    if (details.rotation != 0.0) {
                                      object.rotation = details.rotation;
                                    }
                                  }else {
                                    selectedFunction = 0;
                                  }
                                });
                              },
                              onTap: () {
                                setState(() {
                                  objectList.remove(object);
                                  objectList.add(object);
                                });
                              },
                              onDoubleTap: () {
                                object.rotation = 0.0;
                                setState(() {});
                              },
                              child: Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()
                                  ..scale(object.scale)
                                  ..rotateZ(object.rotation),
                                child: SizedBox(
                                  width: object.width * object.scale,
                                  height: object.height * object.scale,
                                  child: Image.file(
                                    images[object.sourceIndex],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }else if(object.objectType == 1 || object.objectType == 2) {
                          return Positioned(
                            left: object.x,
                            top: object.y,
                            child: GestureDetector(
                              onScaleUpdate: (details) {
                                setState(() {
                                  lastSelect["type"] = 0;
                                  lastSelect["index"] = objectList.indexOf(object);
                                  if (selectedFunction == 0) {
                                    object.x += details.focalPointDelta.dx;
                                    object.y += details.focalPointDelta.dy;
                                    if (details.scale != 1.0) {
                                      if (details.scale >= object.scale) {
                                        object.scale = details.scale;
                                      } else if (details.scale <= object.scale) {
                                        object.scale = details.scale;
                                      }
                                    }
                                    if (details.rotation != 0.0) {
                                      object.rotation = details.rotation;
                                    }
                                  }else {
                                    selectedFunction = 0;
                                  }
                                });
                              },
                              onTap: () {
                                setState(() {
                                  objectList.remove(object);
                                  objectList.add(object);
                                });
                              },
                              onDoubleTap: () {
                                object.rotation = 0.0;
                                setState(() {});
                              },
                              child: Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()
                                  ..scale(object.scale)
                                  ..rotateZ(object.rotation),
                                child: SizedBox(
                                  width: object.width * object.scale,
                                  height: object.height * object.scale,
                                  child:Container(
                                    decoration: BoxDecoration(
                                      color: object.color,
                                      shape: object.objectType == 2 ? BoxShape.circle : BoxShape.rectangle,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }else {
                          return Container();
                        }
                      }),
                      ...textList.map((text) {
                        return Positioned(
                          left: text.position.dx,
                          top: text.position.dy,
                          child: GestureDetector(
                            onScaleUpdate: (details) {
                              setState(() {
                                lastSelect["type"] = 1;
                                lastSelect["index"] = textList.indexOf(text);
                                if (selectedFunction == 0) {
                                  text.position += details.focalPointDelta;
                                  if (details.scale != 1.0) {
                                    if (details.scale >= text.scale) {
                                      text.scale = details.scale;
                                    } else if (details.scale <= text.scale) {
                                      text.scale = details.scale;
                                    }
                                  }
                                  if (details.rotation != 0.0) {
                                    text.rotation = details.rotation;
                                  }
                                }else {
                                  selectedFunction = 0;
                                }
                              });
                            },
                            onTap: () {
                              setState(() {
                                textList.remove(text);
                                textList.add(text);
                              });
                            },
                            onDoubleTap: () {
                              text.rotation = 0.0;
                              setState(() {});
                            },
                            child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..scale(text.scale)
                                ..rotateZ(text.rotation),
                              child: SizedBox(
                                child: Text(text.text,style: TextStyle(
                                  fontSize: 20 * text.scale,
                                  color: text.color
                                ),)
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
