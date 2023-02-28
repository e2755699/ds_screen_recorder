import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';


class VideoTranscode{
  void transcode(String oldPath, String newsPath) {
    FFmpegKit.execute('-i $oldPath -c:v mpeg4 $newsPath')
        .then((session) async {
      final returnCode = await session.getReturnCode();

      if (ReturnCode.isSuccess(returnCode)) {
        // SUCCESS
      } else if (ReturnCode.isCancel(returnCode)) {
        // CANCEL
      } else {
        // ERROR
      }
    });
  }
}

