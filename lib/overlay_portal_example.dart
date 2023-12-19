import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

class OverlayPortalExampleApp extends StatelessWidget {
  const OverlayPortalExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: const Text('OverlayPortal Example')),
          body: const Center(
            child: CustomDropDown(),
          ),
        ),
      ),
    );
  }
}

// 참조 링크 : https://medium.com/snapp-x/creating-custom-dropdowns-with-overlayportal-in-flutter-4f09b217cfce
class CustomDropDown extends StatefulWidget {
  const CustomDropDown({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => CustomDropDownState();
}

class CustomDropDownState extends State<CustomDropDown> {
  final OverlayPortalController _tooltipController = OverlayPortalController();

  final _link = LayerLink();

  /// width of the button after the widget rendered
  double? _buttonWidth;

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _link,
      child: OverlayPortal(
        controller: _tooltipController,
        overlayChildBuilder: (BuildContext context) {
          return CompositedTransformFollower(
            link: _link,
            targetAnchor: Alignment.bottomLeft,
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: Container(
                margin: const EdgeInsets.only(top: 4),
                child: MenuWidget(width: _buttonWidth),
              ),
            ),
          );
        },
        child: ElevatedButton(
          onPressed: () {
            onTap();
          },
          child: const Text('Button Text'),
        ),
      ),
    );
  }

  void onTap() {
    _buttonWidth = context.size?.width;
    _tooltipController.toggle();
  }
}

class MenuWidget extends StatelessWidget {
  const MenuWidget({
    super.key,
    this.width,
  });

  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 200,
      height: 300,
      decoration: ShapeDecoration(
        color: Colors.black26,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1.5,
            color: Colors.black26,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 32,
            offset: Offset(0, 20),
            spreadRadius: -8,
          ),
        ],
      ),
    );
  }
}

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    // print(!ModalRoute.of(context)!.isCurrent);
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   _dialogBuilder(context);
    // });
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('sss'),
      ),
    );
  }
}
