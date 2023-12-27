import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';

class OverlayEntryExample2 extends StatelessWidget {
  const OverlayEntryExample2({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      useDefaultLoading: false,
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
      child: const MaterialApp(
        home: OverlayEntryExample2Body(),
      ),
    );
  }
}

class OverlayEntryExample2Body extends StatelessWidget {
  const OverlayEntryExample2Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => OverlayWidget.settingOverlayEntry(context));
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                showPopup('기본 정보 등록이 먼저 필요합니다.');
              },
              child: const Text('show popup'),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () async {
                context.loaderOverlay.show();
                await Future.delayed(const Duration(seconds: 3));
              },
              child: const Text('show loading'),
            ),
          ],
        ),
      ),
    );
  }
}

void showPopup(String title) async {
  OverlayWidget.addItem(title);
  await Future.delayed(const Duration(seconds: 2));
  OverlayWidget.removeItem(0);
}

final GlobalKey<AnimatedListState> animatedKey = GlobalKey();
List<String> overlayList = [];

class OverlayWidget extends StatelessWidget {
  const OverlayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // 인터페이스 영역 제거
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(top: kToolbarHeight), // 앱 바 높이만큼 여백 추가
        alignment: Alignment.topCenter, // 시작 포인트 지정(세로 영역)
        child: AnimatedList(
          shrinkWrap: true, // 전체 영역 제거(자식크기 영역)
          key: animatedKey,
          initialItemCount: overlayList.length,
          itemBuilder: (context, index, animation) {
            return Container(
              color: Colors.blue,
              child: BuildItem(
                item: overlayList[index],
                animation: animation,
                index: index,
              ),
            );
          },
        ),
      ),
    );
  }

  /// 오버레이 영역에 추가
  static void settingOverlayEntry(BuildContext context) async {
    OverlayEntry overlay = OverlayEntry(builder: (context) => const OverlayWidget());
    Navigator.of(context).overlay!.insert(overlay);
  }

  /// 오버레이 항목 추가
  static void addItem(String title) {
    int i = overlayList.isNotEmpty ? overlayList.length : 0;
    overlayList.insert(i, title);

    /// animatedKey 할당한 AnimatedList 에서 i번째에 해당하는 순서에 아이템을 추가 한다.
    animatedKey.currentState!.insertItem(i);
  }

  /// 오버레이 항목 제거
  static void removeItem(int index) {
    String removeItem = overlayList.removeAt(index);

    /// animatedKey 할당한 AnimatedList 에서
    /// 첫번째 파라미터인 index 순서에 두번째 파라미터 builder 에 해당하는 아이템을 지운다.
    animatedKey.currentState!.removeItem(index, (context, animation) {
      return BuildItem(item: removeItem, animation: animation, index: index);
    });
  }
}

class BuildItem extends StatelessWidget {
  const BuildItem({
    Key? key,
    required this.item,
    required this.animation,
    required this.index,
  }) : super(key: key);

  final String item;
  final Animation<double> animation;
  final int index;

  @override
  Widget build(BuildContext context) {
    print(animation.value);
    print(animation.status);
    // 0 , forward >>>
    // 1 , reverse <<<
    return SizeTransition(
      sizeFactor: animation,
      child: Container(
        alignment: Alignment.topCenter, // 시작 포인트 지정(가로)
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
                  item.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
