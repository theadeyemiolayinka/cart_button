library cart_button;

import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cart_button_style.dart';

const _animateDuration = Duration(milliseconds: 300);

const _textStyle = TextStyle(
  fontWeight: FontWeight.w400,
  fontFamily: "Quicksand",
  fontStyle: FontStyle.normal,
);

/// CartButton widget
class CartButton<VM extends num> extends StatefulWidget {
  const CartButton({
    Key? key,
    VM? value,
    @Deprecated('use value instead') VM? count,
    VM? stepper,
    required this.onChanged,
    this.size = 30.0,
    this.axis = Axis.horizontal,
    this.numberSize = 3,
    this.editKeyboardType,
    this.elevation,
    this.style,
    this.defaultWidget,
    this.onDefaultWidgetTapped, // Add the onDefaultWidgetTapped callback
  })  : _value = (value ?? count ?? 0) as VM,
        _stepper = (stepper ?? 1) as VM,
        super(key: key);

  final VM _value;
  final VM _stepper;

  final double size;
  final double numberSize;
  final TextInputType? editKeyboardType;
  final Axis axis;
  final ValueChanged<VM> onChanged;
  final double? elevation;
  final CartButtonStyle? style;
  final Widget? defaultWidget;
  final VoidCallback? onDefaultWidgetTapped; // Add the onDefaultWidgetTapped callback

  @override
  State<CartButton<VM>> createState() => _CartButtonState<VM>();
}

class _CartButtonState<VM extends num> extends State<CartButton<VM>> {
  bool _editMode = false;
  String lastText = '';
  late final TextEditingController _controller;
  late final FocusNode _focusNode = FocusNode()
    ..addListener(() {
      if (_editMode && !_focusNode.hasFocus) {
        setState(() {
          _editMode = false;
        });
      }
    });

  num defaultValue = 0;

  bool get isVertical => widget.axis == Axis.vertical;

