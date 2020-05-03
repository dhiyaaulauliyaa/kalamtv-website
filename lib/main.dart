import 'package:flutter/material.dart';

import 'package:responsive_builder/responsive_builder.dart';

import 'package:kalamtv_web/views/desktop/DesktopPage.dart';
import 'package:kalamtv_web/views/tablet/TabletPage.dart';
import 'package:kalamtv_web/views/mobile/landscape/MobileLandscapePage.dart';
import 'package:kalamtv_web/views/mobile/portrait/MobilePortraitPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KalamTV',
      home: MainPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF3748ac),
        accentColor: Color(0xFF90d2e5),
        secondaryHeaderColor: Color(0xFFaab5da),
        backgroundColor: Color(0xFF141a2a),
        fontFamily: 'ProximaNova',
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenRatio = _screenHeight > _screenWidth
        ? _screenHeight / _screenWidth
        : _screenWidth / _screenHeight;

    double _ratioTreshold = 1.3;

    return Scaffold(
      body: Container(
        height: _screenHeight,
        width: _screenWidth,
        color: Theme.of(context).backgroundColor,
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Container(
                height: _screenHeight,
                width: _screenWidth,
                child: _screenHeight > _screenWidth
                    ? RotatedBox(
                        quarterTurns: 1,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Opacity(
                            opacity: 0.2,
                            child: Image.asset(
                              'assets/img/grunge.png',
                            ),
                          ),
                        ),
                      )
                    : FittedBox(
                        fit: BoxFit.cover,
                        child: Opacity(
                          opacity: 0.2,
                          child: Image.asset(
                            'assets/img/grunge.png',
                          ),
                        ),
                      ),
              ),
            ),
            Positioned(
              child: ScreenTypeLayout(
                breakpoints: ScreenBreakpoints(
                  desktop: 900,
                  tablet: 550,
                  watch: 250,
                ),
                desktop: _screenRatio > _ratioTreshold
                    ? DesktopPage()
                    : TabletPage(),
                tablet: TabletPage(),
                mobile: OrientationLayoutBuilder(
                  portrait: (context) => MobilePortraitPage(),
                  landscape: (context) => MobileLandscapePage(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
