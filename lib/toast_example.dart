import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastExampleApp extends StatelessWidget {
  const ToastExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Toast Demo',
      home: SnackBarPage(),
    );
  }
}

class SnackBarPage extends StatelessWidget {
  const SnackBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                CustomToast.success('성공입니다.');
              },
              child: const Text('success'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                CustomToast.error('오류입니다.');
              },
              child: const Text('error'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const MyPage(),
                  ),
                );
              },
              child: const Text('move'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                CustomToast.success('성공입니다.');
              },
              child: const Text('success'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                CustomToast.error('오류입니다.');
              },
              child: const Text('error'),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomToast {
  static void success(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 5,
        textColor: Colors.black,
        fontSize: 16.0,
        webBgColor: "#4FF0B1",
        gravity: ToastGravity.TOP,
        webPosition: "right",
        webShowClose: true);
  }

  static void error(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 5,
      textColor: Colors.white,
      fontSize: 16.0,
      webBgColor: "#EE0022",
      gravity: ToastGravity.TOP,
      webPosition: "right",
    );
  }
}
