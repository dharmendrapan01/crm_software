import 'package:flutter/material.dart';

import '../search_screen.dart';
import '../user_preference.dart';
import 'clock_widget.dart';

class HeaderSection extends StatefulWidget {
  const HeaderSection({Key? key}) : super(key: key);

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  var myLeadController = TextEditingController();
  var myNameMblController = TextEditingController();

  String? userId = '';
  String? userName = '';

  @override
  void initState() {
    super.initState();
    userId = UserPreference.getUserId() ?? '';
    userName = UserPreference.getUserName() ?? '';
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myLeadController.dispose();
    myNameMblController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: myLeadController,
                    autofocus: false,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: ' CRM ID',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 5),
                      suffixIcon: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchPage(searchBox: 'lead', searchValue: myLeadController.text.toString()),
                            ),
                          );
                        },
                        icon: Icon(Icons.search, color: Colors.green,),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5,),
                Expanded(
                  child: TextFormField(
                    controller: myNameMblController,
                    autofocus: false,
                    // keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: ' MOBILE / NAME',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 5),
                      suffixIcon: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchPage(searchBox: 'name', searchValue: myNameMblController.text.toString()),
                              ),
                          );
                        },
                          icon: Icon(Icons.search, color: Colors.green,),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClockPart(),
                // Text ('$formattedDate $formattedTime',
                //   style: TextStyle(fontSize: 16, color: Colors.white),),
                Text('$userName',
                  style: TextStyle(fontSize: 16, color: Colors.white),),
              ],
            ),
          ],
        ),
      );
  }
}
