import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_x/helpers/ColorPalette.dart';


class SearchableDialog extends StatelessWidget {
  final String? placeholder;
  final dynamic value;
  final Function(dynamic)? onChanged;
  final List<DropDownItems> options;

  ///
  /// Example usage:
  /// ```dart
  /// SearchableDialog(
  ///     onChanged: (value) {},
  ///     value: true,
  ///     placeholder: "PlaceHolder Name",
  ///     options: [
  ///       DropDownItems(
  ///         label: "Select Language",
  ///         value: 'select_language',
  ///       ),
  ///       DropDownItems(
  ///           label: 'English',
  ///           value: 'en',
  ///         );
  ///     ]),
  /// ```
  ///
  SearchableDialog({
    Key? key,
    this.placeholder = "Input hint",
    this.value,
    this.onChanged,
    required this.options,
  }) : super(key: key);

  final SearchableDialogController controller = SearchableDialogController.instance;

  @override
  Widget build(BuildContext context) {
    final Size screen = Get.size;
    controller.setOptions(options);
    if (value != null) {
      controller.setSelectedValue(value);
    }
    return GestureDetector(
      onTap: () {
        Get.dialog(
          Dialog(
            child: Obx(
                  () => Scaffold(
                appBar: AppBar(
                  title: Text('$placeholder'),
                  leading: GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(
                        Icons.arrow_back,
                        color: kcWhite,
                      )),
                  titleSpacing: 0,
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          fillColor: kcOffWhite.withOpacity(0.6),
                          hintText: controller.selectedValue.value != null ? controller.selectedValue.label : placeholder,
                        ),
                        onChanged: (value) {
                          controller.search(value);
                        },
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 8,
                                ),
                                ...List.generate(controller.options.length, (index) {
                                  DropDownItems dropDownItem = controller.options[index];
                                  return InkWell(
                                    onTap: () {
                                      controller.setSelectedValue(dropDownItem.value);
                                      // log.w('Details @@ ${dropDownItem.value}');
                                      if (onChanged != null) onChanged!(dropDownItem.value);
                                      Get.back();
                                      controller.setOptions(options);
                                      controller.searchInput.clear();
                                    },
                                    child: Container(
                                      width: screen.width,
                                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                      margin: EdgeInsets.only(bottom: 2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: kcPrimary.withOpacity(0.75),
                                      ),
                                      child: Text(
                                        '${dropDownItem.label}',
                                        style: TextStyle(color: kcBlack),
                                      ),
                                    ),
                                  );
                                })
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ),
            insetPadding: EdgeInsets.zero,
          ),
        );
      },
      child: Obx(
            () => Container(
          width: screen.width,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: kcPrimary.withOpacity(0.6),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '${controller.selectedValue.value != null ? controller.selectedValue.label : placeholder}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              // Spacer(),
              // Icon(
              //   Icons.keyboard_arrow_down_sharp,
              //   size: 20,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchableDialogController extends GetxController {
  static SearchableDialogController get instance {
    if (!Get.isRegistered<SearchableDialogController>()) Get.create(() => SearchableDialogController());
    return Get.find<SearchableDialogController>();
  }

  ///Observables
  var _selectedValue = DropDownItems().obs;
  var _options = <DropDownItems>[].obs;
  var _tempOptions = <DropDownItems>[].obs;

  ///Getter
  DropDownItems get selectedValue => _selectedValue.value;

  List<DropDownItems> get options => _options;

  final TextEditingController searchInput = TextEditingController();

  /// Set Selected Value
  void setSelectedValue(dynamic value) {
    _selectedValue(_options.where((op) => op.value == value).first);
  }

  /// Set Options
  void setOptions(List<DropDownItems> opts) {
    _tempOptions.assignAll(opts);
    _options.assignAll(opts);
  }

  void search(String term) {
    if (term.length > 0) {
      _options.assignAll(_tempOptions.where((element) {
        var _str = element.label!.toLowerCase();
        return _str.contains('${term.toLowerCase()}');
      }));
    } else {
      _options.assignAll(_tempOptions);
    }
  }
}

class DropDownItems {
  final dynamic value;
  final String? label;

  DropDownItems({this.value, this.label});
}
