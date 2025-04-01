import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class Dropdown extends StatefulWidget {
  const Dropdown({super.key});

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  final Map<String, List<String>> categories = {
    "Fruits": ["Mango", "Apple", "Grapes"],
    "Vegetables": ["Tomato", "Beans", "Potato"],
  };

  List<String> fruits = ["Mango", "Apple", "Grapes"];

  String? selectedItem;
  bool isExpanded2 = false;
  String? selectedItem2;

// button 3
  String? expandedCategory3;
  String? selectedItem3;
  bool isDropdownOpen3 = false;

// button 4
  String? selectedOption = 'Select Option';
  bool isExpanded4 = false;

  @override
  void initState() {
    super.initState();
    selectedItem = categories.values.expand((list) => list).first;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isExpanded2 = !isExpanded2;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                  ),
                  child: DropdownButton<String>(
                    value: selectedItem,
                    isExpanded: true,
                    icon: const Icon(Icons.arrow_drop_down),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: SizedBox.shrink(),
                    items: [
                      ...categories.entries.expand((entry) => [
                            DropdownMenuItem<String>(
                              enabled: false,
                              child: Text(
                                entry.key,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            ...entry.value
                                .map((String item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 1, vertical: 15.0),
                                        color: Colors.grey,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ))
                          ])
                    ],
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedItem = newValue;
                      });
                    },
                  ),
                ),
                Text("Selected Item: $selectedItem"),
              ],
            ),
            Column(
              children: [
                DropdownButton2<String>(
                  isExpanded: true,
                  underline: SizedBox.shrink(),
                  hint: const Text(
                    "Select Item",
                    style: TextStyle(color: Colors.white),
                  ),
                  value: selectedItem2,
                  items: categories.entries.expand((entry) {
                    return [
                      DropdownMenuItem<String>(
                        enabled: false, // Category is non-selectable
                        child: Text(
                          entry.key,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                      ),
                      ...entry.value.map((item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item,
                              style: const TextStyle(color: Colors.black)),
                        );
                      }).toList(),
                    ];
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedItem2 = newValue;
                    });
                  },
                  buttonStyleData: ButtonStyleData(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                      color: Colors.white,
                    ),
                  ),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white, // Background color for dropdown
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isDropdownOpen3 = !isDropdownOpen3;
                    });
                  },
                  child: Text(
                      isDropdownOpen3 ? "Close Dropdown" : "Open Dropdown"),
                ),
                const SizedBox(height: 10),
                if (isDropdownOpen3)
                  DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: const Text("Select a Category"),
                      value: selectedItem3,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedItem3 = newValue;
                        });
                      },
                      items: _buildExpandableItems(),
                      buttonStyleData: const ButtonStyleData(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 300,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(color: Colors.black26, blurRadius: 5)
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 10),
            Column(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      isExpanded4 = !isExpanded4;
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 1.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Text(selectedOption!),
                          const Spacer(),
                          Icon(isExpanded4
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down),
                        ],
                      ),
                    ),
                  ),
                ),
                if (isExpanded4)
                  ListView(
                    primary: true,
                    shrinkWrap: true,
                    children: categories.keys.map((category) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Category Header (Click to Expand/Collapse)
                          InkWell(
                            onTap: () {
                              setState(() {
                                expandedCategory3 =
                                    (expandedCategory3 == category)
                                        ? null
                                        : category;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(category,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  Icon(
                                    expandedCategory3 == category
                                        ? Icons.expand_less
                                        : Icons.expand_more,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Sub-items (If category is expanded)
                          if (expandedCategory3 == category)
                            Column(
                              children: categories[category]!.map((item) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedOption = item;
                                      isExpanded4 = false;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, bottom: 10),
                                    child: Text(item,
                                        style: TextStyle(fontSize: 14)),
                                  ),
                                );
                              }).toList(),
                            ),
                        ],
                      );
                    }).toList(),
                  ),
              ],
            ),
            SizedBox(height: 50),
            Column(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      isExpanded4 = !isExpanded4;
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 1.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Text(selectedOption!),
                          const Spacer(),
                          Icon(isExpanded4
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down),
                        ],
                      ),
                    ),
                  ),
                ),
                if (isExpanded4)
                  ListView(
                    primary: true,
                    shrinkWrap: true,
                    children: categories.keys.map((category) {
                      return Container(
                        color: Colors.pink,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Category Header (Click to Expand/Collapse)
                            InkWell(
                              onTap: () {
                                setState(() {
                                  expandedCategory3 =
                                      (expandedCategory3 == category)
                                          ? null
                                          : category;
                                });
                              },
                              child: Column(
                                children: [
                                  Container(
                                    color: Colors.green,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(category,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red)),
                                        Icon(
                                          expandedCategory3 == category
                                              ? Icons.expand_less
                                              : Icons.expand_more,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    color: Colors.grey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children:
                                          categories[category]!.map((item) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectedOption = item;
                                              isExpanded4 = false;
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20, bottom: 10),
                                            child: Text(item,
                                                style: TextStyle(fontSize: 14)),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildExpandableItems() {
    List<DropdownMenuItem<String>> menuItems = [];

    for (String category in categories.keys) {
      menuItems.add(
        DropdownMenuItem<String>(
          value: category,
          enabled: false, // Disable selection for categories
          child: GestureDetector(
            onTap: () {
              setState(() {
                expandedCategory3 =
                    (expandedCategory3 == category) ? null : category;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.white, // Category Background
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(category,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Icon(expandedCategory3 == category
                      ? Icons.expand_less
                      : Icons.expand_more),
                ],
              ),
            ),
          ),
        ),
      );

      // Show items when category is expanded
      if (expandedCategory3 == category) {
        for (String item in categories[category]!) {
          menuItems.add(
            DropdownMenuItem<String>(
              value: item,
              child: Container(
                color: Colors.grey[300], // Item Background
                padding: const EdgeInsets.only(left: 20.0, top: 5, bottom: 5),
                child: Text(item),
              ),
            ),
          );
        }
      }
    }
    return menuItems;
  }
}
