library json_to_form;

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CoreForm extends StatefulWidget {
  final String form;
  final dynamic formMap;
  final EdgeInsets? padding;
  final String? labelText;
  final ValueChanged<dynamic> onChanged;
  final OutlineInputBorder? enabledBorder;
  final OutlineInputBorder? errorBorder;
  final OutlineInputBorder? disabledBorder;
  final OutlineInputBorder? focusedErrorBorder;
  final OutlineInputBorder? focusedBorder;

  const CoreForm({
    required this.form,
    required this.onChanged,
    this.labelText,
    this.padding,
    this.formMap,
    this.enabledBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.focusedBorder,
    this.disabledBorder,
  });

  @override
  _CoreFormState createState() =>
      new _CoreFormState(formMap ?? json.decode(form));
}

class _CoreFormState extends State<CoreForm> {
  final dynamic formItems;

  int? radioValue;

  List<Widget> jsonToForm() {
    List<Widget> listWidget = [];

    for (var item in formItems) {
      if (item['type'] == "Input" ||
          item['type'] == "Password" ||
          item['type'] == "Email" ||
          item['type'] == "TareaText") {
        listWidget.add(new Container(
            padding: new EdgeInsets.only(top: 5.0, bottom: 5.0),
            child: new Text(
              item['title'],
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ))
        );
        listWidget.add(new TextField(
          controller: null,
          inputFormatters: item['validator'] != null && item['validator'] != ''
              ? [
                  if (item['validator'] == 'digitsOnly')
                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                  if (item['validator'] == 'textOnly')
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))
                ]
              : null,
          decoration: new InputDecoration(
            labelText: widget.labelText,
            enabledBorder: widget.enabledBorder ?? null,
            errorBorder: widget.errorBorder ?? null,
            focusedErrorBorder: widget.focusedErrorBorder ?? null,
            focusedBorder: widget.focusedBorder ?? null,
            disabledBorder: widget.disabledBorder ?? null,
            hintText: item['placeholder'] ?? "",
          ),
          maxLines: item['type'] == "TareaText" ? 10 : 1,
          keyboardType: item['keyboardType'] != null
              ? item['keyboardType'][item['key']]
              : TextInputType.text,
          onChanged: (String value) {
            item['response'] = value;
            _handleChanged();
          },
          obscureText: item['type'] == "Password" ? true : false,
        ));
      }

      if (item['type'] == "RadioButton") {
        listWidget.add(new Container(
            margin: new EdgeInsets.only(top: 5.0, bottom: 5.0),
            child: new Text(item['title'],
                style: new TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16.0))));
        radioValue = item['value'];
        for (var i = 0; i < item['list'].length; i++) {
          listWidget.add(
            new Row(
              children: <Widget>[
                new Expanded(child: new Text(item['list'][i]['title'])),
                new Radio<int>(
                    value: item['list'][i]['value'],
                    groupValue: radioValue,
                    onChanged: (int? value) {
                      this.setState(() {
                        radioValue = value;
                        item['value'] = value;
                        _handleChanged();
                      });
                    })
              ],
            ),
          );
        }
      }

      if (item['type'] == "Switch") {
        listWidget.add(
          new Row(children: <Widget>[
            new Expanded(child: new Text(item['title'])),
            new Switch(
                value: item['switchValue'],
                onChanged: (bool value) {
                  this.setState(() {
                    item['switchValue'] = value;
                    _handleChanged();
                  });
                })
          ]),
        );
      }

      if (item['type'] == "Checkbox") {
        listWidget.add(new Container(
            margin: new EdgeInsets.only(top: 5.0, bottom: 5.0),
            child: new Text(item['title'],
                style: new TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16.0))));
        for (var i = 0; i < item['list'].length; i++) {
          listWidget.add(
            new Row(
              children: <Widget>[
                new Expanded(child: new Text(item['list'][i]['title'])),
                new Checkbox(
                    value: item['list'][i]['value'],
                    onChanged: (bool? value) {
                      this.setState(() {
                        item['list'][i]['value'] = value;
                        _handleChanged();
                      });
                    })
              ],
            ),
          );
        }
      }
    }
    return listWidget;
  }

  _CoreFormState(this.formItems);

  void _handleChanged() {
    widget.onChanged(formItems);
  }

  void onChange(int position, dynamic value) {
    this.setState(() {
      formItems[position]['value'] = value;
      _handleChanged();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding ?? EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: jsonToForm(),
      ),
    );
  }
}
