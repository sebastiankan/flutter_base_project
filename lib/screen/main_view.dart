import 'package:flutter/material.dart';
import 'package:mizban/screen/friends/friends_view.dart';
import 'package:mizban/screen/home/home_view.dart';
import 'package:mizban/screen/search/search_screen.dart';
import 'package:mizban/screen/setting/setting_view.dart';

class MainView extends StatefulWidget {
  MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView>
    with SingleTickerProviderStateMixin {
  var searchIcon = Icon(Icons.search);
  List<Widget> listScreens = [];
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 3);
    listScreens = [
      HomeView(),
      FriendsView(),
      SettingView(),
    ];
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
      title: new Text('Mizban'),
      actions: [
        IconButton(
            onPressed: () => Navigator.of(context).push(PageRouteBuilder(
                opaque: false,
                pageBuilder: (BuildContext context, _, __) => SearchScreen())),
            icon: searchIcon)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).bottomAppBarColor,
      appBar: buildAppBar(context),
      bottomNavigationBar: SafeArea(child: bottomNavigationBar(context), maintainBottomViewPadding: true,),
      body: new TabBarView(
        controller: controller,
        children: listScreens,
    ));
  }

  Material bottomNavigationBar(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor,
      child: TabBar(
        controller: controller,
        tabs: <Tab>[
          new Tab(
            icon: Icon(Icons.home),
          ),
          new Tab(
            icon: Icon(Icons.people),
          ),
          new Tab(
            icon: Icon(Icons.settings),
          )
        ],
      ),
    );
  }
}
