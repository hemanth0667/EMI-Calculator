import 'package:flutter/material.dart';
import 'dart:math';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List tenuretypes=[ "Month(s)","Year(s)"];
  String tenuretype="Year(s)";
  String emiresult="";

  final TextEditingController principalamount=TextEditingController();
  final TextEditingController interestrate=TextEditingController();
  final TextEditingController tenure=TextEditingController();

  bool switchvalue=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "EMI Calculator"
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 10.0,bottom: 10.0,left: 20.0,right: 20.0),
                child: TextField(
                     controller: principalamount,
                     decoration: InputDecoration(
                       labelText: "Enter Principal Amount"
                     ), 
                     keyboardType: TextInputType.number,   
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10.0,bottom: 10.0,left: 20.0,right: 20.0),
                child: TextField(
                  controller: interestrate,
                     decoration: InputDecoration(
                       labelText: "Interest Rate"
                     ),    
                     keyboardType: TextInputType.number,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10.0,bottom: 10.0,left: 20.0,right: 20.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      flex: 4,
                      fit: FlexFit.tight,
                      child: TextField(
                        controller: tenure,
                     decoration: InputDecoration(
                       labelText: "Tenure"
                     ), 
                     keyboardType: TextInputType.number,
                      ), 
                      ),
                      Flexible(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            Text(
                              tenuretype,
                              style: TextStyle(
                                fontWeight:FontWeight.bold, 
                              ),
                              ),
                             Switch(
                               value: switchvalue,
                               onChanged: (bool value){
                                 if(value){
                                   tenuretype=tenuretypes[1];
                                 }
                                 else{
                                   tenuretype=tenuretypes[0];
                                 }
                                 setState(() {
                                   switchvalue=value;
                                 });
                               },
                               )
                          ],

                        ),
                      )
                  ],
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: RaisedButton(
                  onPressed: _handlecalculation,
                  child: Text("Calculate"),
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0 ,left: 24.0 ,right: 24.0),
                ),
              ),
              emiresultwidget(emiresult)
            ],
          ),
        ),
      ),
    );
  }

void _handlecalculation(){
  
   double a=0.0;
   int p=int.parse(principalamount.text);
   double r=double.parse(interestrate.text)/12/100;
   int n=tenuretype=="Year(s)"?int.parse(tenure.text)*12 :int.parse(tenure.text);

   a=(p*r*pow((1+r),n)/(pow((1+r),n)-1));
   emiresult = a.toStringAsFixed(2);
   
  setState((){

  });
}
Widget emiresultwidget(emires)
{
  bool canshow = false;
  String emiresult=emires;
  if(emiresult.length>0)
  canshow=true;
  return
  Container(
                margin: EdgeInsets.only(top: 40.0),
                child: canshow ? Column(
                  children: <Widget>[
                    Text(
                      "Your monthly EMI is",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        ),
                    ),
                    
                    Container(
                      child: Text(
                        emiresult,
                        style: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                        ),),
                    ),
                ],
                ):Container()
              );
}}