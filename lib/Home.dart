import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _preco = "0";

  void _recuperarPreco() async{

    var url = Uri.parse("https://blockchain.info/ticker");
    http.Response response = await http.get(url);
    Map<String, dynamic> retorno = jsonDecode(response.body);
    print("Resultado: " + retorno["BRL"]["buy"].toString());

    setState(() {
      _preco = retorno["BRL"]["buy"].toString();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("image/bitcoin.png"),
              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 30),
                child: Container(
                  height: 100,
                  width: 200,
                  child: Card(
                    color: Colors.orangeAccent,
                    child: Center(
                      child: Text(
                        "R\$" + _preco,
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                  ),
                ),

              ),
              ElevatedButton(
                  onPressed: () {
                    _recuperarPreco();
                  },
                style: ElevatedButton.styleFrom(
                  primary: Colors.orangeAccent, // Background color
                ),
                  child: Text(
                    "Atualizar",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),

              )
            ],
          ),
        ),
      ),
    );
  }
}
