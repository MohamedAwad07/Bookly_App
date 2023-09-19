import 'package:bookly/services/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Waiting extends StatelessWidget {
  const Waiting({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
        ),
        Center(
          child: Text(
            'No Result',
            style: Styles.textStyle18.copyWith(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
