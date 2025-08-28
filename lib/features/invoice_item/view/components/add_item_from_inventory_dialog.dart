import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nwara_store_desktop/core/components/custom_form_field.dart';
import 'package:nwara_store_desktop/core/database/hive/inventory_model.dart';
import 'package:nwara_store_desktop/features/inventory/viewmodel/get_inventory_items_cubit.dart';
import 'package:nwara_store_desktop/features/invoice_item/viewmodel/add_item_to_invoice_cubit.dart';

class AddItemFromInventoryDialog extends StatelessWidget {
  const AddItemFromInventoryDialog({super.key,required this.invoiceId});
final int invoiceId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetInventoryItemsCubit()..getAllInventoryItems(),
      child: BlocBuilder<GetInventoryItemsCubit, GetInventoryItemsState>(
        builder: (context, state) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text("اضافة عنصر من المخزن", style: TextStyle(fontSize: 30)),
                  SizedBox(height: 20),
                  Builder(
                    builder: (context) {
                      if (state is GetInventoryItemsLoading) {
                        return CircularProgressIndicator();
                      } else if (state is GetInventoryItemsFailure) {
                        return Column(
                          children: [
                            Text(
                              state.errorMessage,
                              style: TextStyle(color: Colors.red),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                context
                                    .read<GetInventoryItemsCubit>()
                                    .getAllInventoryItems();
                              },
                              child: Text("اعادة المحاولة"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("الغاء"),
                            ),
                          ],
                        );
                      } else if (state is GetInventoryItemsSuccess) {
                        if (state.items.isEmpty) {
                          return Column(
                                children: [
                                  Text("لا يوجد عناصر في المخزن"),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("الغاء"),
                                  ),
                                ],
                              );

                        } else {
                          return BlocProvider(
                            create: (context) => AddItemToInvoiceCubit(),
                            child: BlocConsumer<AddItemToInvoiceCubit, AddItemToInvoiceState>(
                              listener: (context, state) {
                                if (state is AddItemToInvoiceSuccess) {
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("تمت إضافة العنصر بنجاح")),
                                  );
                                } else if (state is AddItemToInvoiceFailure) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(state.errorMessage)),
                                  );
                                }
                              },
                              builder: (context, addItemState) {
                                final addCubit = context.read<AddItemToInvoiceCubit>();
                                return Form(
                                  key: addCubit.formKey,
                                  child: Column(
                                    spacing: 10,
                                    children: [
                                      DropdownSearch<InventoryModel>(
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
                                          return state.items;
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
                                      ),
                                      CustomFormField(
                                        hintText: "الكمية",
                                        onChange: (value) {
                                         // addCubit.quantityController.text = value ?? "";
                                        },
                                        validator: (value) {
                                          final regex = RegExp(r'^\d+(\.\d+)?$');
                                          if (value == null || value.isEmpty) {
                                            return 'الرجاء ادخال الكمية';
                                          }
                                          if(!regex.hasMatch(value)){
                                            return 'الرجاء ادخال رقم صحيح';
                                          }
                                          if(value.contains('.')){
                                            return 'الرجاء ادخال رقم صحيح';
                                          }
                                          if(int.parse(value) > addCubit.itemToAddToInvoice!.quantity){
                                            return "الكمية المتوفرة في المخزن هي ${addCubit.itemToAddToInvoice?.quantity}";
                                          }
                                          return null;
                                        },
                                        controller: addCubit.quantityController,
                                      ),
                                      CustomFormField(
                                        hintText: "سعر البيع",
                                        validator: (value) {
                                          final regex = RegExp(r'^\d+(\.\d+)?$');
                                          if (value == null || value.isEmpty) {
                                            return 'الرجاء ادخال سعر البيع';
                                          }
                                          if(!regex.hasMatch(value)){
                                            return 'الرجاء ادخال رقم صحيح';
                                          }
                                          return null;
                                        },
                                        controller: addCubit.sellPriceController,
                                      ),
                                      SizedBox(height: 20),
                                      if (addItemState is AddItemToInvoiceLoading)
                                        CircularProgressIndicator()
                                      else
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("الغاء"),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                               debugPrint("sell price: ${addCubit.sellPriceController.text}");
                                                if (!addCubit.formKey.currentState!.validate()) {

                                                  return;
                                                }
                                                addCubit.addItem(
                                                    invoiceId: invoiceId,
                                                    inventoryItemId: addCubit.itemToAddToInvoice!.key,
                                                    quantity: int.parse(addCubit.quantityController.text),
                                                  //  sellPrice: double.parse(addCubit.sellPriceController.text)
                                                );
                                              },
                                              child: Text("اضافة"),
                                            ),

                                    ],
                                            )] ),
                                );
                              },
                            ),
                          );
                        }
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
