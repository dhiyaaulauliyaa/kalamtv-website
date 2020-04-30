import 'package:flutter/material.dart';

class MobilePortraitPage extends StatefulWidget {
  @override
  _MobilePortraitPageState createState() => _MobilePortraitPageState();
}

class _MobilePortraitPageState extends State<MobilePortraitPage> {
  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: <Widget>[
        Positioned(
          bottom: 0,
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: _screenWidth * 0.06,
                  color: Colors.blue,
                  child: Text(
                    "“sebaik-baik manusia adalah yang belajar al qur’an dan mengajarkannya”"
                        .toUpperCase(),
                    style: TextStyle(
                      color: Theme.of(context).secondaryHeaderColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                SizedBox(
                  width: _screenWidth,
                  height: _screenWidth * 0.09,
                )
              ],
            ),
          ),
        ),
        Positioned(
          child: PageView(
            children: <Widget>[
              Container(
                height: _screenHeight,
                width: _screenWidth,
                child: Text('1'),
              ),
              Container(
                height: _screenHeight,
                width: _screenWidth,
                color: Colors.teal.withOpacity(0.5),
                child: Text('2'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
