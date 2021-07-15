import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/chart.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      home: MyHomePage(),
      theme: ThemeData(
        //primarySwatch generates diferent shades based in a primary color
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              button: TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'New shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'New cats',
      amount: 10.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'New cats',
      amount: 10.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'New cats',
      amount: 100.50,
      date: DateTime.utc(2021, 6, 27),
    ),
    Transaction(
      id: 't3',
      title: 'New cats',
      amount: 10.99,
      date: DateTime.utc(2021, 6, 29),
    ),
    Transaction(
      id: 't3',
      title: 'New cats',
      amount: 10.99,
      date: DateTime.utc(2021, 6, 29),
    ),
  ];

  List<Transaction> get _recentTransactions {
    /* Where is used to apply a function in every element of the list,
    if the condition is true the element is keeped*/
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(Duration(days: 7)),
      );
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime selectedDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: selectedDate,
    );

    setState(() {
      _userTransactions.add(newTx);
    });
    Navigator.of(context).pop(); // dismiss the bottom sheet
  }

  void startAddNewTransaction(BuildContext ctx) {
    //The builder is a function that returns the widget contained in the BottomSheet
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: NewTransaction(addTransaction: _addNewTransaction),
            onTap:
                () {}, // We set a different action when the user taps on the bottomSheet, is not necesary if the default works
            behavior: HitTestBehavior
                .opaque, //important to catch the event and avoid it is handle for anyone else
          );
        });
  }

  void _deleteTransaction(String idTransaction) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == idTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppBar _appBar = AppBar(
      actions: [
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => startAddNewTransaction(context)),
      ],
      title: Text('Personal Expenses'),
    );
    final _availableSpace=(MediaQuery.of(context).size.height -
                      _appBar.preferredSize.height-MediaQuery.of(context).padding.top);
    return Scaffold(
      appBar: _appBar,
      body: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: _availableSpace*
                  0.3,
              child: Chart(
                recentTransactions: _recentTransactions,
              ),
            ), // we need only the recent transactions in the chart
            Container(
              height: _availableSpace *
                  0.7,
              child: TransactionList(
                transactions: _userTransactions,
                trailingFunction: _deleteTransaction,
              ),
            ),
          ],
        ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => startAddNewTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
