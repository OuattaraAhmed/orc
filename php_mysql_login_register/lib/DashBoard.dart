import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:php_mysql_login_register/AllPersonData.dart';

class DashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DemoUploadImage(),
    );
  }
}

class DemoUploadImage extends StatefulWidget {
  @override
  _DemoUploadImageState createState() => _DemoUploadImageState();
}

class _DemoUploadImageState extends State<DemoUploadImage> {
  File _image;
  final picker = ImagePicker();
  String content; 
  TextEditingController nameController = TextEditingController();

  Future choiceImage() async {
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage.path);
    });
  }

  Future choiceCamera() async {
    var pickedImage = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(pickedImage.path);
    });
  }

  Future uploadImage() async {
    //fonction get text from image
    //content = resultat

    final uri =
        Uri.parse("http://192.168.43.82/image_upload_php_mysql/upload.php");
    var request = http.MultipartRequest('POST', uri);
    request.fields['name'] = nameController.text;
    request.fields['content']= content;
    var pic = await http.MultipartFile.fromPath("image", _image.path);
    request.files.add(pic);
    var response = await request.send();

    if (response.statusCode == 200) {
      print('Image Téléchargée');
    } else {
      print('Image non Téléchargée');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OCR Application'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Nom de l'image"),
              ),
            ),
            IconButton(
              icon: Icon(Icons.photo),
              onPressed: () {
                choiceImage();
              },
            ),

            Container(
              child: _image == null
                  ? Text('Aucune image selectionnée')
                  : Image.file(_image),
            ),

            IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: () {
                choiceCamera();
              },
            ),

            SizedBox(
              height: 10,
            ),
            RaisedButton(
              child: Text('Télécharger une image'),
              onPressed: () {
                uploadImage();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllPersonData(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
