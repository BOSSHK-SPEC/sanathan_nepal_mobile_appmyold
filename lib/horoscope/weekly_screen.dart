
import 'package:flutter/material.dart';

class WeeklyScreen extends StatefulWidget {
  const WeeklyScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<WeeklyScreen> createState() => _WeeklyScreenState();
}

class _WeeklyScreenState extends State<WeeklyScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                color: Colors.red,
                width: 80,
              ),
              Container(color: Colors.teal,)
            ],
          ),
        ),
    );
  }
}
