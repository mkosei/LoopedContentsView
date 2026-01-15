<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->
# LoopedContentsView

A Flutter widget for vertically or horizontally looping content with auto-scroll.

## Features
- Vertical or horizontal scroll
- Auto-play with customizable interval
- Infinite loop

## Usage

```dart
LoopedContentsView(
  itemCount: 5,
  scrollDirection: Axis.horizontal,
  autoPlay: true,
  autoPlayInterval: Duration(seconds: 2),
  itemBuilder: (context, index) {
    return Container(
      color: Colors.primaries[index % Colors.primaries.length],
      child: Center(child: Text('Item $index')),
    );
  },
)
```

### Auto Play Control

autoPlay will pause automatically when user interacts with the view
and resume when the interaction ends.
