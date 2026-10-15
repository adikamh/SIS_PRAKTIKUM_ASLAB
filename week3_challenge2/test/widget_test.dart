import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:week3_cl2/main.dart';

void main() {
  testWidgets('DrinkDetailPage displays drink details, increments counter, and shows dialog', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: DrinkDetailPage(drinkName: 'Matcha Latte'),
      ),
    );

    // Verifikasi nama minuman dan nilai awal counter (1)
    expect(find.text('Matcha Latte'), findsNWidgets(2)); // di AppBar dan di Body
    expect(find.text('1'), findsOneWidget);

    // Tekan tombol '+' untuk menambah kuantitas
    await tester.tap(find.byIcon(Icons.add_circle));
    await tester.pump();
    expect(find.text('2'), findsOneWidget);

    // Tekan tombol '-' untuk mengurangi kuantitas
    await tester.tap(find.byIcon(Icons.remove_circle));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);

    // Tekan tombol 'Tambah Pesanan' untuk menampilkan AlertDialog
    await tester.tap(find.text('Tambah Pesanan'));
    await tester.pumpAndSettle();

    // Verifikasi kemunculan AlertDialog konfirmasi
    expect(find.text('Pesanan Berhasil'), findsOneWidget);
    expect(find.text('Anda telah memesan Matcha Latte sebanyak 1 cup'), findsOneWidget);
    expect(find.text('OK'), findsOneWidget);

    // Tutup AlertDialog dengan menekan 'OK'
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    expect(find.text('Pesanan Berhasil'), findsNothing);
  });
}
