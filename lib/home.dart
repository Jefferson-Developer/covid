import 'package:atividade_elder9/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:convert' as convert;
class HomeSreem extends StatefulWidget {
  @override
  _HomeSreemState createState() => _HomeSreemState();
}

const request = "https://api.hgbrasil.com/finance?format=json&key=60df7606";
Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class _HomeSreemState extends State<HomeSreem> {
  ContactHelper helper = ContactHelper();

  @override
  void initState() {
    super.initState();

    helper.dasds().then((value){

    });
    // Contact c = Contact();
    // c.uid = 0;
    // c.cases = 11;
    // c.datetime = "4324";
    // c.deaths = 999;
    // c.refuses = 4234;
    // c.state = "dsa";
    // c.suspects = 12321;
    // c.uf = "pb";

    helper.getAllContacts().then((value){
      print(value);


    });






  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
