import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_planner/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function _deleteTransaction;
  TransactionList(this.userTransactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return userTransactions.isEmpty
            ? Column(
                children: [
                  Text(
                    'no transactions added yet!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.5,
                    child: Image.asset('assets/images/waiting.png',
                        fit: BoxFit.cover),
                  ),
                ],
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 5,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: FittedBox(
                            child: Text(
                              '\$ ${userTransactions[index].amount.toStringAsFixed(2)}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        userTransactions[index].title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(userTransactions[index].date),
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      trailing: MediaQuery.of(context).size.width > 360
                          ? FlatButton.icon(
                              label: Text('Delete'),
                              icon: Icon(Icons.delete),
                              textColor: Colors.red,
                              onPressed: () => _deleteTransaction(
                                  userTransactions[index].id),
                            )
                          : IconButton(
                              icon: Icon(Icons.delete),
                              color: Colors.red,
                              onPressed: () => _deleteTransaction(
                                  userTransactions[index].id),
                            ),
                    ),
                  );
                },
                itemCount: userTransactions.length,
              );
      },
    );
  }
}
