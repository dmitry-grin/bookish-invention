import 'package:bookish_invention/main.dart' as bookish_invention;
import 'package:bookish_invention/widgets/book_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

// flutter drive --profile --no-dds --driver=integration_test/integration_test.dart --target=integration_test/performance_test.dart
void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  group(
    'Performance Testing',
    () {
      testWidgets('Write down performance measurements to a file', (tester) async {
        await binding.watchPerformance(
          reportKey: 'Bookish_Invention_Performance',
          () async {
            bookish_invention.main();

            await tester.pumpAndSettle();

            final bookTile1 = tester.firstWidget(find.byType(BookTile));

            await tester.tap(find.byWidget(bookTile1));

            await tester.pumpAndSettle(const Duration(seconds: 2));

            await tester.tap(find.byType(CupertinoNavigationBarBackButton));

            await tester.pumpAndSettle(const Duration(seconds: 2));

            final bookTile2 = tester.firstWidget(find.byType(BookTile));

            await tester.tap(find.byWidget(bookTile2));

            await tester.pumpAndSettle(const Duration(seconds: 2));

            await tester.tap(find.byType(CupertinoNavigationBarBackButton));

            await tester.pumpAndSettle(const Duration(seconds: 2));
          },
        );
      });
    },
  );
}
