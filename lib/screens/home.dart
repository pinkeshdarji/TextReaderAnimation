import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  Animation<double> animation;
  AnimationController animationController;
  double _aniWidth = 8.0;
  AlignmentDirectional _alignm1 = AlignmentDirectional.centerStart;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    animation = Tween(begin: 0.0, end: 0.9).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn,
    ))
      ..addStatusListener(handler);
  }

  void handler(status) {
    if (status == AnimationStatus.forward) {
      setState(() {
        Future.delayed(Duration(milliseconds: 200), () {
          _aniWidth = 35.0;
          _alignm1 = AlignmentDirectional.centerEnd;
        });
      });
    } else if (status == AnimationStatus.completed) {
      setState(() {
        _aniWidth = 8.0;
      });
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    animationController.forward();

    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: <Widget>[
          Center(
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  'Text',
                  style: TextStyle(fontSize: 40),
                ),
              ),
            ),
          ),
          AnimatedBuilder(
              animation: animationController,
              builder: (BuildContext context, Widget child) {
                return Positioned(
                  left: animation.value * width,
                  child: Container(
                    width: 35,
                    child: Stack(
                      alignment: _alignm1,
                      children: <Widget>[
                        AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: AlignmentDirectional.centerEnd,
                                  end: AlignmentDirectional.centerStart,
                                  stops: [0.1, 1.0],
                                  colors: [Colors.grey[400], Colors.white70])),
                          width: _aniWidth,
                          height: 50,
                        ),
                        Container(
                          width: 8,
                          height: 50.0,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
