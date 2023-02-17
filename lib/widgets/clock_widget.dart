import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClockPart extends StatefulWidget {
  const ClockPart({Key? key}) : super(key: key);

  @override
  State<ClockPart> createState() => _ClockPartState();
}

class _ClockPartState extends State<ClockPart> {
  String formattedDate = DateFormat('d MMMM y').format(DateTime.now());
  String formattedTime = DateFormat('jm').format(DateTime.now());
  late Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) => _update());
    super.initState();
  }

  void _update() {
    setState(() {
      formattedDate = DateFormat('d MMMM y').format(DateTime.now());
      formattedTime = DateFormat('jm').format(DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text ('$formattedDate $formattedTime',
      style: TextStyle(fontSize: 16, color: Colors.white),);
  }
}