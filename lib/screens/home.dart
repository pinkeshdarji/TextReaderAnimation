import 'package:flutter/material.dart';

//creating Key for red panel
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
        _aniWidth = _text2Width * 0.3;
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

  @override
  void dispose() {
    animationController1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final double width = MediaQuery.of(context).size.width;

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
            Stack(
              key: _keyT1,
              alignment: AlignmentDirectional.topStart,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 3.0),
                    child: Text(
                      'Textttttttttttttt',
                      style: TextStyle(fontSize: 22),
                    )),
                AnimatedBuilder(
                    animation: animationController1,
                    builder: (BuildContext context, Widget child) {
                      return Positioned(
                        left: animation1.value * _text1Width,
                        child: Visibility(
                          visible: _text1Visiblity,
                          child: Container(
                            width: _text1Width * 0.5,
                            child: Stack(
                              alignment: _alignm1,
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
                                  width: _aniWidth,
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
            ),
            Stack(
              key: _keyT2,
              alignment: AlignmentDirectional.topStart,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 3.0),
                    child: Text(
                      'Reader',
                      style: TextStyle(fontSize: 22),
                    )),
                AnimatedBuilder(
                    animation: animationController2,
                    builder: (BuildContext context, Widget child) {
                      return Positioned(
                        left: animation2.value * _text2Width,
                        child: Visibility(
                          visible: _text2Visiblity,
                          child: Container(
                            width: _text2Width * 0.5,
                            child: Stack(
                              alignment: _alignm1,
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
                                  width: _aniWidth,
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
            ),
            Stack(
              key: _keyT3,
              alignment: AlignmentDirectional.topStart,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 3.0),
                    child: Text(
                      'Animation',
                      style: TextStyle(fontSize: 22),
                    )),
                AnimatedBuilder(
                    animation: animationController3,
                    builder: (BuildContext context, Widget child) {
                      return Positioned(
                        left: animation3.value * _text3Width,
                        child: Visibility(
                          visible: _text3Visiblity,
                          child: Container(
                            width: _text3Width * 0.5,
                            child: Stack(
                              alignment: _alignm1,
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
                                  width: _aniWidth,
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
            ),
          ],
        ),
      ),
    );
  }
}
