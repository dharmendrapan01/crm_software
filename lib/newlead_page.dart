import 'package:flutter/material.dart';

class NewleadPage extends StatefulWidget {
  const NewleadPage({Key? key}) : super(key: key);

  @override
  State<NewleadPage> createState() => _NewleadPageState();
}

class _NewleadPageState extends State<NewleadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('New Lead Page'),
    );
  }
}
