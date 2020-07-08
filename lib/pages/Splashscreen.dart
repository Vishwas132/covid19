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
    Future.delayed(Duration(seconds: 5), r.route(context));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black12,
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: Colors.grey,
                width: 2,
              ),
              image: DecorationImage(
                image: AssetImage('images/image.jpg'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
