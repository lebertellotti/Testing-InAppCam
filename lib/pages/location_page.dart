import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
//import 'package:location/location.dart' as loc;
//import 'package:http/http.dart' as http;
//import 'dart:convert';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String? _currentAddress;
  Position? _currentPosition;
  double? _temperature;
  double? _carTemperature;
  Timer? _timer;
  double? _maxMinutes;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
      _getTemperature().then((temperature) {
        setState(() => _temperature = temperature);
        _calcCarTemp(_temperature!).then((carTemperature) {
          setState(() => _carTemperature = carTemperature);
          _maxMin(_temperature!).then((maxMinutes) {
            setState(() => _maxMinutes = maxMinutes);
          });
        });
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  double kelvinToFahrenheit(double kelvin) {
    final celsius = kelvin - 273.15;
    final fahrenheit = celsius * (9 / 5) + 32;
    return fahrenheit;
  }

  Future<double> _getTemperature() async {
    const String baseUrl = 'http://api.openweathermap.org/data/2.5/weather?';
    const String apiKey = 'cdbc823189558c9822cc1fb23c6d27f1';
    final String url = '$baseUrl'
        'lat=${_currentPosition!.latitude}&lon=${_currentPosition!.longitude}&appid=$apiKey';

    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);

    final tempKelvin = data['main']['temp'];
    final tempFahrenheit = kelvinToFahrenheit(tempKelvin);

    return tempFahrenheit;
  }

  // Get the Car Temperature:
  Future<double> _calcCarTemp(outsideTemp) async {
    const minutes = 1;
    final carTemp = outsideTemp + 2 * minutes;

    return carTemp;
  }

  // Get the max minutes until danger temp zone:
  Future<double> _maxMin(outTemp) async {
    const thres = 85;
    final maxMins = (thres - outTemp) / 2;

    return maxMins;
  }

  // Internal Clock:
  //final now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
          backgroundColor: Colors.grey[900],
          title: const Text("Location Page")),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('LAT: ${_currentPosition?.latitude ?? ""}'),
              Text('LNG: ${_currentPosition?.longitude ?? ""}'),
              Text('ADDRESS: ${_currentAddress ?? ""}'),
              Text(
                  'Temperature: ${_temperature != null ? "${_temperature?.toStringAsFixed(1)}F" : ""}'),
              Text(
                  'Car Temperature: ${_carTemperature != null ? "${_carTemperature?.toStringAsFixed(1)}F" : ""}'),
              Text(
                  'The max amount of minutes until DANGER ZONE: ${_maxMinutes != null ? "${_maxMinutes?.toStringAsFixed(2)}" : ""}'),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _getCurrentPosition,
                child: const Text("Get Current Location"),
              )
            ],
          ),
        ),
      ),
    );
  }
}



/*
// two button notification alert - adjust conditions, messages and button text
// if (tempFahrenheit >= 70) {
// showDialog(
// context: context,
// builder: (context) => AlertDialog(
// title: Text('Temperature Alert'),
// content: Text('The outside temperature is below or equal to 75°F.'),
// actions: [
// ElevatedButton(
// onPressed: () => Navigator.pop(context),
// child: Text('Dismiss'),
// ),
// ElevatedButton(
// onPressed: () => print('Call emergency'),
// child: Text('Call Emergency'),
// ),
// ],
// ),
// );
// } else if (tempFahrenheit < 0) {
// showDialog(
// context: context,
// builder: (context) => AlertDialog(
// title: Text('Temperature Alert'),
// content: Text('The outside temperature is below 0°F'),
// actions: [
// ElevatedButton(
// onPressed: () => Navigator.pop(context),
// child: Text('Dismiss'),
// ),
// ElevatedButton(
// onPressed: () => print('Call emergency'),
// child: Text('Call Emergency'),
// ),
// ],
// ),
// );
// } else {
// showDialog(
// context: context,
// builder: (context) => AlertDialog(
// title: Text('Temperature Alert'),
// content: Text('The outside temperature is safe.'),
// actions: [
// ElevatedButton(
// onPressed: () => Navigator.pop(context),
// child: Text('Dismiss'),
// ),
// ],
// ),
// );
// }

    // FEBA - added code, tested in my remote repo
    //if (tempFahrenheit >= 70) {
    //showDialog(
    //context: context,
    //builder: (context) => AlertDialog(
    //title: Text('Temperature Alert'),
    //content: Text('The outside temperature is below or equal to 75°F.'),
    //actions: [
    //TextButton(
    //onPressed: () => Navigator.pop(context),
    //child: Text('OK'),
    //),
    //],
    //),
    //);
    //} else if (tempFahrenheit < 0) {
    //showDialog(
    //context: context,
    //builder: (context) => AlertDialog(
    //title: Text('Temperature Alert'),
    //content: Text('The outside temperature is below 0°F'),
    //actions: [
    //TextButton(
    //onPressed: () => Navigator.pop(context),
    //child: Text('OK'),
    //),
    //],
    //),
    //);
    //} else {
    //showDialog(
    //context: context,
    //builder: (context) => AlertDialog(
    //title: Text('Temperature Alert'),
    //content: Text('The outside temperature is safe.'),
    //actions: [
    //TextButton(
    //onPressed: () => Navigator.pop(context),
    //child: Text('OK'),
    //),
    //],
    //),
    //);
    //}*/

//// OLD CODE BEFORE TESTING WARRENS LIVE SHARE 
/*import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'package:http/http.dart' as http;
//import 'dart:convert';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temp Check',
      home: LocationPage(),
    );
  }
}

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String? _currentAddress;
  Position? _currentPosition;
  double? _temperature;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
      _getTemperature().then((temperature) {
        setState(() => _temperature = temperature);
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  double kelvinToFahrenheit(double kelvin) {
    final celsius = kelvin - 273.15;
    final fahrenheit = celsius * (9 / 5) + 32;
    return fahrenheit;
  }

  Future<double> _getTemperature() async {
    const String baseUrl = 'http://api.openweathermap.org/data/2.5/weather?';
    const String apiKey = 'cdbc823189558c9822cc1fb23c6d27f1';
    final String url = '$baseUrl'
        'lat=${_currentPosition!.latitude}&lon=${_currentPosition!.longitude}&appid=$apiKey';

    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);

    final tempKelvin = data['main']['temp'];
    final tempFahrenheit = kelvinToFahrenheit(tempKelvin);

    // FEBA - added code, tested in my remote repo
    if (tempFahrenheit <= 75) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Temperature Alert'),
          content: Text('The outside temperature is below or equal to 75°F.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else if (tempFahrenheit < 0) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Temperature Alert'),
          content: Text('The outside temperature is below 0°F'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Temperature Alert'),
          content: Text('The outside temperature is safe.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }

    return tempFahrenheit;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
          backgroundColor: Colors.grey[900],
          title: const Text("Location Page")),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('LAT: ${_currentPosition?.latitude ?? ""}'),
              Text('LNG: ${_currentPosition?.longitude ?? ""}'),
              Text('ADDRESS: ${_currentAddress ?? ""}'),
              Text(
                  'Temperature: ${_temperature != null ? "${_temperature?.toStringAsFixed(1)}F" : ""}'),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _getCurrentPosition,
                child: const Text("Get Current Location"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
*/