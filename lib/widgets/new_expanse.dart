import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expanses/models/expanse.dart';

class NewExpanse extends StatefulWidget {
  const NewExpanse({super.key, required this.onAddExpanse});
  final void Function(Expanse expanse) onAddExpanse;

  @override
  State<NewExpanse> createState() => _NewExpanseState();
}

class _NewExpanseState extends State<NewExpanse> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final pidckedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(now.year - 1, now.month, now.day),
        lastDate: now);
    setState(() {
      _selectedDate = pidckedDate;
    });
  }

  void _submitButton() {
    final enteredAmount = double.tryParse(_amountController.text);

    if (_titleController.text.trim().isEmpty ||
        enteredAmount == null ||
        enteredAmount <= 0 ||
        _selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('Invalid Input'),
                content: Text(
                    'please make sure a valid date and category was entered'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: Text('OK'),
                  )
                ],
              ));
      return;
    }
    widget.onAddExpanse(Expanse(
        title: _titleController.text,
        amount: enteredAmount,
        category: _selectedCategory,
        date: _selectedDate!));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: InputDecoration(label: Text('Title')),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration:
                      InputDecoration(label: Text('Amount'), prefixText: '\$'),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(_selectedDate == null
                      ? 'No date selected'
                      : formatter.format(_selectedDate!)),
                  IconButton(
                      onPressed: _presentDatePicker,
                      icon: Icon(Icons.calendar_month))
                ],
              ))
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(
                            category.name.toUpperCase(),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedCategory = value;
                    });
                  }),
              Spacer(),
              ElevatedButton(onPressed: _submitButton, child: Text('Save')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'))
            ],
          )
        ],
      ),
    );
  }
}
