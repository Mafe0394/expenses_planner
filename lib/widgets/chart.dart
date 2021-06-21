import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart({@required this.recentTransactions});

  // getters are this properties which are calculated dinamically
  List<Map<String, Object>> get groupedTransactionsGroup {
    return List.generate(7, (index) {
      final weekDate = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDate.day &&
            recentTransactions[i].date.month == weekDate.month &&
            recentTransactions[i].date.year == weekDate.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      print(DateFormat.E(weekDate));
      print(totalSum);

      return {
        'day': DateFormat.E(weekDate),
        'amount': totalSum,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: [],
      ),
    );
  }
}
