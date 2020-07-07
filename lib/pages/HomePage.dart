import 'package:covid19/objects/Dataloader.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  Router r = Router();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 10), r.route(context));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Image(
          image: AssetImage('images/image.jpg'),
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
