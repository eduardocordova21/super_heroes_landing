import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:super_heroes_landing/main.dart';

void main() {
  testWidgets('Deve validar se o icone de carregamento circular está sendo mostrado', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byKey(const Key("circularProgress")),findsOneWidget);
  });

  testWidgets('Deve validar se o nome da página está sendo mostrado', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Super Hero Landing'), findsOneWidget);
  });
}
