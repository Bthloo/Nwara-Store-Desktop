import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../../../core/database/hive/inventory_model.dart';
import '../../viewmodel/add_item_to_invoice_cubit.dart';

class CustomDropDownSearch extends StatelessWidget {
  final AddItemToInvoiceCubit addCubit;
  final List<InventoryModel> items;
  const CustomDropDownSearch({super.key,required this.addCubit, required this.items});

  @override
  Widget build(BuildContext context) {
    return  DropdownSearch<InventoryModel>(

      dropdownBuilder:
          (context, selectedItem) {
        return Text(
          selectedItem?.title ??
              "اختر الصنف",
          style: TextStyle(fontSize: 20),
        );
      },
      validator: (value) {
        if (value == null) {
          return "الرجاء اختيار الصنف";
        }
        return null;
      },
      popupProps: PopupProps.menu(
        showSelectedItems: true,
        itemBuilder:
            (
            context,
            item,
            isDisabled,
            isSelected,
            ) {
          return Padding(
            padding: const EdgeInsets.all(
              8.0,
            ),
            child: ListTile(
              title: Text(
                " الاسم :${item.title}",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              subtitle: Text(
                "الكمية: ${item.quantity}",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          );
        },
        showSearchBox: true,
        searchDelay: Duration(seconds: 0),
        fit: FlexFit.loose,
        menuProps: MenuProps(
          backgroundColor: Color(0xFF313239),
          elevation: 4,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        searchFieldProps: TextFieldProps(
          padding: EdgeInsets.all(5),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(
              0xFF666C71,
            ),
            prefixIcon: const Icon(
              Icons.search,
              color: Color(0xFF9CABBA),
            ),
            hintText: "ابحث عن منتج",
            hintStyle: const TextStyle(
              color: Color(0xFF9CABBA),
              fontSize: 20,
            ),
            contentPadding:
            const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 10,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.blue,
                width: 1,
              ),
            ),
          ),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      decoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFF293038),
          prefixIcon: const Icon(
            Icons.select_all,
            color: Color(0xFF9CABBA),
          ),
          hintText: "اختر الصنف",
          hintStyle: const TextStyle(
            color: Color(0xFF9CABBA),
            fontSize: 20,
          ),
          contentPadding:
          const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 10,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.blue,
              width: 1,
            ),
          ),
        ),
      ),
      items: (filter, loadProps) async {
        return items;
      },
      compareFn: (item, selectedItem) =>
      item.title == selectedItem.title,

      onChanged: (value) {
        addCubit.itemToAddToInvoice = value;
        addCubit.sellPriceController.text =
            value!.sellPrice.toString();
        debugPrint("sell price: ${ addCubit.sellPriceController.text}");

      },
      itemAsString: (item) {
        return item.title;
      },
    );
  }
}
