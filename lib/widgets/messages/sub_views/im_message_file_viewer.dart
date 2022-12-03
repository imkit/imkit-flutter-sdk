import 'dart:io';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/widgets/components/im_icon_button_widget.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class IMMessageFileViewer extends StatefulWidget {
  final IMMessage message;

  const IMMessageFileViewer({Key? key, required this.message}) : super(key: key);

  @override
  State<StatefulWidget> createState() => IMMessageFileViewerState();
}

class IMMessageFileViewerState extends State<IMMessageFileViewer> {
  bool _isLoading = true;
  PDFViewer? _pdfViewer;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, _getFile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: IMKit.style.backgroundColor,
      appBar: AppBar(
        backgroundColor: IMKit.style.primaryColor,
        title: Column(children: [
          Text(
            widget.message.file?.filename ?? widget.message.sender?.nickname ?? "",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Visibility(
            visible: widget.message.createdAt != null,
            child: Text(
              DateFormat("yyyy/MM/dd a hh:mm:ss").format(widget.message.createdAt ?? DateTime.now()),
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ]),
        actions: [
          IMIconButtonWidget(
            icon: const Icon(Icons.ios_share),
            onPressed: () {
              final filePath = _pdfViewer?.document.filePath ?? "";
              final file = widget.message.file;
              if (filePath.isNotEmpty) {
                Share.shareXFiles(
                  [
                    XFile(
                      filePath,
                      mimeType: file?.mimeType,
                      name: file?.filename,
                      length: file?.bytes,
                      lastModified: widget.message.createdAt,
                    )
                  ],
                  subject: file?.filename ?? "",
                );
              }
            },
          )
        ],
      ),
      body: Stack(
        children: [
          Visibility(
            visible: _pdfViewer != null,
            child: Container(child: _pdfViewer),
          ),
          Visibility(
            visible: _isLoading,
            child: Center(
              child: SizedBox(
                width: 44,
                height: 44,
                child: CircularProgressIndicator(strokeWidth: 2, color: IMKit.style.primaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _getFile() async {
    final file = widget.message.file;
    final url = file?.url ?? "";
    final filename = file?.filename ?? "";
    final originalPath = file?.originalPath ?? "";

    if (originalPath.isNotEmpty) {
      PDFDocument.fromFile(File(originalPath)).then((document) => _loadFinish(document: document));
    } else if (url.isNotEmpty) {
      IMKit.instance.action
          .downloadFileToCache(url: url, filename: filename)
          .then((file) => PDFDocument.fromFile(file))
          .then((document) => _loadFinish(document: document));
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _loadFinish({required PDFDocument document}) {
    setState(() {
      _isLoading = false;
      _pdfViewer = PDFViewer(
        document: document,
        showPicker: false,
      );
    });
  }
}
