import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // final formKey = new GlobalKey<FormState>();
  // final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _filter = new TextEditingController();
  final dio = new Dio();
  String searchText = "";
  List<String> names = [];
  List<String> filteredNames = [];
  Icon _searchIcon = new Icon(Icons.close);
  Widget _appBarTitle = new Text('Search Example');

  _SearchScreenState() {
    this._appBarTitle = new TextField(
      style: TextStyle(color: Colors.white),
      cursorColor: Colors.grey,
      autofocus: true,
      controller: _filter,
      decoration: new InputDecoration(
          hintText: 'Search...', hintStyle: TextStyle(color: Colors.grey)),
    );

    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchIcon = Icon(Icons.search);
          searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchIcon = Icon(Icons.close);
          searchText = _filter.text;
        });
      }
    });
  }

  @override
  void initState() {
    this._getNames();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      body: Container(
        child: _buildList(),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  AppBar _buildBar(BuildContext context) {
    return new AppBar(
      centerTitle: true,
      title: _appBarTitle,
      leading: new IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: onClosePressed, 
      ),
      actions: [IconButton(onPressed: _searchPressed, icon: _searchIcon)],
    );
  }

  Widget _buildList() {
    if (searchText.isNotEmpty) {
      List<String> tempList = [];
      for (int i = 0; i < filteredNames.length; i++) {
        if (filteredNames[i].toLowerCase().contains(searchText.toLowerCase())) {
          tempList.add(filteredNames[i]);
        }
      }
      filteredNames = tempList;
    }
    return ListView.builder(
      itemCount: filteredNames.length,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          title: Text(filteredNames[index]),
          onTap: () => print(filteredNames[index]),
        );
      },
    );
  }

  void _searchPressed() {
    setState(() {
      this._searchIcon = new Icon(Icons.search);
      // this._appBarTitle = new Text('Search Example');
      filteredNames = names;
      _filter.clear();
    });
  }

  void onClosePressed() {
    Navigator.pop(context);
  }

  void _getNames() async {
    List<String> tempList = [
      "viona",
      "lindo",
      "dante",
      "illi",
      "dayan",
      "sheyda"
    ];

    // final response = await dio.get('https://swapi.co/api/people');
    // for (int i = 0; i < response.data['results'].length; i++) {
    //   tempList.add(response.data['results'][i]);
    // }
    setState(() {
      names = tempList;
      names.shuffle();
      filteredNames = names;
    });
  }
}
