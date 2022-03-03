// ignore_for_file: use_key_in_widget_constructors, prefer_final_fields, unused_field, prefer_const_constructors, unused_local_variable, avoid_unnecessary_containers, non_constant_identifier_names

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Simple Interest Calculator",
      home: SIForm(),
      theme: ThemeData(
        primaryColor: Colors.orangeAccent,
        brightness: Brightness.dark,
      )));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  var _formKey = GlobalKey<FormState>();

  final _minimumpadding = 5.0;

  TextEditingController principalControler = TextEditingController();
  TextEditingController roiControler = TextEditingController();
  TextEditingController termControler = TextEditingController();

  var displayResult = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Simple Interest Calculator")),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(_minimumpadding * 2),
            child: ListView(
              children: <Widget>[
                getImageAsset(),
                Padding(
                  padding: EdgeInsets.only(
                      top: _minimumpadding, bottom: _minimumpadding),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: principalControler,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Please enter Principal amount";
                      }
                    },
                    decoration: InputDecoration(
                        labelText: "Principal",
                        errorStyle: TextStyle(
                          color: Colors.greenAccent,
                          fontSize: 15.0,
                        ),
                        hintText: "Enter principal here",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: _minimumpadding, bottom: _minimumpadding),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: roiControler,
                    validator: (String? value) {
                      if (value!.isEmpty || double.tryParse(value) == null) {
                        return 'Please enter return on investment';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: "Rate of interest",
                        hintText: "Enter Rate here",
                        errorStyle: TextStyle(
                          color: Colors.greenAccent,
                          fontSize: 15.0,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumpadding, bottom: _minimumpadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: termControler,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter the time in years';
                            }
                          },
                          decoration: InputDecoration(
                              labelText: "Term",
                              hintText: "Time in years",
                              errorStyle: TextStyle(
                                  color: Colors.greenAccent, fontSize: 15.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        )),
                        Container(
                          width: _minimumpadding * 5,
                        ),
                        Expanded(
                            child: TextFormField(
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter the currency';
                            }
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Money",
                              errorStyle: TextStyle(
                                  color: Colors.greenAccent, fontSize: 15.0),
                              hintText: "Dollars or FRW",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        ))
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumpadding, bottom: _minimumpadding),
                    child: Row(
                      children: [
                        Expanded(
                            child: RaisedButton(
                          child: Text("Calculate"),
                          onPressed: () {
                            setState(() {
                              if (_formKey.currentState!.validate()) {
                                this.displayResult = _calculateTotalReturns();
                              }
                            });
                          },
                        )),
                        Expanded(
                            child: RaisedButton(
                          child: Text("Reset"),
                          onPressed: () {
                            setState(() {
                              _reset();
                            });
                          },
                        ))
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumpadding, bottom: _minimumpadding),
                    child: Text(this.displayResult))
              ],
            ),
          ),
        ));
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage("images/money.png");
    Image image = Image(image: assetImage);

    return Container(
      child: image,
      padding: EdgeInsets.all(_minimumpadding * 10),
    );
  }

  String _calculateTotalReturns() {
    double principal = double.parse(principalControler.text);
    double roi = double.parse(roiControler.text);
    double term = double.parse(termControler.text);

    double totalAmountPayable = principal + (principal * roi * term) / 100;

    String result =
        "After $term years, your investment will be worth $totalAmountPayable";

    return result;
  }

  void _reset() {
    principalControler.text = " ";
    roiControler.text = " ";
    termControler.text = " ";
    displayResult = " ";
  }
}
