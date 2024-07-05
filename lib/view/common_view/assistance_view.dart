import 'package:flutter/material.dart';
import 'package:mist_app/common_widgets/assistance_widget.dart';
import 'package:mist_app/common_widgets/dropdown_list/select_road_drop_down_list.dart';
import 'package:mist_app/common_widgets/images/default_background.dart';
import 'package:mist_app/common_widgets/loading.dart';
import 'package:mist_app/common_widgets/texts/user_title.dart';
import 'package:mist_app/constants/sizes.dart';
import 'package:mist_app/model/operations/data_models/assistance_data_model.dart';
import 'package:mist_app/model/operations/user_operation.dart';

class AssistanceView extends StatefulWidget {
  final bool byUser;
  final bool onSelectedRoad;
  final bool notSolvedOnly;
  final bool canSetSolved;

  const AssistanceView({
    bool? byUser,
    bool? onSelectedRoad,
    bool? notSolvedOnly,
    this.canSetSolved = false,
    super.key,
  })  : byUser = byUser ?? false,
        onSelectedRoad = onSelectedRoad ?? true,
        notSolvedOnly = notSolvedOnly ?? false;

  @override
  State<AssistanceView> createState() => _AssistanceViewState();
}

class _AssistanceViewState extends State<AssistanceView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const DefaultBackground(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
              child: FutureBuilder(
                future: UserOperations.getAssistances(
                    roadId: selectedRoadId!,
                    byUser: widget.byUser,
                    onSelectedRoad: widget.onSelectedRoad,
                    notSolvedOnly: widget.notSolvedOnly),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return _buildBody(snapshot.data!, context);
                  } else {
                    return const Center(
                        child: Loading());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(List<AssistanceDataModel> data, BuildContext context) {
    final widgets = data
        .map((e) => AssistanceWidget(e,
            showRoadName: !widget.onSelectedRoad,
            canSetSolved: widget.canSetSolved,
            refresh: () => setState(() {})))
        .toList();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserTitle(
              title: "Assistances", roadName: selectedRoad ?? "Current road"),
          ...widgets
        ],
      ),
    );
  }
}
