import 'dart:developer';

import 'package:flutter/material.dart';

import '../utilities/l_text.dart';

class LDropDown extends StatefulWidget {
  String label;
  String hintText;
  final ValueChanged<String?> onChanged;
  bool? tapped;
  String? text;
  List<String> dropDownList;
  final ValueChanged<bool?> onTapped;
  double dropDownHeight;

  LDropDown(
      {required this.label,
      required this.dropDownList,
      required this.hintText,
      required this.dropDownHeight,
      required this.onChanged,
      required this.onTapped,
      this.tapped,
      this.text,
      super.key});

  @override
  State<LDropDown> createState() => _TpDropDownState();
}

class _TpDropDownState extends State<LDropDown>
    with SingleTickerProviderStateMixin {
  bool _isDropDown = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0).copyWith(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            color: const Color(0xff101828),
            text: widget.label,
            fontWeight: FontWeight.w500,
            fontsize: 14,
          ),
          SizedBox(
            height: 7,
          ),
          Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: const Color(0xFFE8EDF1),
                borderRadius: BorderRadius.circular(8)),
            child: ListTile(
              title: TextWidget(
                  text: widget.text ?? widget.hintText,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF697D95),
                  fontsize: 14),
              trailing: _isDropDown
                  ? Transform.rotate(
                      angle: 3.14159, // 180 degrees in radians
                      child: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                      ),
                    )
                  : const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.grey,
                    ),
              onTap: () {
                setState(() {
                  _isDropDown = !_isDropDown;
                  if (widget.tapped != null) {
                    widget.tapped = !widget.tapped!;
                  }
                });
                if (widget.tapped != null) {
                  widget.onTapped(widget.tapped);
                }
              },
            ),
          ),
          AnimatedContainer(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            duration: const Duration(milliseconds: 300),
            height: _isDropDown ? widget.dropDownHeight : 0,
            child: ListView(
              children: [
                ...widget.dropDownList.map((e) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.text = e;
                          _isDropDown = !_isDropDown;
                          if (widget.tapped != null) {
                            widget.tapped = !widget.tapped!;
                          }
                        });
                        if (widget.tapped != null) {
                          widget.onTapped(widget.tapped);
                        }

                        widget.onChanged(widget.text);
                      },
                      child: TextWidget(
                          color: const Color(0xff0D0D0D),
                          text: e,
                          fontWeight: FontWeight.w500,
                          fontsize: 15),
                    ),
                  );
                })
              ],
            ),
          )
        ],
      ),
    );
  }
}
