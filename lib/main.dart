import 'package:expense_planner/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Expense App",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Transaction> transactions = [
      Transaction(
          amount: 189.0,
          id: "1",
          dateTime: DateTime.now(),
          title: "Weekly groceries"),
      Transaction(
          amount: 434.6, id: "2", dateTime: DateTime.now(), title: "Shoes"),
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("My Expense App"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            height: 100,
            width: double.infinity,
            child: const Card(
              child: Text(
                "CHART",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              elevation: 5,
            ),
          ),
          Column(
              children: transactions.map((tx) {
            return Card(
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.purple, width: 2)),
                    padding: const EdgeInsets.all(10),
                    child: Text("Rs "+
                      tx.amount.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.purple),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tx.title,style:const  TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                      Text(DateFormat('yyyy/MM/dd').format(tx.dateTime),style: const TextStyle(color:Colors.grey),),
                      
                     
                    ],
                  ),
                ],
              ),
            );
          }).toList()),
        ],
      ),
    );
  }
}
