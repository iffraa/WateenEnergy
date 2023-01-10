import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class BottomNavIndexCN with ChangeNotifier, DiagnosticableTreeMixin {
  int selectedIndex = 0;

  int get selIndex => selectedIndex;

  void setIndex(int index) {
    selectedIndex  = index;
    notifyListeners();
  }


  void removeAll() {
    selectedIndex = 0;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('count', selIndex));
  }
}