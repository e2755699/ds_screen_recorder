# ds_screen_recorder

A Flutter screen recorder project.

## Platform Support

| macOS | Windows |
| :---: | :-----: |
|   ✔️   |    X    |

## How to use

- Call ScreenRecorder.factory() to get instance 

```diff
  final ScreenRecorder screenRecorder = ScreenRecorder.factory();
```
- Start to record
```diff
  screenRecorder.start(fileName: "dustin_test");
```
- Stop to record
```diff
  screenRecorder.stop();
```

## Example
```diff
 import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:ds_screen_recorder/src/screen_recorder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:preference_list/preference_list.dart';
import 'package:screen_capturer/screen_capturer.dart';
import 'package:path_provider/path_provider.dart';

class ScreenRecorderPage extends StatefulWidget {
  const ScreenRecorderPage({Key? key}) : super(key: key);

  @override
  _ScreenRecorderPageState createState() => _ScreenRecorderPageState();
}

class _ScreenRecorderPageState extends State<ScreenRecorderPage> {
  final ScreenRecorder screenRecorder = ScreenRecorder.factory();
  bool _isAccessAllowed = false;

  @override
  void initState() {
    super.initState();
    // _init();
  }

  void _init() async {
    _isAccessAllowed = await ScreenCapturer.instance.isAccessAllowed();

    setState(() {});
  }

  void _handleClickStart() async {
    screenRecorder.start(fileName: "dustin_test");
    setState(() {});
  }

  void _handleClickStop() async {
    screenRecorder.stop();
    setState(() {});
  }

  Widget _buildBody(BuildContext context) {
    return PreferenceList(
      children: <Widget>[
        if (Platform.isMacOS)
          PreferenceListSection(
            children: [
              PreferenceListItem(
                title: const Text('isAccessAllowed'),
                accessoryView: Text('$_isAccessAllowed'),
                onTap: () async {
                  bool allowed =
                      await ScreenCapturer.instance.isAccessAllowed();
                  setState(() {
                    _isAccessAllowed = allowed;
                  });
                },
              ),
              PreferenceListItem(
                title: const Text('requestAccess'),
                onTap: () async {
                  await ScreenCapturer.instance.requestAccess();
                },
              ),
            ],
          ),
        PreferenceListSection(
          title: const Text('METHODS'),
          children: [
            PreferenceListItem(
              title: const Text('recorder'),
              accessoryView: Row(children: [
                CupertinoButton(
                  child: const Text('start'),
                  onPressed: () {
                    _handleClickStart();
                  },
                ),
                CupertinoButton(
                  child: const Text('stop'),
                  onPressed: () {
                    _handleClickStop();
                  },
                ),
              ]),
            ),
          ],
        ),
        Text(screenRecorder.savePath.value)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DS Screen Recorder'),
      ),
      body: _buildBody(context),
    );
  }
}

```
