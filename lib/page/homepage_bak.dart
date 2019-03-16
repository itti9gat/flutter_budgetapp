// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// import '../models/budget.dart';
// import 'package:budget_app/page/addpage.dart';


// const myIcons = <String, IconData> {
//   'car': FontAwesomeIcons.car,
//   'utensils': FontAwesomeIcons.utensils,
//   'money-bill-wave-alt': FontAwesomeIcons.moneyBillWaveAlt,
// };


// class HomePage extends StatefulWidget {
//   HomePage({Key key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final Color bgColor = Color.fromRGBO(122, 186, 188, 1.0);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: bgColor,
//           centerTitle: true,
//           elevation: 0.0,
//           title: Text("Cash Piggy"),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             Navigator.push(
//                 context,
//                 new MaterialPageRoute(
//                     builder: (BuildContext context) => AddPage()));
//           },
//           child: Icon(Icons.add),
//         ),
//         body: Container(
//           decoration: BoxDecoration(color: bgColor),
//           child: ListView(
//             children: <Widget>[
//               Container(
//                   height: 200.0,
//                   child: Column(children: <Widget>[
//                     SizedBox(
//                       height: 40.0,
//                     ),
//                     Text(
//                       'ยอดเงิน',
//                       style: TextStyle(fontSize: 20.0, color: Colors.white70),
//                     ),
//                     SizedBox(
//                       height: 15.0,
//                     ),
//                     Text(
//                       '12,000',
//                       style: TextStyle(
//                           fontSize: 50.0,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white),
//                     ),
//                   ])),
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(30.0),
//                       topRight: Radius.circular(30.0)),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 100.0),
//                   child: FutureBuilder(
//                       future: fetchBudget(http.Client()),
//                       builder: (context, snapshot) {
//                         if (snapshot.hasError) {
//                           print(snapshot.error);
//                         }
//                         return snapshot.hasData
//                             ? BudgetList(budget: snapshot.data)
//                             : Center(child: CircularProgressIndicator());
//                       }),
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
// }

// class BudgetList extends StatelessWidget {
//   final List<Budget> budget;
//   BudgetList({Key key, this.budget}) : super(key: key);
  
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         itemCount: budget.length,
//         itemBuilder: (context, index) {

//           var iconName = budget[index].iconname;

//           return ListTile(
//             contentPadding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 10.0),
//             leading: Icon(myIcons[iconName], size: 25.0, color: Color.fromARGB(255, 223, 116, 119),),
//             title: Text(
//               budget[index].title,
//               style: TextStyle(fontSize: 20.0),
//             ),
//             subtitle: Text(
//               budget[index].category,
//               style: TextStyle(fontSize: 15.0),
//             ),
//             trailing: budget[index].typeID == 2
//                 ? Text(
//                     "- ${budget[index].price.toString()}",
//                     style: TextStyle(
//                         fontSize: 25.0,
//                         fontWeight: FontWeight.bold,
//                         color: Color.fromARGB(255, 223, 116, 119)),
//                   )
//                 : Text(
//                     budget[index].price.toString(),
//                     style: TextStyle(
//                         fontSize: 25.0,
//                         fontWeight: FontWeight.bold,
//                         color: Color.fromARGB(255, 110, 179, 182)),
//                   ),
//           );
//         },
//         shrinkWrap: true,
//         physics: ClampingScrollPhysics());
//   }
// }
