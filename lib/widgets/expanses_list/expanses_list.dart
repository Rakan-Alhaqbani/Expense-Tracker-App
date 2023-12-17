import 'package:expanses/widgets/expanses_list/expanse_item.dart';
import 'package:flutter/material.dart';
import 'package:expanses/models/expanse.dart';

class ExpansesList extends StatelessWidget {
  const ExpansesList(
      {super.key, required this.expanses, required this.onRemoveExpanse});
  final List<Expanse> expanses;
  final void Function(Expanse expanse) onRemoveExpanse;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expanses.length,
      itemBuilder: (ctx, index) => Dismissible(
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.75),
            margin: EdgeInsets.symmetric(
                horizontal: Theme.of(context).cardTheme.margin!.horizontal),
          ),
          onDismissed: (direction) {
            onRemoveExpanse(expanses[index]);
          },
          key: ValueKey(expanses[index]),
          child: ExpanseItem(expanses[index])),
    );
  }
}
