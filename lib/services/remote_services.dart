import 'package:uhc_geoteagging/model/household.dart';
import 'package:http/http.dart' as http;

class RemoteServices {
  Future<List<Household>?> getHouseholds() async {
    var client = http.Client();
    var uri = Uri.parse(
        'http://uhcsocot20222-001-site1.dtempurl.com/api/GetHouseHolds');
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var json = response.body;
      return householdFromJson(json);
    }
  }
}
