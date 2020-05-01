import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class PhoneHeaderFooter extends StatelessWidget {
  const PhoneHeaderFooter({
    Key key,
    @required this.activePage,
    @required this.child,
  }) : super(key: key);

  final double activePage;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: <Widget>[
        child,
        //----------------------- Header -----------------------//
        Positioned(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: _screenWidth * 0.06,
              vertical: _screenWidth * 0.06,
            ),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Image.asset(
                    'assets/icon/hamburger-blue.png',
                  ),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {},
                ),
                Expanded(child: SizedBox()),
                IconButton(
                  icon: Image.asset(
                    'assets/icon/play-blue.png',
                  ),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),

        //----------------------- Footer -----------------------//
        Positioned(
          child: Container(
            height: _screenHeight,
            width: _screenWidth,
            child: Column(
              children: <Widget>[
                //----------------------- Page Indicator -----------------------//
                Expanded(flex: 3+12+28,child: SizedBox()),
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
                          width: activePage == 1
                              ? _screenWidth * 0.017
                              : _screenWidth * 0.017 * 3,
                          duration: Duration(milliseconds: 400),
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: activePage == 1
                                ? Theme.of(context).secondaryHeaderColor
                                : Theme.of(context)
                                    .secondaryHeaderColor
                                    .withOpacity(0.6),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        AnimatedContainer(
                          height: _screenWidth * 0.017,
                          width: activePage != 1
                              ? _screenWidth * 0.017
                              : _screenWidth * 0.017 * 3,
                          duration: Duration(milliseconds: 400),
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: activePage != 1
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
                    padding:
                        EdgeInsets.symmetric(horizontal: _screenWidth * 0.05),
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
        ),
      ],
    );
  }
}
