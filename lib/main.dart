import 'package:flutter/material.dart';

void main() {
  return runApp(
    const MaterialApp(home: EasyOverlay()),
  );
}

ValueNotifier<Map<String, String>> aabbc = ValueNotifier({});

class EasyOverlay extends StatelessWidget {
  const EasyOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => settingOverlayEntry(context));
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () async {
                showPopup();
              },
              child: const Text('insert overlay'),
            ),
          ],
        ),
      ),
    );
  }

  void showPopup() async {
    var key = UniqueKey().toString();
    aabbc.value.addAll({key: '인증 방식 적용이 필요합니다.11'});
    aabbc.value = Map.from(aabbc.value);
    await Future.delayed(const Duration(seconds: 2));
    aabbc.value.remove(key);
    aabbc.value = Map.from(aabbc.value);
  }

  void settingOverlayEntry(BuildContext context) async {
    OverlayEntry overlay = OverlayEntry(builder: (context) => const ToastWidget());
    Navigator.of(context).overlay!.insert(overlay);
  }
}

class ToastWidget extends StatelessWidget {
  const ToastWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: kToolbarHeight),
          child: ValueListenableBuilder<Map<String, String>>(
            valueListenable: aabbc,
            builder: (context, value, child) {
              var myList = aabbc.value.values;
              return ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: myList
                    .map(
                      (e) => Align(
                        alignment: Alignment.topCenter,
                        child: Card(
                          color: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.circle_notifications_outlined,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  e.toString(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}
