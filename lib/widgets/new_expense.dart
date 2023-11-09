import 'package:flutter/material.dart';
import 'package:expense_tracker_app/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense)
      onAddExpense; //occurs after Form is submitted

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  // var _enteredTitle = '';

  // void _saveTitleInput(String inputValue) {
  //   _enteredTitle = inputValue;
  // }

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate; //stores date (dateTime format) or nothing (null)
  Category _selectedCategory = Category.cat;

// functional for date picking and storing the picked date
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate =
        DateTime(now.year - 1, now.month, now.day); // today -1 year
    final pickedDate = await showDatePicker(
        //for getting future date value
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    //sprint(pickedDate); // after the date is picked
    setState(() {
      _selectedDate = pickedDate;
    });
  }

//user inputs validation there:
  void _submitExpenseData() {
    final enteredAmount =
        double.tryParse(_amountController.text); //returns number or null
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {  //show error message
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Please make sure a valid title, amount, date and category was entered'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    widget.onAddExpense(Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory));

        Navigator.pop(context); //closing overlay after adding new expense 
  }

//deleting _titleController
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16), //we are not obscure anything on add expense popup
      child: Column(
        children: [
          TextField(
            // onChanged: _saveTitleInput,
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(label: Text('write title')),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      prefixText: '\$ ', label: Text('write amount')),
                ),
              ),
              const SizedBox(
                width: 16,
              ), //16 px
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_selectedDate == null
                            ? 'No date selected'
                            : formatter.format(
                                _selectedDate!) // '!' forcing flutter that here is never be null
                        ),
                    IconButton(
                        onPressed: _presentDatePicker,
                        icon: const Icon(Icons.calendar_month)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              DropdownButton(
                //for picking category
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
                  setState(() {
                    if (value == null) {
                      // checking is category picked
                      return;
                    }
                    _selectedCategory = value; //storing picked category
                  });
                },
              ),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    Navigator.pop(
                        context); //.pop removes overlay off the screan
                  },
                  child: const Text('Cancel')),
              ElevatedButton(
                onPressed: () {
                  _submitExpenseData();
                },
                child: const Text('save expense'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
