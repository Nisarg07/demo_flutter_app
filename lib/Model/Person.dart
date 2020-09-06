import 'dart:ui';

class Person {
  Person({this.name, this.address, this.dob, this.color, this.state});

  String name;
  String address;
  String dob;
  Color color;
  String state;

  String getName() => name;

  String getAddress() => address;

  String getdob() => dob;

  Color getColor() => color;

  String getState() => state;
}
