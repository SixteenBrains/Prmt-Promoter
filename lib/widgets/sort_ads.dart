import 'package:flutter/material.dart';

class SortAds extends StatefulWidget {
  final VoidCallback onChanged;
  const SortAds({Key? key, required this.onChanged}) : super(key: key);

  @override
  State<SortAds> createState() => _SortAdsState();
}

class _SortAdsState extends State<SortAds> {
  // Initial Selected Value
  String dropdownvalue = 'Recent';

  // List of items in our dropdown menu
  var items = ['Recent', 'Old'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.0,
      width: 80.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: Colors.blue, width: 1.5),
      ),
      child: Center(
        child: DropdownButton(
          // Initial Value
          value: dropdownvalue,
          underline: const SizedBox.shrink(),
          alignment: Alignment.center,

          // Down Arrow Icon
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.blue,
          ),

          // hint: const Text('Sort'),
          selectedItemBuilder: (context) => items
              .map(
                (e) => const Center(
                  child: Text('Sort'),
                ),
              )
              .toList(),

          // Array list of items
          items: items.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items),
            );
            // );
          }).toList(),
          // After selecting the desired option,it will
          // change button value to selected value
          onChanged: (String? newValue) {
            //await SharedPrefs().setSortType(newValue == 'Recent');
            widget.onChanged();
            // setState(() {
            //   dropdownvalue = newValue!;
            // });
          },
        ),
      ),
    );
  }
}
