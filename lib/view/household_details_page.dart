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

  void checkLat() async {
    debugPrint('asda');
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

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
      debugPrint('None');
    } else {
      debugPrint('error');
    }
    debugPrint('None');
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
            leading: Icon(
              Icons.man,
              color: Colors.green,
            ),
          ),
          ListTile(
            title: Text(widget.household!.address.toString()),
            leading: Icon(
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
              child: Text('Set Location'))
        ]),
      ),
    );
  }
}
