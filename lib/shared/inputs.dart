import 'package:flutter/material.dart';

import 'constants.dart';

//custom setting button
class MySettingButton extends StatelessWidget {
  final String name;
  final icon;
  final VoidCallback callback;

  const MySettingButton(this.name, this.icon, this.callback);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: settingButtonDecoration,
        child: InkWell(
          onTap: callback,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(flex:2 ,child: Icon(icon, size: 60, color: Colors.amber,)),
              Expanded(flex:1, child: Text(name, style: TextStyle(fontSize: 20, color: Colors.orangeAccent),))
            ],
          ),
        ),
      ),
    );
  }
}

//custom home button
class MyHomeButton extends StatelessWidget{
  final icon;
  final VoidCallback callback;

  const MyHomeButton(this.icon, this.callback);


  @override
  Widget build(BuildContext context) {
    var color;
    if (icon == Icons.clear){
      color = Colors.red;
    }else if(icon == Icons.check){
      color = Colors.green;
    }else{
      color = Colors.white;
    }
    return Container(
      height: 100,
      width: 100,
      //decoration: icon == Icons.check ? null : homeButtonDecoration,
      child: IconButton(icon: Icon(icon, size: 60, color: color,), onPressed: callback)

    );
  }
}

//custom submit button
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

//custom text form
class MyTextFormField extends StatelessWidget {
  final Function(String) changeFunc;
  final String type;
  final String initValue;
  const MyTextFormField({this.type, this.initValue, this.changeFunc});

  @override
  Widget build(BuildContext context) {
    bool shouldObscure = type == "Password" ? true : false;
    int lines = type == "Description of you"
        || type == "Your request"
        || type == "Detail of report"
        ? 7 : 1;

    return TextFormField(
      obscureText: shouldObscure,
      initialValue: initValue,
      validator: (val) {
        if (type == "Email") {
          RegExp checkEmail = new RegExp(r"^[A-Za-z0-9]+@.*");
          RegExp checkCUHK = new RegExp(r".*[a-z.]*cuhk\.edu\.hk$");
          if (val.isEmpty){
            return 'Email can not be empty';
          } else if (!checkEmail.hasMatch(val)){
            return "Invalid email syntax";
          } else if (!checkCUHK.hasMatch(val)){
            return 'You must enter an email with CUHK domain';
          }
        }else if (type == "Your contact email")  {
          RegExp checkEmail = new RegExp(r"^[A-Za-z0-9]+@.*");
          if (val.isEmpty){
            print("empty");
            return 'Email can not be empty';
          } else if (!checkEmail.hasMatch(val)){
            print("not email");
            return "Invalid email syntax";
          }else{
            print("ok");
            return null;
          }
        }else if (type == "Password"){
          return val.length < 6 ? 'Password must be at least 6 characters' : null;
        }else if (type == "Name"){
          return val.isEmpty ? 'Name can not be empty' : null;
        }else if (type == "Description of you"){
          return val.isEmpty ? 'Description can not be empty' : null;
        }else if (type == "Your request"){
          return val.isEmpty ? 'Request can not be empty' : null;
        }else if (type == "Detail of report"){
          return val.isEmpty ? 'Report can not be empty' : null;
        }
        return null;
      },
      maxLines: lines,
      onChanged: (val) => changeFunc(val),
      style: TextStyle(color: Colors.orange),
      cursorColor: Colors.lightGreenAccent,
      decoration: textInputDecoration.copyWith(labelText: type),
    );
  }
}

//custom slider
class MySlider extends StatelessWidget {
  final Function(double) changeFunc;
  final double age;
  const MySlider({this.age, this.changeFunc});
  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
        thumbColor: Colors.amberAccent,
        activeTrackColor: Colors.orange[700],
        inactiveTrackColor: Colors.amber[400],
        overlayColor: Colors.orange.withAlpha(32),
        overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
        valueIndicatorShape: PaddleSliderValueIndicatorShape(),
        valueIndicatorColor: Colors.green,
        valueIndicatorTextStyle: TextStyle(
          color: Colors.white,
        ),
      ),
      child: Slider(
        value: age,
        min: 18,
        max: 30,
        divisions: 12,
        label: "$age",
        onChanged: (val) => changeFunc(val),
      ),
    );
  }
}

//custom drop down button
class MyDropdownButtonFormField extends StatelessWidget {
  final List<String> mylist;
  final String type;
  final String value;
  final Function(String) changeFunc;
  const MyDropdownButtonFormField({this.value, this.type, this.mylist, this.changeFunc});
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      hint: Text(type, style: TextStyle(color: Colors.lightGreenAccent)),
      style: TextStyle(color: Colors.orange),
      decoration: textInputDecoration,
      validator: (val) => val.isEmpty ? 'Value can not be empty' : null,
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

//custom range slider
class MyRangeSlider extends StatelessWidget {
  final RangeValues range;
  final Function(RangeValues) changeFunc;
  const MyRangeSlider({this.range, this.changeFunc});

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
        thumbColor: Colors.amberAccent,
        activeTrackColor: Colors.amber[400],
        inactiveTrackColor: Colors.orange[700],
        overlayColor: Colors.orange.withAlpha(32),
        overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
        valueIndicatorShape: PaddleSliderValueIndicatorShape(),
        valueIndicatorColor: Colors.green,
        valueIndicatorTextStyle: TextStyle(
          color: Colors.white,
        ),
      ),
      child: RangeSlider(
        values: range,
        onChanged: (val) => changeFunc(val),
        min: 18,
        max: 30,
        divisions: 12,
        labels: RangeLabels('${range.start}', '${range.end}'),
      ),
    );
  }
}

//custom switch
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

//custom login title
class MyFirstLoginTitle extends StatelessWidget{
  final String text;
  final double size;

  const MyFirstLoginTitle({this.text, this.size});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(text,
        style: TextStyle(color: Colors.orange, fontSize: size)),
    );
  }
}

//custom intro text
class MyIntroText extends StatelessWidget{

  final String text;
  final String type;
  const MyIntroText(this.text, this.type);
  @override
  Widget build(BuildContext context) {
    var size = type == "name" ? 40.0 : 20.0;
    return Container(
      child: Text(
        text,
        style: TextStyle(
          color: Colors.amberAccent,
          fontSize: size,
        ),
      ),
    );
  }
}










