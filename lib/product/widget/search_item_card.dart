import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../search/model/user_model.dart';

class SearchItemCard extends StatelessWidget {
  const SearchItemCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Data item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.fullName, style: context.textTheme.bodyText1),
      subtitle: Text(item.email ?? ''),
      trailing: CircleAvatar(radius: 10, child: FittedBox(child: Text('${item.id}'))),
      leading: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(item.avatar ?? ''),
      ),
    );
  }
}
