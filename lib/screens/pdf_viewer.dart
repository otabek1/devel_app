import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewerScreen extends StatefulWidget {
  static const routeName = "/pdfviewer";

  @override
  _PdfViewerScreenState createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  PDFViewController? controller;
  int pages = 0;
  int indexPage = 0;

  @override
  Widget build(BuildContext context) {
    final arguments =
        (ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>);
    final title = arguments["title"];
    // print("Title>> $arguments");
    final path = arguments["path"];
    final file = arguments["file"];
    var isDownloaded = (file != null);
    final text = '${indexPage + 1} of $pages';
    // print("PATH FROM PDF >>>> $path or ${arguments['file'].path}");
    // print()
    // if (path!.isEmpty) {
    //   Future.delayed(Duration(seconds: 2));
    //   print("waiting;");

    // }
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
        actions: pages >= 2
            ? [
                Center(child: Text(text)),
                IconButton(
                  icon: Icon(Icons.chevron_left, size: 32),
                  onPressed: () {
                    final page = indexPage == 0 ? pages : indexPage - 1;
                    controller!.setPage(page);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.chevron_right, size: 32),
                  onPressed: () {
                    final page = indexPage == pages - 1 ? 0 : indexPage + 1;
                    controller!.setPage(page);
                  },
                ),
              ]
            : null,
      ),
      body: PDFView(
        filePath: isDownloaded ? file.path : path,
        // autoSpacing: false,
        // swipeHorizontal: true,
        // pageSnap: false,
        // pageFling: false,
        onRender: (pages) => setState(() => this.pages = pages!),
        onViewCreated: (controller) =>
            setState(() => this.controller = controller),
        onPageChanged: (indexPage, _) =>
            setState(() => this.indexPage = indexPage!),
      ),
    );
  }
}
