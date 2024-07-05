import 'package:flutter/material.dart';
import 'package:mist_app/common_widgets/assistance_widget.dart';
import 'package:mist_app/common_widgets/dropdown_list/select_road_drop_down_list.dart';
import 'package:mist_app/common_widgets/images/default_background.dart';
import 'package:mist_app/common_widgets/loading.dart';
import 'package:mist_app/common_widgets/sizedbox20.dart';
import 'package:mist_app/constants/fonts.dart';
import 'package:mist_app/model/operations/user_operation.dart';

class ShowAssistanceHistory extends StatelessWidget {
  const ShowAssistanceHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const DefaultBackground(),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: FutureBuilder(
                  future: UserOperations.getAssistances(
                      roadId: selectedRoadId!,
                      byUser: false,
                      onSelectedRoad: true),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final assistences = snapshot.data!
                          .map((e) => AssistanceWidget(e,
                              showRoadName: false,
                              canSetSolved: true,
                              refresh: () {}))
                          .toList();

                      // final accidents =
                      //     snapshot.data!.map((e) => _buildAccident(e));
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            child: const Icon(
                              Icons.arrow_back_ios_sharp,
                              size: 15,
                            ),
                            onTap: () => Navigator.pop(context),
                          ),
                          const SizedBox20(),
                          Text(
                            selectedRoad!,
                            style: TextStyle(
                                fontSize: 36, fontFamily: fontFamily2),
                          ),
                          Text(
                            "Assistances",
                            style: TextStyle(
                                fontSize: 26, fontFamily: fontFamily2),
                          ),
                          ...assistences,
                          //assistance
                        ],
                      );
                    } else {
                      return const Center(child: Loading());
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
