import 'package:advanced_search_flutter/product/widget/search_field.dart';
import 'package:advanced_search_flutter/search/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../product/base/base_state.dart';
import '../../product/widget/search_item_card.dart';
import '../model/user_model.dart';
import '../service/search_item_service.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> with BaseState {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(SearchService(networkManager)),
      child: Scaffold(
        body: BlocConsumer<SearchCubit, SearchState>(
          listener: (context, state) {},
          builder: (context, state) {
            switch (state.runtimeType) {
              case SearchLoading:
                return Center(child: CircularProgressIndicator());
              case SearchComplete:
                return _createSearchListView(context, state as SearchComplete);
              default:
                return SizedBox();
            }
          },
        ),
      ),
    );
  }

  Widget _createSearchListView(BuildContext context, SearchComplete searchComplete) {
    final items = searchComplete.model?.data ?? [];
    return CustomScrollView(
      slivers: [_sliverAppBar(context, items), _sliverList(items)],
    );
  }

  SliverAppBar _sliverAppBar(BuildContext context, List<Data> items) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        title: SearchField(
          onChanged: (value) {
            context.read<SearchCubit>().findItems(value);
          },
        ),
      ),
    );
  }

  SliverList _sliverList(List<Data> items) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      return SearchItemCard(item: items[index]);
    }, childCount: items.length));
  }
}
