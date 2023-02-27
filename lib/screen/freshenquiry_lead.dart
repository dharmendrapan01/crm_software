import 'package:flutter/material.dart';

class FreshenqLead extends StatefulWidget {
  const FreshenqLead({Key? key}) : super(key: key);

  @override
  State<FreshenqLead> createState() => _FreshenqLeadState();
}

class _FreshenqLeadState extends State<FreshenqLead> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Text('Fresh Enquiry page')),
      ),
    );
  }
}
