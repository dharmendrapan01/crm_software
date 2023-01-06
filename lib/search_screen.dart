import 'package:crm_software/search_body.dart';
import 'package:crm_software/widgets/header_section.dart';
import 'package:crm_software/widgets/top_header.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  String searchValue;
  String searchBox;
  SearchPage({Key? key, required this.searchBox, required this.searchValue}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          TopHeader(),
          HeaderSection(),
          searchBodySec(widget.searchBox, widget.searchValue),
        ],
      ),
    );
  }


  Container searchBodySec(searchBox, searchValue) {
    return Container(
      height: 680,
      child: Column(
        children: [
          Expanded(
            child: SearchBody(searchBox: searchBox, searchValue: searchValue),
          ),
        ],
      ),
    );
  }



}



