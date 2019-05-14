import 'package:flutter/material.dart';

import 'reader_animation.dart';

GlobalKey _keyT1 = GlobalKey();
GlobalKey _keyT2 = GlobalKey();
GlobalKey _keyT3 = GlobalKey();

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  Animation<double> animation1;
  Animation<double> animation2;
  Animation<double> animation3;
  AnimationController animationController1;
  AnimationController animationController2;
  AnimationController animationController3;
  double _aniWidth = 8.0;
  AlignmentDirectional _alignm1 = AlignmentDirectional.centerStart;
  double _text1Width = 0.0;
  double _text2Width = 0.0;
  double _text3Width = 0.0;
  bool _text1Visiblity = false;
  bool _text2Visiblity = false;
  bool _text3Visiblity = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);

    animationController1 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animationController2 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animationController3 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    animation1 = Tween(begin: 0.0, end: 0.5).animate(CurvedAnimation(
      parent: animationController1,
      curve: Curves.fastOutSlowIn,
    ))
      ..addStatusListener(handler1);

    animation2 = Tween(begin: 0.0, end: 0.5).animate(CurvedAnimation(
      parent: animationController2,
      curve: Curves.fastOutSlowIn,
    ))
      ..addStatusListener(handler2);

    animation3 = Tween(begin: 0.0, end: 0.5).animate(CurvedAnimation(
      parent: animationController3,
      curve: Curves.fastOutSlowIn,
    ))
      ..addStatusListener(handler3);
  }

  _afterLayout(_) {
    _getSizes();
  }

  _getSizes() {
    _text1Width = _keyT1.currentContext.size.width;
    _text2Width = _keyT2.currentContext.size.width;
    _text3Width = _keyT3.currentContext.size.width;
    print("width of Red: $_text1Width $_text2Width $_text3Width");
    animationController1.forward();
  }

  void handler1(status) {
    if (status == AnimationStatus.forward) {
      setState(() {
        _text1Visiblity = true;
        _aniWidth = _text1Width * 0.3;
        _alignm1 = AlignmentDirectional.centerEnd;
      });
    } else if (status == AnimationStatus.completed) {
      setState(() {
        _text1Visiblity = false;
        _aniWidth = 3.0;
        animationController1.reset();
        animationController2.forward();
      });
    }
  }

  void handler2(status) {
    if (status == AnimationStatus.forward) {
      setState(() {
        _text2Visiblity = true;
        _aniWidth = _text3Width * 0.3;
        _alignm1 = AlignmentDirectional.centerEnd;
      });
    } else if (status == AnimationStatus.completed) {
      setState(() {
        _text2Visiblity = false;
        _aniWidth = 3.0;
        animationController2.reset();
        animationController3.forward();
      });
    }
  }

  void handler3(status) {
    if (status == AnimationStatus.forward) {
      setState(() {
        _text3Visiblity = true;
        _aniWidth = 35.0;
        _alignm1 = AlignmentDirectional.centerEnd;
      });
    } else if (status == AnimationStatus.completed) {
      setState(() {
        _text3Visiblity = false;
        _aniWidth = 3.0;
        animationController3.reset();
        animationController1.forward();
      });
    }
  }

  @override
  void dispose() {
    animationController1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Animation Experiment',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        margin: EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            ReaderAnimation(
              globalKey: _keyT1,
              animationController: animationController1,
              animation: animation1,
              alignmentDirectional: _alignm1,
              aniWidth: _aniWidth,
              textString: "Text",
              textVisibilty: _text1Visiblity,
              textWidth: _text1Width,
            ),
            ReaderAnimation(
              globalKey: _keyT2,
              animationController: animationController2,
              animation: animation2,
              alignmentDirectional: _alignm1,
              aniWidth: _aniWidth,
              textString: "Reader",
              textVisibilty: _text2Visiblity,
              textWidth: _text2Width,
            ),
            ReaderAnimation(
              globalKey: _keyT3,
              animationController: animationController3,
              animation: animation3,
              alignmentDirectional: _alignm1,
              aniWidth: _aniWidth,
              textString: "Animation",
              textVisibilty: _text3Visiblity,
              textWidth: _text3Width,
            ),
          ],
        ),
      ),
    );
  }
}
