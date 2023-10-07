import 'package:flutter/material.dart';
import 'package:ui_x/helpers/ColorPalette.dart';
import 'package:ui_x/helpers/TextStyl.dart';
import '../../../helpers/Global.dart';

class AccordionWidget extends StatefulWidget {
  final String title;
  final List<OptionsWidget>? options;
  final List<Widget>? subTitle;
  final VoidCallback? onTapChild;
  final VoidCallback? onTap;
  final VoidCallback? onTapSubChild;
  final String? count;
  final String? countName;
  final bool categoryLength;
  final String? image;

  ///
  /// Ex:
  ///
  /// AccordionWidget(
  ///      image: "image_path",
  ///      onTap: () {},
  ///      title: 'Title',
  ///      categoryLength: true,
  ///      options: [
  ///        ...List.generate(
  ///            10,
  ///                (index) {
  ///              return OptionsWidget(
  ///                title: 'Name',
  ///                countName: "Count:",
  ///                count: "13213,
  ///                onTap: () {},
  ///              );
  ///            })
  ///      ],
  ///    ),
  ///
  AccordionWidget({
    Key? key,
    required this.title,
    this.options,
    this.subTitle,
    this.onTapChild,
    this.onTapSubChild,
    this.countName,
    this.count,
    this.onTap,
    this.categoryLength = false,
    this.image,
  }) : super(key: key);

  @override
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<AccordionWidget> {
  bool _showContent = false;
  bool _showContentSub = false;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _showContent = !_showContent;
              });
            },
            child: Container(
              width: screen.width,
              decoration: BoxDecoration(),
              child: ListTile(
                title: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  decoration: BoxDecoration(
                    color: kcWhite,
                  ),
                  child: Row(
                    children: [
                      Image.network(
                        // "assets/icons/category-icon.png",
                        "${widget.image}",
                        width: 35,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: widget.onTap,
                            child: Text(
                              widget.title,
                              style: TextStyl.bodySm?.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: kcBlack.withOpacity(0.75)),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Icon(
                        !_showContent
                            ? Icons.arrow_drop_down
                            : Icons.arrow_drop_up,
                        color: kcBlack,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (widget.categoryLength == true)
            _showContent
                ? Container(
                    width: screen.width,
                    margin:
                        const EdgeInsets.only(left: 17, right: 17, bottom: 5),
                    decoration: BoxDecoration(
                      color: kcPrimaryLight,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.options != null) ...widget.options!,
                          ],
                        ),
                      ],
                    ),
                  )
                : Container()
        ]);
  }
}

class OptionsWidget extends StatelessWidget {
  const OptionsWidget(
      {key, this.count, this.countName, required this.title, this.onTap});

  final String? count;
  final String? countName;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 12, bottom: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: kcDarkAlt.withOpacity(0.1), width: 1),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icons/bullet.png",
                    width: 15,
                    color: kcDarkAlt,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: title,
                        style: TextStyl.bodySm?.copyWith(
                            fontSize: 15, fontWeight: FontWeight.w600),
                        children: [
                          TextSpan(
                            text: "  (${count ?? "0"})",
                            style: TextStyl.bodySm?.copyWith(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: kcDarkAlt),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: kcDarkAlt,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}
