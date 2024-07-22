# flexi_ui

If you have struggled with creating platform-specific UIs in Flutter, use flexi_ui. Our package
addresses the issues found in the `screen_util` package. While `screen_util` is great for creating
responsive UIs in Flutter, it falls short when targeting multiple Figma designs, such as small
screens and large screens. flexi_ui solves this problem by allowing you to provide two values for
small and large screens, and it will calculate the rest for you.

You can target just small screens using responsive extensions, which will automatically adapt to
large screens. Similarly, if you target large screens, you can also cater to small screens by
providing the target device while initializing flexi_ui.

If you have a card that should be responsive, you can use `ResponsiveCardConfig`. By providing the
target card width and height, you can create an adaptive container where all elements inside the
card will be responsive using flexible extensions.

Overall, this package is used for creating adaptive designs that will be adaptive for any screen
size.

## Features

- **Responsive Widgets**: Automatically adjust widget sizes based on the screen size.
- **Adaptive Text**: Scale text sizes dynamically.
- **Device-Specific Layouts**: Tailor your UI for different devices like phones, tablets, and
  desktops.
- **Orientation Handling**: Adapt to changes in screen orientation seamlessly.
- **Responsive Card Configuration**: Make entire card components responsive effortlessly.

## Getting Started

To start using flexi_ui, add it to your `pubspec.yaml`:

```yaml
dependencies:
  flexi_ui: ^0.0.4
```

Then, import it in your main Dart code:

```dart
import 'package:flexi_ui/flexi_ui.dart';
```

## Usage

## ScreenAdaptiveConfig
Before you start coding, please note that this package relies entirely on calculations based on
screen size changes. Therefore, do not use ***const*** with this package, except for tuples. If you do, it won't
work properly, as it needs to be triggered whenever Screen size changes.

Here is a simple example to get you started:

```dart
import 'package:flexi_ui/flexi_ui.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) {
          return OrientationBuilder(
            builder: (context, orientation) {
              // Initialize flexi_ui with context and orientation
              // The default values are double designMinWidth = 360 and double designMaxWidth = 1440.
              // You can adjust these values based on your design requirements. Similarly, you can adjust the heights.
              // Although flexi_ui primarily adapts sizes based on width, height adjustments may still be necessary in certain cases, such as for diagonal elements.

              ScreenAdaptiveConfig.init(
                      context: context,
                      orientation: orientation,
                      targetDevice: TargetDeviceType.phonePortrait // Default target device. Only change this if you are creating a responsive design for large screens and targeting small screens.
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: adaptiveText(),
      ),
    );
  }
}
```

In the code below, we use a tuple with two values.
The first value represents the minimum font size for small screens,
while the second value represents the font size for large screens.
Using the aw method will make the font size responsive across other screen sizes.

```dart
Widget adaptiveText() {
  return Text(
    "Adaptive Text",
    style: TextStyle(fontSize: const Tuple2(12, 40).aw),
  );
}
```

To render a device-specific widget, you can do it as follows:

```dart
 Widget deviceSpecificWidget() {
    return Center(
      child: ScreenAdaptiveConfig.instance!.isPhonePortrait
          ? const Text("Small Screen")
          : const Text("Large Screen"),
    );
  }
```
To display a widget based on screen height, use h. For width, use w. For example:

```dart
 Widget halfScreenWidth() {
    return Container(
      width: 0.5.w,
      height: 40,
      color: Colors.red,
    );
  }
```

If you want a widget to be responsive to both height and width, use the diagonal extension.

```dart
 Widget adaptiveWidget2() {
    return Center(
      child: Container(
        width: Tuple2(20, 80).d,
        height: Tuple2(20, 80).d,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(Tuple2(20, 80).d),
        ),
      ),
    );
  }
```
Below is an example of how to create a adaptive widget:

```dart
 Widget adaptiveWidget() {
    return Center(
      child: Container(
        width: Tuple2(100, 500).aw,
        height: Tuple2(100, 500).aw,
        color: Colors.green,
      ),
    );
  }
```

Below is an example of how to create a responsive widget:

```dart
 Widget responsiveText() {
    return Text(
      "Responsive Text",
      style: TextStyle(fontSize: 12.rw),
    );
  }
```
The main difference between adaptive and responsive is that adaptive design is based on two values: target values for small and large screens. In contrast, responsive design relies on a single screen value. By default, responsive design targets small screen sizes, but you can change this during initialization. Typically, you'll use aw for adaptive design, while ah is rarely used unless you need to adjust based on screen height.

## ResponsiveCardConfig

If you have a card with multiple child widgets, you can use `ResponsiveCardConfig`. This requires the currentParentWidth and currentParentHeight, which you can obtain using LayoutBuilder to pass the maxWidth and maxHeight. Additionally, you need to specify the targetParentWidth and targetParentHeight, which represent the target dimensions of the container, for example, a card with a width of 300 and a height of 300.

```dart
LayoutBuilder( builder: (context, constraints) {
        ResponsiveCardConfig().init(
          currentParentWidth: constraints.maxWidth,
          currentParentHeight: constraints.maxHeight,
          targetParentWidth: 300,
          targetParentHeight: 300,
        );
        return Container(
          color: Colors.lightBlue,
          width: 300.rw,
          height: 300.rw,
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
                height: 100.fh,
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
```
You can also use `blockSizeVertical` and `blockSizeHorizontal` to make your screen responsive by manually calculating values based on the block sizes. Similarly, you can use `safeBlocks` from `ScreenAdaptiveConfig`, which provides block sizes by considering safe values (eliminating device paddings). However, we don't actually need these since we have responsive and adaptive extensions.

## Additional information

Find more examples here [Examples](https://github.com/akshaySavanoor/flutter_flexi/blob/master/example/flexi_ui_example.dart)

## Community support

If you have any suggestions or issues, feel free to open an [Issue](https://github.com/akshaySavanoor/flutter_flexi/issues).
If you would like to contribute, feel free to create a [PR](https://github.com/akshaySavanoor/flutter_flexi/pulls).
