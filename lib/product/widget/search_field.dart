import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  final void Function(String value) onChanged;
  const SearchField({Key? key, required this.onChanged}) : super(key: key);

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late CancelableOperation<void> cancellableOperation;
  final _delayTime = Duration(milliseconds: 300);
  @override
  void initState() {
    super.initState();
    _start();
  }

  void _start() {
    cancellableOperation = CancelableOperation.fromFuture(
      Future.delayed(_delayTime),
      onCancel: () {
        print('Canceled');
      },
    );
  }

  void _onItemChanged(String value) {
    cancellableOperation.cancel();
    _start();
    cancellableOperation.value.whenComplete(() {
      widget.onChanged(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: _onItemChanged,
      decoration: InputDecoration(prefixIcon: Icon(Icons.search)),
    );
  }
}
