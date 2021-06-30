import './chart_bar.dart';
import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart({
    @required this.recentTransactions,
  });

  // getters are this properties which are calculated dinamically
  List<Map<String, Object>> get groupedTransactionsGroup {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekday.day &&
            recentTransactions[i].date.month == weekday.month &&
            recentTransactions[i].date.year == weekday.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      print(DateFormat.E().format(weekday));
      print(totalSum);

      return {
        'day': DateFormat.E()
            .format(weekday)
            .substring(0, 1), // to get the first element of a string
        'amount': totalSum,
      };
    });
  }

  /* .fold allows to turn a list into a number type*/
  double get totalSpending {
    return groupedTransactionsGroup.fold(
        0.0, (previousValue, element) => previousValue + element['amount']);
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionsGroup);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: groupedTransactionsGroup.map((data) {
          return ChartBar(
            label: data['day'],
            spendingAmount: data['amount'],
            spendingPctOfTotal: totalSpending == 0.0
                ? 0.0
                : (data['amount'] as double) / totalSpending,
          );
        }).toList(),
      ),
    );
  }
}
