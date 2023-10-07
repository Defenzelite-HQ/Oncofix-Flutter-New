import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_x/helpers/ColorPalette.dart';
import 'package:ui_x/helpers/TextStyl.dart';
import 'package:oncofix/app/helpers/Global.dart';

class SearchableFormSelect extends StatelessWidget {
  final String? placeholder;
  final dynamic value;
  final Function(dynamic)? onChanged;
  final List<DropDownItem> options;

  ///
  /// Example usage:
  /// ```dart
  /// SearchableFormSelect(
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
  SearchableFormSelect({
    Key? key,
    this.placeholder = "Input hint",
    this.value,
    this.onChanged,
    required this.options,
  }) : super(key: key);

  final SearchableFormSelectController controller = SearchableFormSelectController.instance;

  @override
  Widget build(BuildContext context) {
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
                  title: Text('Select $placeholder'),
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
                              DropDownItem dropDownItem = controller.options[index];
                              return InkWell(
                                onTap: () {
                                  controller.setSelectedValue(dropDownItem.value);
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
                                    color: kcOffWhite.withOpacity(0.75),
                                  ),
                                  child: Text(
                                    '${dropDownItem.label}',
                                    style: TextStyl.bodySm?.copyWith(fontSize: 15),
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
            borderRadius: BorderRadius.circular(50),
            color: kcOffWhite.withOpacity(0.6),
          ),
          child: Row(
            children: [
              Text(
                '${controller.selectedValue.value != null ? controller.selectedValue.label : placeholder}',
              ),
              Spacer(),
              Icon(
                Icons.keyboard_arrow_down_sharp,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchableFormSelectController extends GetxController {
  static SearchableFormSelectController get instance {
    if (!Get.isRegistered<SearchableFormSelectController>()) Get.create(() => SearchableFormSelectController());
    return Get.find<SearchableFormSelectController>();
  }

  ///Observables
  var _selectedValue = DropDownItem().obs;
  var _options = <DropDownItem>[].obs;
  var _tempOptions = <DropDownItem>[].obs;

  ///Getter
  DropDownItem get selectedValue => _selectedValue.value;

  List<DropDownItem> get options => _options;

  final TextEditingController searchInput = TextEditingController();

  /// Set Selected Value
  void setSelectedValue(dynamic value) {
    _selectedValue(_options.where((op) => op.value == value).first);
  }

  /// Set Options
  void setOptions(List<DropDownItem> opts) {
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

class DropDownItem {
  final dynamic value;
  final String? label;

  DropDownItem({this.value, this.label});
}
