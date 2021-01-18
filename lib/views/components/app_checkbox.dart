import 'package:flutter/material.dart';
import 'package:manga_app/views/themes/app_color.dart';

class AppCheckbox extends StatefulWidget {
  final String label;
  final bool value;

  final bool disabled;

  final Function(bool isChecked) onChanged;

  /// The style to use for the labels.
  final TextStyle labelStyle;

  /// The color to use when a Checkbox is checked.
  final Color activeColor;

  /// The color to use for the check icon when a Checkbox is checked.
  final Color checkColor;

  /// If true the checkbox's value can be true, false, or null.
  final bool tristate;

  AppCheckbox({
    Key key,
    this.label,
    this.value,
    this.disabled,
    this.onChanged,
    this.labelStyle = const TextStyle(),
    this.activeColor = AppColors.primary, //defaults to toggleableActiveColor,
    this.checkColor = const Color(0xFFFFFFFF),
    this.tristate = false,
  }) : super(key: key);

  @override
  _AppCheckboxState createState() => _AppCheckboxState();
}

class _AppCheckboxState extends State<AppCheckbox> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    if (widget.value != null) {
      checked = widget.value;
    }

    return InkWell(
      onTap: () {
        if (!widget.disabled) {
          checked = !checked;
          widget.onChanged != null && widget.onChanged(checked);
        }
      },
      child: Container(
          padding: EdgeInsets.only(right: 12),
          child: Row(
            children: [
              Checkbox(
                value: checked,
                onChanged: widget.disabled
                    ? null
                    : (isChecked) {
                        checked = isChecked;
                        widget.onChanged != null && widget.onChanged(checked);
                      },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                checkColor: widget.checkColor,
                activeColor: widget.activeColor,
                tristate: widget.tristate,
              ),
              Text(widget.label,
                  style: widget.disabled == true
                      ? widget.labelStyle
                          .apply(color: Theme.of(context).disabledColor)
                      : widget.labelStyle)
            ],
          )),
    );
  }
}
