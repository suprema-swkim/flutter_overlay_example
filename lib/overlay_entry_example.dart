import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OverlayEntryExample extends StatelessWidget {
  const OverlayEntryExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomDropdownPage(),
              CustomDropdownPage(),
              CustomDropdownPage(),
            ],
          ),
        ),
      ),
    );
  }
}

OverlayEntry? _overlayEntry;

class CustomDropdownPage extends StatefulWidget {
  const CustomDropdownPage({Key? key}) : super(key: key);

  @override
  State<CustomDropdownPage> createState() => _CustomDropdownPageState();
}

class _CustomDropdownPageState extends State<CustomDropdownPage> {
  // 드롭다운 리스트
  static const List<String> _dropdownList = ['One', 'Two', 'Three', 'Four', 'Five'];

  // 드롭다운 선택값
  String _dropdownValue = _dropdownList[0];

  // 위젯 링크(선택 항목 좌표 및 사이즈)
  final LayerLink _layerLink = LayerLink();

  // 드롭다운 생성
  void _createOverlay() {
    if (_overlayEntry == null) {
      _overlayEntry = _overlayEntryMenu();
      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  // 드롭다운 해제
  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    // 드롭다운 버튼 빌드
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: () {
          _createOverlay();
        },
        child: Container(
          width: 200,
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              Text(
                _dropdownValue,
                style: const TextStyle(
                  fontSize: 16,
                  height: 22 / 16,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_downward,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 드롭다운 메뉴 호출
  OverlayEntry _overlayEntryMenu() {
    return OverlayEntry(
      maintainState: true,
      builder: (context) {
        var menuHeight = (22.0 * _dropdownList.length) + (21 * (_dropdownList.length - 1)) + 20;

        var buttonHeight = _layerLink.leaderSize!.height; // 버튼 높이
        var buttonOffSet = _layerLink.leader!.offset; // 버튼 좌표(왼쪽위 기준)
        var pageHeight = MediaQuery.of(context).size.height; // 화면 높이
        return Stack(
          children: [
            GestureDetector(
              onTap: () {
                _removeOverlay();
              },
            ),
            CompositedTransformFollower(
              link: _layerLink,
              targetAnchor: Alignment.bottomLeft,
              offset: const Offset(0, 0),

              // targetAnchor: Alignment.topRight,
              // offset: const Offset(0, 0),

              // targetAnchor: Alignment.topLeft, // 수치조정 필요
              // offset: Offset(0, -menuHeight),

              // targetAnchor: Alignment.topLeft, // 수치조정 필요
              // offset: Offset(-_layerLink.leaderSize!.width, 0),

              child: Container(
                width: _layerLink.leaderSize!.width,
                height: menuHeight,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ListView.separated(
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  itemCount: _dropdownList.length,
                  itemBuilder: (context, index) {
                    return CupertinoButton(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      pressedOpacity: 1,
                      minSize: 0,
                      onPressed: () {
                        setState(() {
                          _dropdownValue = _dropdownList.elementAt(index);
                        });
                        _removeOverlay();
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _dropdownList.elementAt(index),
                          style: const TextStyle(
                            fontSize: 16,
                            height: 22 / 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Divider(
                        color: Colors.grey,
                        height: 20,
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
