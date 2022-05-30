import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  
  const  NewTransaction(this.addTx, {Key? key}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  TextEditingController titleController = TextEditingController();

   TextEditingController amountController = TextEditingController();

  void _submitData() {
print(titleController.text);
print(amountController.text);
     final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if(enteredTitle.isEmpty|| enteredAmount <= 0){
      return;
    }
    
    widget.addTx(enteredTitle,enteredAmount
    );
    Navigator.pop(context);
  }
  void _showDatePicker(){
  showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2022), lastDate: DateTime.now());

  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Title"),
              onSubmitted: (_) => 
              _submitData(),
            ),
            
            TextField(
              
              keyboardType: TextInputType.number,
              controller: amountController,
              decoration: const InputDecoration(
                  labelText: "Amount", iconColor: Colors.purple),
                  
              onSubmitted: (_) => _submitData(),
            ),
            Container(height: 70,

              child: Row(children: [ 
                const Text("No Date Chosen!"),
                
                TextButton(onPressed: 

                  _showDatePicker,
                child:const  Text("Choose Date",style: TextStyle(fontWeight: FontWeight.bold),),),
              ],),
            ),
            ElevatedButton(
              
              onPressed: 
                _submitData,
              
              child: const  Text(
                "Add Transactions",
                style: TextStyle(color: Colors.white, fontSize: 17),
                
              ),
            )
          ],
        ),
      ),
    );
  }
}
