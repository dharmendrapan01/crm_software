import 'package:flutter/material.dart';

class DataenqLead extends StatefulWidget {
  const DataenqLead({Key? key}) : super(key: key);

  @override
  State<DataenqLead> createState() => _DataenqLeadState();
}

class _DataenqLeadState extends State<DataenqLead> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Text('Default Page')),
      ),
    );
  }
}
