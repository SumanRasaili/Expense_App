import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx, {Key? key}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  TextEditingController titleController = TextEditingController();

  TextEditingController amountController = TextEditingController();
   DateTime? _selectedDate;
    

  void _submitData() {
    if(amountController.text.isEmpty){
      return;
    }
    print(titleController.text);
    print(amountController.text);
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(enteredTitle, enteredAmount,_selectedDate);
    Navigator.pop(context);
  }
 
  void _showDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime.now(),
        
        ).then((pickedDate){
          if(pickedDate == null){
            return;
          }
          
         setState(() {
           _selectedDate = pickedDate;
         });
        });
        }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding:  EdgeInsets.only(right: 10,left: 10,top: 10,bottom: MediaQuery.of(context).viewInsets.bottom +10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Title"),
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: amountController,
                decoration: const InputDecoration(
                    labelText: "Amount", iconColor: Colors.purple),
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                     Expanded(child: Text(_selectedDate == null ? "No Date Chosen!": 'Picked Date :${DateFormat.yMd().format(_selectedDate!)}',)),
                    TextButton(
                      onPressed: _showDatePicker,
                      child: const Text(
                        "Choose Date",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _submitData,
                child: const Text(
                  "Add Transactions",
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
