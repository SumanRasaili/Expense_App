

import 'dart:io';

import 'package:expense_planner/widgets/chart.dart';

import './widgets/transaction_list.dart';
import 'package:expense_planner/widgets/new_transcations.dart';
import 'package:flutter/material.dart';

import 'models/transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Expense App",
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //     amount: 189.0,
    //     id: "1",
    //     dateTime: DateTime.now(),
    //     title: "Weekly groceries"),
    // Transaction(
    //     amount: 434.6,
    //     id: "2",
    //     dateTime: DateTime.now(),
    //      title: "Shoes"),
  ];
  void _addNewTranscation(
      String titleTx, double amountTx, DateTime chosenDate) {
    final newTx = Transaction(
        amount: amountTx,
        id: DateTime.now().toString(),
        dateTime: chosenDate,
        title: titleTx);
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.dateTime
          .isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }
//     List<Transaction> get _recentTransactions {
//     return _userTransactions.where((tx) => DateTime.now().difference(tx.dateTime).inDays <= 7).toList();
// }
bool _showChart = false;
  
  void _startAddNewtransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTranscation),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {

    final isLandscape = MediaQuery.of(context).orientation== Orientation.landscape;
    final appBar = AppBar(
      centerTitle: true,
      title: const Text("My Expense App"),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => _startAddNewtransaction(context),
        )
      ],
    );
    final txListWidget = Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.7,
                child: TransactionList(_userTransactions, _deleteTransaction));

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            if(isLandscape) Row(mainAxisAlignment: MainAxisAlignment.center, children: [ 
              Text("SHow Chart"),
              Switch(value: _showChart, onChanged: (val){

                setState(() {
                   _showChart = val;
                });
              })
            ],),
            if(!isLandscape)
            Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                child: Chart(_recentTransactions)),
                if(!isLandscape) txListWidget,
           if(isLandscape) _showChart ? Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.7,
                child: Chart(_recentTransactions)):
            txListWidget
           ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS ? Container(): FloatingActionButton(
        onPressed: () => _startAddNewtransaction(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
