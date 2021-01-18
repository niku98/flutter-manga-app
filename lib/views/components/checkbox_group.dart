import 'package:flutter/material.dart';
import 'package:manga_app/domain/enums/checkbox_group_orientation.dart';
import 'package:manga_app/domain/models/option.dart';
import 'package:manga_app/views/components/app_checkbox.dart';
import 'package:manga_app/views/themes/app_color.dart';

class CheckboxGroup extends StatefulWidget {
  final List<Option> options;

  final List<String> checked;

  final Function(List<String> selected) onChange;

  final List<String> disabled;

  /// The style to use for the labels.
  final TextStyle labelStyle;

  /// Specifies the orientation to display elements.
  final CheckboxGroupOrientation orientation;

  //THESE FIELDS ARE FOR THE CHECKBOX

  /// The color to use when a Checkbox is checked.
  final Color activeColor;

  /// The color to use for the check icon when a Checkbox is checked.
  final Color checkColor;

  /// If true the checkbox's value can be true, false, or null.
  final bool tristate;

  //SPACING STUFF

  /// Empty space in which to inset the CheckboxGroup.
  final EdgeInsetsGeometry padding;

  /// Empty space surrounding the CheckboxGroup.
  final EdgeInsetsGeometry margin;

  CheckboxGroup({
    Key key,
    @required this.options,
    this.checked,
    this.disabled,
    this.onChange,
    this.labelStyle = const TextStyle(),
    this.activeColor = AppColors.primary, //defaults to toggleableActiveColor,
    this.checkColor = const Color(0xFFFFFFFF),
    this.tristate = false,
    this.orientation = CheckboxGroupOrientation.VERTICAL,
    this.padding = const EdgeInsets.all(0.0),
    this.margin = const EdgeInsets.all(0.0),
  }) : super(key: key);

  @override
  _CheckboxGroupState createState() => _CheckboxGroupState();
}

class _CheckboxGroupState extends State<CheckboxGroup> {
  List<String> _selected;

  @override
  void initState() {
    super.initState();

    //set the selected to the checked (if not null)
    _selected = widget.checked ?? [];
  }

  void onChanged(bool isChecked, int i) {
    final List<String> values = widget.options.map((e) => e.value).toList();
    bool isAlreadyContained = _selected.contains(values.elementAt(i));

    if (mounted) {
      setState(() {
        if (!isChecked && isAlreadyContained) {
          _selected.remove(values.elementAt(i));
        } else if (isChecked && !isAlreadyContained) {
          _selected.add(values.elementAt(i));
        }

        if (widget.onChange != null) widget.onChange(_selected);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //set the selected to the checked (if not null)
    if (widget.checked != null) {
      _selected = [];
      _selected.addAll(widget.checked); //use add all to prevent a shallow copy
    }

    return ListView.builder(
        scrollDirection:
            widget.orientation == CheckboxGroupOrientation.HORIZONTAL
                ? Axis.horizontal
                : Axis.vertical,
        itemCount: widget.options.length,
        itemBuilder: (context, index) {
          return AppCheckbox(
            label: widget.options.elementAt(index).label,
            value: _selected.contains(widget.options.elementAt(index).value),
            onChanged: (bool isChecked) => onChanged(isChecked, index),
            checkColor: widget.checkColor,
            activeColor:
                widget.activeColor ?? Theme.of(context).toggleableActiveColor,
            tristate: widget.tristate,
            disabled: widget.disabled != null &&
                widget.disabled.contains(widget.options.elementAt(index).value),
          );
        });
  }
}
