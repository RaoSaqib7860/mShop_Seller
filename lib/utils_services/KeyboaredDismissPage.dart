import 'package:flutter/material.dart';

class KeyBoardDismissPage extends StatefulWidget {
  final Widget? child;
  const KeyBoardDismissPage({Key? key, this.child}) : super(key: key);

  @override
  State<KeyBoardDismissPage> createState() => _KeyBoardDismissPageState();
}

class _KeyBoardDismissPageState extends State<KeyBoardDismissPage> {
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (PointerDownEvent event) =>
          FocusManager.instance.primaryFocus?.unfocus(),
      child: widget.child,
    );
  }
}
