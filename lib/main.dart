import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:intl/intl.dart';

import 'Model/Person.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(brightness: Brightness.dark),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _name;
  TextEditingController _address;
  FocusNode _namenode;
  FocusNode _addressnode;
  var date = "DATE OF BIRTH";
  Person person = Person();
  Color color = Colors.blue;
  Color tempColor;
  List<Color> tileColor=List<Color>();
  List<String> states = [
    "Select State",
    "Andra Pradesh",
    "Arunachal Pradesh",
    "Assam",
    "Bihar",
    "Chhattisgarh",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jammu and Kashmir",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Madya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Orissa",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telagana",
    "Tripura",
    "Uttaranchal",
    "Uttar Pradesh",
    "West Bengal",
    "Andaman and Nicobar Islands",
    "Chandigarh",
    "Dadar and Nagar Haveli",
    "Daman and Diu",
    "Delhi",
    "Lakshadeep",
    "Pondicherry"
  ];
  String state = "";
  final _formKey = GlobalKey<FormState>();
  List<String> names=List<String>();

  Future _selectDate(context) async {
    final DateTime selectDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1980, 1),
        lastDate: DateTime(2100, 12));
    if (selectDate != null &&
        DateFormat("dd-MM-yyyy").format(selectDate) !=
            DateFormat("dd-MM-yyyy").format(DateTime.now())) {
      setState(() {
        date = DateFormat("dd-MM-yyyy").format(selectDate);
      });
    } else {
      date = "DATE OF BIRTH";
    }
  }

  void _selectColor() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(8.0),
          content: MaterialColorPicker(
            onColorChange: (color) {
              setState(() {
                tempColor = color;
              });
            },
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("CANCEL"),
              onPressed: () => Navigator.pop(context),
            ),
            FlatButton(
              child: Text("SUBMIT"),
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  color = tempColor;
                });
              },
            )
          ],
        );
      },
    );
  }
  bool _validateForm(){
    if(date=="DATE OF BIRTH"){
      showDialog(
          context: context,
          builder: (_){
            return AlertDialog(
              content: Text("Please select the Date of Birth"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Ok"),
                  onPressed: ()=>Navigator.pop(context),
                )
              ],
            );
          }
      );
      return false;
    }
    if(state==states[0]){
      showDialog(
          context: context,
          builder: (_){
            return AlertDialog(
              content: Text("Please choose your State"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Ok"),
                  onPressed: ()=>Navigator.pop(context),
                )
              ],
            );
          }
      );
      return false;
    }
    return true;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _name = TextEditingController();
    _address = TextEditingController();
    _namenode = FocusNode();
    _addressnode = FocusNode();
    state = states[0];

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  autovalidate: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 100,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          autofocus: false,
                          keyboardType: TextInputType.text,
                          maxLength: 30,
                          controller: _name,
                          focusNode: _namenode,
                          validator: (value)=>value.isEmpty?"Please fill Name":null,
                          decoration: InputDecoration(
                            labelText: "NAME",
                            helperText: '',
                            border: OutlineInputBorder(),
                            counterText: "",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          autofocus: false,
                          keyboardType: TextInputType.text,
                          maxLength: 200,
                          controller: _address,
                          focusNode: _addressnode,
                          validator: (value)=>value.isEmpty?"Please fill the Address":null,
                          decoration: InputDecoration(
                            labelText: "ADDRESS",
                            helperText: '',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      RaisedButton.icon(
                        icon: Icon(Icons.calendar_today),
                        label: Text("$date"),
                        color: Colors.blue,
                        onPressed: () {
                          _selectDate(context);
                          _namenode.unfocus();
                          _addressnode.unfocus();
                        },
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                            color: color,
                            child: Text("CHOOSE YOUR FAVOURITE COLOR"),
                            onPressed: _selectColor,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                          ),
                      ),
                      DropdownButton(
                        hint: Text("Select State..."),
                        value: state,
                        items: states.map((f) {
                          return DropdownMenuItem(
                            value: f,
                            child: Text(f),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            state = value;
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          child: Text("Submit"),
                          color: Colors.blue,
                          onPressed: () {
                            if(_formKey.currentState.validate()){
                              print("Validate");
                              if(_validateForm()){
                                person.name = _name.text;
                                person.address = _address.text;
                                person.dob = date;
                                person.color = color;
                                person.state = state;
                                setState(() {
                                  names.add(_name.text);
                                  print(names);
                                  tileColor.add(color);
                                });
                              }
                            }
                            else{
                              print("error");
                            }
                          },
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      Container(
                        height: 200,
                        child: ListView.builder(itemCount:names.length!=0?names.length:0,itemBuilder: (context,index)=>
                            Column(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                    color: tileColor[index],
                                  ),
                                  child: ListTile(
                                    title: Center(child: Text(names[index])),
                                  ),
                                ),
                                Divider(thickness: 1.5,),
                              ],
                            )
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        ),
      ),
    );
  }
}
