import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_gradient_selector/flutter_gradient_selector.dart';
import 'package:flutter_gradient_selector/helpers/localization.dart';

import '../classes/helper.dart/popup_helper.dart';

// ignore: must_be_immutable
class WsColorPicker extends StatefulWidget {
  const WsColorPicker(
      {super.key,
      required this.color,
      this.onChange,
      this.title,
      this.allowGradientMode = false,
      this.colorHistory,
      this.visualDensity = VisualDensity.standard});
  final dynamic color;
  final String? title;
  final VisualDensity visualDensity;
  final Function? onChange;
  final bool allowGradientMode;
  final List<Color>? colorHistory;

  @override
  State<WsColorPicker> createState() => _WsColorPickerState();
}

class _WsColorPickerState extends State<WsColorPicker> {
  late dynamic _colorMemPopUp;

  @override
  void initState() {
    _colorMemPopUp = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (widget.title != null) Text("${widget.title} : "),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: widget.visualDensity == VisualDensity.compact ? const EdgeInsets.symmetric(horizontal: 10) : null,
                visualDensity: widget.visualDensity),
            onPressed: () {
              PopupHelper.showDialog(icon: Icons.color_lens, context,
                  StatefulBuilder(builder: (BuildContext context, StateSetter popupState) {
                return SizedBox(
                    height: min(MediaQuery.of(context).orientation == Orientation.portrait ? 600 : 400,
                        MediaQuery.of(context).size.height * 0.9),
                    width: min(700, MediaQuery.of(context).size.width * 0.9),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GradientSelector(
                        gradientMode: _colorMemPopUp is! Color,
                        allowChangeMode: widget.allowGradientMode,
                        color: _colorMemPopUp,
                        lang: localizationOptions.languageCode,
                        history: widget.colorHistory,
                        onChange: (value) {
                          _colorMemPopUp = value;
                        },
                      ),
                    ));
              }),
                  button2: PopupHelper.okButton(
                      context: context,
                      onPress: () {
                        widget.onChange?.call(_colorMemPopUp);
                        Navigator.pop(context);
                      }),
                  button1: PopupHelper.cancelButton(
                      context: context,
                      onPress: () {
                        Navigator.pop(
                          context,
                        );
                      }));
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Theme.of(context).colorScheme.onSecondaryContainer),
                      color: widget.color is Color ? widget.color : null,
                      gradient: widget.color is Color ? null : widget.color),
                  width: 20,
                  height: 20,
                ),
                const SizedBox(width: 3),
                const Icon(Icons.color_lens)
              ],
            )),
      ],
    );
  }
}