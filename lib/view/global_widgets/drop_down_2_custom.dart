import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropDown2 extends StatefulWidget {
  final List<String> list_items;
  final Function(int) selected_index;
  final String? hint;
  final String? initial_value;
  final Offset? offset;
  final double? drop_down_width;
  const CustomDropDown2(
      {Key? key,
      required this.list_items,
      required this.selected_index,
      required this.hint,
      required this.initial_value,
      this.offset = const Offset(0, -10),
      this.drop_down_width})
      : super(key: key);

  @override
  State<CustomDropDown2> createState() => _CustomDropDown2State();
}

class _CustomDropDown2State extends State<CustomDropDown2> {
  String? initial_value;
  @override
  void initState() {
    initial_value = widget.initial_value!.isEmpty ? null : widget.initial_value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Row(
          children: [
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Text(
                '${widget.hint}',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                  fontFamily: 'Aveni_Next_R',
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: widget.list_items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Row(
                    children: [
                      SizedBox(width: 5),
                      Text(
                        item,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontFamily: 'Aveni_Next_R',
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ))
            .toList(),
        value: initial_value,
        onChanged: (value) {
          initial_value = value!;
          setState(() {});
          int index = widget.list_items.indexOf(value);
          widget.selected_index.call(index);
        },
        buttonStyleData: ButtonStyleData(
          height: 50,
          width: double.infinity,
          //padding: const EdgeInsets.only(left: 14, right: 14),
          elevation: 0,
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.keyboard_arrow_down_sharp,
            size: 25,
          ),
          iconSize: 14,
          iconEnabledColor: Colors.black,
          iconDisabledColor: Colors.grey,
        ),
        dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            width: widget.drop_down_width == null
                ? MediaQuery.of(context).size.width - 40
                : widget.drop_down_width!,
            //padding: const EdgeInsets.only(left: 14, right: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            elevation: 8,
            offset: widget.offset!,
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: MaterialStateProperty.all(6),
              thumbVisibility: MaterialStateProperty.all(true),
            )),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }
}
