import 'package:vexana/vexana.dart';

class ProjectNetworkManager {
  static ProjectNetworkManager? _instace;
  static ProjectNetworkManager get instance {
    _instace = ProjectNetworkManager._init();
    return _instace!;
  }

  late final INetworkManager networkManager;

  // TODO: Use flutter dot env library
  final String _baseUrl = 'https://reqres.in/api';

  ProjectNetworkManager._init() {
    networkManager = NetworkManager(options: BaseOptions(baseUrl: '$_baseUrl'));
  }
}
