import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:wateen_energy/models/alarm.dart';

import '../models/sites.dart';

class AlarmListCN with ChangeNotifier, DiagnosticableTreeMixin {
  List<Alarm>  _data = [];

  List<Alarm> get data => _data;

  void updateData( List<Alarm> newData) {
    data.addAll(newData);
    notifyListeners();
  }


  void clear( ) {
    data.clear();
    notifyListeners();
  }
  /// Makes `selectedDay` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

  }

  void initializeDate() {
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}