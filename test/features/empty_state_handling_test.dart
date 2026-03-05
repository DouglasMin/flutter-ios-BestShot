import 'package:bestshot/features/export/presentation/export_page.dart';
import 'package:bestshot/features/kept_grid/presentation/kept_grid_page.dart';
import 'package:bestshot/features/layout_selection/presentation/layout_selection_page.dart';
import 'package:bestshot/features/swipe_review/presentation/swipe_review_page.dart';
import 'package:bestshot/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues(<String, Object>{});
  });

  testWidgets('Swipe review handles empty selection', (tester) async {
    await tester.pumpWidget(
      _buildTestApp(const SwipeReviewPage(selectedPhotos: [])),
    );

    expect(find.text('선택된 사진이 없어요.'), findsOneWidget);
    expect(find.text('사진 선택으로 이동'), findsOneWidget);
  });

  testWidgets('Kept grid handles zero kept assets', (tester) async {
    await tester.pumpWidget(
      _buildTestApp(const KeptGridPage(keptPhotos: [])),
    );

    expect(find.text('아직 보관한 사진이 없어요.'), findsOneWidget);
    expect(find.text('사진 선택으로 이동'), findsOneWidget);
  });

  testWidgets('Layout selection blocks when kept assets are not 4', (tester) async {
    await tester.pumpWidget(
      _buildTestApp(const LayoutSelectionPage(keptPhotos: [])),
    );
    await tester.pumpAndSettle();

    expect(find.text('정확히 4장의 보관 사진이 필요해요.'), findsOneWidget);
    expect(find.text('보관한 사진으로'), findsOneWidget);
  });

  testWidgets('Export blocks when selected assets are not 4', (tester) async {
    await tester.pumpWidget(
      _buildTestApp(const ExportPage(selectedPhotos: [])),
    );
    await tester.pumpAndSettle();

    expect(find.text('내보내려면 사진이 정확히 4장 필요해요.'), findsOneWidget);
    expect(find.text('레이아웃 선택으로'), findsOneWidget);
  });
}

Widget _buildTestApp(Widget home) {
  return ProviderScope(
    child: CupertinoApp(
      locale: const Locale('ko'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: home,
    ),
  );
}
