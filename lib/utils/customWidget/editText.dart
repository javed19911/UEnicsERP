import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'customText.dart';

class CustomInputFormatter {
  static List<TextInputFormatter> NON_NEGATIVE_DECIMAL_NUMBER =
      <TextInputFormatter>[
    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,5}')),
  ];

  static List<TextInputFormatter> NON_NEGATIVE_INTEGER = <TextInputFormatter>[
    FilteringTextInputFormatter.digitsOnly,
  ];

  static List<TextInputFormatter> ALPHANUMERIC = <TextInputFormatter>[
    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
  ];

  static List<TextInputFormatter> ALPHANUMERIC_UNDERSCORE =
      <TextInputFormatter>[
    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_]')),
  ];
}

class BoarderRoundTextView extends SimpleEditText {
  final String placeHolder;
  final ValueChanged<String>? listener;
  final ValueChanged<bool>? onFocusChanged;
  final TextEditingController? controller;
  final TextAlign alignment;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;
  final int? minLines;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final double order;

  const BoarderRoundTextView(
      {Key? key,
      required this.placeHolder,
      this.listener,
      this.onFocusChanged,
      this.alignment = TextAlign.start,
      this.controller,
      this.keyboardType,
      this.inputFormatters,
      this.maxLines = 1,
      this.minLines,
      this.maxLength,
      this.textInputAction,
      this.order = 1})
      : super(
            key: key,
            placeHolder: placeHolder,
            listener: listener,
            onFocusChanged: onFocusChanged,
            alignment: alignment,
            controller: controller,
            border: const OutlineInputBorder(),
            focusedBorder: const OutlineInputBorder(),
            inputFormatters: inputFormatters,
            maxLines: maxLines,
            minLines: minLines,
            maxLength: maxLength,
            order: order);
}

class SimpleEditText extends StatefulWidget {
  final String placeHolder;
  final ValueChanged<String>? listener;
  final ValueChanged<bool>? onFocusChanged;
  final TextEditingController? controller;
  final TextAlign alignment;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;
  final int? minLines;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final double order;

  const SimpleEditText(
      {Key? key,
      required this.placeHolder,
      this.listener,
      this.onFocusChanged,
      this.alignment = TextAlign.start,
      this.controller,
      this.border,
      this.focusedBorder,
      this.keyboardType,
      this.inputFormatters,
      this.maxLines = 1,
      this.minLines,
      this.maxLength,
      this.textInputAction,
      this.order = 1})
      : super(key: key);

  @override
  _SimpleEditTextState createState() => _SimpleEditTextState();
}

class _SimpleEditTextState extends State<SimpleEditText> {
  final _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (widget.onFocusChanged != null) {
        widget.onFocusChanged!(_focusNode.hasFocus);
      }
    });
    _focusNode.onKey = (FocusNode node, RawKeyEvent event) {
      if (event.isKeyPressed(LogicalKeyboardKey.escape)) {
        node.previousFocus();
        return KeyEventResult.handled;
      }

      /*else if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
        node.nextFocus();
        return KeyEventResult.handled;
      }*/
      //print("${node}  : ${event.physicalKey}");
      return KeyEventResult.ignored;
    };
    widget.controller?.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_printLatestValue);
    widget.controller?.dispose();
    super.dispose();
  }

  void _printLatestValue() {
    if (widget.listener != null) {
      widget.listener!("${widget.controller?.text}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FocusTraversalOrder(
      order: NumericFocusOrder(widget.order),
      child: TextField(
        key: widget.key,
        focusNode: _focusNode,
        controller: widget.controller,
        textAlign: widget.alignment,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        textInputAction: widget.textInputAction ??
            (widget.maxLines > 1
                ? TextInputAction.newline
                : TextInputAction.next),
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,
        minLines: widget.maxLines,
        decoration: InputDecoration(
          labelText: widget.placeHolder,
          labelStyle: TextStyle(
            color: Colors.grey,
          ),
          border: widget.border,
          focusedBorder: widget.focusedBorder,
        ),
      ),
    );
  }
}

class WebSimpleTextView extends StatefulWidget {
  final double placeHolderRatio;
  final String placeHolder;
  final ValueChanged<String>? listener;
  final ValueChanged<bool>? onFocusChanged;
  final TextEditingController? controller;
  final TextAlign alignment;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;
  final int? minLines;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final double order;

  const WebSimpleTextView(
      {Key? key,
      required this.placeHolder,
      this.placeHolderRatio = 0.5,
      this.listener,
      this.onFocusChanged,
      this.alignment = TextAlign.start,
      this.controller,
      this.fontWeight = FontWeight.bold,
      this.fontStyle,
      this.keyboardType,
      this.inputFormatters,
      this.maxLines = 1,
      this.minLines,
      this.maxLength,
      this.textInputAction,
      this.order = 1})
      : super(key: key);

  @override
  _WebSimpleTextViewState createState() => _WebSimpleTextViewState();
}

class _WebSimpleTextViewState extends State<WebSimpleTextView> {
  var left = 1;
  var right = 1;
  @override
  void initState() {
    var c = "${widget.placeHolderRatio}".length -
        "${(widget.placeHolderRatio.toInt())}".length;

    var n = 1;
    for (int i = 1; i < c; i++) {
      n = n * 10;
    }
    if (widget.placeHolderRatio > 1) {
      right = (widget.placeHolderRatio * n).toInt();
      left = n;
    } else {
      left = (widget.placeHolderRatio * n).toInt();
      right = n;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
              flex: left,
              child: SimpleText(
                widget.placeHolder,
                fontStyle: widget.fontStyle,
                fontWeight: widget.fontWeight,
              )),
          SimpleText("  :  "),
          Flexible(
            flex: right,
            child: Container(
              height: 28,
              child: SimpleEditText(
                placeHolder: "",
                listener: widget.listener,
                onFocusChanged: widget.onFocusChanged,
                alignment: widget.alignment,
                controller: widget.controller,
                keyboardType: widget.keyboardType,
                inputFormatters: widget.inputFormatters,
                border: InputBorder.none,
                focusedBorder: UnderlineInputBorder(),
                minLines: widget.minLines,
                maxLength: widget.maxLength,
                maxLines: widget.maxLines,
                textInputAction: widget.textInputAction,
                order: widget.order,
              ),
            ),
          )
        ],
      ),
    );
  }
}
