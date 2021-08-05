import 'package:flutter/material.dart';
import 'package:mizban/components/avatar.dart';

class FriendsView extends StatefulWidget {
  const FriendsView({Key? key}) : super(key: key);

  @override
  _FriendsViewState createState() => _FriendsViewState();
}

class _FriendsViewState extends State<FriendsView>
    with AutomaticKeepAliveClientMixin<FriendsView> {
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var screenSize = MediaQuery.of(context).size;
    List<String> usersList = ["User 1", "User 2", "User 3", "User 4"];

    return Container(
        color: Theme.of(context).backgroundColor,
        child: ListView(
            scrollDirection: Axis.vertical,
            children: usersList.map((user) {
              return TextButton(
                  onPressed: () => {onItemPress(user)},
                  child: Container(
                    height: 68,
                    child: Center(
                        child: Container(
                      child: Row(
                        children: [
                          Avatar(),
                          Container(width: 8),
                          Text(user)
                        ],
                      ),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 12, right: 12),
                    )),
                  ));
            }).toList()));
  }

  @override
  bool get wantKeepAlive => true;

  onItemPress(place) {
    print(place);
  }
}
