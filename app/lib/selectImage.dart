import 'dart:io';

import 'package:app/selectLayout.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'designPage.dart';
class selectImage extends StatefulWidget {
  const selectImage({super.key});

  @override
  State<selectImage> createState() => _selectImageState();
}

class _selectImageState extends State<selectImage> {

  List<File> selectedImages = [];

  @override
  void initState() {
    super.initState();
    uploadImage();
  }

  Future<void> uploadImage() async{
    final picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      File file = File(image.path);
      selectedImages.add(file);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Text("上傳圖片"),
            Spacer(),
            IconButton(onPressed: (){
              if (selectedImages.length < 9){
                uploadImage();
              }else {
                var message = SnackBar(content: Text("一次僅能上傳9張圖片"));
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(message);
              }
            }, icon: Icon(Icons.add))
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            width: 50,
            height: 50,
          ),SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.7,
            child:ListView.builder(
                itemCount: selectedImages.length % 3 == 0 ? (selectedImages.length / 3).toInt() : (selectedImages.length / 3).toInt() + 1,
                itemBuilder: (context,index1){
                  return Center(
                    child:SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.width * 0.3,
                      child:ListView.builder(
                          itemCount: selectedImages.length - index1 * 3,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context,index2){
                            return SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: MediaQuery.of(context).size.width * 0.3,
                              child: Image.file(selectedImages[index1 * 3 + index2], fit: BoxFit.contain),
                            );
                          }),
                    )
                  );
                }),
          ),

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
                  if (selectedImages.length != 0){
                    Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>selectLayout(images: selectedImages,)));
                  }else {
                    var message = SnackBar(content: Text("請按右上角的 + 按鈕選擇圖片"));
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(message);
                  }
                }, child: Text(
              "選擇版型",style:
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
    );
  }
}
