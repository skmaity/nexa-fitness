import 'dart:ui';

import 'package:flutter/material.dart';

class FrostedGlassColor extends StatelessWidget {
  const FrostedGlassColor({
    super.key,
    this.thehight,
    this.thewidth,
    this.thechild,
    this.thecolors,
  });

  final thewidth;
  final thechild;
  final thehight;
  final thecolors;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          height: thehight,
          width: thewidth,
          color: Colors.transparent,
          child: Stack(
            children: [
              //Blurr effect
              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 4.0,
                  sigmaY: 4.0,
                ),
                child: Container(),
              ),

              //gradient effect

              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.13),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: thecolors ?? Colors.white,
                      // Colors.white.withOpacity(0.15),
                      // Colors.white.withOpacity(0.05)
                    )),
              ),
              //child
              Center(
                child: thechild,
              )
            ],
          ),
        ));
  }
}
