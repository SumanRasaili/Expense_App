import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(this.transcations, {Key? key}) : super(key: key);
  final List<Transaction> transcations;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transcations.isEmpty
          ? Column(
              children: [
                const Text(
                  "Nothing Here",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                const SizedBox(
                  height: 10,
                ),
                Image.asset(
                  "assets/images/nothing.jpg",
                  fit: BoxFit.cover,
                )
              ],
            )
          : ListView.builder(
              itemCount: transcations.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                              child: Text(transcations[index]
                                  .amount
                                  .toStringAsFixed(2)))),
                    ),
                    title: Text(
                      transcations[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(DateFormat('yyyy-MM-dd')
                        .format(transcations[index].dateTime)),
                  ),
                );
              },
            ),
    );
  }
}
// Card(
//                   child: Row(
//                     children: [
//                       Container(
//                         margin: const EdgeInsets.symmetric(
//                             vertical: 10, horizontal: 15),
//                         decoration: BoxDecoration(
//                             border: Border.all(color: Theme.of(context).primaryColor)),
//                         padding: const EdgeInsets.all(10),
//                         child: Text(
//                           '\$${ transcations[index].amount.toStringAsFixed(2)}',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20,
//                               color: Theme.of(context).primaryColor),
//                         ),
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             transcations[index].title,
//                             style: const TextStyle(
//                                 fontSize: 16, fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             DateFormat('yyyy/MM/dd').format(transcations[index].dateTime),
//                             style: const TextStyle(color: Colors.grey),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 );