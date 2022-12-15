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

  // showHouseholdDetails(BuildContext contexxt, Household myHousehold) async {
  //   var hh = myHousehold;
  //   Navigator.push(
  //       contexxt,
  //       MaterialPageRoute(
  //           builder: (context) => Householddetails(hh),
  //           settings: RouteSettings(arguments: myHousehold)));
  // }

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
                  leading: const Icon(Icons.task_alt),
                  title: Text(households![index].residenceName.toString()),
                  subtitle: Text(households![index].address.toString()),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Householddetails(
                                  household: households![index],
                                )));
                  },
                ),
              );
            }),
      ),
    );
  }
}
