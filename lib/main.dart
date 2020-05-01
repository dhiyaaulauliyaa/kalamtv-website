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

    return Scaffold(
      body: Container(
        height: _screenHeight,
        width: _screenWidth,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: [0.0, 0.8],
            colors: [
              Color.fromRGBO(76, 105, 255, 0.2),
              Color.fromRGBO(42, 250, 223, 0.05),
            ],
          ),
        ),
        // color: Colors.blue,
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
                          fit: BoxFit.fitHeight,
                          child: Opacity(
                            opacity: 0.3,
                            child: Image.asset(
                              'assets/img/grunge.png',
                            ),
                          ),
                        ),
                      )
                    : FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Opacity(
                          opacity: 0.3,
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
                desktop: DesktopPage(),
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
