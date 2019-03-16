import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config/listurl.dart';

class Category {
  int categoryID = 0;
  String title = '';
  int level = 0;
  int levelID = 0;
  String necessary = '';
  int position = 0;
  String status = '';

  Category(
      {this.categoryID,
      this.title,
      this.level,
      this.levelID,
      this.necessary,
      this.position,
      this.status});

  factory Category.fromJson(Map<String, dynamic> parsedJson) {
    return Category(
      categoryID: parsedJson['category_id'],
      title: parsedJson['title'],
      level: parsedJson['level'],
      levelID: parsedJson['level_id'],
      necessary: parsedJson['necessary'],
      position: parsedJson['position'],
      status: parsedJson['status'],
    );
  }
}

Future<List<Category>> fetchCategory(http.Client client) async {
  final response = await client.get(URL_LISTCATEGORY);
  if (response.statusCode == 200) {
    Map<String, dynamic> mapResponse = json.decode(response.body);
    if (mapResponse["status_code"] == 200) {
      final resultBuget = mapResponse["result"].cast<Map<String, dynamic>>();
      final listCategory = await resultBuget.map<Category>((parsedJson) {
        return Category.fromJson(parsedJson);
      }).toList();
      return listCategory;
    } else {
      return [];
    }
  } else {
    throw Exception("Fail to get list from api");
  }
}
