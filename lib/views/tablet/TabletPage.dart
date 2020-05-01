import 'package:flutter/material.dart';
import 'package:kalamtv_web/widgets/TabletHeaderFooter.dart';

class TabletPage extends StatefulWidget {
  @override
  _TabletPageState createState() => _TabletPageState();
}

class _TabletPageState extends State<TabletPage> {
  PageController _pageController;
  double _page = 1;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: 0);
    _pageController.addListener(() {
      setState(() {
        _page = _pageController.page + 1;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;

    return TabletHeaderFooter(
      activePage: _page,
      child: Positioned(
        child: PageView(
          controller: _pageController,
          children: <Widget>[
            Container(
              height: _screenHeight,
              width: _screenWidth,
            ),
            Container(
              height: _screenHeight,
              width: _screenWidth,
            ),
          ],
        ),
      ),
    );
  }
}
