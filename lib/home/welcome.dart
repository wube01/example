import 'package:example/common/header.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<StatefulWidget> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
bool _loading = false;
Position? _location;

  @override
  void initState() {
    super.initState();
    _loading = true;
    _getLocation().then((position) {
      _location = position;
      debugPrint(position.toString());
      _load(position.latitude.toString(), position.longitude.toString());
      _loading = false;
    });
  }

  void _load(String lat, String lon) async {
    await http
        .get(
          Uri.https('api.met.no', 'weatherapi/locationforecast/2.0/compact', {
            'lat': lat,
            'lon': lon,
          }),
          headers: {'User-Agent': 'MyApp/1.0 (ylari.ainjarv@gmail.com)'},
        )
        .then((response) {
          debugPrint(response.body);
        });
  }

  Future<Position> _getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location not available');
    }
    return await GeolocatorPlatform.instance.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: 'Avaleht'),
      body: Center(
        child: Image.asset('assets/ylari.jpeg', width: 90, height: 90),
      ),
    );
  }
}
