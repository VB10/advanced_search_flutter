import 'dart:convert';
import 'dart:io';

import 'package:advanced_search_flutter/search/model/user_model.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SampleFutureCancel {
  Future<List<UserModel>?> fetchUsers() async {
    final response = await http.get(Uri.parse('https://reqres.in/api/users'));

    if (response.statusCode == HttpStatus.ok) {
      final jsonBody = jsonDecode(response.body);
      if (jsonBody is List) {
        return jsonBody.map((e) => UserModel.fromJson(e)).toList();
      }
    }

    return [];
  }
}

class SamplePage extends StatefulWidget {
  const SamplePage({Key? key}) : super(key: key);

  @override
  _SamplePageState createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {
  void _fetchItems() {
    _operation.value.then((value) {
      _items = value ?? [];
      setState(() {});
    });
  }

  late CancelableOperation<List<UserModel>?> _operation;
  List<UserModel> _items = [];
  @override
  void initState() {
    super.initState();
    _operation = CancelableOperation.fromFuture(
      SampleFutureCancel().fetchUsers(),
      onCancel: () {
        print('The request has been Canceled');
      },
    );

    _fetchItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: Text('${_items.length}')),
      floatingActionButton: FloatingActionButton(
        child: Text('Cancel Request'),
        onPressed: () {
          _operation.cancel();
        },
      ),
    );
  }
}
