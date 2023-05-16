import 'package:app/modules/candidate/data/repositories/user_repositories.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewerScreen extends StatefulWidget {
  const PDFViewerScreen({super.key, required this.name, required this.pathCV});

  final String name;
  final String pathCV;

  @override
  State<PDFViewerScreen> createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  UserRepositories userRepositories = UserRepositories();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Center(
        child: SfPdfViewer.network(userRepositories.getAvatar(widget.pathCV)),
      ),
    );
  }
}
