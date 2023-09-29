import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mass_qr/pages/chartType.dart';
import 'package:mass_qr/pages/export.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:mass_qr/models/scans.dart';
import 'package:mass_qr/pages/help.dart';
import 'package:mass_qr/pages/settings.dart';
import 'package:mass_qr/pages/scan.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<String>  ChartsList = ["PieChart","VerticalBar","HorizontalBar"];
  List<Icon>iconList   = [Icon(Icons.pie_chart,size: 35,),Icon(Icons.bar_chart,size: 35,),Icon(Icons.bar_chart,size: 35,)];


  int currentChartType=0;
  var dropdownValue = "PieChart" ;


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('MultiQR'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.help_outline),
            tooltip: 'Help',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HelpPage(),
                  ));
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 10,),
          Container(
            child: Consumer<ScansModel>(builder: (context, scans, child) {
              return Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScanPage(),
                          ),
                        );
                      },
                      child: Text('Scan'),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: const Icon(Icons.settings),
                      tooltip: 'Settings',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SettingsPage(),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: const Icon(Icons.delete_rounded),
                      tooltip: "Delete All",
                      onPressed: scans.scans.length == 0
                          ? null
                          : () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Are you sure?'),
                                  content: Text(
                                      'This will delete all scans.\n\nTo save them first, use the Export button'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        scans.removeAll();
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text('Deleted'),
                                          ),
                                        );
                                      },
                                      child: Text('Delete'),
                                      style: TextButton.styleFrom(
                                        foregroundColor: Theme.of(context).colorScheme.error,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExportPage(),
                          ),
                        );
                      },
                      child: Text('Export'),
                    ),
                  ),
                ],
              );
            }),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Consumer<ScansModel>(
                builder: (context, scans, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      scans.scans.length == 0
                          ?

                         Center(
                           heightFactor:2,
                         child: Image(image: AssetImage('assets/empty_state.png'))
                         )
                  :
                  /*Expanded(
                        child: ListView(
                          children: scans.scans
                              .map(
                                (e) => Container(
                              child: Text(e),
                              padding: EdgeInsets.fromLTRB(
                                  0, 10, 0, 10),
                            ),
                          )
                              .toList(),
                          shrinkWrap: true,
                        ),
                      )*/

                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Column(
                              children: [
                                Container(
                                  height: 110,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(padding:const EdgeInsets.only(top: 7,left: 10,bottom: 15),child: Text("Chart type",style: TextStyle(color: Colors.black87,fontSize: 16),)),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Container(
                                          height: 60,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(12)
                                          ),
                                          child: Row(
                                            children: [
                                              Padding(padding:const EdgeInsets.symmetric(horizontal: 9),child: iconList[currentChartType]),
                                              Expanded(
                                                child: DropdownButton<dynamic>(
                                                  // isDense: true,
                                                  //focusNode: FocusNode(),
                                                  underline: DropdownButtonHideUnderline(child: SizedBox(),),
                                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                                  isExpanded: true,
                                                  value: dropdownValue,
                                                  icon: Icon(Icons.arrow_drop_down, size: 35),
                                                  elevation: 0,
                                                  style: TextStyle(color: Colors.black, fontSize: 16),

                                                  onChanged: (value) {
                                                    // This is called when the user selects an item.
                                                    setState(() {
                                                      dropdownValue = value!;
                                                      currentChartType=ChartsList.indexOf(value);
                                                      print("----------**********__________");
                                                      // print(dropdownValue);

                                                    });
                                                  },
                                                  onTap: () {
                                                    dropdownValue;
                                                  },
                                                  items: ChartsList.map((dynamic value) {
                                                    return DropdownMenuItem(
                                                      value: value,
                                                      child: ListTile(
                                                        // leading:iconList[currentChartType],
                                                        title:  Text(value,style: TextStyle(color: Colors.black87,fontSize: 25),),
                                                        // trailing: Icon(Icons.arrow_drop_down,size: 38),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),

                                            ],
                                          )

                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5,),

                                Container(
                                  height: 270,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white
                                  ),
                                  child: Scrollbar(
                                   thumbVisibility: true,
                                    radius: Radius.circular(3),
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 9),
                                      child: Column(
                                       crossAxisAlignment:CrossAxisAlignment.start,
                                        children: [
                                          Padding(padding:const EdgeInsets.only(top: 5,left: 5,bottom: 15),child: Text("SUGGESTED",style: TextStyle(color: Colors.black87,fontSize: 16,fontWeight: FontWeight.bold))),
                                          Expanded(
                                            child: GridView.builder(
                                              shrinkWrap: true,
                                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                mainAxisSpacing: 3,
                                                crossAxisSpacing: 3),
                                                itemCount: ChartTypes().chartType.length,
                                                itemBuilder: (context,index){

                                                  // return ChartTypes().chartType[index];
                                                  return GestureDetector(
                                                    onTap: (){
                                                      setState(() {
                                                        currentChartType=index;
                                                        print("8888888888888888888888888888");
                                                        print(currentChartType);
                                                      });
                                                    },
                                                    child: Container(
                                                        height: 110,
                                                        width: 150,
                                                        decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.fromBorderSide(BorderSide(color: Colors.black.withOpacity(0.2),width: 4))
                                                    ),
                                                    child:ChartTypes().chartType[index]
                                                    ),
                                                  );
                                                }
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      if(scans.scans.length > 0) Divider(color: Colors.black.withOpacity(0.7),),

                      if(scans.scans.length > 0)
                      Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(padding:const EdgeInsets.only(top: 5,left: 5),child: Text("Count",style: TextStyle(color: Colors.black87,fontSize: 23),)),
                          Container(
                            height: 110,
                            width: double.infinity,
                            // color: Colors.black,
                            child: Center(
                              child:ChartTypes().chartType[currentChartType] ,
                            ),
                          )

                        ],
                      )


                        ],
                  );
                },
              ),
            ),
          ),

        ],
      ),
    );


  }
}

String generateNowString() {
  String fillZeros(String string, int length) {
    while (string.length < length) string = '0' + string;
    return string;
  }

  DateTime now = DateTime.now();
  return now.year.toString() +
      '-' +
      fillZeros(now.month.toString(), 2) +
      '-' +
      fillZeros(now.day.toString(), 2) +
      '-' +
      fillZeros(now.hour.toString(), 2) +
      '-' +
      fillZeros(now.minute.toString(), 2) +
      '-' +
      fillZeros(now.second.toString(), 2) +
      '-' +
      fillZeros(now.millisecond.toString(), 3);
}

Future<void> exportData(List<String> scans) async {
  String fileName = 'MassQR-Export-${generateNowString()}.txt';
  final String path = '${(await getTemporaryDirectory()).path}/$fileName';
  final File file = File(path);
  await file.writeAsString(scans.join('\n'), flush: true);
  await Share.shareFiles([path], text: 'MassQR Export');
}
