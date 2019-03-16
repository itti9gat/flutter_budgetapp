import 'dart:async';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/budget.dart';
import '../models/category.dart';

class AddPage extends StatefulWidget {
  AddPage({Key key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  final Color bgColor = Color.fromRGBO(122, 186, 188, 1.0);

  String _selectedDate =
      DateFormat("d MMM y").format(DateTime.now()).toString();
  String _savedDate = DateFormat("y-MM-dd").format(DateTime.now()).toString();

  int _category = 0;
  String _title = "";
  int _price = 0;
  String categoryLevelID = "2";
  List<Category> _categories;

  Future<Null> _chooseDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: convertToDate(_selectedDate),
        firstDate: DateTime(2019),
        lastDate: DateTime(2050));

    if (picked != null) {
      setState(() {
        _selectedDate = new DateFormat("d MMM y").format(picked);
        _savedDate = new DateFormat("y-MM-dd").format(picked);
      });
    }
  }

  DateTime convertToDate(String input) {
    try {
      var d = new DateFormat("d MMM y").parseStrict(input);
      return d;
    } catch (e) {
      return null;
    }
  }

  void _submitForm(BuildContext context) async {
    final FormState form = _formKey.currentState;
    form.save();

    Map<String, dynamic> params = Map<String, dynamic>();

    params["user_id"] = 1;
    params["category_id"] = _category;
    params["type_id"] = 2;
    params["title"] = _title;
    params["price"] = _price;
    params["status"] = "A";
    params["created_at"] = _savedDate;

    await saveBudget(http.Client(), params);

    Navigator.pop(context, true);
  }

  @override
  void initState() {
    super.initState();
    fetchCategory(http.Client()).then((value) {
      setState(() {
        this._categories = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: bgColor,
          centerTitle: true,
          elevation: 0.0,
          title: Text("Add Tracker"),
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
          child: Form(
            key: _formKey,
            child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  InputDecorator(
                    baseStyle: TextStyle(fontSize: 20.0),
                    decoration: InputDecoration(
                      icon: const Icon(
                        Icons.view_list,
                        size: 30.0,
                      ),
                      hintText: 'หมวดหมู่',
                    ),
                    isEmpty: _category == 0,
                    child: Container(
                      child: new DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: new DropdownButton(
                            value: _category == 0 ? null : _category,
                            isDense: true,
                            onChanged: (val) {
                              setState(() {
                                _category = val;
                              });
                            },
                            items: _categories?.map((Category item) {
                                  return new DropdownMenuItem(
                                    value: item.categoryID,
                                    child: new Text(
                                      item.title,
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                  );
                                })?.toList() ??
                                [],
                          ),
                        ),
                      ),
                    ),
                  ),
                  new SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                      style: TextStyle(fontSize: 20.0),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.note,
                          size: 30.0,
                        ),
                        hintText: 'รายการ',
                      ),
                      onSaved: (val) {
                        setState(() {
                          _title = val;
                        });
                      }),
                  new SizedBox(
                    height: 20.0,
                  ),
                  new TextFormField(
                      style: TextStyle(fontSize: 20.0),
                      decoration: const InputDecoration(
                        icon: const Icon(
                          Icons.attach_money,
                          size: 30.0,
                        ),
                        hintText: 'จำนวนเงิน',
                      ),
                      keyboardType: TextInputType.number,
                      onSaved: (val) {
                        setState(() {
                          _price = int.parse(val);
                        });
                      }),
                  new SizedBox(
                    height: 20.0,
                  ),
                  new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Icon(
                          Icons.event_note,
                          size: 30.0,
                          color: Colors.grey[600],
                        ),
                        new SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          child: new Text(
                            _selectedDate,
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                        new IconButton(
                          icon: new Icon(Icons.more_horiz),
                          tooltip: 'Choose date',
                          onPressed: (() {
                            _chooseDate(context);
                          }),
                        )
                      ]),
                  new SizedBox(
                    height: 50.0,
                  ),
                  new FlatButton(
                    padding: EdgeInsets.all(10.0),
                    color: Colors.green,
                    child: const Text(
                      'บันทึก',
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                    onPressed: () {
                      _submitForm(context);
                    },
                  ),
                ]),
          ),
        ));
  }
}
