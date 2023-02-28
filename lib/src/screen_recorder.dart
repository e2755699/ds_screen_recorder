import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

abstract class ScreenRecorder {
  late Process _process;
  final ValueNotifier<String> savePath = ValueNotifier("");

  Future<void> start({required String fileName}) async {
    savePath.value = await getSavePath(fileName, "mp4");
  }

  Future<String> stop();

  static factory() {
    if(Platform.isMacOS){
      return ScreenRecorderMacOs();

    }else if(Platform.isWindows){
      throw MissingPluginException("Platform :${Platform.operatingSystem}");
    }
    throw MissingPluginException("Platform :${Platform.operatingSystem}");
  }

  Future<String> getSavePath(String fileName, String fileType) async {
    Directory directory = await getApplicationDocumentsDirectory();
    fileName = '$fileName-${DateTime.now().millisecondsSinceEpoch}.$fileType';
    return '${directory.path}/$fileName';
  }
}

class ScreenRecorderMacOs extends ScreenRecorder {
  @override
  Future<void> start({required String fileName}) async {
    await super.start(fileName: fileName);
    _process = await Process.start(
      'screencapture',
      ['-v', savePath.value],
    );
  }

  @override
  Future<String> stop() async {
    _process.stdin.write("c");
    await Future.delayed(const Duration(seconds: 1));
    _process.kill(ProcessSignal.sigterm);
    return savePath.value;
  }
}
