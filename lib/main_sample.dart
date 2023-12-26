import 'package:flutter/material.dart';
import 'package:flutter_application_2/toast_example.dart';

void main() {
  return runApp(
    // overlay portal example
    // const OverlayPortalExampleApp(),

    // overlay entry example
    // const OverlayEntryExample(),

    // global overlay example
    // const GlobalLoaderOverlayExampleApp(),

    // toast example
    // const ToastExampleApp(),

    // snackbar example
    // 출처 : https://devmemory.tistory.com/70
    // const SnackBarDemo(),

    const MaterialApp(home: EasyOverlay()),
  );
}

// List list = ['인증 방식 적용이 필요합니다.1', '인증 방식 적용이 필요합니다.2', '인증 방식 적용이 필요합니다.3'];

ValueNotifier<int> aa = ValueNotifier(55);

ValueNotifier<List<String>> aabb = ValueNotifier(['인증 방식 적용이 필요합니다.1', '인증 방식 적용이 필요합니다.2', '인증 방식 적용이 필요합니다.3']);

class EasyOverlay extends StatelessWidget {
  const EasyOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () async {
                showAlert(context);
                // list.removeLast();
                await Future.delayed(const Duration(seconds: 2));
                aabb.value.removeLast();
                aabb.value = [...aabb.value];
                // showAlert(context);
                // list.removeLast();
                // await Future.delayed(const Duration(seconds: 2));
                // showAlert(context);
                // list.removeLast();
                // await Future.delayed(const Duration(seconds: 2));
                // showAlert(context);
                // list.removeLast();
                // await Future.delayed(const Duration(seconds: 2));
                // showAlert(context);
              },
              child: const Text('insert overlay'),
            ),
          ],
        ),
      ),
    );
  }

  void showAlert(BuildContext context) async {
    OverlayEntry overlay = OverlayEntry(
      builder: (_) => SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: kToolbarHeight),
            child: Material(
              color: Colors.blue,
              child: ValueListenableBuilder<List<String>>(
                valueListenable: aabb,
                builder: (context, value, child) {
                  return ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    children: value
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
        ),
      ),
    );
    Navigator.of(context).overlay!.insert(overlay);
  }
}

OverlayEntry overlay = OverlayEntry(builder: (_) => const OverlayWidget());
final GlobalKey<AnimatedListState> animatedListKey = GlobalKey();

class OverlayWidget extends StatefulWidget {
  const OverlayWidget({super.key});

  @override
  State<OverlayWidget> createState() => OverlayWidgetState();
}

class OverlayWidgetState extends State<OverlayWidget> {
  final _items = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 80.0),
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(8),
              color: Colors.red,
              // child: Column(mainAxisSize: MainAxisSize.min, children: _items.map((e) => Text(e.toString())).toList()),
            ),
          ),
        ),
      ),
    );
    // return Scaffold(
    //   body: AnimatedList(
    //     key: _key,
    //     initialItemCount: 0,
    //     padding: const EdgeInsets.all(8),
    //     itemBuilder: (context, index, animation) {
    //       return SizeTransition(
    //         sizeFactor: animation,
    //         child: Card(
    //           margin: const EdgeInsets.all(8),
    //           color: Colors.orangeAccent,
    //           child: ListTile(
    //             title: Text(
    //               _items[index],
    //               style: const TextStyle(fontSize: 24),
    //             ),
    //             trailing: IconButton(
    //               icon: const Icon(Icons.delete),
    //               onPressed: () {
    //                 removeItem(index);
    //               },
    //             ),
    //           ),
    //         ),
    //       );
    //     },
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: () {
    //       addItem();
    //     },
    //     child: const Icon(Icons.add),
    //   ),
    // );
  }
}

class Alert extends StatefulWidget {
  const Alert({Key? key}) : super(key: key);

  @override
  AlertState createState() => AlertState();
}

