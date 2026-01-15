import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:looped_contents_view/looped_contents_view.dart';

void main() {
  testWidgets('LoopedContentsView builds without error', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: LoopedContentsView(
            itemCount: 3,
            itemBuilder: _itemBuilder,
          ),
        ),
      ),
    );

    expect(find.text('item 0'), findsOneWidget);
  });
}

Widget _itemBuilder(BuildContext context, int index) {
  return Center(
    child: Text('item $index'),
  );
}
