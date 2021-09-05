import 'package:vexana/vexana.dart';

import '../init/project_network_manager.dart';

mixin BaseState {
  INetworkManager get networkManager => ProjectNetworkManager.instance.networkManager;
}
