import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../models/sites.dart';

class SiteListCN with ChangeNotifier, DiagnosticableTreeMixin {
  List<Site>  _data = [];

  List<Site> get data => _data;

  void updateData( List<Site> newData) {
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