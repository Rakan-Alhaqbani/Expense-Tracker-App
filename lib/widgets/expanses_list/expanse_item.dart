import 'package:flutter/material.dart';
import 'package:expanses/models/expanse.dart';

class ExpanseItem extends StatelessWidget {
  const ExpanseItem(this.expanse, {super.key});
  final Expanse expanse;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expanse.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text('${expanse.amount.toStringAsFixed(2)}'),
                Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expanse.category]),
                    SizedBox(
                      width: 8,
                    ),
                    Text(expanse.formattedDate)
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
