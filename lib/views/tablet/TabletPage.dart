import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class TabletPage extends StatefulWidget {
  @override
  _TabletPageState createState() => _TabletPageState();
}

class _TabletPageState extends State<TabletPage> with TickerProviderStateMixin {
  PageController _pageController;
  double _activePage = 1;

  bool _isMenuActive;
  void _pageChanger(int page) {
    setState(() {
      _activePage = page.toDouble();
      _pageController.jumpToPage(page - 1);
    });
  }

  @override
  void initState() {
    super.initState();

    _isMenuActive = false;

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

    double _screenRatio = _screenHeight / _screenWidth;
    bool _portrait = _screenRatio > 1 ? true : false;

    //----------------------- Grunge Overlay -----------------------//
    Positioned _grunge() {
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

    //----------------------- Menu -----------------------//
    Positioned _menu() {
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
              : Container(
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
                        flex: _portrait ? 8 : 9,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                _pageChanger(1);
                                _isMenuActive = false;
                              },
                              child: TextResponsive(
                                "Home.",
                                style: TextStyle(
                                  fontSize: _portrait ? 100 : 80,
                                  letterSpacing: -0.75,
                                  fontWeight: FontWeight.w700,
                                  color: _activePage == 1
                                      ? Colors.white
                                      : Colors.white38,
                                ),
                              ),
                            ),
                            SizedBoxResponsive(height: _portrait ? 50 : 25),
                            InkWell(
                              onTap: () {
                                _pageChanger(2);
                                _isMenuActive = false;
                              },
                              child: TextResponsive(
                                "Kontak.",
                                style: TextStyle(
                                  fontSize: _portrait ? 100 : 80,
                                  letterSpacing: -0.75,
                                  fontWeight: FontWeight.w700,
                                  color: _activePage == 2
                                      ? Colors.white
                                      : Colors.white38,
                                ),
                              ),
                            ),
                            SizedBoxResponsive(height: _portrait ? 50 : 25),
                            InkWell(
                              onTap: () {
                                _launchYT();
                              },
                              child: TextResponsive(
                                "VideoDakwah.",
                                style: TextStyle(
                                  fontSize: _portrait ? 100 : 80,
                                  letterSpacing: -0.75,
                                  fontWeight: FontWeight.w700,
                                  color: _activePage == 3
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
                        flex: _portrait ? 1 : 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              iconSize: _portrait ? 30 : 50,
                              icon: Image.asset(
                                "assets/icon/facebook.png",
                              ),
                              onPressed: () => _launchFB(),
                            ),
                            IconButton(
                              iconSize: _portrait ? 32 : 64,
                              icon: Image.asset(
                                "assets/icon/instagram.png",
                              ),
                              onPressed: () => _launchIG(),
                            ),
                            IconButton(
                              iconSize: _portrait ? 44 : 88,
                              icon: Image.asset(
                                "assets/icon/youtube.png",
                              ),
                              onPressed: () => _launchYT(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      );
    }

    Stack _portraitView() {
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

          //----------------------- Page Content -----------------------//
          PageView(
            controller: _pageController,
            children: <Widget>[
              Container(
                height: _screenHeight,
                width: _screenWidth,
                alignment: Alignment.center,
                child: Container(
                  width: _screenWidth * 0.8,
                  child: Image.asset("assets/img/center.png"),
                ),
              ),
              Container(
                height: _screenHeight,
                width: _screenWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //----------------------- Title -----------------------//
                    TextResponsive(
                      "DAKWAH ANDA\nINGIN DILIPUT?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.75,
                        fontSize: 150,
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
                        fontSize: 80,
                        letterSpacing: -0.75,
                      ),
                    ),

                    //----------------------- Phone -----------------------//
                    ContainerResponsive(
                      height: 90,
                      width: 1100,
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(
                        vertical: 100,
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
                            width: 40,
                          ),
                          SizedBoxResponsive(width: 40),
                          TextResponsive(
                            "+62.816.197.4846",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 100,
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
                        fontSize: 75,
                        letterSpacing: -0.75,
                      ),
                    ),
                    SizedBoxResponsive(
                      height: 10,
                    ),

                    //----------------------- Donasi Subtitle -----------------------//
                    TextResponsive(
                      "Donasi: Rekening BNI syariah\n4 2019 2020 4 a.n. KALAM TV",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 75,
                        letterSpacing: -0.75,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          //----------------------- Footer -----------------------//
          Positioned(
            bottom: 0,
            child: Container(
              child: Column(
                children: <Widget>[
                  //----------------------- Page Indicator -----------------------//
                  Container(
                    width: _screenWidth,
                    margin: EdgeInsets.only(bottom: _screenWidth * 0.035),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AnimatedContainer(
                          height: _screenWidth * 0.015,
                          width: _activePage == 1
                              ? _screenWidth * 0.015 * 5
                              : _screenWidth * 0.015,
                          duration: Duration(milliseconds: 400),
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: _activePage == 1
                                ? Theme.of(context).secondaryHeaderColor
                                : Theme.of(context)
                                    .secondaryHeaderColor
                                    .withOpacity(0.6),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        AnimatedContainer(
                          height: _screenWidth * 0.015,
                          width: _activePage != 1
                              ? _screenWidth * 0.015 * 5
                              : _screenWidth * 0.015,
                          duration: Duration(milliseconds: 400),
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: _activePage != 1
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
                  //----------------------- Hadits -----------------------//
                  Container(
                    height: _screenWidth * 0.065,
                    width: _screenWidth,
                    margin: EdgeInsets.only(
                      bottom: _screenWidth * 0.05,
                    ),
                    child: AutoSizeText(
                      "“sebaik-baik manusia adalah yang \n belajar al qur’an dan mengajarkannya”"
                          .toUpperCase(),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

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
          _grunge(),
          _menu(),
          // ------------ MENU ------------ //

          //----------------------- Header -----------------------//
          Positioned(
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
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    SingleChildScrollView _landscapeView() {
      return SingleChildScrollView(
        child: Container(
          height: _screenWidth,
          width: _screenWidth,
          child: Stack(
            children: <Widget>[
              //----------------------- Background -----------------------//
              Positioned(
                child: Container(
                  height: _screenWidth,
                  width: _screenWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                child: Container(
                  height: _screenWidth,
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
                  height: _screenWidth,
                  width: _screenWidth,
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

              //----------------------- Page Content -----------------------//
              PageView(
                controller: _pageController,
                children: <Widget>[
                  //----------------------- Pejwan -----------------------//
                  Container(
                    height: _screenWidth,
                    width: _screenWidth,
                    alignment: Alignment.center,
                    child: Container(
                      width: _screenWidth * 0.8,
                      child: Image.asset("assets/img/center.png"),
                    ),
                  ),
                  //----------------------- Pejtu -----------------------//
                  Container(
                    height: _screenWidth,
                    width: _screenWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        //----------------------- Title -----------------------//
                        TextResponsive(
                          "DAKWAH ANDA\nINGIN DILIPUT?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.75,
                            fontSize: 120,
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
                            fontSize: 65,
                            letterSpacing: -0.75,
                          ),
                        ),

                        //----------------------- Phone -----------------------//
                        ContainerResponsive(
                          height: 160,
                          width: 950,
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(
                            vertical: 60,
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
                                width: 35,
                              ),
                              SizedBoxResponsive(width: 40),
                              TextResponsive(
                                "+62.816.197.4846",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 90,
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
                            fontSize: 60,
                            letterSpacing: -0.75,
                          ),
                        ),
                        SizedBoxResponsive(
                          height: 10,
                        ),

                        //----------------------- Donasi Subtitle -----------------------//
                        TextResponsive(
                          "Donasi: Rekening BNI syariah\n4 2019 2020 4 a.n. KALAM TV",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 60,
                            letterSpacing: -0.75,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              //----------------------- Footer -----------------------//
              Positioned(
                bottom: 0,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      //----------------------- Page Indicator -----------------------//
                      Container(
                        width: _screenWidth,
                        margin: EdgeInsets.only(bottom: _screenWidth * 0.035),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            AnimatedContainer(
                              height: _screenWidth * 0.015,
                              width: _activePage == 1
                                  ? _screenWidth * 0.015 * 5
                                  : _screenWidth * 0.015,
                              duration: Duration(milliseconds: 400),
                              margin: EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                color: _activePage == 1
                                    ? Theme.of(context).secondaryHeaderColor
                                    : Theme.of(context)
                                        .secondaryHeaderColor
                                        .withOpacity(0.6),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            AnimatedContainer(
                              height: _screenWidth * 0.015,
                              width: _activePage != 1
                                  ? _screenWidth * 0.015 * 5
                                  : _screenWidth * 0.015,
                              duration: Duration(milliseconds: 400),
                              margin: EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                color: _activePage != 1
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
                      //----------------------- Hadits -----------------------//
                      Container(
                        height: _screenWidth * 0.065,
                        width: _screenWidth,
                        margin: EdgeInsets.only(
                          bottom: _screenWidth * 0.05,
                        ),
                        child: AutoSizeText(
                          "“sebaik-baik manusia adalah yang \n belajar al qur’an dan mengajarkannya”"
                              .toUpperCase(),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).secondaryHeaderColor,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

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
              _grunge(),
              _menu(),
              // ------------ MENU ------------ //

              //----------------------- Header -----------------------//
              Positioned(
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
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
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
      child: _portrait ? _portraitView() : _landscapeView(),
    );
  }
}
