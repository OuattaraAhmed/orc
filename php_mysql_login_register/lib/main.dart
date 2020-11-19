import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:php_mysql_login_register/register.dart';
import 'package:http/http.dart' as http;

import 'DashBoard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  String md5pass;

  Future login() async {
    var url = "http://192.168.43.82/image_upload_php_mysql/login.php";
    var response = await http.post(url, body: {
      //pass.text convert to md5
      //md5pass=resultat
      "email": email.text,
      "password": pass.text,
    });
    var data = json.decode(response.body);
    if (data == "Success") {
      FlutterToast(context).showToast(
          child: Text(
        'Connexion reussie',
        style: TextStyle(
            fontSize: 25, color: Colors.green, fontWeight: FontWeight.bold),
      ));
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DashBoard(),
        ),
      );
    } else {
      FlutterToast(context).showToast(
          child: Text('Email ou mot de passe incorrect',
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.red,
                  fontWeight: FontWeight.bold)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Page Connexion',
          textScaleFactor: 1.5,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        height: 500,
        child: Card(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Connectez-vous',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ),
              SizedBox(
                  height: 100.0,
                  child: Image.asset("assets/imagesUser.png",
                      fit: BoxFit.contain)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'email',
                    prefixIcon: Icon(Icons.alternate_email),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  controller: email,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Mot de Passe',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  controller: pass,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: MaterialButton(
                  color: Colors.green,
                  child: Text('Connexion',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  onPressed: () {
                    login();
                  },
                ),
              ),
              SizedBox(
                height: 70.0,
              ),
              Expanded(
                child: MaterialButton(
                  color: Colors.blue,
                  child: Text("S'inscrire",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Register(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
