import 'package:flutter/material.dart';


/* We change New Transaction from a stateless to a statefulWidget so 
we correct the input boxes behavior (the text dissappearing) */
class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction({@required this.addTransaction});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final String enteredTitle = titleController.text;
    final double enteredAmount = double.tryParse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return; //Stops the function execution
    }
    return widget.addTransaction(enteredTitle, enteredAmount);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submitData(),
              // onChanged: (value) => titleInput = value,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
              // onChanged: (value) => amountInput=value,
            ),
            ElevatedButton(
              onPressed: submitData,
              child: Text('Add Transaction'),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.purple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
