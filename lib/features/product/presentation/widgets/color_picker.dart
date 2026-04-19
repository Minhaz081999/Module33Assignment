import 'package:crafty_bay/app/extensions/utils_extension.dart';
import 'package:crafty_bay/features/product/presentation/providers/color_picker_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';


class ColorPicker extends StatefulWidget {
  const ColorPicker({super.key, required this.colors, required this.onSelected, this.initialValue });

  final List<String> colors;
  final Function(String) onSelected;
  final String ? initialValue;

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    if (widget.initialValue != null ){
      Future.microtask((){ context.read<ColorPickerProvider>().setColor = widget.initialValue!;});
    }
  }

// --------------------- UI PART -------------------------
  @override
  Widget build(BuildContext context) {
    // Provider er object create korlam
    final provider = context.watch<ColorPickerProvider>();

    return Column(
      crossAxisAlignment: .start,
      spacing: 6,
      children: [
        Text('Color',
        style: context.textTheme.bodyLarge?.copyWith(
          fontWeight: .bold
        ),
        ),
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: .horizontal,
              itemCount: widget.colors.length,
              itemBuilder:(context, index ){
              // variable part
                 String color = widget.colors[index]; // 'red', 'green', 'blue', 'yellow', 'orange'
                 bool isSelected = (color == provider.selectedColor); // true 0r false
                return GestureDetector(
                  onTap: (){
                    provider.updateColor(color);
                    widget.onSelected(color);

                  },
                  child: Container(
                    margin: .only(right: 8),
                    padding: .symmetric(horizontal: 10, vertical: 5),
                    alignment: .center,
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.themeColor : Colors.transparent ,
                      borderRadius: .circular(4),
                      border: .all(color: Colors.grey)
                    ),
                    child: Text(color,
                    style: TextStyle(
                      color: isSelected ?  Colors.white : Colors.black
                    ),),
                  ),
                );
              }
          ),
        )
      ],
    );
  }
}
