import 'dart:convert';

import 'package:advanced_search_flutter/search/model/user_model.dart';

class MultiThreadUtility {
  static SearchModel? findItemsModelParents(SearchModel model) {
    final _searchItem = model;
    if (_searchItem is SearchModel) {
      final _findValues = _searchItem.items.where((element) => element.isValueContains(_searchItem.key)).toList();
      _searchItem.items = _findValues;
      return _searchItem;
    }

    return null;
  }
}

class SearchModel {
  final String key;
  List<Data> items;

  SearchModel(this.key, this.items);

  Map<String, dynamic> toMap() => {'key': key, 'items': items.map((x) => x.toJson()).toList()};

  factory SearchModel.fromMap(Map<String, dynamic> map) =>
      SearchModel(map['key'], List<Data>.from(map['items']?.map((x) => Data.fromJson(x))));

  String toJson() => json.encode(toMap());

  factory SearchModel.fromJson(String source) => SearchModel.fromMap(json.decode(source));
}
