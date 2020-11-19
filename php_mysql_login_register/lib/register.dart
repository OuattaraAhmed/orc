import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'DashBoard.dart';
import 'main.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
  
}

class _RegisterState extends State<Register> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  Future register() async {
    var url = "http://192.168.43.82/image_upload_php_mysql/register.php";
    var response = await http.post(url, body: {
      "email": email.text,
      "password": pass.text,
    });
    var data = json.decode(response.body);
    if (data == "Error") {
      FlutterToast(context).showToast(
          child: Text(
        'Oups cet email existe déjà !',
        style: TextStyle(
            fontSize: 25, color: Colors.red, fontWeight: FontWeight.bold),
      ));
    } else {
      FlutterToast(context).showToast(
          child: Text('Inscription reussie',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.green,
                  fontWeight: FontWeight.bold)));
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DashBoard(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Page d'insciption",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      
      body: Container(
        height: 700,
        child: Card(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'INSCRIVEZ-VOUS',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(
                  height: 150.0,
                  child: Image.asset("assets/imagesAddUser.png", fit: BoxFit.contain)),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
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
                child: TextField(
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
                height: 40.0,
              ),

              Row(
                children: <Widget>[
                  Expanded(
                    child: MaterialButton(
                      color: Colors.blue,
                      child: Text("S'inscrire",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      onPressed: () {
                        register();
                      },
                    ),
                  ),
                  Expanded(
                    child: MaterialButton(
                      color: Colors.green,
                      child: Text('Connexion',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyHomePage(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
