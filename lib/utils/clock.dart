import 'package:UEnicsERP/utils/customWidget/customText.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Clock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 1)),
      builder: (context, snapshot) {
        return Center(
          child: SimpleText(
            DateFormat('dd-MMM-yyyy hh:mm:ss').format(DateTime.now()),
          ),
        );
      },
    );
  }
}
