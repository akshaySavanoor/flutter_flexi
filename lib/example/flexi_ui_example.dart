import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import '../src/flexi_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) {
          return OrientationBuilder(
            builder: (context, orientation) {
              // If you are building a responsive web targeting web design (large device),
              // change targetDevice = TargetDeviceType.phonePortrait to TargetDeviceType.desktop
              ScreenAdaptiveConfig.init(
                  context: context, orientation: orientation
              );
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: HomeScreen(),
              );
            },
          );
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: responsiveCard(),
      ),
    );
  }

  Widget responsiveCard() {
    return LayoutBuilder(
      builder: (context, constraints) {
        ResponsiveCardConfig().init(
          currentParentWidth: constraints.maxWidth,
          currentParentHeight: constraints.maxHeight,
          targetParentWidth: 300,
          targetParentHeight: 300,
        );
        return Container(
          color: Colors.lightBlue,
          width: const Tuple2(300, 800).aw,
          height: const Tuple2(300, 800).aw,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Adaptive Text",
                style: TextStyle(fontSize: 12.fw),
              ),
              Container(
                color: Colors.blueAccent,
                width: 100.fw,
                height: 60.fh,
                child: Center(
                  child: Container(
                    width: 30.fw,
                    height: 30.fw,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(30.fw),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.orange,
                    width: 50.fw,
                    height: 50.fh,
                  ),
                  Container(
                    color: Colors.red,
                    width: 50.fw,
                    height: 50.fh,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget responsiveText() {
    return Text(
      "Responsive Text",
      style: TextStyle(fontSize: 12.rw),
    );
  }

  Widget adaptiveText() {
    return Text(
      "Adaptive Text",
      style: TextStyle(fontSize: const Tuple2(12, 40).aw),
    );
  }

  Widget adaptiveWidget() {
    return Center(
      child: Container(
        width: const Tuple2(100, 500).aw,
        height: const Tuple2(100, 500).aw,
        color: Colors.green,
      ),
    );
  }

  Widget adaptiveWidget2() {
    return Center(
      child: Container(
        width: const Tuple2(20, 80).d,
        height: const Tuple2(20, 80).d,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(const Tuple2(20, 80).d),
        ),
      ),
    );
  }

  Widget deviceSpecificWidget() {
    return Center(
      child: ScreenAdaptiveConfig.instance!.isPhonePortrait
          ? const Text("Small Screen")
          : const Text("Large Screen"),
    );
  }

  Widget halfScreenWidth() {
    return Container(
      width: 0.5.w,
      height: 40,
      color: Colors.red,
    );
  }

  Widget halfScreenHeight() {
    return Container(
      width: 400,
      height: 0.5.h,
      color: Colors.red,
    );
  }
}
