import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('PDF Printer App')),
        body: Center(
          child: ElevatedButton(
            onPressed: () => printPdf(),
            child: const Text('Invoke Direct Print'),
          ),
        ),
      ),
    );
  }
}

Future<pw.Document> generatePdf() async {
  final pdf = pw.Document();
  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Text('Hello, PDF!'),
        );
      },
    ),
  );
  return pdf;
}

// Future<PrintingInfo> info() {
//   Printer(url: url)
// }

void printPdf() async {
  final doc = await generatePdf();

  await Printing.directPrintPdf(
    printer: const Printer(url: 'http://127.0.0.1:631/printers/PDF'),
    onLayout: (PdfPageFormat format) async => doc.save(),
  );
}

// void printPdf() async {
//   final pdf = await generatePdf();

//   await Printing.layoutPdf(
//     onLayout: (PdfPageFormat format) async => pdf.save(),
//   );
// }
