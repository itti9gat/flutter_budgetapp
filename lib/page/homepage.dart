import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/budget.dart';
import 'package:budget_app/page/addpage.dart';

const myIcons = <String, IconData>{
  'hand-holding-usd': FontAwesomeIcons.handHoldingUsd,
  'dollar-sign': FontAwesomeIcons.dollarSign,
  'utensils': FontAwesomeIcons.utensils,
  'home': FontAwesomeIcons.home,
  'bolt': FontAwesomeIcons.bolt,
  'toilet': FontAwesomeIcons.toilet,
  'mobile-alt': FontAwesomeIcons.mobileAlt,
  'tshirt': FontAwesomeIcons.tshirt,
  'heartbeat': FontAwesomeIcons.heartbeat,
  'car': FontAwesomeIcons.car,
  'gas-pump': FontAwesomeIcons.gasPump,
  'angellist': FontAwesomeIcons.angellist,
  'beer': FontAwesomeIcons.beer,
  'money-bill-wave-alt': FontAwesomeIcons.moneyBillWaveAlt,
  'shopping-bag': FontAwesomeIcons.shoppingBag,
  'hiking': FontAwesomeIcons.hiking,
  'vihara': FontAwesomeIcons.vihara,
  'info-circle': FontAwesomeIcons.infoCircle,
};

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Color bgColor = Color.fromRGBO(122, 186, 188, 1.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: bgColor,
          centerTitle: true,
          elevation: 0.0,
          title: Text("Cash Piggy"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) => AddPage()));
          },
          child: Icon(Icons.add),
        ),
        body: Container(
          decoration: BoxDecoration(color: bgColor),
          child: FutureBuilder(
              future: fetchBudget(http.Client()),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                }
                return snapshot.hasData
                    ? BudgetList(budget: snapshot.data)
                    : Center(child: CircularProgressIndicator());
              }),
        ));
  }
}

class BudgetList extends StatelessWidget {
  final Budget budget;
  BudgetList({Key key, this.budget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
            height: 200.0,
            child: Column(children: <Widget>[
              SizedBox(
                height: 40.0,
              ),
              Text(
                'ยอดเงิน',
                style: TextStyle(fontSize: 20.0, color: Colors.white70),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                budget.totalPrice.toString(),
                style: TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ])),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
            child: GenBudgetList(budgetlist: budget.budget),
          ),
        ),
      ],
    );
  }
}

class GenBudgetList extends StatelessWidget {
  final List<BudgetGroup> budgetlist;
  GenBudgetList({Key key, this.budgetlist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: budgetlist.length,
        itemBuilder: (context, index) {
          var d =
              new DateFormat("y-M-dd").parseStrict(budgetlist[index].dateTime);
          String showDate = DateFormat("E, d MMM yy").format(d).toString();

          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      showDate,
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                    Text(
                      "- ${budgetlist[index].price.toString()}",
                      style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    )
                  ],
                ),
              ),
              ListView.builder(
                  itemCount: budgetlist[index].listMoney.length,
                  itemBuilder: (context, idx) {
                    var iconName = budgetlist[index].listMoney[idx].iconname;

                    return ListTile(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
                      leading: Icon(
                        myIcons[iconName],
                        size: 25.0,
                        color: Color.fromARGB(255, 223, 116, 119),
                      ),
                      title: Text(
                        budgetlist[index].listMoney[idx].title,
                        style: TextStyle(fontSize: 20.0),
                      ),
                      subtitle: Text(
                        budgetlist[index].listMoney[idx].category,
                        style: TextStyle(fontSize: 15.0),
                      ),
                      trailing: budgetlist[index].listMoney[idx].typeID == 2
                          ? Text(
                              "- ${budgetlist[index].listMoney[idx].price.toString()}",
                              style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 223, 116, 119)),
                            )
                          : Text(
                              budgetlist[index].listMoney[idx].price.toString(),
                              style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 110, 179, 182)),
                            ),
                    );
                  },
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics())
            ],
          );
        },
        shrinkWrap: true,
        physics: ClampingScrollPhysics());
  }
}
