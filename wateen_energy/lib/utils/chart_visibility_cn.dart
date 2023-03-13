import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ChartVisibilityCN with ChangeNotifier, DiagnosticableTreeMixin {
  Map<String,bool> _lblMap = {};

  Map<String,bool> get lblMap => _lblMap;

  void addLabel(String key, bool val) {
    if (lblMap.containsKey(key)) {
      // item exists: update it
      lblMap.update(key, (value) => val);
      print(key + " = " + val.toString());
      notifyListeners();
    } else {
      // item does not exist: set it
      lblMap[key] = val;
    }
  }


  void removeAll() {
    lblMap.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
  }
}