

import 'package:flutter/material.dart';
import 'package:mass_qr/models/scans.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class ChartTypes{


  List<dynamic> chartType=[
     Center(
          child:Consumer<ScansModel>(
            builder: (context,provider,child){
            return SfCircularChart(
              // title: ChartTitle(text: 'Sales by sales person'),
              // legend: Legend(isVisible: true),
                series: <PieSeries<PieData, String>>[
                  PieSeries<PieData, String>(
                      explode: true,
                      explodeIndex: 0,
                      dataSource: provider.pieDataList,
                      xValueMapper: (PieData data, _) => data.xDataColor,
                      yValueMapper: (PieData data, _) => data.yDataValue,
                      dataLabelMapper: (PieData data, _) => data.xDataColor,
                      dataLabelSettings: DataLabelSettings(isVisible: true,labelPosition: ChartDataLabelPosition.outside),
                  ),
                ]
            );
            },
          )
      ),



       Center(
          child:Consumer<ScansModel>(
             builder: (context,provider,child){
              return SfCartesianChart(
                   primaryXAxis: CategoryAxis(),
                   // primaryYAxis: CategoryAxis(),
                   // legend: Legend(isVisible: true),
                   series: [
                     StackedColumnSeries(
                         dataSource: provider.pieDataList,
                         xValueMapper: ( PieData data, _) => data.xDataColor,
                         yValueMapper: (PieData data, _) => data.yDataValue ,
                         // dataLabelMapper: (_PieData data, _) => data.text,
                         dataLabelSettings: DataLabelSettings(isVisible: true)
                     ),
                   ]
               );
             },

          )
      ),


     Center(
          child:Consumer<ScansModel>(
            builder: (context,provider,child){
              return SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  // primaryYAxis: CategoryAxis(),
                  // legend: Legend(isVisible: true),
                  series: [
                    StackedBarSeries(
                        dataSource: provider.pieDataList,
                        xValueMapper: (PieData data, _) => data.xDataColor,
                        yValueMapper: (PieData data, _) => data.yDataValue ,
                        // dataLabelMapper: (_PieData data, _) => data.text,
                        dataLabelSettings: DataLabelSettings(isVisible: true)
                    ),
                  ]
              );
            },

          )
      ),

  ];

}

