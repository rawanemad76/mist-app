import 'package:flutter/material.dart';
import 'package:mist_app/common_widgets/assistance_widget.dart';
import 'package:mist_app/common_widgets/dropdown_list/select_road_drop_down_list.dart';
import 'package:mist_app/common_widgets/images/default_background.dart';
import 'package:mist_app/common_widgets/loading.dart';
import 'package:mist_app/common_widgets/texts/user_title.dart';
import 'package:mist_app/constants/sizes.dart';
import 'package:mist_app/model/operations/data_models/assistance_data_model.dart';
import 'package:mist_app/model/operations/user_operation.dart';

class AssistanceHistory extends StatefulWidget {
  final bool byUser;
  final bool onSelectedRoad;
  const AssistanceHistory({bool? byUser, bool? onSelectedRoad, super.key})
      : byUser = byUser ?? true,
        onSelectedRoad = onSelectedRoad ?? false;

  @override
  State<AssistanceHistory> createState() => _AssistanceHistoryState();
}

class _AssistanceHistoryState extends State<AssistanceHistory> {
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
                    onSelectedRoad: widget.onSelectedRoad),
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
            refresh: () => setState(() {})))
        .toList();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserTitle(title: "History", roadName: selectedRoad ?? "Current road"),
          ...widgets
        ],
      ),
    );
  }
}
