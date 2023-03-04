import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

import 'package:int20h/core/style/colors.dart';

class BaseTextField extends TextFormField {
  // @override
  // BaseInputDecoration? decoration;

  BaseTextField({
    super.initialValue,
    super.decoration,
    super.key,
    super.controller,
    super.focusNode,
    super.keyboardType,
    super.textInputAction,
    super.textCapitalization = TextCapitalization.none,
    super.style,
    super.strutStyle,
    super.textAlign = TextAlign.left,
    super.textAlignVertical,
    super.textDirection,
    super.readOnly = false,
    super.toolbarOptions,
    super.showCursor,
    super.autofocus = false,
    super.obscuringCharacter = '*',
    super.obscureText = false,
    super.autocorrect = true,
    super.smartDashesType,
    super.smartQuotesType,
    super.enableSuggestions = true,
    super.maxLines = 1,
    super.minLines,
    super.expands = false,
    super.maxLength,
    super.maxLengthEnforcement,
    super.onChanged,
    super.onEditingComplete,
    super.inputFormatters,
    super.enabled,
    super.cursorWidth = 2.0,
    super.cursorHeight,
    super.cursorRadius,
    super.cursorColor = CColors.white,
    super.keyboardAppearance,
    super.scrollPadding = const EdgeInsets.all(20.0),
    super.enableInteractiveSelection,
    super.selectionControls,
    super.onTap,
    super.mouseCursor,
    super.buildCounter,
    super.scrollController,
    super.scrollPhysics,
    super.autofillHints = const <String>[],
    super.restorationId,
    super.enableIMEPersonalizedLearning = true,
  }) {
    // this.decoration = decoration;
  }
}
