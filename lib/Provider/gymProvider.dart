import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../Model/gymPriceDto.dart';

class GymProvider with ChangeNotifier {
  String? _gymName;
  String? _gymAddress;
  String? _gymArea;
  String? _gymCount;
  String? _gymOneline;
  String? _gymIntroduce;
  String? _gymCode;

  void register_gymInfo(String code,String gym_name, String gym_address, String gym_area,
      String gym_count, String gym_oneline, String gym_introduce) {
    _gymName = gym_name;
    _gymCode = code;
    _gymAddress = gym_address;
    _gymArea = gym_area;
    _gymCount = gym_count;
    _gymOneline = gym_oneline;
    _gymIntroduce = gym_introduce;
    notifyListeners();
  }

  //gymTime
  String? _mondayTime;
  String? _tuesdayTime;
  String? _wednesdayTime;
  String? _thursdayTime;
  String? _fridayTime;
  String? _saturdayTime;
  String? _sundayTime;
  String? _holidayTime;
  String? _closedTime;

  void register_gymTime(
      String monday,
      String tuesday,
      String wednesday,
      String thursday,
      String friday,
      String saturday,
      String sunday,
      String holiday,
      String colseday) {
    _mondayTime = monday;
    _tuesdayTime = tuesday;
    _wednesdayTime = wednesday;
    _thursdayTime = thursday;
    _fridayTime = friday;
    _saturdayTime = saturday;
    _sundayTime = sunday;
    _holidayTime = holiday;
    _closedTime = colseday;
    notifyListeners();
  }

  //gymImg
  List<XFile> _image_picked = [];

  void register_gymImg(List<XFile> gymImgs) {
    _image_picked = gymImgs;
    notifyListeners();
  }

  //gymPrices
  List<GymPriceDto> _prices = [];

  void register_gymPrices(List<GymPriceDto> gymPrices) {
    _prices = gymPrices;
    notifyListeners();
  }

  String? get gymName => _gymName;

  String? get gymAddress => _gymAddress;

  String? get gymArea => _gymArea;

  String? get gymCount => _gymCount;

  String? get gymOneline => _gymOneline;

  String? get gymCode => _gymCode;

  String? get gymIntroduce => _gymIntroduce;

  String? get mondayTime => _mondayTime;

  String? get tuesdayTime => _tuesdayTime;

  String? get wednesdayTime => _wednesdayTime;

  String? get thursdayTime => _thursdayTime;

  String? get fridayTime => _fridayTime;

  String? get saturdayTime => _saturdayTime;

  String? get sundayTime => _sundayTime;

  String? get holidayTime => _holidayTime;

  String? get closedTime => _closedTime;

  //gymImg
  List<XFile> get image_picked => _image_picked;

  //gymPrices
  List<GymPriceDto> get prices => _prices;
}
