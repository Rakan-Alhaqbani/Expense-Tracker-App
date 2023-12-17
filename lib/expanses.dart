import 'package:expanses/widgets/chart/chart.dart';
import 'package:expanses/widgets/new_expanse.dart';
import 'package:flutter/material.dart';
import 'package:expanses/models/expanse.dart';
import 'widgets/expanses_list/expanses_list.dart';
import 'package:expanses/widgets/chart/chart.dart';

class Expanses extends StatefulWidget {
  const Expanses({super.key});

  @override
  State<Expanses> createState() => _ExpansesState();
}

class _ExpansesState extends State<Expanses> {
  final List<Expanse> _registeredExpanses = [
    Expanse(
        title: 'Flutter Course',
        amount: 19.99,
        date: DateTime.now(),
        category: Category.work),
    Expanse(
        title: 'Cinema',
        amount: 14.99,
        date: DateTime.now(),
        category: Category.leisure),
    Expanse(
        title: 'Flutter Course',
        amount: 19.99,
        date: DateTime.now(),
        category: Category.work),
  ];

  void _openAddExpanseOverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpanse(
              onAddExpanse: _addExpanse,
            ));
  }

  void _addExpanse(Expanse expanse) {
    setState(() {
      _registeredExpanses.add(expanse);
    });
  }

  void _removeExpanse(Expanse expanse) {
    final expanseIndex = _registeredExpanses.indexOf(expanse);
    setState(() {
      _registeredExpanses.remove(expanse);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registeredExpanses.insert(expanseIndex, expanse);
              });
            }),
        duration: Duration(seconds: 3),
        content: Text('Expanse deleted.')));
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(
      child: Text('No expanses found , Start adding sone'),
    );
    if (_registeredExpanses.isNotEmpty) {
      mainContent = ExpansesList(
        expanses: _registeredExpanses,
        onRemoveExpanse: _removeExpanse,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Expanse Tracker'),
        actions: [
          IconButton(onPressed: _openAddExpanseOverlay, icon: Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpanses),
          Expanded(child: mainContent)
        ],
      ),
    );
  }
}
