import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import '../widgets/required_text.dart';
import 'meta_styles.dart';

class SimpleDropSelect extends StatefulWidget {
  SimpleDropSelect({
    Key? key,
    required this.item,
    required this.onChange,
    required this.position,
    this.errorMessages = const {},
    this.validations = const {},
    this.decorations = const {},
    this.keyboardTypes = const {},
  }) : super(key: key);
  final dynamic item;
  final Function onChange;
  final int position;
  final Map errorMessages;
  final Map validations;
  final Map decorations;
  final Map keyboardTypes;

  @override
  _SimpleDropSelect createState() => new _SimpleDropSelect();
}

class _SimpleDropSelect extends State<SimpleDropSelect> {
  dynamic item;
  String? _itemType;
  String? isRequired(item, value) {
    if (value.isEmpty) {
      return widget.errorMessages[item['key']] ?? 'Please enter some text';
    }
    return null;
  }
  List<Map<String, dynamic>> itemsValue = [];
  @override
  void initState() {
    super.initState();
    item = widget.item;
    print("items ${item['items']}");
  }
  @override
  Widget build(BuildContext context) {
    // Widget label = SizedBox.shrink();
    // if (Fun.labelHidden(item)) {
    //   label = new Text(item['label'],
    //       style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0));
    // }
    return new Container(
      width: 300,
      margin: new EdgeInsets.only(top: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // label,
          DropdownSearch<String>(
            popupProps: PopupProps.menu(
              constraints: const BoxConstraints(
                maxHeight: 120,
              ),
              menuProps: const MenuProps(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20),
                  ),
                ),
              ),
            ),
            validator: (value) {
              if (value == null) {
                return 'Please select value';
              }
              return null;
            },
            onChanged: (String? value) {
              setState(() {
                _itemType = value;
              });
            },
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration:
              MetaStyles.customInputDecoration(
                context,
                label: RequiredText(
                  label: "${item['label']}",
                ),
              ),
            ),
            // dropdownDecoratorProps: DropDownDecoratorProps(
            //   dropdownSearchDecoration:
            //   MetaStyles.customInputDecoration(context,
            //       labelText: '${item['label']}',
            //       hintText: 'Select Type'),
            // ),
            selectedItem: _itemType,
            items: item['items']
                .map<String>((data) => data['value'] as String)
                .toList(),
          ),
          // new DropdownButton<String>(
          //   isExpanded: true,
          //   itemHeight: 60,
          //   hint: new Text("Select a user"),
          //   value: item['value'],
          //   onChanged: (String? newValue) {
          //     setState(() {
          //       item['value'] = newValue;
          //       widget.onChange(widget.position, newValue);
          //     });
          //   },
          //   items: item['items'].map<DropdownMenuItem<String>>((dynamic data) {
          //     return DropdownMenuItem<String>(
          //       value: data['value'],
          //       child: new Text(
          //         data['label'],
          //         style: new TextStyle(color: Colors.black),
          //       ),
          //     );
          //   }).toList(),
          // ),
            // dropdownDecoratorProps: DropDownDecoratorProps(
            //   dropdownSearchDecoration:
            //   MetaStyles.customInputDecoration(
            //     context,
            //     label: const RequiredText(
            //       label: "Account Type",
            //     ),
            //   ),
            // ),
        ],
      ),
    );
  }
}
