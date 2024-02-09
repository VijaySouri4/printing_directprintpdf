// class MyApp extends StatelessWidget {
//   void printPdf() async {
//   final doc = await generatePdf();
//   Printer? pri = await Printing.pickPrinter(context: context);
//   await Printing.directPrintPdf(
//     printer: pri!,
//     onLayout: (PdfPageFormat format) async => doc.save(),
//   );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text('PDF Printer App')),
//         body: Center(
//           child: ElevatedButton(
//             onPressed: () => printPdf(),
//             child: const Text('Invoke Direct Print'),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('PDF Printer App'),
        ),
        body: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => printPdf(context),
        child: const Text('Print PDF'),
      ),
    );
  }

  Future<void> printPdf(BuildContext context) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
          build: (pw.Context context) =>
              pw.Center(child: pw.Text('Hello, PDF!'))),
    );

    final Uint8List bytes = await pdf.save();
    //Printer? printer = await Printing.pickPrinter(context: context);

    await Printing.directPrintPdf(
      // printer: printer,
      printer: Printer(
          url:
              'PDF'), // Give name when running locally over CUPS. User netowrk address for network printer.
      onLayout: (PdfPageFormat format) async => bytes,
    );

    // if (printer != null) {
    //   await Printing.directPrintPdf(
    //     // printer: printer,
    //     printer: Printer(url: url),
    //     onLayout: (PdfPageFormat format) async => bytes,
    //   );
    // }
  }
}
