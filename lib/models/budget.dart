import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config/listurl.dart';

class Budget {
  final int totalPrice;
  List<BudgetGroup> budget;

  Budget(
      {
        this.totalPrice,
        this.budget
      });

  factory Budget.fromJson(Map<String, dynamic> parsedJson) {

    var list = parsedJson['budget'] as List;
    List<BudgetGroup> groupList = list.map((i) => BudgetGroup.fromJson(i)).toList();

    return Budget(
      totalPrice: parsedJson['totalprice'],
      budget: groupList,
    );
  }
}

class BudgetGroup {
  final String dateTime;
  final int price;
  final List<MoneyList> listMoney;

  BudgetGroup(
      {
        this.dateTime,
        this.price,
        this.listMoney
      });

  factory BudgetGroup.fromJson(Map<String, dynamic> parsedJson) {

    var list = parsedJson['listmoney'] as List;
    List<MoneyList> moneyList = list.map((i) => MoneyList.fromJson(i)).toList();

    return BudgetGroup(
      dateTime: parsedJson['datetime'],
      price: parsedJson['price'],
      listMoney: moneyList,
    );
  }
}

class MoneyList {
  final int moneyID;
  final int userID;
  final int categoryID;
  final int typeID;
  final String category;
  final String iconname;
  final String type;
  final String title;
  final int price;
  final String status;
  final String createdAt;

  MoneyList(
      {
        this.moneyID,
        this.userID,
        this.categoryID,
        this.typeID,
        this.category,
        this.iconname,
        this.type,
        this.title,
        this.price,
        this.status,
        this.createdAt
      });

  factory MoneyList.fromJson(Map<String, dynamic> parsedJson) {
    return MoneyList(
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

Future<Budget> fetchBudget(http.Client client) async {

  final response = await client.get(URL_LISTBUDGET);
  if (response.statusCode == 200) {

    Map<String, dynamic> mapResponse = json.decode(response.body);
    final resultBudget = mapResponse["result"];

    var budget = Budget.fromJson(resultBudget);

    return budget;

  } else {
    throw Exception("Fail to get list from api");
  }
}

Future<Null> saveBudget(http.Client client, Map<String, dynamic> params) async {
  await client.post(URL_SAVEBUDGET,
      body: json.encode(params));
}
