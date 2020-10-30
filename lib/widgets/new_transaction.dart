import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function newTx;

  NewTransaction(this.newTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectedDate;

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((value) {
      print(value);
      setState(() {
        selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Title'),
            // onChanged: (value) => titleInput = value,
            controller: titleController,
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Amount'),
            controller: amountController,
            keyboardType: TextInputType.number,
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: Text(
                    selectedDate == null
                        ? 'No Date Choosen!'
                        : DateFormat.yMMMd().format(selectedDate),
                  ),
                ),
                FlatButton(
                  child: Text(
                    'Choose Date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  textColor: Theme.of(context).primaryColor,
                  onPressed: () {
                    _presentDatePicker();
                  },
                )
              ],
            ),
          ),
          RaisedButton(
            child: Text('Add Transsaction'),
            textColor: Colors.white,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              widget.newTx(titleController.text,
                  double.parse(amountController.text), selectedDate);
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
