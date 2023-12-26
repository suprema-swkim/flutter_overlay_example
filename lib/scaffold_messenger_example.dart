import 'package:flutter/material.dart';

final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

void main() => runApp(const SnackBarDemo());

class SnackBarDemo extends StatelessWidget {
  const SnackBarDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _scaffoldKey,
      title: 'SnackBar Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('SnackBar Demo'),
        ),
        body: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SnackBarPageWithContext(),
              SizedBox(height: 20),
              SanckBarPage(),
            ],
          ),
        ),
      ),
    );
  }
}

class SnackBarPageWithContext extends StatelessWidget {
  const SnackBarPageWithContext({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          final snackBar = SnackBar(
            content: const Text('Yay! A SnackBar!'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );

          // Find the ScaffoldMessenger in the widget tree
          // and use it to show a SnackBar.
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: const Text('Show SnackBar With Context'),
      ),
    );
  }
}

class SanckBarPage extends StatelessWidget {
  const SanckBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          var snackBar = const SnackBar(
            width: 200,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
            content: Text(
              'Yay! A SnackBar!',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          );

          _scaffoldKey.currentState!.showSnackBar(snackBar);
        },
        child: const Text('Show SnackBar'),
      ),
    );
  }
}
