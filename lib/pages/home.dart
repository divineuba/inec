import 'package:flutter/material.dart';
import 'package:myinec/widgets/seach_unit.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          child: Stack(
            children: [
              Container(
                height: size.height * 0.7,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    alignment: Alignment(0, 1),
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/home-bg.png"),
                  ),
                ),
              ),
              Positioned(
                bottom: 80.0,
                width: size.width,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Track Your\n Way to your Polling Unit",
                              style: TextStyle(
                                height: 1.4,
                                fontSize: 30.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      SearchUnit(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
