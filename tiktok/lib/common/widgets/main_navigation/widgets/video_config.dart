import 'package:flutter/foundation.dart';

class VideoConfig extends ChangeNotifier {
  bool autoMute = false;

  void toggleAutoMute() {
    autoMute = !autoMute;
    //데이터 변경 사항을 듣고 있는 화면들이 있음. 데이터가 변경 되었으니 청취자에게 알려줘야함. 리스너로
    // 실제 각 화면에서는 AnimatedBuilder가 듣고 있으며, 변경 사항을 적용해줌.
    // 이전에 InheritedWidget은 위젯트리 맨 위에 있어서, 매번 automute와 같은 상태가 변경되면 전체 앱을 다 Rebuild하지만 이거는 해당 AnimatedBuilder 부분만 Rebuild
    notifyListeners();
  }
}

final videoConfig = VideoConfig();
