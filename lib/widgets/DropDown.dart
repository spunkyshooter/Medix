import 'package:flutter/material.dart';

class DropDown extends StatelessWidget {
  DropDown({this.onChanged, this.items, this.value, this.id, this.title});

  final Function onChanged;
  final List<String> items;
  final String value, id, title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      margin: EdgeInsets.only(left: 12, right: 12, bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: Colors.blueAccent,
            ),
          ),
          SizedBox(
            width: 15,
          ),
          DropdownButton<String>(
            value: value,
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.blueAccent,
            ),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.blueAccent),
            underline: Container(
              height: 1,
              color: Colors.blueAccent,
            ),
            onChanged: (String newValue) {
              onChanged(id, newValue);
            },
            items: items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