class AlertState extends State<Alert> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween<Offset>(begin: const Offset(0.0, -1.0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.yellow,
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: SlideTransition(
              position: _animation,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(30)),
                  child: const Text(
                    'Alert',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Toast extends StatefulWidget {
  const Toast({Key? key}) : super(key: key);

  @override
  ToastState createState() => ToastState();
}

class ToastState extends State<Toast> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.decelerate));

    _controller.forward().whenComplete(() {
      _controller.reverse();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 70),
          child: FadeTransition(
            opacity: _animation,
            child: Material(
              child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.grey),
                  child: const Text('Toast', style: TextStyle(color: Colors.white))),
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedListSample extends StatefulWidget {
  const AnimatedListSample({super.key});

  @override
  State<AnimatedListSample> createState() => _AnimatedListSampleState();
}

class _AnimatedListSampleState extends State<AnimatedListSample> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late ListModel<int> _list;
  int? _selectedItem;
  late int _nextItem; // The next item inserted when the user presses the '+' button.

  @override
  void initState() {
    super.initState();
    _list = ListModel<int>(
      listKey: _listKey,
      initialItems: <int>[0, 1, 2],
      removedItemBuilder: _buildRemovedItem,
    );
    _nextItem = 3;
  }

  // Used to build list items that haven't been removed.
  Widget _buildItem(BuildContext context, int index, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: _list[index],
      selected: _selectedItem == _list[index],
      onTap: () {
        setState(() {
          _selectedItem = _selectedItem == _list[index] ? null : _list[index];
        });
      },
    );
  }

  /// The builder function used to build items that have been removed.
  ///
  /// Used to build an item after it has been removed from the list. This method
  /// is needed because a removed item remains visible until its animation has
  /// completed (even though it's gone as far as this ListModel is concerned).
  /// The widget will be used by the [AnimatedListState.removeItem] method's
  /// [AnimatedRemovedItemBuilder] parameter.
  Widget _buildRemovedItem(int item, BuildContext context, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: item,
      // No gesture detector here: we don't want removed items to be interactive.
    );
  }

  // Insert the "next item" into the list model.
  void _insert() {
    final int index = _selectedItem == null ? _list.length : _list.indexOf(_selectedItem!);
    _list.insert(index, _nextItem++);
  }

  // Remove the selected item from the list model.
  void _remove() {
    if (_selectedItem != null) {
      _list.removeAt(_list.indexOf(_selectedItem!));
      setState(() {
        _selectedItem = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AnimatedList'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add_circle),
              onPressed: _insert,
              tooltip: 'insert a new item',
            ),
            IconButton(
              icon: const Icon(Icons.remove_circle),
              onPressed: _remove,
              tooltip: 'remove the selected item',
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AnimatedList(
            key: _listKey,
            initialItemCount: _list.length,
            itemBuilder: _buildItem,
          ),
        ),
      ),
    );
  }
}

typedef RemovedItemBuilder<T> = Widget Function(T item, BuildContext context, Animation<double> animation);

/// Keeps a Dart [List] in sync with an [AnimatedList].
///
/// The [insert] and [removeAt] methods apply to both the internal list and
/// the animated list that belongs to [listKey].
///
/// This class only exposes as much of the Dart List API as is needed by the
/// sample app. More list methods are easily added, however methods that
/// mutate the list must make the same changes to the animated list in terms
/// of [AnimatedListState.insertItem] and [AnimatedList.removeItem].
class ListModel<E> {
  ListModel({
    required this.listKey,
    required this.removedItemBuilder,
    Iterable<E>? initialItems,
  }) : _items = List<E>.from(initialItems ?? <E>[]);

  final GlobalKey<AnimatedListState> listKey;
  final RemovedItemBuilder<E> removedItemBuilder;
  final List<E> _items;

  AnimatedListState? get _animatedList => listKey.currentState;

  void insert(int index, E item) {
    _items.insert(index, item);
    _animatedList!.insertItem(index);
  }

  E removeAt(int index) {
    final E removedItem = _items.removeAt(index);
    if (removedItem != null) {
      _animatedList!.removeItem(
        index,
        (BuildContext context, Animation<double> animation) {
          return removedItemBuilder(removedItem, context, animation);
        },
      );
    }
    return removedItem;
  }

  int get length => _items.length;

  E operator [](int index) => _items[index];

  int indexOf(E item) => _items.indexOf(item);
}

/// Displays its integer item as 'item N' on a Card whose color is based on
/// the item's value.
///
/// The text is displayed in bright green if [selected] is
/// true. This widget's height is based on the [animation] parameter, it
/// varies from 0 to 128 as the animation varies from 0.0 to 1.0.
class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    this.onTap,
    this.selected = false,
    required this.animation,
    required this.item,
  }) : assert(item >= 0);

  final Animation<double> animation;
  final VoidCallback? onTap;
  final int item;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headlineMedium!;
    if (selected) {
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
    }
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizeTransition(
        sizeFactor: animation,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: SizedBox(
            height: 80.0,
            child: Card(
              color: Colors.primaries[item % Colors.primaries.length],
              child: Center(
                child: Text('Item $item', style: textStyle),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
