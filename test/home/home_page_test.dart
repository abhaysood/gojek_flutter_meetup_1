import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:meetup/src/home/home_page.dart';
import 'package:semantic_announcement_tester/semantic_announcement_tester.dart';

void main() {
  group(("Demo 1"), () {
    testWidgets("triggers onTap callback", (tester) async {
      bool tapped = false;
      final widget = MaterialApp(
        home: Scaffold(
          body: ButtonDemo1(
            onTap: () => tapped = true,
          ),
        ),
      );

      await tester.pumpWidget(widget);
      await tester.tap(find.byType(ButtonDemo1));
      expect(tapped, isTrue);
    });
  });

  group(("Demo 2"), () {
    testGoldens("renders hello world", (tester) async {
      const widget = Scaffold(
        body: HomePageDemo2(),
      );
      final builder = DeviceBuilder()
        ..addScenario(
          widget: widget,
          name: 'demo_2',
        );
      await tester.pumpDeviceBuilder(builder);

      await screenMatchesGolden(tester, 'demo_2');
    });
  });

  group(("Demo 3"), () {
    testGoldens("without greeting", (tester) async {
      const widget = Scaffold(
        body: HomePageDemo3(),
      );
      final builder = DeviceBuilder()
        ..addScenario(
          widget: widget,
          name: 'demo_3_without_greeting',
        );
      await tester.pumpDeviceBuilder(builder);

      await screenMatchesGolden(tester, 'demo_3_without_greeting');
    });

    testGoldens("with greeting", (tester) async {
      const widget = Scaffold(
        body: HomePageDemo3(),
      );
      final builder = DeviceBuilder()
        ..addScenario(
          widget: widget,
          name: 'demo_3_with_greeting',
        );
      await tester.pumpDeviceBuilder(builder);

      // tap the widget and wait for animation to end
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump(const Duration(seconds: 1));

      await screenMatchesGolden(tester, 'demo_3_with_greeting');
    });
  });

  group(("Demo 4"), () {
    testWidgets("overrides semantics label when order is received",
        (tester) async {
      const widget = MaterialApp(
        home: Scaffold(
          body: HomePageDemo4(),
        ),
      );
      await tester.pumpWidget(widget);

      await tester.pump(const Duration(seconds: 5));

      expect(
        find.bySemanticsLabel("${order.item} for ${order.customerName}"),
        findsOneWidget,
      );
    });

    testWidgets("makes semantic announcement on order received",
        (tester) async {
      final mockAnnouncements = MockSemanticAnnouncements(tester);
      const expectedAnnouncement =
          AnnounceSemanticsEvent("New order received", TextDirection.ltr);
      const widget = MaterialApp(
        home: Scaffold(
          body: HomePageDemo4(),
        ),
      );
      await tester.pumpWidget(widget);

      await tester.pump(const Duration(seconds: 5));

      expect(
        mockAnnouncements.announcements,
        hasOneAnnouncement(expectedAnnouncement),
      );
    });
  });
}
