import 'package:flutter/material.dart';
import 'package:uhc_geoteagging/model/household.dart';
import 'package:uhc_geoteagging/services/remote_services.dart';
import 'package:uhc_geoteagging/view/household_details_page.dart';

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

  Widget checkLoc(var loc) {
    if (loc == null) {
      return const Icon(Icons.check_circle_outlined);
    } else {
      return const Icon(Icons.check_circle);
    }
    // return const Icon(Icons.task_alt);
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
              return Card(
                child: ListTile(
                  leading: checkLoc(households?[index].longitude),
                  title: Text(households![index].residenceName.toString()),
                  subtitle: Text(households![index].address.toString()),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Householddetails(
                                  household: households![index],
                                ))).then((_) {
                      // This block runs when you have returned back to the 1st Page from 2nd.
                      setState(() {
                        // Call setState to refresh the page.
                        getHousehold();
                      });
                    });
                  },
                ),
              );
            }),
      ),
    );
  }
}
