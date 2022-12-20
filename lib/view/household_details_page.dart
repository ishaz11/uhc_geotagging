import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:uhc_geoteagging/model/household.dart';
import 'package:geolocator/geolocator.dart';

class Householddetails extends StatefulWidget {
  final Household? household;
  // const Householddetails({super.key});
  const Householddetails({super.key, this.household});

  @override
  State<Householddetails> createState() => _HouseholddetailsState();
}

class _HouseholddetailsState extends State<Householddetails> {
  Icon icon = const Icon(
    Icons.location_off,
    color: Colors.red,
  );
  // void initState() {
  //   super.initState();
  //   debugPrint(widget.household!.longitude);
  // }

  checkLong() async {
    if (widget.household!.longitude != null) {
      icon = const Icon(
        Icons.location_on,
        color: Colors.blue,
      );
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    // return await Geolocator.getCurrentPosition();
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  void checkLat() async {
    Position position = await _determinePosition();
    // await Geolocator.checkPermission();
    // await Geolocator.requestPermission();

    // debugPrint(pos.toString());
    // Position position = await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.high);

    var uri = 'http://uhcsocot20222-001-site1.dtempurl.com/api/UpdateLocation';
    Response response = await post(Uri.parse(uri), body: {
      'Id': widget.household?.id.toString(),
      'Latitude': position.latitude.toString(),
      'Longitude': position.longitude.toString(),
    });
    if (response.statusCode == 200) {
      setState(() {
        widget.household?.latitude = position.latitude;
        widget.household?.longitude = position.longitude;
      });
      print(position.latitude);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.household!.residenceName.toString()),
      ),
      body: Card(
        elevation: 2,
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          ListTile(
            title: Text(widget.household!.headofFamily.toString()),
            leading: const Icon(
              Icons.man,
              color: Colors.green,
            ),
          ),
          ListTile(
            title: Text(widget.household!.address.toString()),
            leading: const Icon(
              Icons.house_rounded,
              color: Colors.blue,
            ),
          ),
          ListTile(
            title:
                Text(widget.household?.longitude.toString() ?? 'Not Available'),
            leading: icon,
          ),
          ElevatedButton(
              onPressed: () {
                checkLat();
              },
              child: const Text('Update Location'))
        ]),
      ),
    );
  }
}
