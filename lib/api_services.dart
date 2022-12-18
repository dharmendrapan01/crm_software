// import 'dart:convert';
// import 'package:crm_software/callhistory_modal.dart';
// import 'package:http/http.dart' as http;
//
// class ApiServices {
//   Future<CallHistory> getData(String? userToken, String userId) async{
//     var client = http.Client();
//     var uri = Uri.parse('https://spaze-salesapp.com/app/_api/callhistory.php');
//     var params = {"user_id": userId};
//     var headersData = {
//     "Content-type": "application/json",
//     "Authorization": "Bearer $userToken"
//     };
//     var response = await client.post(uri, body: jsonEncode(params), headers: headersData);
//     var responseDate = jsonDecode(response.body);
//
//     if(response.statusCode == 200){
//       print('Success');
//       return CallHistory.fromJson(responseDate);
//     }else{
//       print('Failed');
//       return CallHistory.fromJson(responseDate);
//     }
//   }
// }