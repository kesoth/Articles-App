import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class MyPdfViewer extends StatefulWidget {
  String pdfPath;
  MyPdfViewer({required this.pdfPath});
  @override
  _MyPdfViewerState createState() => _MyPdfViewerState();
}

class _MyPdfViewerState extends State<MyPdfViewer> {
  late PDFViewController pdfViewController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    setState(() {
      _isLoading = true;
    });

    try {
      Reference ref = FirebaseStorage.instance.ref().child(widget.pdfPath);
      Directory tempDir = await getTemporaryDirectory();
      File tempFile = File('${tempDir.path}/${widget.pdfPath.split('/').last}');
      await ref.writeToFile(tempFile);

      setState(() {
        widget.pdfPath = tempFile.path;
        _isLoading = false;
      });
    } catch (error) {
      print('Error loading PDF: $error');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : PDFView(
            filePath: widget.pdfPath,
            autoSpacing: true,
            enableSwipe: true,
            pageSnap: true,
            swipeHorizontal: true,
            onError: (error) {
              print(error);
            },
            onPageError: (page, error) {
              print('$page: ${error.toString()}');
            },
            onViewCreated: (PDFViewController vc) {
              pdfViewController = vc;
            },
            onPageChanged: (int? page, int? total) {
              print('page change: $page/$total');
            },
          );
  }
}
