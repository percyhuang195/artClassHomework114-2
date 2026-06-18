import 'package:flutter/material.dart';

class previewImage extends StatefulWidget {
  int imageId = 0;

  previewImage({super.key, required this.imageId});

  @override
  State<previewImage> createState() => _previewImageState(imageId: imageId);
}

class _previewImageState extends State<previewImage> {
  int imageId = 0;

  _previewImageState({required this.imageId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("圖片預覽"),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Color.fromRGBO(238, 238, 238, 1),
          child: Column(
            children: [
              Row(),
              Spacer(),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.width * 0.8,
                color: Colors.white,
              ),
              Spacer(),
              Spacer(),
            ],
          ),
        ));
  }
}
