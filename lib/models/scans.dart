import 'dart:collection';

import 'package:flutter/material.dart';

class ScansModel extends ChangeNotifier {
  final List<String> _scans = [];
  List Red=[];
  List Green=[];
  List Blue=[];
  List Yellow=[];


  List<PieData> pieDataList=[
    PieData("red", 0),
    PieData("green", 0),
    PieData("blue", 0),
    PieData("yellow", 0),
  ];

  late int currentChartType;

  UnmodifiableListView<String> get scans => UnmodifiableListView(_scans);

  void add(String item) {
    _scans.add(item);
    List colorIndex = item.split("*");
    String colorName = colorIndex[0];
    if(colorName=="red"){
      Red.add(item);
      print("RedLength  "+Red.length.toString());
      pieDataList=[
        PieData("red", Red.length),
        PieData("green", Green.length),
        PieData("blue", Blue.length),
        PieData("yellow", Yellow.length),
      ];
     notifyListeners();
    }else if(colorName=="green"){
      Green.add(item);
      print("GreenLength  "+Green.length.toString());
      pieDataList=[
        PieData("red", Red.length),
        PieData("green", Green.length),
        PieData("blue", Blue.length),
        PieData("yellow", Yellow.length),
      ];
      notifyListeners();
    } else if(colorName=="blue"){
      Blue.add(item);
      print("BlueLength  "+Blue.length.toString());
      pieDataList=[
        PieData("red", Red.length),
        PieData("green", Green.length),
        PieData("blue", Blue.length),
        PieData("yellow", Yellow.length),
      ];
      notifyListeners();
    }else if(colorName=="yellow"){
      Yellow.add(item);
      print("YellowLength  "+Yellow.length.toString());
      pieDataList=[
        PieData("red", Red.length),
        PieData("green", Green.length),
        PieData("blue", Blue.length),
        PieData("yellow", Yellow.length),
      ];
      notifyListeners();
    }
    notifyListeners();
  }

  void removeAll() {
     Red=[];
     Green=[];
     Blue=[];
     Yellow=[];
    _scans.clear();
    notifyListeners();
  }

  void updateListType(int index){
    currentChartType=index;
  }

  void AddRed(String items){
    Red.add(items);
  }

  void AddGreen(String items){
    Green.add(items);
  }

  void AddBlue(String items){
    Blue.add(items);
  }

  void AddYellow(String items){
    Yellow.add(items);
  }

}

class PieData {
  PieData(this.xDataColor, this.yDataValue, );
  final String xDataColor;
  final num yDataValue;
}