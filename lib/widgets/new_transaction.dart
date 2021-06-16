import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function addTransaction;

  NewTransaction({@required this.addTransaction});

  void submitData() {
    final String enteredTitle = titleController.text;
    final double enteredAmount = double.tryParse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return; //Stops the function execution
    }
    return addTransaction(enteredTitle, enteredAmount);
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
