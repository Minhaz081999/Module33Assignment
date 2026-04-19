import 'package:crafty_bay/app/extensions/utils_extension.dart';

import 'package:crafty_bay/features/product/presentation/providers/size_picker_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';


class SizePicker extends StatefulWidget {
  const SizePicker({super.key, required this.sizes, required this.onSelected, this.initialValue });

  final List<String> sizes;
  final Function(String) onSelected;
  final String ? initialValue;

  @override
  State<SizePicker> createState() => _SizePickerState();
}

class _SizePickerState extends State<SizePicker> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.initialValue != null ){
      Future.microtask((){ context.read<SizePickerProvider>().setSize = widget.initialValue!;});
    }
  }

// --------------------- UI PART -------------------------
  @override
  Widget build(BuildContext context) {
    // Provider er object create korlam
    final provider = context.watch<SizePickerProvider>();

    return Column(
      crossAxisAlignment: .start,
      spacing: 6,
      children: [
        Text('Size',
          style: context.textTheme.bodyLarge?.copyWith(
              fontWeight: .bold
          ),
        ),
        SizedBox(
          height: 40,
          child: ListView.builder(
              scrollDirection: .horizontal,
              itemCount: widget.sizes.length,
              itemBuilder:(context, index ){
                // variable part
                String size = widget.sizes[index]; // 'red', 'green', 'blue', 'yellow', 'orange'
                bool isSelected = (size == provider.selectedSize); // true 0r false
                return GestureDetector(
                  onTap: (){
                    provider.updateSize(size);
                    widget.onSelected(size);

                  },
                  child: Container(
                    width: 50,
                    margin: .only(right: 8),
                    padding: .symmetric(horizontal: 10, vertical: 5),
                    alignment: .center,
                    decoration: BoxDecoration(
                        color: isSelected ? AppColors.themeColor : Colors.transparent ,
                        borderRadius: .circular(4),
                        border: .all(color: Colors.grey)
                    ),
                    child: Text(size,
                      style: TextStyle(
                          color: isSelected ?  Colors.white : Colors.black,
                        fontWeight: .bold
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
