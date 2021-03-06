import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ydrs_desktop_app/common/app_strings.dart';
import 'package:ydrs_desktop_app/network/models/login/pin_generation_model.dart';

class PinGenerateResponse {
  // ignore: missing_return
  Future<PinGenerateModel> pinGeneratePostApiMethod(
      int memberId, String pin) async {
    var client = http.Client();
    String apiUrl = ApiUrlConstants.generatePin;

    final json = {
      "memberId": memberId,
      "pin": pin,
    };
    try {
      http.Response response = await client.post(
        Uri.parse(apiUrl),
        body: jsonEncode(json),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        print("Updated successful");
      }
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      print(response.body);

      return PinGenerateModel.fromJson(jsonResponse);
    } catch (e) {
      print("${e.toString()}");
    } finally {
      client.close();
    }
  }
}
