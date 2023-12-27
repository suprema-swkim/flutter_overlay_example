// import 'package:flutter/material.dart';

// /// Flutter code sample for [showDialog].

// void main() => runApp(const ShowDialogExampleApp());

// class ShowDialogExampleApp extends StatelessWidget {
//   const ShowDialogExampleApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: DialogExample(),
//     );
//   }
// }

// class DialogExample extends StatelessWidget {
//   const DialogExample({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('showDialog Sample')),
//       body: Center(
//         child: OutlinedButton(
//           onPressed: () {
//             CustomOverlay.showDialog2(child: CustomDialog.ok());
//           },
//           child: const Text('Open Dialog'),
//         ),
//       ),
//     );
//   }

//   Future<void> _dialogBuilder(BuildContext context) {
//     return showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         // 1.
//         // CustomOverlay.showDialog();

//         // 2.
//         return const CustomDialog.ok();
//         // return const CustomDialog.okCancel();

//         // 3.
//         // return const OKDialog();
//         // return const OKCancelDialog();
//       },
//     );
//   }
// }

// // 수동 - 다이얼로그(dialog)
// // 자동 - 팝업(snackBar&Toast)
// // 수동 - 로딩(loading)
// // 수동 - 메뉴(menu)
// // 수동 - 서랍(drawer)
import 'package:flutter/material.dart';

class CustomOverlay {
  static showWidget(Widget widget) {
    // ...
  }

  static showToast(Icon, message) {
    // ...
  }

  static showLoading() {
    // ...
  }

  static hideLoading() {
    // ...
  }
}

// CustomDialog
// CustomDialog2
// CustomDialog3.show
// CustomDialog4.show

// CustomLoading1

// CustomPopup1
// CustomPopup2
// CustomPopup3



// onTap() {
//   // 로딩 시작
//   // vm 호출 시작
//   // vm 수행 완료
//   //! 로딩종료(onDone, onFailed, onError)
// }
// // vm 호출 시작

// class CustomDialog extends StatelessWidget {
//   const CustomDialog.ok({super.key});

//   const CustomDialog.okCancel({super.key});

//   final Widget title;
//   final Widget content;

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

// class CustomPopup {}
