import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class TabletHeaderFooter extends StatelessWidget {
  const TabletHeaderFooter({
    Key key,
    @required this.activePage,
    @required this.child,
  }) : super(key: key);

  final double activePage;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // double _screenHeight = MediaQuery.of(context).size.height;
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
                        width: activePage == 1
                            ? _screenWidth * 0.015 * 5
                            : _screenWidth * 0.015,
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
                        height: _screenWidth * 0.015,
                        width: activePage != 1
                            ? _screenWidth * 0.015 * 5
                            : _screenWidth * 0.015,
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
      ],
    );
  }
}
