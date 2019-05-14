import 'package:flutter/material.dart';

class ReaderAnimation extends StatelessWidget {
  Key globalKey;
  AnimationController animationController;
  Animation animation;
  double textWidth;
  String textString;
  double aniWidth;
  bool textVisibilty;
  AlignmentDirectional alignmentDirectional;

  ReaderAnimation(
      {Key key,
      this.globalKey,
      this.animationController,
      this.animation,
      this.textWidth,
      this.textString,
      this.aniWidth,
      this.textVisibilty,
      this.alignmentDirectional});

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: globalKey,
      alignment: AlignmentDirectional.topStart,
      children: <Widget>[
        Container(
            padding: EdgeInsets.symmetric(horizontal: 3.0),
            child: Text(
              textString,
              style: TextStyle(fontSize: 22),
            )),
        AnimatedBuilder(
            animation: animationController,
            builder: (BuildContext context, Widget child) {
              return Positioned(
                left: animation.value * textWidth,
                child: Visibility(
                  visible: textVisibilty,
                  child: Container(
                    width: textWidth * 0.5,
                    child: Stack(
                      alignment: alignmentDirectional,
                      children: <Widget>[
                        AnimatedContainer(
                          duration: Duration(milliseconds: 100),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: AlignmentDirectional.centerEnd,
                                  end: AlignmentDirectional.centerStart,
                                  stops: [
                                0.1,
                                1.0
                              ],
                                  colors: [
                                Colors.blueAccent[100],
                                Colors.white70
                              ])),
                          width: aniWidth,
                          height: 50,
                        ),
                        Container(
                          width: 3,
                          height: 50.0,
                          color: Colors.grey[400],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ],
    );
  }
}
