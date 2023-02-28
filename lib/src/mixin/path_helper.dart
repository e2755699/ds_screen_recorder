import 'dart:io';

import 'package:path_provider/path_provider.dart';

mixin PathHelper {
  Future<String> genSavePath(String fileName, String fileType) async {
    Directory directory = await getApplicationDocumentsDirectory();
    fileName = '$fileName-${DateTime.now().millisecondsSinceEpoch}.$fileType';
    return '${directory.path}/$fileName';
  }

}
