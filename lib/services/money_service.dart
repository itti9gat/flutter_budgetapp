import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../models/budget.dart';

class MoneyService {
  // static final _url = 'http://10.0.2.2:8020/v1';
  // Map<String,String> _headers = {
  //     'Content-type' : 'application/json', 
  //     'Accept': 'application/json',
  //   };

  // Future fetchCategory(String levelID) async {
    
  //   var urlRequest = "$_url/money/category/type/2/$levelID";

  //   final response = await http.get(urlRequest, headers: _headers);

  //   if (response.statusCode == 200) {

  //     final parsed = json.decode(response.body);
  //     final _data = parsed["result"].cast<Map<String, dynamic>>();

  //     return _data.map<List>((json) => Budget.fromJson(json)).toList();

  //    // return compute(parseData, response.body);

  //     // List _data = resBody['result'];

  //     // List _result = List<Budget>();

  //     // for (int i=0; i< _data.length; i++) {
  //     //   _result.add(new Budget.fromJson(_data[i]));
  //     // }

  //     // return _result;
  //   }
  // }

  // List<Budget> parseData(String response) {

  //   final responseJson = json.decode(response);

  //   List _data = responseJson['result'];

  //   List<Budget> _result = List();

  //   for (int i=0; i< _data.length; i++) {
  //     _result.add(new Budget.fromJson(_data[i]));
  //   }

  //   return _result;

  //   // final responseJson = json.decode(response);
  //   // final dataResponse = new Budget.fromJson(responseJson);
  //   // return dataResponse;
  // }

  

  // Future<Null> saveBudget(Budget newBudget) async {

  //   var urlRequest = "$_url/money/add";
    
  //   var body = json.encode({
  //     "user_id": 1,
  //     "category_id": newBudget.categoryID,
  //     "type_id": 2,
  //     "title": newBudget.title,
  //     "price": newBudget.price,
  //     "status": "A",
  //     "created_at": "2016-01-01 22:30:00"
  //   });

  //   final response = await http.post(urlRequest, headers: _headers, body: body);

  //   if (response.statusCode != 200) {
  //     print("save Fail");
  //   }

  //   print("save Success");
  // }
}
