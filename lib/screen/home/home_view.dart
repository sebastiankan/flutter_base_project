
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin<HomeView> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    var screenSize = MediaQuery.of(context).size;
    List<String> placesList = ["place1", "place2", "place3", "place4"];

    return Container(
      child: Container(child: carousel(screenSize, placesList),),
      color: Theme.of(context).backgroundColor,
    );
  }

  CarouselSlider carousel(Size screenSize, List<String> placesList) {
    return CarouselSlider(
      options: CarouselOptions(
          height: screenSize.height * 0.17,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3)),
      items: placesList.map((e) {
        return Builder(builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).cardColor),
            width: screenSize.width * 0.8,
            margin: EdgeInsets.symmetric(horizontal: 5.0),
          );
        });
      }).toList(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
