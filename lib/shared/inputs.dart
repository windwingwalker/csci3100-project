import 'package:csci3100/views/setting/setting.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class MySettingButton extends StatelessWidget {
  final String name;
  final icon;
  final VoidCallback callback;
  final double width;

  const MySettingButton(this.name, this.icon, this.callback, this.width);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: width,
      decoration: buttonDecoration,
      child: InkWell(
        onTap: callback,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 60,),
            Text(name, style: TextStyle(fontSize: 20),)
          ],
        ),
      ),
    );
  }
}

class MySubmitButton extends StatelessWidget {
  final VoidCallback callback;
  final String name;
  const MySubmitButton(this.name, this.callback);
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.transparent,
      child: Text(
        name,
        style: TextStyle(
          color: Colors.lightGreenAccent,
        ),
      ),
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(25.0),
      ),
      onPressed: callback,
    );
  }
}

class MyTextFormField extends StatelessWidget {
  final Function(String) changeFunc;
  final String type;
  final String initValue;
  const MyTextFormField({this.type, this.initValue, this.changeFunc});

  @override
  Widget build(BuildContext context) {
    bool shouldObscure = false;
    int lines = 1;
    if (type == "Password"){
      shouldObscure = true;
    }
    if (type == "Description of you"){
      lines = 6;
    }

    return TextFormField(
      obscureText: shouldObscure,
      initialValue: initValue,
      validator: (val) {
        if (type == "Email"){
          /*RegExp checkEmail = new RegExp(r"^[A-Za-z0-9]+@.*");
          RegExp checkCUHK = new RegExp(r".*[a-z.]*cuhk\.edu\.hk$");
          if (val.isEmpty){
            return 'Email can not be empty';
          } else if (!checkEmail.hasMatch(val)){
            return "Invalid email syntax";
          } else if (!checkCUHK.hasMatch(val)){
            return 'You must enter an email with CUHK domain';
          }*/
        }else if (type == "Password"){
          return val.length < 6 ? 'Password must be at least 6 characters' : null;
        }else if (type == "Name"){
          return val.isEmpty ? 'Name can not be empty' : null;
        }else if (type == "Description of you"){
          return val.isEmpty ? 'Description can not be empty' : null;
        }
        return null;
      },
      maxLines: lines,
      onChanged: (val) => changeFunc(val),
      style: TextStyle(color: Colors.orange),
      cursorColor: Colors.lightGreenAccent,
      decoration: textInputDecoration.copyWith(hintText: type),
    );
  }
}

class MySlider extends StatelessWidget {
  final Function(double) changeFunc;
  final double age;
  const MySlider({this.age, this.changeFunc});
  @override
  Widget build(BuildContext context) {
    return Slider(
      value: age,
      min: 18,
      max: 30,
      divisions: 12,
      label: "$age",
      onChanged: (val) => changeFunc(val),
    );
  }
}

class MyDropdownButtonFormField extends StatelessWidget {
  final List<String> mylist;
  final String value;
  final Function(String) changeFunc;
  const MyDropdownButtonFormField({this.value, this.mylist, this.changeFunc});
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: textInputDecoration,
      items: mylist.map((item){
        return DropdownMenuItem(
          value: item,
          child: Text('$item'),
        );
      }).toList(),
      onChanged: (val) => changeFunc(val),
      value: value,
    );
  }
}

class MyRangeSlider extends StatelessWidget {
  final RangeValues range;
  final Function(RangeValues) changeFunc;
  const MyRangeSlider({this.range, this.changeFunc});

  @override
  Widget build(BuildContext context) {
    return RangeSlider(
      values: range,
      onChanged: (val) => changeFunc(val),
      min: 18,
      max: 30,
      divisions: 12,
      labels: RangeLabels('${range.start}', '${range.end}'),
    );
  }
}

class MySwitch extends StatelessWidget {
  final Function(bool) changeFunc;
  final String name;
  final bool value;

  const MySwitch({this.name, this.value, this.changeFunc});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Text(
            name,
            style: TextStyle(fontSize: 20,color: Colors.amber),
          ),
        ),
        Expanded(
          flex: 1,
          child: Switch(
            value: value,
            onChanged: (val) => changeFunc(val),
            activeColor: Colors.orange,
          ),
        ),
      ],
    );
  }
}










