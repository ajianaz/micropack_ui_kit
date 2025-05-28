import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class MPTabRounded extends StatelessWidget {
  const MPTabRounded({
    super.key,
    required this.title,
    this.tabLocation = 'center',
    this.tabColor = Colors.grey,
    this.tabColorActive,
    this.textColor = Colors.black,
    this.textColorActive = Colors.white,
    this.height = 50,
    this.isActiveTab = false,
    this.onTab,
    this.deviderColor = Colors.white,
    this.dimen = 32.0,
  });

  final String? title;
  final String? tabLocation;
  final Color? tabColorActive;
  final Color? tabColor;
  final Color? textColorActive;
  final Color? textColor;
  final double? height;
  final bool? isActiveTab;
  final void Function()? onTab;
  final Color deviderColor;
  final double dimen;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTab ?? () {},
        child: Container(
          height: height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              left: tabLocation?.toLowerCase() == 'center'
                  ? BorderSide(color: deviderColor)
                  : BorderSide.none,
              right: tabLocation?.toLowerCase() == 'center'
                  ? BorderSide(color: deviderColor)
                  : BorderSide.none,
            ),
            color: isActiveTab == true
                ? (tabColorActive ?? MpUiKit.colorBrand)
                : tabColor,
            borderRadius: BorderRadius.only(
              topLeft: tabLocation?.toLowerCase() == 'left'
                  ? Radius.circular(dimen)
                  : Radius.zero,
              bottomLeft: tabLocation?.toLowerCase() == 'left'
                  ? Radius.circular(dimen)
                  : Radius.zero,
              topRight: tabLocation?.toLowerCase() == 'right'
                  ? Radius.circular(dimen)
                  : Radius.zero,
              bottomRight: tabLocation?.toLowerCase() == 'right'
                  ? Radius.circular(dimen)
                  : Radius.zero,
            ),
          ),
          child: MPText.label(
            '$title',
            color: isActiveTab == true ? textColorActive : textColor,
            fontWeight: isActiveTab == true ? FontWeight.w500 : FontWeight.w200,
          ),
        ),
      ),
    );
  }
}
