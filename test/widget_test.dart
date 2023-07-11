// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_widget_tests/main.dart';
import 'package:flutter_widget_tests/todo_list_widget.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(
      items: List<String>.generate(10000, (i) => 'Item $i'),
    ));

    final listFinder = find.byType(Scrollable);
    final itemFinder = find.byKey(const ValueKey('item_50_text'));

    // scroll until the item to be found appears
    await tester.scrollUntilVisible(
      itemFinder,
      500.0,
      scrollable: listFinder,
    );

    // Verify that the item contains the correct text
    expect(itemFinder, findsOneWidget);
  });

  // todo list tests
  testWidgets('Add and remove a todo', (tester) async {
    // build the widget
    await tester.pumpWidget(const TodoList());

    // Enter 'hi' into the text field
    await tester.enterText(find.byType(TextField), 'hi');

    // ensure tapping a button adds the todo
    // tap the add button
    await tester.tap(find.byType(FloatingActionButton));

    // rebuild the widget after the state has changed
    await tester.pump();

    // expect to find the item on screen
    expect(find.text('hi'), findsOneWidget);

    // ensure swipe to dismiss removes the todo
    await tester.drag(find.byType(Dismissible), const Offset(500, 0));

    // build the widget until the dismiss animation ends
    await tester.pumpAndSettle();

    // ensure that the item is no loner on screen
    expect(find.text('hi'), findsNothing);
  });
}
