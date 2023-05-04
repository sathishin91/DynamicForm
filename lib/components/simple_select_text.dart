import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';

import '../widgets/required_text.dart';

class SimpleSelectText extends StatefulWidget {
  SimpleSelectText({
    Key? key,
    required this.item,
    required this.onChange,
    required this.position,
    this.errorMessages = const {},
    this.validations = const {},
    this.decorations = const {},
    this.keyboardTypes = const {},
    this.dropDownController,
    this.isEditable = true,
    this.validatorMsg,
    this.isMandatory=false,
    this.enableSearch = false
  }) : super(key: key);
  final dynamic item;
  final Function onChange;
  final int position;
  final Map errorMessages;
  final Map validations;
  final Map decorations;
  final Map keyboardTypes;
  final SingleValueDropDownController? dropDownController;
  final String? validatorMsg;
  final bool isEditable;
  final bool enableSearch;
  final bool isMandatory;

  @override
  _SimpleSelectText createState() => new _SimpleSelectText();
}

class _SimpleSelectText extends State<SimpleSelectText> {
  dynamic item;

  String? isRequired(item, value) {
    if (value.isEmpty) {
      return widget.errorMessages[item['key']] ?? 'Please enter some text';
    }
    return null;
  }
  List<Map<String, dynamic>> itemsValue = [];
  late List<DropDownValueModel> dropDownItems;
  late final bool isMandatory;
  @override
  void initState() {
    super.initState();
    item = widget.item;
    isMandatory = item['mandatory'];
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Opacity(
              opacity: widget.isEditable ? 1.0 : 0.5,
              child: DropDownTextField(
                enableSearch: widget.enableSearch,
                controller: widget.dropDownController,
                dropDownList: (item['items'] as List<dynamic>).map((item) {
                  return DropDownValueModel(
                    name: item['value'] as String,
                    value: item['label'] as String,
                  );
                }).toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Select Value";
                  }
                  return null;
                },
                isEnabled: widget.isEditable,
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
                padding: const EdgeInsets.symmetric(vertical: 5),
                textFieldDecoration: InputDecoration(
                  label: widget.isMandatory
                      ? RequiredText(
                    label: item['label'],
                    style: Theme.of(context).textTheme.titleSmall,
                    starStyle: Theme.of(context).textTheme.headlineMedium,
                  )
                      : Text(item['label'],
                      style: Theme.of(context).textTheme.titleSmall),
                ),

                onChanged: (value) {
                  widget.dropDownController?.setDropDown(value);
                },
                clearOption: false,
              ),
            ),
          )
          // textFieldDecoration: InputDecoration(
          //   label: widget.isMandatory
          //       ? RequiredText(
          //     label: widget.label,
          //     style: Theme.of(context).textTheme.subtitle2,
          //     starStyle: Theme.of(context).textTheme.headline6,
          //   )
          //       : Text(widget.label,
          //       style: Theme.of(context).textTheme.subtitle2),
          // ),
          // onChanged: (value) {
          //   widget.dropDownController.setDropDown(value);
          // },
        ],
      ),
    );
  }
}
