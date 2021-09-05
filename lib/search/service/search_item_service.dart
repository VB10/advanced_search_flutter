import 'package:vexana/vexana.dart';

import '../../product/utility/network_querys.dart';
import '../model/user_model.dart';

abstract class ISearchService {
  ISearchService(INetworkManager networkManager) {
    _networkManager = networkManager;
  }
  Future<UserModel?> fetchAllItem({int page = 0, int perPage = 13});
  late final INetworkManager _networkManager;
}

enum _ServicePath { users }

extension on _ServicePath {
  String get rawValue {
    switch (this) {
      case _ServicePath.users:
        return '/users';
    }
  }
}

class SearchService extends ISearchService {
  SearchService(INetworkManager networkManager) : super(networkManager);

  @override
  Future<UserModel?> fetchAllItem({int page = 0, int perPage = 13}) async {
    final response = await _networkManager.send<UserModel, UserModel>(_ServicePath.users.rawValue,
        queryParameters: Map.fromEntries([
          NetworkQuery.page.rawValue('$page'),
          NetworkQuery.per_page.rawValue('$perPage'),
        ]),
        parseModel: UserModel(),
        method: RequestType.GET);

    return response.data;
  }
}
