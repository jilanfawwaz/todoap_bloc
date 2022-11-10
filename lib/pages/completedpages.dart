import 'package:flutter/material.dart';

class CompletedPages extends StatelessWidget {
  const CompletedPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Completed Task'),
        ],
      ),
    );
  }
}
