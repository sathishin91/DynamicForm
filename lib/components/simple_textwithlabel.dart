import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../functions.dart';
import '../widgets/required_text.dart';

class SimpleTextLabel extends StatefulWidget {
  SimpleTextLabel({
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
  _SimpleTextLabel createState() => new _SimpleTextLabel();
}

class _SimpleTextLabel extends State<SimpleTextLabel> {
  dynamic item;

  String? isRequired(item, value) {
    if (value.isEmpty) {
      return widget.errorMessages[item['key']] ?? 'Please enter some text';
    }
    return null;
  }
  final bool isMandatory=false;
  final String? title="";
  final bool isEditable=false;
  final double opacity=0.8;
  final bool isUpperCaseOnly=false;
  final bool autofocus=false;
  late final List<TextInputFormatter> inputFormatters;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    item = widget.item;
    inputFormatters = item['inputformatters'];
  }

  @override
  Widget build(BuildContext context) {
    Widget label = SizedBox.shrink();
    if (Fun.labelHidden(item)) {
      label = new Container(
        child: new Text(
          item['label'],
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
      );
    }
    return Opacity(
      opacity: isEditable ? 1.0 : 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          if (title != null)
            isMandatory && title!.isNotEmpty
                ? RequiredText(
              label: title!,
              style: Theme.of(context).textTheme.subtitle2,
              starStyle: Theme.of(context).textTheme.headline6,
            )
                : Text(title!),
          TextFormField(
            autofocus: autofocus,
            style: const TextStyle(fontWeight: FontWeight.bold),
            // focusNode: focusNode,
            enabled: isEditable,

            decoration: InputDecoration(
              // suffix: widget.suffix,
              // prefix: widget.prefix,
              hintText: title,
              hintStyle: const TextStyle(fontWeight: FontWeight.normal),
              label: title != null
                  ? null
                  : isMandatory
                  ? RequiredText(
                label: "$title",
                style: Theme.of(context).textTheme.subtitle2,
                starStyle: Theme.of(context).textTheme.headline6,
              )
                  : Text("$title",
                  style: Theme.of(context).textTheme.subtitle2),
            ),
            keyboardType: item['keyboardType'] ??
                widget.keyboardTypes[item['key']] ??
                TextInputType.text,
            inputFormatters: inputFormatters,
            textCapitalization: isUpperCaseOnly
                ? TextCapitalization.characters
                : TextCapitalization.none,
          )
        ],
      ),
    );
  }
}
