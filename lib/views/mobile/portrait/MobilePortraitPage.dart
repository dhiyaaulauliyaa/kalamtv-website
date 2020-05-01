import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kalamtv_web/widgets/PhoneHeaderFooter.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MobilePortraitPage extends StatefulWidget {
  @override
  _MobilePortraitPageState createState() => _MobilePortraitPageState();
}

class _MobilePortraitPageState extends State<MobilePortraitPage> {
  PageController _pageController;
  double _activePage = 1;

  final double _ratioTreshold = 1.95;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: 0);
    _pageController.addListener(() {
      setState(() {
        _activePage = _pageController.page + 1;
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
    double _screenRatio = _screenHeight > _screenWidth
        ? _screenHeight / _screenWidth
        : _screenWidth / _screenHeight;
    print("Height: $_screenHeight");
    print("Width : $_screenWidth");
    print("Ratio : $_screenRatio");

    return PhoneHeaderFooter(
      activePage: _activePage,
      child: Positioned(
        child: PageView(
          controller: _pageController,
          children: <Widget>[
            //----------------------- First Page -----------------------//
            Container(
              height: _screenHeight,
              width: _screenWidth,
              child: Stack(
                children: <Widget>[
                  //----------------------- Clouds -----------------------//
                  Container(
                    height: _screenHeight,
                    width: _screenWidth,
                    alignment: Alignment.bottomLeft,
                    margin: EdgeInsets.only(
                      bottom: _screenRatio > _ratioTreshold
                          ? _screenWidth * 0.3
                          : _screenWidth * 0.25,
                    ),
                    child: Image.asset('assets/img/cloud.png'),
                  ),

                  Container(
                    height: _screenHeight,
                    width: _screenWidth,
                    child: Column(
                      children: <Widget>[
                        //----------------------- Logo -----------------------//
                        Expanded(
                          flex: _screenRatio > _ratioTreshold ? 31 : 29,
                          child: Container(
                            alignment: Alignment.bottomLeft,
                            margin: EdgeInsets.only(
                              bottom: 0,
                              left: _screenWidth * 0.1,
                            ),
                            child: Stack(
                              alignment: Alignment.bottomLeft,
                              children: <Widget>[
                                Positioned(
                                  bottom: -10,
                                  child: Image.asset(
                                    'assets/img/logo-white.png',
                                    width: _screenWidth * 0.35,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        //----------------------- Main Text -----------------------//
                        Expanded(
                          flex: _screenRatio > _ratioTreshold ? 9 : 11,
                          child: Container(
                            padding: EdgeInsets.only(left: _screenWidth * 0.15),
                            alignment: Alignment.centerLeft,
                            child: AutoSizeText(
                              'dakwah\nkapan pun,\ndimana pun.',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 70,
                                letterSpacing: -2,
                                height: 0.97,
                              ),
                            ),
                          ),
                        ),

                        //----------------------- Subtext -----------------------//
                        Expanded(
                          flex: 3,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: _screenRatio > _ratioTreshold
                                  ? _screenWidth * 0.012
                                  : _screenWidth * 0.01,
                              horizontal: _screenRatio > _ratioTreshold
                                  ? _screenWidth * 0.15
                                  : 0,
                            ),
                            child: Image.asset(
                              'assets/img/subtitle.png',
                            ),
                          ),
                        ),
                        Expanded(flex: 9, child: SizedBox()),
                      ],
                    ),
                  )
                ],
              ),
            ),

            //----------------------- Second Page -----------------------//
            Container(
              height: _screenHeight,
              width: _screenWidth,
              child: Column(
                children: <Widget>[
                  AutoSizeText(
                    "DAKWAH ANDA INGIN DILIPUT?",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
              // color: Colors.teal.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}
