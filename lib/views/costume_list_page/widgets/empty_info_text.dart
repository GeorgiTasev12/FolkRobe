import 'package:flutter/material.dart';
import 'package:folk_robe/constants.dart';

class EmptyInfoText extends StatelessWidget {
  const EmptyInfoText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Имате празен инвентар от риквизити, моля добавте като натискате:',
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white54,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 15),
            Icon(
              Icons.add,
              color: Colors.white54,
              size: 32,
            ),
          ],
        ),
      ),
    );
  }
}