  @override
  void initState() {
    super.initState();
    lastText = widget._value.toString();
    _controller = TextEditingController(text: lastText);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  VM? parseValue(String text) {
    if (text.isEmpty) return 0 as VM;
    double? value = double.tryParse(text);
    if (value == null) return null;
    if (value is VM) return value as VM;
    return value.toInt() as VM;
  }

  void _setValue(VM newValue) {
    if (_editMode) {
      setState(() {
        _editMode = false;
      });
    }
    widget.onChanged(newValue);
  }

  void _buttonSetValue(VM newValue) {
    _setValue(newValue);
  }

    // Add a method to handle incrementing the value when the default widget is tapped
  void _defaultWidgetTapped() {
    setState(() {
      _setValue((widget._value + widget._stepper) as VM);
    });
    widget.onDefaultWidgetTapped?.call(); // Call the callback if provided
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style ?? CartButtonTheme.of(context);

    final isExpanded = _editMode || widget._value > 0;
    final textStyle = _textStyle
        .merge(Theme.of(context).textTheme.bodyMedium?.merge(style.textStyle) ??
            style.textStyle)
        .copyWith(
          height: 1.25,
          fontSize: widget.size * 0.5,
          color:
              isExpanded ? style.activeForegroundColor : style.foregroundColor,
        );
    final borderRadius = BorderRadius.all(
      style.radius ?? Radius.circular(widget.size),
    );

    List<Widget> children = [
      InkResponse(
        radius: widget.size,
        borderRadius: borderRadius,
        highlightShape: BoxShape.rectangle,
        onTap: () {
          _buttonSetValue((widget._value + widget._stepper) as VM);
        },
        child: SizedBox(
          width: isVertical ? widget.size : null,
          height: isVertical ? null : widget.size,
          child: AspectRatio(
            aspectRatio: isExpanded ? style.buttonAspectRatio : 1,
            child: Center(
              child: Icon(
                style.iconPlus ?? CupertinoIcons.add,
                color: isExpanded
                    ? style.activeForegroundColor
                    : style.foregroundColor,
              ),
            ),
          ),
        ),
      ),
    ];
    if (isExpanded) {
      children.add(
        GestureDetector(
          onTap: () {
            setState(() {
              lastText = widget._value.toString();
              _controller.text = lastText;
              _editMode = !_editMode;
              _focusNode.requestFocus();
            });
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            alignment: Alignment.center,
            width:
                isVertical ? widget.size : widget.size * widget.numberSize * .5,
            child: _editMode
                ? EditableText(
                    controller: _controller,
                    focusNode: _focusNode,
                    textAlign: TextAlign.center,
                    keyboardType:
                        widget.editKeyboardType ?? TextInputType.number,
                    style: textStyle,
                    cursorColor: style.activeForegroundColor,
                    backgroundCursorColor: style.activeBackgroundColor,
                    onEditingComplete: () {
                      setState(() {
                        _editMode = false;
                      });
                    },
                    onChanged: (String value) {
                      VM? newValue = parseValue(_controller.text);
                      if (newValue == null) {
                        _controller.text = lastText;
                        _controller.selection =
                            TextSelection.collapsed(offset: lastText.length);
                      } else {
                        lastText = value;
                        widget.onChanged(newValue);
                      }
                    },
                  )
                : Text(
                    widget._value.toString(),
                    softWrap: false,
                  ),
          ),
        ),
      );
      children.add(
        InkResponse(
          radius: widget.size,
          borderRadius: borderRadius,
          highlightShape: BoxShape.rectangle,
          onTap: () {
            _buttonSetValue(math.max((widget._value - widget._stepper),
                    VM is int ? defaultValue.toInt() : defaultValue.toDouble())
                as VM);
          },
          child: SizedBox(
            width: isVertical ? widget.size : null,
            height: isVertical ? null : widget.size,
            child: AspectRatio(
              aspectRatio: style.buttonAspectRatio,
              child: Center(
                child: Icon(
                  style.iconMinus ?? CupertinoIcons.minus,
                  color: style.activeForegroundColor,
                ),
              ),
            ),
          ),
        ),
      );
      if (style.border != null) {
        if (isVertical) {
          children[0] = Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: style.border!.top.color),
              ),
            ),
            child: children[0],
          );
          children[2] = Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: style.border!.top.color),
              ),
            ),
            child: children[2],
          );
        } else {
          children[0] = Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: style.border!.top.color),
              ),
            ),
            child: children[0],
          );
          children[2] = Container(
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(color: style.border!.top.color),
              ),
            ),
            child: children[2],
          );
        }
      }
    }

    // If the value is 0 and default widget is provided, show the default widget
if (widget._value == 0 && widget.defaultWidget != null) {
      return GestureDetector(
        onTap: _defaultWidgetTapped, // Call the method when the default widget is tapped
        child: widget.defaultWidget!,
      );
    }


    Widget body = AnimatedPhysicalModel(
      duration: _animateDuration,
      curve: Curves.easeIn,
      shape: style.shape,
      borderRadius: borderRadius,
      shadowColor: style.shadowColor ?? const Color.fromARGB(255, 0, 0, 0),
      color: isExpanded ? style.activeBackgroundColor : style.backgroundColor,
      elevation: widget.elevation ?? style.elevation,
      child: isVertical
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: children,
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: children.reversed.toList(),
            ),
    );

    if (style.border != null) {
      body = AnimatedContainer(
        duration: _animateDuration,
        curve: Curves.easeIn,
        decoration: BoxDecoration(
          border: style.border,
          borderRadius: borderRadius,
        ),
        child: body,
      );
    }
    return DefaultTextStyle(
      style: textStyle,
      child: IconTheme.merge(
        data: style.iconTheme.copyWith(size: widget.size * .6),
        child: body,
      ),
    );
  }
}

typedef CartButtonInt = CartButton<int>;
typedef CartButtonDouble = CartButton<double>;
