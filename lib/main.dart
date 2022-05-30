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
    return  MaterialApp(
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
    void _addNewTranscation(String titleTx, double amountTx) {
      final newTx = Transaction(
          amount: amountTx,
          id: DateTime.now().toString(),
          dateTime: DateTime.now(),
          title: titleTx);
      setState(() {
        _userTransactions.add(newTx);
      });
    }

    List<Transaction> get _recentTransactions{
      return _userTransactions.where((tx){
        return tx.dateTime.isAfter(DateTime.now().subtract(const Duration(days: 7)));
      }).toList();
    }
//     List<Transaction> get _recentTransactions {
//     return _userTransactions.where((tx) => DateTime.now().difference(tx.dateTime).inDays <= 7).toList();
// }

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
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("My Expense App"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _startAddNewtransaction(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            
           
            Chart( _recentTransactions),
            TransactionList(_userTransactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewtransaction(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
