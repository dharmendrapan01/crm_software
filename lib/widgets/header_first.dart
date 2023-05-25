import 'package:flutter/material.dart';

import '../live_call.dart';
import 'filter_widget.dart';

class HeaderFirst extends StatefulWidget {
  const HeaderFirst({Key? key}) : super(key: key);

  @override
  State<HeaderFirst> createState() => _HeaderFirstState();
}

class _HeaderFirstState extends State<HeaderFirst> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 20,),
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => FilterWidgetPage(),
                );
              },
              icon: Icon(Icons.filter_alt, color: Colors.green,),
          ),
          Image.asset('assets/images/salesapp.png', width: 100),
          Padding(
            padding: const EdgeInsets.only(right: 3.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => LiveCall()));
              },
              child: Row(
                children: [
                  Text('Live Call'.toUpperCase(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                  SizedBox(width: 3,),
                  Icon(Icons.call),
                ],
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
