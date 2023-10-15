import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:medicine_delivery/checkout/location.dart';

// ignore: must_be_immutable
class LocationDropDown extends StatefulWidget {
  String? selectedLocation;
  final ValueChanged<String?> setLocation;

  LocationDropDown(
      {super.key, required this.setLocation, this.selectedLocation});

  @override
  State<LocationDropDown> createState() => _LocationDropDownState();
}

class _LocationDropDownState extends State<LocationDropDown> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Location.getCurrentPosition(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return buildDropdownButton(snapshot.data);
        } else if (snapshot.hasError) {
          return const Text('Error');
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget buildDropdownButton(List<String>? locations) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        iconStyleData: const IconStyleData(
            icon: Icon(
          Icons.location_on,
          color: Colors.green,
        )),
        isExpanded: true,
        hint: Text(
          'Select Your desired location',
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).hintColor,
          ),
        ),
        items: locations!
            .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
            .toList(),
        value: widget.selectedLocation,
        onChanged: widget.setLocation,

        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.symmetric(horizontal: 16),
          height: 40,
          width: 200,
        ),
        dropdownStyleData: const DropdownStyleData(
          maxHeight: 200,
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),
        dropdownSearchData: DropdownSearchData(
          searchController: textEditingController,
          searchInnerWidgetHeight: 50,
          searchInnerWidget: Container(
            height: 50,
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 4,
              right: 8,
              left: 8,
            ),
            child: TextFormField(
              expands: true,
              maxLines: null,
              controller: textEditingController,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                hintText: 'Type your desired location',
                hintStyle: const TextStyle(fontSize: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          searchMatchFn: (item, searchValue) {
            return item.value.toString().contains(searchValue);
          },
        ),
        //This to clear the search value when you close the menu
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            textEditingController.clear();
          }
        },
      ),
    );
  }
}
