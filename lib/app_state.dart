import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _CatNames = prefs.getStringList('ff_CatNames') ?? _CatNames;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  List<String> _CatNames = ['Mia', 'Mua', 'Kati'];
  List<String> get CatNames => _CatNames;
  set CatNames(List<String> _value) {
    _CatNames = _value;
    prefs.setStringList('ff_CatNames', _value);
  }

  void addToCatNames(String _value) {
    _CatNames.add(_value);
    prefs.setStringList('ff_CatNames', _CatNames);
  }

  void removeFromCatNames(String _value) {
    _CatNames.remove(_value);
    prefs.setStringList('ff_CatNames', _CatNames);
  }

  void removeAtIndexFromCatNames(int _index) {
    _CatNames.removeAt(_index);
    prefs.setStringList('ff_CatNames', _CatNames);
  }

  void updateCatNamesAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _CatNames[_index] = updateFn(_CatNames[_index]);
    prefs.setStringList('ff_CatNames', _CatNames);
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
