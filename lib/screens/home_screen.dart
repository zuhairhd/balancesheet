import 'package:flutter/material.dart';
import 'package:balancesheet/models/expense.dart';
import 'package:balancesheet/screens/add_expense_screen.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Expense> _expenses = [];

  void _addExpense(String title, double amount, DateTime date) {
    final newExpense = Expense(title: title, amount: amount, date: date);
    setState(() {
      _expenses.add(newExpense);
    });
  }

  void _startAddNewExpense(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return AddExpenseScreen(_addExpense);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewExpense(context),
          ),
        ],
      ),
      body: _expenses.isEmpty
          ? Center(
              child: Text('No expenses added yet!'),
            )
          : ListView.builder(
              itemCount: _expenses.length,
              itemBuilder: (ctx, index) {
                final exp = _expenses[index];
                return Card(
                  child: ListTile(
                    title: Text(exp.title),
                    subtitle: Text(
                      '${exp.amount} - ${exp.date.toLocal().toString().split(' ')[0]}',
                    ),
                  ),
                );
              },
            ),
    );
  }
}
