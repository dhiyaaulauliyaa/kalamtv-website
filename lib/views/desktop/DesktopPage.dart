import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:slide_container/slide_container.dart';
import 'package:slide_container/slide_container_controller.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

class DesktopPage extends StatefulWidget {
  @override
  _DesktopPageState createState() => _DesktopPageState();
}

class _DesktopPageState extends State<DesktopPage>
    with TickerProviderStateMixin {
  final SlideContainerController _slideController = SlideContainerController();
  double _activePage = 1;

  AnimationController rotationController;
  bool _buttonAppearance = true;
  bool _buttonInRight = true;
  TextStyle _buttonStyle = TextStyle(
    fontSize: 115,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );
  void _buttonAppearanceChanger(bool val) {
    setState(() {
      _buttonAppearance = val;
    });
  }

  void _onButtonPressed() {
    setState(() {
      if (_buttonInRight) {
        _slideController.forceSlide(SlideContainerDirection.rightToLeft);
        _buttonInRight = false;
        _activePage = 2;
      } else {
        _slideController.forceSlide(SlideContainerDirection.leftToRight);
        _buttonInRight = true;
        _activePage = 1;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _slideController.addListener(() {});
    rotationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  void _launchYT() async {
    const url = 'https://www.youtube.com/channel/UC9J5nLBU9Xsy17I8wZN1WDA';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _launchIG() async {
    const url = "https://www.instagram.com/kalamtv.official/";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _launchFB() async {
    const url = 'https://www.facebook.com/kalamtv.official/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  String loremIpsum =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    // double _screenHeight = 1080;
    // double _screenWidth = 1920;
    double _screenRatio = _screenHeight > _screenWidth
        ? _screenHeight / _screenWidth
        : _screenWidth / _screenHeight;

    double _ratioTreshold = 1.6;
    double _heightTreshold = 750;
    // double _widthTreshold = 1200;
    double _navButtonSize = _screenWidth * 0.075;

    double _adaptiveWidth(double _sizePercentage) {
      if (_screenHeight < _heightTreshold) {
        _buttonAppearanceChanger(false);
        return _screenWidth;
      } else if (_screenRatio > _ratioTreshold) {
        _buttonAppearanceChanger(true);
        return _screenWidth * _sizePercentage;
      } else {
        _buttonAppearanceChanger(false);
        return _screenWidth;
      }
    }

    double _ratioChecker(double _treshold, double _comparison, double _greater,
        double _smaller) {
      if (_comparison > _treshold) {
        _buttonAppearanceChanger(true);
        return _greater;
      } else {
        _buttonAppearanceChanger(false);
        return _smaller;
      }
    }

    // ----------------------- Right Padding -----------------------//
    Container _mainPageRightPadding() {
      return Container(
        width: _buttonAppearance ? _screenWidth * 0.15 : _screenWidth * 0.25,
        height:
            _screenHeight > _heightTreshold ? _screenHeight : _heightTreshold,
      );
    }

    // ----------------------- Left Padding -----------------------//
    Container _mainPageLeftPadding() {
      return Container(
        width: _buttonAppearance ? _screenWidth * 0.075 : _screenWidth * 0.175,
        height:
            _screenHeight > _heightTreshold ? _screenHeight : _heightTreshold,
      );
    }

    ResponsiveWidgets.init(
      context,
      height: 1080,
      width: 1920,
      allowFontScaling: true,
    );

    return ResponsiveWidgets.builder(
      allowFontScaling: true,
      height: 1080,
      width: 1920,
      child: SingleChildScrollView(
        child: Container(
          height:
              _screenHeight < _heightTreshold ? _heightTreshold : _screenHeight,
          width: _screenWidth,
          //----------------------- Base Stack -----------------------//
          child: Stack(
            children: <Widget>[
              //----------------------- Hamburger -----------------------//
              Positioned(
                top: _screenHeight < _heightTreshold
                    ? _heightTreshold * 0.067
                    : _screenHeight * 0.067,
                right: _screenWidth * 0.1 / 2 - 40,
                child: !_buttonAppearance
                    ? SizedBox()
                    : IconButton(
                        icon: Image.asset(
                          'assets/icon/hamburger-white.png',
                        ),
                        iconSize: 50,
                        color: Colors.white,
                        onPressed: () => setState(() {
                          // _isMenuActive = !_isMenuActive;
                        }),
                      ),
              ),

              //----------------------- Pejtu -----------------------//
              Positioned(
                top: 0,
                left: _screenRatio > _ratioTreshold ? _screenWidth * 0.1 : 0,
                child: Container(
                  height: _screenHeight < _heightTreshold
                      ? _heightTreshold
                      : _screenHeight,
                  width: _adaptiveWidth(0.8),
                  alignment: Alignment.center,
                  child: AnimatedCrossFade(
                    duration: Duration(milliseconds: 400),
                    reverseDuration: Duration(milliseconds: 400),
                    crossFadeState: _activePage == 1
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    firstChild: SizedBox(),
                    secondChild: _pejtu(_screenHeight, _heightTreshold),
                  ),
                ),
              ),

              //----------------------- Pejwan -----------------------//
              Positioned(
                top: 0,
                right: _screenRatio > _ratioTreshold ? _screenWidth * 0.05 : 0,
                child: Container(
                  height: _screenHeight < _heightTreshold
                      ? _heightTreshold
                      : _screenHeight,
                  width: _adaptiveWidth(0.95),
                  child: SlideContainer(
                    controller: _slideController,
                    slideDirection: SlideContainerDirection.rightToLeft,
                    maxSlideDistance: _ratioChecker(
                      _ratioTreshold,
                      _screenRatio,
                      _screenWidth * 0.8,
                      _screenWidth,
                    ),
                    autoSlideDuration: Duration(milliseconds: 500),
                    dampeningStrength: 5,
                    child: Stack(
                      children: <Widget>[
                        // ----------------------- Background White -----------------------//
                        Positioned(
                          top: 0,
                          right: _ratioChecker(
                            _ratioTreshold,
                            _screenRatio,
                            _screenWidth * 0.05,
                            0,
                          ),
                          child: Container(
                            width: _ratioChecker(
                              _ratioTreshold,
                              _screenRatio,
                              _screenWidth * 0.9,
                              _screenWidth,
                            ),
                            height: _screenHeight < _heightTreshold
                                ? _heightTreshold
                                : _screenHeight,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 20,
                                  spreadRadius: 20,
                                  color: Colors.black.withOpacity(0.3),
                                )
                              ],
                            ),
                            // child: TextResponsive(
                            //   "Screen Width: ${_screenWidth.toString()}\n" +
                            //       "Screen Height: ${_screenHeight.toString()}\n" +
                            //       "Screen Ratio: ${_screenRatio.toString()}\n",
                            //   style: TextStyle(
                            //     fontSize: 50,
                            //     fontWeight: FontWeight.w700,
                            //   ),
                            // ),
                          ),
                        ),

                        //----------------------- Background Grad -----------------------//
                        Positioned(
                          top: 0,
                          right: _ratioChecker(
                            _ratioTreshold,
                            _screenRatio,
                            _screenWidth * 0.05,
                            0,
                          ),
                          child: Container(
                            width: _ratioChecker(
                              _ratioTreshold,
                              _screenRatio,
                              _screenWidth * 0.9,
                              _screenWidth,
                            ),
                            height: _screenHeight < _heightTreshold
                                ? _heightTreshold
                                : _screenHeight,
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
                          ),
                        ),

                        //----------------------- Background Grunge -----------------------//
                        Positioned(
                          top: 0,
                          right: _ratioChecker(
                            _ratioTreshold,
                            _screenRatio,
                            _screenWidth * 0.05,
                            0,
                          ),
                          child: Container(
                            width: _ratioChecker(
                              _ratioTreshold,
                              _screenRatio,
                              _screenWidth * 0.9,
                              _screenWidth,
                            ),
                            height: _screenHeight < _heightTreshold
                                ? _heightTreshold
                                : _screenHeight,
                            child: FittedBox(
                              fit: BoxFit.cover,
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
                          top: 0,
                          left: _buttonAppearance ? _screenWidth * 0.1 : 0,
                          child: Container(
                            width: _buttonAppearance
                                ? _screenWidth * 0.8
                                : _screenWidth,
                            height: _screenHeight > _heightTreshold
                                ? _screenHeight
                                : _heightTreshold,
                            child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                // ----------------------- Main Logo -----------------------//
                                Positioned(
                                  left: 0,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      _mainPageLeftPadding(),
                                      Container(
                                        height: _screenHeight > _heightTreshold
                                            ? _screenHeight / 1.6
                                            : 475,
                                        width: _screenWidth * 0.3,
                                        alignment: Alignment.centerLeft,
                                        child: Image.asset(
                                          "assets/img/logo-desktop.png",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // ----------------------- Cloud -----------------------//
                                Positioned(
                                  left: 0,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      // _mainPageLeftPadding(),
                                      Container(
                                        width: _buttonAppearance
                                            ? _screenWidth * 0.075 * 0.9
                                            : _screenWidth * 0.175 * 0.9,
                                        height: _screenHeight > _heightTreshold
                                            ? _screenHeight
                                            : _heightTreshold,
                                      ),
                                      Container(
                                        height: _screenHeight > _heightTreshold
                                            ? _screenWidth > 1200
                                                ? _screenHeight / 1.4
                                                : _screenWidth > 1000
                                                    ? _screenHeight / 1.6
                                                    : _screenHeight / 1.8
                                            : _screenWidth > 1200 ? 500 : 400,
                                        width: _buttonAppearance
                                            ? (_screenWidth * 0.8) -
                                                (_screenWidth * 0.075 * 0.8) -
                                                (_screenWidth * 0.15 * 0.8)
                                            : (_screenWidth) -
                                                (_screenWidth * 0.175 * 0.8) -
                                                (_screenWidth * 0.25 * 0.8),
                                        alignment: Alignment.bottomCenter,
                                        child: Image.asset(
                                          "assets/img/cloud-desktop.png",
                                          width: _buttonAppearance
                                              ? (_screenWidth * 0.8) -
                                                  (_screenWidth * 0.075 * 0.8) -
                                                  (_screenWidth * 0.15 * 0.8)
                                              : (_screenWidth) -
                                                  (_screenWidth * 0.175 * 0.8) -
                                                  (_screenWidth * 0.25 * 0.8),
                                        ),
                                      ),
                                      Container(
                                        width: _buttonAppearance
                                            ? _screenWidth * 0.15 * 0.8
                                            : _screenWidth * 0.25 * 0.8,
                                        height: _screenHeight > _heightTreshold
                                            ? _screenHeight
                                            : _heightTreshold,
                                      ),
                                      // _mainPageRightPadding(),
                                    ],
                                  ),
                                ),

                                // ----------------------- Main Text -----------------------//
                                Positioned(
                                  right: 0,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        height: _screenHeight > _heightTreshold
                                            ? _screenWidth > 1400
                                                ? _screenHeight / 2.25
                                                : _screenWidth > 1300
                                                    ? _screenHeight / 2.35
                                                    : _screenWidth > 1200
                                                        ? _screenHeight / 2.4
                                                        : _screenWidth > 1100
                                                            ? _screenHeight /
                                                                2.8
                                                            : _screenHeight / 3
                                            : _screenWidth > 1400
                                                ? 320
                                                : _screenWidth > 1300
                                                    ? 300
                                                    : _screenWidth > 1200
                                                        ? 280
                                                        : _screenWidth > 1100
                                                            ? 260
                                                            : 240,
                                        width: _screenHeight > _heightTreshold
                                            ? _screenWidth * 0.385
                                            : _screenWidth > 1400
                                                ? _screenWidth * 0.37
                                                : _screenWidth > 1300
                                                    ? _screenWidth * 0.35
                                                    : _screenWidth > 1200
                                                        ? _screenWidth * 0.35
                                                        : _screenWidth > 1100
                                                            ? _screenWidth *
                                                                0.35
                                                            : _screenWidth *
                                                                0.35,
                                        alignment: Alignment.topLeft,
                                        child: TextResponsive(
                                          "dakwah\nkapan pun,\ndimana pun.",
                                          style: TextStyle(
                                              shadows: [
                                                Shadow(
                                                  blurRadius: 10.0,
                                                  color: Theme.of(context)
                                                      .primaryColor
                                                      .withOpacity(0.2),
                                                  offset: Offset(5.0, 5.0),
                                                ),
                                              ],
                                              fontSize: _screenHeight >
                                                      _heightTreshold
                                                  ? _screenWidth > 1400
                                                      ? 125
                                                      : _screenWidth > 1300
                                                          ? 130
                                                          : 140
                                                  : _screenWidth > 1000
                                                      ? 125
                                                      : 127,
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: -3.5,
                                              height: 0.95,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      ),
                                      _mainPageRightPadding(),
                                    ],
                                  ),
                                ),
                                // ----------------------- Subtitle -----------------------//
                                Positioned(
                                  right: 0,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        height: _screenHeight > _heightTreshold
                                            ? _screenWidth > 1400
                                                ? _screenHeight / 2
                                                : _screenWidth > 1200
                                                    ? _screenHeight / 2.45
                                                    : _screenWidth > 1100
                                                        ? _screenHeight / 2.35
                                                        : _screenWidth > 1050
                                                            ? _screenHeight /
                                                                2.6
                                                            : _screenHeight /
                                                                2.8
                                            : _screenWidth > 1400
                                                ? 400
                                                : _screenWidth > 1200
                                                    ? 325
                                                    : _screenWidth > 1000
                                                        ? 260
                                                        : 200,
                                        width: _screenWidth * 0.35,
                                        alignment: Alignment.bottomRight,
                                        child: Image.asset(
                                          "assets/img/subtitle.png",
                                        ),
                                      ),
                                      _mainPageRightPadding(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // ----------------------- Button -----------------------//
                        Positioned(
                          top: _screenHeight < _heightTreshold
                              ? (_heightTreshold / 2) - (_navButtonSize / 2)
                              : (_screenHeight / 2) - (_navButtonSize / 2),
                          right: (_screenWidth * 0.05) - (_navButtonSize / 2),
                          child: !_buttonAppearance
                              ? SizedBox()
                              : Container(
                                  width: _navButtonSize,
                                  height: _navButtonSize,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xFF81fbb8),
                                        Color(0xFF28c76f),
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(5, 5),
                                        blurRadius: 10,
                                        spreadRadius: 5,
                                        color: Colors.black12,
                                      )
                                    ],
                                  ),
                                  child: RawMaterialButton(
                                    shape: CircleBorder(),
                                    elevation: 4.0,
                                    child: AnimatedCrossFade(
                                      duration: Duration(milliseconds: 750),
                                      reverseDuration:
                                          Duration(milliseconds: 750),
                                      crossFadeState: _buttonInRight
                                          ? CrossFadeState.showFirst
                                          : CrossFadeState.showSecond,
                                      firstChild: TextResponsive(
                                        "<",
                                        style: _buttonStyle,
                                      ),
                                      secondChild: TextResponsive(
                                        ">",
                                        style: _buttonStyle,
                                      ),
                                    ),
                                    onPressed: _onButtonPressed,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // ----------------------- Page Overlay -----------------------//
              //----------------------- Play & Kajian -----------------------//
              Positioned(
                top: 0,
                right: _ratioChecker(
                  _ratioTreshold,
                  _screenRatio,
                  _screenWidth * 0.1,
                  0,
                ),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  width: _activePage == 1
                      ? _ratioChecker(
                          _ratioTreshold,
                          _screenRatio,
                          _screenWidth * 0.9,
                          _screenWidth,
                        )
                      : _ratioChecker(
                          _ratioTreshold,
                          _screenRatio,
                          _screenWidth * 0.8,
                          _screenWidth,
                        ),
                  height: _screenHeight < _heightTreshold
                      ? _heightTreshold
                      : _screenHeight,
                  padding: EdgeInsets.symmetric(
                    vertical: _screenHeight < _heightTreshold
                        ? _heightTreshold * 0.07
                        : _screenHeight * 0.07,
                    horizontal: _screenWidth * 0.07,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //----------------------- Play -----------------------//
                          ContainerResponsive(
                            height: _screenHeight < 800 ? 70 : 90,
                            width: 90,
                            heightResponsive:
                                _screenHeight < 800 ? false : true,

                            // color: Colors.grey,
                            child: IconButton(
                              icon: Image.asset(
                                _activePage == 1
                                    ? "assets/icon/play-blue.png"
                                    : "assets/icon/play-green.png",
                              ),
                              onPressed: () {
                                _launchYT();
                              },
                            ),
                          ),
                        ],
                      ),

                      //----------------------- Kajian -----------------------//
                      TextResponsive(
                        "KAJIAN ISLAM",
                        style: TextStyle(
                          color: Theme.of(context).secondaryHeaderColor,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 7,
                          fontSize: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //----------------------- Menu -----------------------//
              Positioned(
                top: 0,
                right: _ratioChecker(
                  _ratioTreshold,
                  _screenRatio,
                  _screenWidth * 0.1,
                  0,
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: _screenHeight < _heightTreshold
                        ? _heightTreshold * 0.07
                        : _screenHeight * 0.07,
                    horizontal: _screenWidth * 0.07,
                  ),
                  child: AnimatedCrossFade(
                    duration: Duration(milliseconds: 400),
                    reverseDuration: Duration(milliseconds: 400),
                    crossFadeState: _activePage == 1
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    firstChild: Row(
                      children: [
                        Text(
                          'home',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            letterSpacing: -1.5,
                            fontSize: _screenWidth < 1400 ? 32 : 40,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        SizedBoxResponsive(width: 100),
                        InkWell(
                          onTap: _onButtonPressed,
                          child: Text(
                            'hubungi kami',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              letterSpacing: -1.5,
                              fontSize: _screenWidth < 1400 ? 32 : 40,
                              color: Theme.of(context).secondaryHeaderColor,
                            ),
                          ),
                        ),
                        SizedBoxResponsive(width: 100),
                        InkWell(
                          onTap: _launchYT,
                          child: Text(
                            'video dakwah',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              letterSpacing: -1.5,
                              fontSize: _screenWidth < 1400 ? 32 : 40,
                              color: Theme.of(context).secondaryHeaderColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    secondChild: Row(
                      children: [
                        InkWell(
                          onTap: _onButtonPressed,
                          child: Text(
                            'home',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              letterSpacing: -1.5,
                              fontSize: _screenWidth < 1400 ? 32 : 40,
                              color: Theme.of(context).secondaryHeaderColor,
                            ),
                          ),
                        ),
                        SizedBoxResponsive(width: 100),
                        Text(
                          'hubungi kami',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            letterSpacing: -1.5,
                            fontSize: _screenWidth < 1400 ? 32 : 40,
                            color: Colors.white,
                          ),
                        ),
                        SizedBoxResponsive(width: 100),
                        InkWell(
                          onTap: _launchYT,
                          child: Text(
                            'video dakwah',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              letterSpacing: -1.5,
                              fontSize: _screenWidth < 1400 ? 32 : 40,
                              color: Theme.of(context).secondaryHeaderColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              //----------------------- Page Bar -----------------------//
              Positioned(
                bottom: 0,
                right: _ratioChecker(
                  _ratioTreshold,
                  _screenRatio,
                  _screenWidth * 0.1,
                  0,
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: _screenHeight < _heightTreshold
                        ? _heightTreshold * 0.07
                        : _screenHeight * 0.07,
                    horizontal: _screenWidth * 0.07,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: _activePage == 2 ? _onButtonPressed : () {},
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 400),
                          height: _activePage == 1 ? 13 : 7,
                          width: _screenWidth < 1350
                              ? _screenWidth * 0.15
                              : _screenWidth * 0.1,
                          color: _activePage == 1
                              ? Color(0xFF5ae498)
                              : Colors.white,
                          margin: EdgeInsets.only(right: 6),
                        ),
                      ),
                      InkWell(
                        onTap: _activePage == 1 ? _onButtonPressed : () {},
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 400),
                          height: _activePage == 2 ? 13 : 7,
                          width: _screenWidth < 1350
                              ? _screenWidth * 0.15
                              : _screenWidth * 0.1,
                          color: _activePage == 2
                              ? Color(0xFF5ae498)
                              : Theme.of(context).secondaryHeaderColor,
                          margin: EdgeInsets.only(right: 6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _pejtu(double _screenHeight, double _heightTreshold) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        //----------------------- Title -----------------------//
        TextResponsive(
          "DAKWAH ANDA INGIN DILIPUT?",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.75,
            fontSize: _buttonAppearance ? 70 : 85,
            height: 1,
          ),
        ),
        SizedBoxResponsive(
          height: 6,
        ),

        //----------------------- Subtitle -----------------------//
        TextResponsive(
          "hubungi kami di nomor berikut:",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: _buttonAppearance ? 45 : 60,
            letterSpacing: -0.75,
          ),
        ),

        //----------------------- Phone -----------------------//
        ContainerResponsive(
          height: _screenHeight > _heightTreshold ? 125 : 100,
          width: _buttonAppearance ? 630 : 660,
          alignment: Alignment.center,
          heightResponsive: _screenHeight > _heightTreshold ? true : false,
          margin: EdgeInsets.symmetric(
            vertical: _screenHeight > _heightTreshold ? 95 : 80,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(150),
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
                width: 55,
              ),
              SizedBoxResponsive(width: 40),
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
          "belanjakan sebagian harta anda untuk dakwah di media sosial:",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: _buttonAppearance ? 35 : 45,
            letterSpacing: -0.5,
          ),
        ),

        //----------------------- Donasi Subtitle -----------------------//
        TextResponsive(
          "Donasi: BNI Syariah 4 2019 2020 4 a/n KALAM TV",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: _buttonAppearance ? 35 : 45,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }
}
