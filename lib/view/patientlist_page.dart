import 'package:flutter/material.dart';
import 'package:uhc_geoteagging/model/household.dart';
import 'package:uhc_geoteagging/services/remote_services.dart';

class PatientList extends StatefulWidget {
  const PatientList({super.key});

  @override
  State<PatientList> createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  List<Household>? households;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getHousehold();
  }

  getHousehold() async {
    households = await RemoteServices().getHouseholds();
    if (households != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Households'),
      ),
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.builder(
            itemCount: households?.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(households![index].headofFamily.toString()),
                subtitle: Text(households![index].address.toString()),
                trailing: const Icon(Icons.arrow_downward),
              );
            }),
      ),
    );
  }
}
