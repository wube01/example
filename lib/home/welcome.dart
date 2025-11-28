import 'package:example/common/header.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<StatefulWidget> createState() => _WelcomeState();
  
}

class _WelcomeState extends State<Welcome> {

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() async {
    await http.get(Uri.https('api.met.no',
    'weatherapi/locationforecast/2.0/compact?lat=59.42709985708767&lon=24.536038897750476'),
    headers: {
      'User-Agent': 'minu eriti vinge app',
      'Access-Control-Allow-Origin': 'true'
    }).then((response) {
      debugPrint(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: 'Avaleht'),
      body: Center(child: Image.asset('assets/ylari.jpeg', width: 90, height: 90,),),
    );
  }
  
}