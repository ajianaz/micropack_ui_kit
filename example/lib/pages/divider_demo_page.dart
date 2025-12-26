import 'package:flutter/material.dart';
import 'package:micropack_ui_kit/micropack_ui_kit.dart';

class DividerDemoPage extends StatelessWidget {
  const DividerDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.mp.adaptiveBackgroundColor,
      appBar: AppBar(
        title: MPText.head(
          'Divider',
          style: TextStyle(color: context.mp.textColor),
          fontSize: 20,
        ),
        backgroundColor: context.mp.adaptiveBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: MPResponsivePadding.card(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildThicknesses(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildStyles(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildOrientations(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildLabeledDividers(context),
            SizedBox(height: MPResponsivePadding.getLg(context)),
            _buildWithIndent(context),
          ],
        ),
      ),
    );
  }

  Widget _buildThicknesses(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head('Divider Thickness'),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        Column(
          children: [
            MPDivider(
              thickness: MPDividerThickness.thin,
            ),
            SizedBox(height: MPResponsivePadding.getMd(context)),
            MPText.label('Thin (1px)'),
            SizedBox(height: MPResponsivePadding.getMd(context)),
            MPDivider(
              thickness: MPDividerThickness.medium,
            ),
            SizedBox(height: MPResponsivePadding.getMd(context)),
            MPText.label('Medium (2px)'),
            SizedBox(height: MPResponsivePadding.getMd(context)),
            MPDivider(
              thickness: MPDividerThickness.thick,
            ),
            SizedBox(height: MPResponsivePadding.getMd(context)),
            MPText.label('Thick (3px)'),
          ],
        ),
      ],
    );
  }

  Widget _buildStyles(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head('Divider Styles'),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        Column(
          children: [
            MPDivider(
              style: MPDividerStyle.solid,
            ),
            SizedBox(height: MPResponsivePadding.getMd(context)),
            MPText.label('Solid'),
            SizedBox(height: MPResponsivePadding.getMd(context)),
            MPDivider(
              style: MPDividerStyle.dashed,
            ),
            SizedBox(height: MPResponsivePadding.getMd(context)),
            MPText.label('Dashed'),
          ],
        ),
      ],
    );
  }

  Widget _buildOrientations(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head('Divider Orientations'),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  MPText.label('Horizontal'),
                  SizedBox(height: MPResponsivePadding.getXs(context)),
                  MPDivider(
                    orientation: MPDividerOrientation.horizontal,
                  ),
                ],
              ),
            ),
            SizedBox(width: MPResponsivePadding.getLg(context)),
            Expanded(
              child: Column(
                children: [
                  MPText.label('Vertical'),
                  SizedBox(height: MPResponsivePadding.getXs(context)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MPDivider(
                        orientation: MPDividerOrientation.vertical,
                        height: 100,
                      ),
                      MPDivider(
                        orientation: MPDividerOrientation.vertical,
                        height: 100,
                      ),
                      MPDivider(
                        orientation: MPDividerOrientation.vertical,
                        height: 100,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLabeledDividers(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head('Labeled Dividers'),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        Column(
          children: [
            MPDivider(
              label: 'Section 1',
            ),
            SizedBox(height: MPResponsivePadding.getMd(context)),
            MPText.label('Content for section 1'),
            SizedBox(height: MPResponsivePadding.getMd(context)),
            MPDivider(
              label: 'Section 2',
            ),
            SizedBox(height: MPResponsivePadding.getMd(context)),
            MPText.label('Content for section 2'),
            SizedBox(height: MPResponsivePadding.getMd(context)),
            MPDivider(
              label: 'Section 3',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWithIndent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MPText.head('Dividers with Indent'),
        SizedBox(height: MPResponsivePadding.getSm(context)),
        Column(
          children: [
            MPDivider(
              indent: 24,
            ),
            SizedBox(height: MPResponsivePadding.getMd(context)),
            MPText.label('With start indent (24px)'),
            SizedBox(height: MPResponsivePadding.getMd(context)),
            MPDivider(
              endIndent: 24,
            ),
            SizedBox(height: MPResponsivePadding.getMd(context)),
            MPText.label('With end indent (24px)'),
            SizedBox(height: MPResponsivePadding.getMd(context)),
            MPDivider(
              indent: 32,
              endIndent: 32,
            ),
            SizedBox(height: MPResponsivePadding.getMd(context)),
            MPText.label('With both indents (32px)'),
          ],
        ),
      ],
    );
  }
}
