import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config/listurl.dart';

class Budget {
  int moneyID = 0;
  int userID = 0;
  int categoryID = 0;
  int typeID = 0;
  String category = '';
  String iconname = '';
  String type = '';
  String title = '';
  int price = 0;
  String status = '';
  String createdAt = '';

  Budget(
      {this.moneyID,
      this.userID,
      this.categoryID,
      this.typeID,
      this.category,
      this.iconname,
      this.type,
      this.title,
      this.price,
      this.status,
      this.createdAt});

  factory Budget.fromJson(Map<String, dynamic> parsedJson) {
    return Budget(
      moneyID: parsedJson['money_id'],
      userID: parsedJson['user_id'],
      categoryID: parsedJson['category_id'],
      typeID: parsedJson['type_id'],
      category: parsedJson['category'],
      iconname: parsedJson['iconname'],
      type: parsedJson['type'],
      title: parsedJson['title'],
      price: parsedJson['price'],
      status: parsedJson['status'],
      createdAt: parsedJson['created_at'],
    );
  }
}

Future<List<Budget>> fetchBudget(http.Client client) async {

  final response = await client.get(URL_LISTBUDGET);
  if (response.statusCode == 200) {
    Map<String, dynamic> mapResponse = json.decode(response.body);
    if (mapResponse["status_code"] == 200) {
      final resultBuget = mapResponse["result"].cast<Map<String, dynamic>>();
      final listBudget = await resultBuget.map<Budget>((parsedJson) {
        return Budget.fromJson(parsedJson);
      }).toList();
      return listBudget;
    } else {
      return [];
    }
  } else {
    throw Exception("Fail to get list from api");
  }
}

Future<Null> saveBudget(http.Client client, Map<String, dynamic> params) async {
  await client.post(URL_SAVEBUDGET,
      body: json.encode(params));
}

// Future<List<Budget>> saveBudget(http.Client client) async {
//   final response = await client.post(URL_SAVEBUDGET);
//   if (response.statusCode == 200) {
//     Map<String, dynamic> mapResponse = json.decode(response.body);
//     if (mapResponse["status_code"] == 200) {
//       final resultBuget = mapResponse["result"].cast<Map<String, dynamic>>();
//       final listBudget = await resultBuget.map<Budget>((parsedJson) {
//         return Budget.fromJson(parsedJson);
//       }).toList();
//       return listBudget;
//     } else {
//       return [];
//     }
//   } else {
//     throw Exception("Fail to get list from api");
//   }
// }
