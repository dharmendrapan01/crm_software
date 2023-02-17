import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';

class DownloadingDialog extends StatefulWidget {
  final downloadUrl;
  const DownloadingDialog({Key? key, this.downloadUrl}) : super(key: key);

  @override
  State<DownloadingDialog> createState() => _DownloadingDialogState();
}

class _DownloadingDialogState extends State<DownloadingDialog> {
  int _done = 0;
  double? _progress;
  String _status = '';

  void startDownloading() async {
    String url = widget.downloadUrl;
    await FileDownloader.downloadFile(
      url: url,
      onProgress: (name, progress) {
        setState(() {
          _progress = progress;
          _status = 'Progress: $progress%';
          _done = 1;
        });
      },
      onDownloadCompleted: (path) {
        setState(() {
          _progress = null;
          _status = 'File Downloaded';
          _done = 2;
        });
      },
      onDownloadError: (error) {
        // print('Downloading Error: $errorMessage');
        setState(() {
          _progress = null;
          _status = 'Download error: $error';
          _done = 3;
        });
      },
    ).then((file) {
      print('file path: ${file?.path}');
    });
  }

  @override
  void initState() {
    startDownloading();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_status.isNotEmpty) ...[
              _done == 2 ? Icon(Icons.done, size: 50, color: Colors.green) : _done == 3 ? Icon(Icons.error, size: 50, color: Colors.red) : Icon(Icons.more_horiz, size: 50, color: Colors.blueGrey),
              Text(_status, textAlign: TextAlign.center),
              const SizedBox(height: 16),
            ],
            if (_progress != null) ...[
              CircularProgressIndicator(
                value: _progress! / 100,
              ),
              const SizedBox(height: 16),
            ],
          ],
        ),
      );
  }
}
