import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

import 'package:kalamtv_web/widgets/PhoneHeaderFooter.dart';

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

  void _pageChanger(int page) {
    setState(() {
      _activePage = page.toDouble();
      _pageController.jumpToPage(page - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenRatio = _screenHeight > _screenWidth
        ? _screenHeight / _screenWidth
        : _screenWidth / _screenHeight;

    ResponsiveWidgets.init(
      context,
      height: 1920, // Optional
      width: 1080, // Optional
      allowFontScaling: true, // Optional
    );

    return PhoneHeaderFooter(
      activePage: _activePage,
      pageChanger: _pageChanger,
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
              child: ResponsiveWidgets.builder(
                allowFontScaling: true,
                height: 1920,
                width: 1080,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //----------------------- Title -----------------------//

                    TextResponsive(
                      "DAKWAH ANDA\nINGIN DILIPUT?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.75,
                        fontSize: 90,
                        height: 1,
                      ),
                    ),
                    SizedBoxResponsive(
                      height: 10,
                    ),
                    //----------------------- Subtitle -----------------------//
                    TextResponsive(
                      "hubungi kami di nomor berikut:",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 55,
                        letterSpacing: -0.75,
                      ),
                    ),
                    //----------------------- Phone -----------------------//
                    ContainerResponsive(
                      height: 135,
                      width: 680,
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(
                        vertical: _screenRatio > _ratioTreshold ? 75 : 55,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF81fbb8),
                            Color(0xFF28c76f),
                          ],
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icon/phone.png',
                            width: 30,
                          ),
                          SizedBoxResponsive(width: 30),
                          TextResponsive(
                            "+62.816.197.4846",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 60,
                              letterSpacing: -0.75,
                            ),
                          ),
                        ],
                      ),
                    ),

                    //----------------------- Donasi Title -----------------------//
                    TextResponsive(
                      "belanjakan sebagian harta anda\nuntuk dakwah di media sosial:",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 50,
                        letterSpacing: -0.5,
                      ),
                    ),

                    //----------------------- Donasi Subtitle -----------------------//
                    TextResponsive(
                      "Donasi: Rekening BNI syariah\n4 2019 2020 4 a.n. KALAM TV",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 50,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
              // color: Colors.teal.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}
