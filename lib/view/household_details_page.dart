import 'package:flutter/material.dart';
import 'package:uhc_geoteagging/model/household.dart';

class Householddetails extends StatefulWidget {
  final Household? household;
  // const Householddetails({super.key});
  const Householddetails({super.key, this.household});

  @override
  State<Householddetails> createState() => _HouseholddetailsState();
}

class _HouseholddetailsState extends State<Householddetails> {
  Icon icon = Icon(
    Icons.location_off,
    color: Colors.red,
  );
  void initState() {
    super.initState();
    debugPrint(widget.household!.longitude);
  }

  checkLong() async {
    if (widget.household!.longitude != null) {
      icon = Icon(
        Icons.location_on,
        color: Colors.blue,
      );
    }
  }

  checkLat() {
    if (widget.household?.longitude == null) {
      return '';
    }
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
            title: Text(widget.household?.longitude ?? 'Not Available'),
            leading: icon,
          ),
        ]),
      ),
    );
  }
}
