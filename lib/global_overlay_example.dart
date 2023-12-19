// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';

class GlobalLoaderOverlayExampleApp extends StatelessWidget {
  const GlobalLoaderOverlayExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      useDefaultLoading: false,
      // overlayWidgetBuilder: (dynamic progress) {
      //   return Center(
      //     child: Column(
      //       mainAxisSize: MainAxisSize.min,
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         const CircularProgressIndicator(),
      //         const SizedBox(height: 12),
      //         const Text(
      //           'Reconnecting...',
      //         ),
      //         const SizedBox(height: 12),
      //         Text(
      //           progress ?? '',
      //         ),
      //       ],
      //     ),
      //   );
      // },
      overlayWidgetBuilder: (progress) {
        //ignored progress for the moment
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SpinKitCubeGrid(
                color: Colors.red,
                size: 50.0,
              ),
              const SizedBox(
                height: 50,
              ),
              if (progress != null) Text(progress)
            ],
          ),
        );
      },
      // overlayColor: Colors.yellow.withOpacity(0.8),
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GlobalLoaderOverlay Example')),
      body: Center(
        child: InkWell(
          onTap: () async {
            context.loaderOverlay.show(
              progress: 'Doing progress #0',
            );

            await Future.delayed(const Duration(seconds: 1));
            context.loaderOverlay.progress('Doing progress #1');
            await Future.delayed(const Duration(seconds: 1));
            context.loaderOverlay.progress('Doing progress #2');
            await Future.delayed(const Duration(seconds: 1));
            context.loaderOverlay.progress('Doing progress #3');
            await Future.delayed(const Duration(seconds: 1));
            context.loaderOverlay.progress('Doing progress #4');
            await Future.delayed(const Duration(seconds: 1));
            context.loaderOverlay.progress('Doing progress #5');
            await Future.delayed(const Duration(seconds: 1));

            context.loaderOverlay.hide();

            // context.loaderOverlay.show(
            //     // widgetBuilder: (progress) {
            //     //   return const Center(child: CircularProgressIndicator());
            //     // },
            //     );
            // await Future.delayed(const Duration(seconds: 2));
            // Navigator.push(
            //   context,
            //   MaterialPageRoute<void>(
            //     builder: (BuildContext context) => const MyPage(),
            //   ),
            // );
            // await Future.delayed(const Duration(seconds: 5));
            // context.loaderOverlay.hide();
          },
          child: const Text('home'),
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
      body: const Center(
        child: Text('detail'),
      ),
    );
  }
}
