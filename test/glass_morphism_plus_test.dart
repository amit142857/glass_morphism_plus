import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glass_morphism_plus/glass_morphism_plus.dart';

void main() {
  group('GlassContainer', () {
    testWidgets('renders default glass container with child', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: GlassContainer(child: Text('Default Glass'))),
        ),
      );

      expect(find.text('Default Glass'), findsOneWidget);
      expect(find.byType(BackdropFilter), findsOneWidget);
      expect(find.byType(ClipRRect), findsOneWidget);
    });

    testWidgets('supports isBlurEnabled false for performance', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: GlassContainer(isBlurEnabled: false, child: Text('No Blur')),
          ),
        ),
      );

      expect(find.text('No Blur'), findsOneWidget);
      expect(find.byType(BackdropFilter), findsNothing);
    });

    testWidgets('supports BoxShape.circle and ClipOval', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: GlassContainer(
              shape: BoxShape.circle,
              width: 100,
              height: 100,
              child: Text('Circle Glass'),
            ),
          ),
        ),
      );

      expect(find.text('Circle Glass'), findsOneWidget);
      expect(find.byType(ClipOval), findsOneWidget);
    });

    testWidgets('supports custom non-uniform borderRadius', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: GlassContainer(
              customBorderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              child: Text('Asymmetric Glass'),
            ),
          ),
        ),
      );

      expect(find.text('Asymmetric Glass'), findsOneWidget);
      final clipRRect = tester.widget<ClipRRect>(find.byType(ClipRRect));
      expect(
        clipRRect.borderRadius,
        const BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      );
    });

    testWidgets('supports custom borderGradient via GlassBorderPainter', (
      tester,
    ) async {
      const gradient = LinearGradient(colors: [Colors.red, Colors.blue]);
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: GlassContainer(
              borderGradient: gradient,
              borderWidth: 2.0,
              child: Text('Gradient Border'),
            ),
          ),
        ),
      );

      expect(find.text('Gradient Border'), findsOneWidget);
      expect(
        find.byWidgetPredicate(
          (w) => w is CustomPaint && w.foregroundPainter is GlassBorderPainter,
        ),
        findsOneWidget,
      );
    });

    testWidgets('supports custom background gradient and solid fill', (
      tester,
    ) async {
      const bgGradient = LinearGradient(colors: [Colors.purple, Colors.amber]);
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                GlassContainer(
                  gradient: bgGradient,
                  child: Text('Gradient BG'),
                ),
                GlassContainer(
                  useDefaultGradient: false,
                  color: Colors.green,
                  opacity: 0.5,
                  child: Text('Solid Translucent BG'),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Gradient BG'), findsOneWidget);
      expect(find.text('Solid Translucent BG'), findsOneWidget);
    });

    testWidgets('supports directional blur blurX and blurY', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: GlassContainer(
              blurX: 25.0,
              blurY: 5.0,
              child: Text('Directional Blur'),
            ),
          ),
        ),
      );

      expect(find.text('Directional Blur'), findsOneWidget);
      final backdrop = tester.widget<BackdropFilter>(
        find.byType(BackdropFilter),
      );
      final blurFilter = backdrop.filter;
      expect(blurFilter.toString(), contains('25.0, 5.0'));
    });

    testWidgets('handles interactive gestures onTap', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassContainer(
              onTap: () => tapped = true,
              child: const Text('Tap Me'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Tap Me'));
      await tester.pump();
      expect(tapped, isTrue);
    });

    testWidgets('supports elevation and shadowColor', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: GlassContainer(
              elevation: 8.0,
              shadowColor: Colors.deepPurple,
              child: Text('Elevated Glass'),
            ),
          ),
        ),
      );

      expect(find.text('Elevated Glass'), findsOneWidget);
    });
  });

  group('GlassTheme', () {
    testWidgets('descendants inherit styling from GlassTheme', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: GlassTheme(
              data: GlassThemeData(
                blur: 35.0,
                opacity: 0.3,
                borderRadius: 28.0,
                color: Colors.cyan,
              ),
              child: GlassContainer(child: Text('Themed Glass')),
            ),
          ),
        ),
      );

      expect(find.text('Themed Glass'), findsOneWidget);
      final clipRRect = tester.widget<ClipRRect>(find.byType(ClipRRect));
      expect(clipRRect.borderRadius, BorderRadius.circular(28.0));
      final backdrop = tester.widget<BackdropFilter>(
        find.byType(BackdropFilter),
      );
      expect(backdrop.filter.toString(), contains('35.0, 35.0'));
    });
  });

  group('GlassCard', () {
    testWidgets('renders structured title, subtitle, leading, and trailing', (
      tester,
    ) async {
      var cardTapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassCard(
              leading: const Icon(Icons.star),
              title: const Text('Card Title'),
              subtitle: const Text('Card Subtitle'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () => cardTapped = true,
            ),
          ),
        ),
      );

      expect(find.text('Card Title'), findsOneWidget);
      expect(find.text('Card Subtitle'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);

      await tester.tap(find.text('Card Title'));
      await tester.pump();
      expect(cardTapped, isTrue);
    });
  });

  group('GlassButton & GlassIconButton', () {
    testWidgets(
      'GlassButton renders label, icon, and handles tap and loading',
      (tester) async {
        var buttonPressed = false;
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  GlassButton(
                    icon: const Icon(Icons.send),
                    label: const Text('Send'),
                    onPressed: () => buttonPressed = true,
                  ),
                  GlassButton(
                    isLoading: true,
                    label: const Text('Loading'),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        );

        expect(find.text('Send'), findsOneWidget);
        expect(find.byIcon(Icons.send), findsOneWidget);
        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        await tester.tap(find.text('Send'));
        await tester.pump();
        expect(buttonPressed, isTrue);
      },
    );

    testWidgets('GlassIconButton renders and triggers onPressed', (
      tester,
    ) async {
      var iconPressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassIconButton(
              icon: const Icon(Icons.favorite),
              tooltip: 'Like',
              onPressed: () => iconPressed = true,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.favorite), findsOneWidget);
      await tester.tap(find.byIcon(Icons.favorite));
      await tester.pump();
      expect(iconPressed, isTrue);
    });
  });

  group('GlassTextField', () {
    testWidgets('renders input, handles typing and focus', (tester) async {
      final controller = TextEditingController();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlassTextField(
              controller: controller,
              hintText: 'Enter name',
              prefixIcon: const Icon(Icons.person),
            ),
          ),
        ),
      );

      expect(find.text('Enter name'), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'Flutter Dev');
      await tester.pump();
      expect(controller.text, 'Flutter Dev');
    });
  });

  group('GlassAppBar', () {
    testWidgets('renders frosted app bar with title and actions', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: GlassAppBar(
              title: Text('Glass Navigation'),
              actions: [Icon(Icons.settings)],
            ),
            body: Center(child: Text('Content')),
          ),
        ),
      );

      expect(find.text('Glass Navigation'), findsOneWidget);
      expect(find.byIcon(Icons.settings), findsOneWidget);
    });
  });

  group('GlassListTile & GlassDivider', () {
    testWidgets('renders GlassListTile and GlassDivider', (tester) async {
      var tileTapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                GlassListTile(
                  leading: const Icon(Icons.notifications),
                  title: const Text('Notifications'),
                  subtitle: const Text('Manage alerts'),
                  onTap: () => tileTapped = true,
                ),
                const GlassDivider(),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Notifications'), findsOneWidget);
      expect(find.text('Manage alerts'), findsOneWidget);
      expect(find.byType(GlassDivider), findsOneWidget);

      await tester.tap(find.text('Notifications'));
      await tester.pump();
      expect(tileTapped, isTrue);
    });
  });
}
