import 'package:flutter/material.dart';

import 'search/view/search_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: SearchView(),
    );
  }
}
