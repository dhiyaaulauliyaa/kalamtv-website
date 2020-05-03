import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'package:animated_size_and_fade/animated_size_and_fade.dart';

class PhoneBaseWidgets extends StatefulWidget {
  PhoneBaseWidgets({
    Key key,
    @required this.activePage,
    @required this.child,
    @required this.pageChanger,
  }) : super(key: key);

  final double activePage;
  final Widget child;
  final Function pageChanger;

  @override
  _PhoneBaseWidgetsState createState() => _PhoneBaseWidgetsState();
}

class _PhoneBaseWidgetsState extends State<PhoneBaseWidgets>
    with TickerProviderStateMixin {
  bool _isMenuActive;

  @override
  void initState() {
    super.initState();
    _isMenuActive = false;
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

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: <Widget>[
        //----------------------- Background -----------------------//
        Positioned(
          child: Container(
            height: _screenHeight,
            width: _screenWidth,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          child: Container(
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
          ),
        ),
        Positioned(
          child: Container(
            height: _screenHeight,
            width: _screenWidth,
            child: _screenHeight > _screenWidth
                ? RotatedBox(
                    quarterTurns: 1,
                    child: FittedBox(
                      fit: BoxFit.fill,
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

        widget.child,
        _footer(_screenHeight, _screenWidth, context),

        // ------------ MENU ------------ //
        Positioned(
          child: AnimatedSizeAndFade(
            vsync: this,
            fadeDuration: const Duration(milliseconds: 800),
            sizeDuration: const Duration(milliseconds: 600),
            child: !_isMenuActive
                ? SizedBox(
                    height: _isMenuActive ? _screenHeight : 0,
                    width: _isMenuActive ? _screenWidth : 0,
                  )
                : Container(
                    height: _screenHeight,
                    width: _screenWidth,
                    color: Theme.of(context).backgroundColor,
                  ),
          ),
        ),
        _grunge(_screenHeight, _screenWidth),
        _menu(_screenHeight, _screenWidth),
        // ------------ MENU ------------ //

        _header(_screenWidth, context),
      ],
    );
  }

  //----------------------- Header -----------------------//
  Positioned _header(double _screenWidth, BuildContext context) {
    return Positioned(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: _screenWidth * 0.06,
          vertical: _screenWidth * 0.06,
        ),
        child: Row(
          children: <Widget>[
            //----------------------- Menu -----------------------//
            AnimatedCrossFade(
              duration: Duration(milliseconds: 400),
              crossFadeState: _isMenuActive
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstChild: IconButton(
                icon: Image.asset(
                  'assets/icon/hamburger-white.png',
                ),
                color: Theme.of(context).primaryColor,
                onPressed: () => setState(() {
                  _isMenuActive = !_isMenuActive;
                }),
              ),
              secondChild: IconButton(
                icon: Image.asset(
                  'assets/icon/hamburger-blue.png',
                ),
                color: Theme.of(context).primaryColor,
                onPressed: () => setState(() {
                  _isMenuActive = !_isMenuActive;
                }),
              ),
            ),
            Expanded(child: SizedBox()),
            //----------------------- Open URL -----------------------//
            AnimatedCrossFade(
              duration: Duration(milliseconds: 400),
              crossFadeState: _isMenuActive
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstChild: IconButton(
                icon: Icon(Icons.close),
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    _isMenuActive = !_isMenuActive;
                  });
                },
              ),
              secondChild: IconButton(
                icon: Image.asset(
                  'assets/icon/play-blue.png',
                ),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  _launchYT();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  //----------------------- Footer -----------------------//
  Positioned _footer(
    double _screenHeight,
    double _screenWidth,
    BuildContext context,
  ) {
    return Positioned(
      child: Container(
        height: _screenHeight,
        width: _screenWidth,
        child: Column(
          children: <Widget>[
            //----------------------- Page Indicator -----------------------//
            Expanded(flex: 3 + 12 + 28, child: SizedBox()),
            Expanded(
              flex: 4,
              child: Container(
                width: _screenWidth,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AnimatedContainer(
                      height: _screenWidth * 0.017,
                      width: widget.activePage == 1
                          ? _screenWidth * 0.017
                          : _screenWidth * 0.017 * 5,
                      duration: Duration(milliseconds: 400),
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: widget.activePage == 1
                            ? Theme.of(context).secondaryHeaderColor
                            : Theme.of(context)
                                .secondaryHeaderColor
                                .withOpacity(0.6),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    AnimatedContainer(
                      height: _screenWidth * 0.017,
                      width: widget.activePage != 1
                          ? _screenWidth * 0.017
                          : _screenWidth * 0.017 * 5,
                      duration: Duration(milliseconds: 400),
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: widget.activePage != 1
                            ? Theme.of(context).secondaryHeaderColor
                            : Theme.of(context)
                                .secondaryHeaderColor
                                .withOpacity(0.6),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //----------------------- Hadits -----------------------//
            Expanded(
              flex: 5,
              child: Container(
                height: _screenWidth * 0.07,
                width: _screenWidth,
                padding: EdgeInsets.symmetric(horizontal: _screenWidth * 0.05),
                // color: Colors.blue,
                child: AutoSizeText(
                  "“sebaik-baik manusia adalah yang \n belajar al qur’an dan mengajarkannya”"
                      .toUpperCase(),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).secondaryHeaderColor,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //----------------------- Menu -----------------------//
  Positioned _menu(double _screenHeight, double _screenWidth) {
    return Positioned(
      child: AnimatedSizeAndFade(
        vsync: this,
        fadeDuration: const Duration(milliseconds: 800),
        sizeDuration: const Duration(milliseconds: 600),
        child: !_isMenuActive
            ? SizedBox(
                height: _isMenuActive ? _screenHeight : 0,
                width: _isMenuActive ? _screenWidth : 0,
              )
            : ResponsiveWidgets.builder(
                allowFontScaling: true,
                height: 1920,
                width: 1080,
                child: Container(
                    height: _screenHeight,
                    width: _screenWidth,
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.symmetric(
                      horizontal: _screenWidth * 0.06,
                      vertical: _screenWidth * 0.06,
                    ),
                    // color: Color(0xFF141a2a).withOpacity(1),
                    child: Column(
                      children: [
                        //----------------------- Menu -----------------------//
                        Expanded(flex: 1, child: SizedBox()),
                        Expanded(
                          flex: 8,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  widget.pageChanger(1);
                                  _isMenuActive = false;
                                },
                                child: TextResponsive(
                                  "Home.",
                                  style: TextStyle(
                                    fontSize: 100,
                                    letterSpacing: -0.75,
                                    fontWeight: FontWeight.w700,
                                    color: widget.activePage == 1
                                        ? Colors.white
                                        : Colors.white38,
                                  ),
                                ),
                              ),
                              SizedBoxResponsive(height: 50),
                              InkWell(
                                onTap: () {
                                  widget.pageChanger(2);
                                  _isMenuActive = false;
                                },
                                child: TextResponsive(
                                  "Kontak.",
                                  style: TextStyle(
                                    fontSize: 100,
                                    letterSpacing: -0.75,
                                    fontWeight: FontWeight.w700,
                                    color: widget.activePage == 2
                                        ? Colors.white
                                        : Colors.white38,
                                  ),
                                ),
                              ),
                              SizedBoxResponsive(height: 50),
                              InkWell(
                                onTap: () {
                                  _launchYT();
                                },
                                child: TextResponsive(
                                  "VideoDakwah.",
                                  style: TextStyle(
                                    fontSize: 100,
                                    letterSpacing: -0.75,
                                    fontWeight: FontWeight.w700,
                                    color: widget.activePage == 3
                                        ? Colors.white
                                        : Colors.white38,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //----------------------- Socmed -----------------------//
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                iconSize: 30,
                                icon: Image.asset(
                                  "assets/icon/facebook.png",
                                ),
                                onPressed: () => _launchFB(),
                              ),
                              IconButton(
                                iconSize: 32,
                                icon: Image.asset(
                                  "assets/icon/instagram.png",
                                ),
                                onPressed: () => _launchIG(),
                              ),
                              IconButton(
                                iconSize: 44,
                                icon: Image.asset(
                                  "assets/icon/youtube.png",
                                ),
                                onPressed: () => _launchYT(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
      ),
    );
  }

  //----------------------- Grunge Overlay -----------------------//
  Positioned _grunge(double _screenHeight, double _screenWidth) {
    return Positioned(
      child: !_isMenuActive
          ? SizedBox()
          : GestureDetector(
              onTap: () => setState(() {
                _isMenuActive = !_isMenuActive;
              }),
              child: Container(
                height: _screenHeight,
                width: _screenWidth,
                child: RotatedBox(
                  quarterTurns: 1,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Opacity(
                      opacity: 0.3,
                      child: Image.asset(
                        'assets/img/grunge.png',
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

}
