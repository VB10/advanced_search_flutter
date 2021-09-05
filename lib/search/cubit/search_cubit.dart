import 'dart:convert';

import 'package:advanced_search_flutter/product/utility/search_utility.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/user_model.dart';
import '../service/search_item_service.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(ISearchService service) : super(SearchLoading()) {
    _searchService = service;
    _fetchItems();
  }
  late final ISearchService _searchService;

  late UserModel _userModel;

  Future<void> _fetchItems() async {
    final response = await _searchService.fetchAllItem();
    if (response != null) {
      _userModel = response;
      emit(SearchComplete(response));
    } else {
      emit(SearchError('something went wrong'));
    }
  }

  Future<void> findItems(String key) async {
    final response = await compute(MultiThreadUtility.findItemsModelParents, SearchModel(key, _userModel.data ?? []));
    if (response != null) {
      emit(SearchComplete(UserModel(data: response.items)));
    }
  }
}

abstract class SearchState {}

class SearchLoading extends SearchState {}

class SearchComplete extends SearchState {
  final UserModel? model;

  SearchComplete(this.model);
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);
}
