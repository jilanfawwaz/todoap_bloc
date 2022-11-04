import 'package:flutter/material.dart';
import 'package:todoapp_bloc/pages/listtile.dart';

class PendingPages extends StatelessWidget {
  const PendingPages({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.grey.shade300,
          ),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '4 Pendings | 0 Completed',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return ListTilePage();
          },
        ),
      ],
    );
  }
}
