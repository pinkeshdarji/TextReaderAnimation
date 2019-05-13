import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  Animation<double> animation;
  Animation<double> widthAnimation;
  AnimationController animationController;
  AlignmentDirectional _defaultPlace = AlignmentDirectional.topStart;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 300));

    animation = Tween(begin: -0.5, end: 0.0).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.elasticIn,
    ))
      ..addStatusListener(handler);

    widthAnimation = Tween(begin: 8.0, end: 100.0).animate(animationController)
      //..addStatusListener(handler);
  }

  void handler(status) {
    if (status == AnimationStatus.completed) {
      animation.removeStatusListener(handler);
      widthAnimation.removeStatusListener(handler);
      animationController.reset();
      animation = Tween(begin: 0.0, end: 0.5).animate(CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOut,
      ))
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {}
        });

      widthAnimation = Tween(begin: 100.0, end: 8.0).animate(animationController)


      animationController.forward();
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
        children: <Widget>[
          Container(
            color: Colors.grey,
            height: 100,
          ),
          AnimatedBuilder(
              animation: animationController,
              builder: (BuildContext context, Widget child) {
                print(animation.value);
                return Transform(
                  transform: Matrix4.translationValues(
                      animation.value * width, 0.0, 0.0),
                  child: new Center(
                      child: Container(
                    width: widthAnimation.value,
                    height: 100.0,
                    color: Colors.red,
                  )),
                );
              })
        ],
      ),
    );
  }
}
