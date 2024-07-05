import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mist_app/common_widgets/assistance_widget.dart';
import 'package:mist_app/common_widgets/dropdown_list/select_road_drop_down_list.dart';
import 'package:mist_app/common_widgets/images/default_background.dart';
import 'package:mist_app/common_widgets/loading.dart';
import 'package:mist_app/common_widgets/show_bottom_sheet/add_request_bottom_sheet.dart';
import 'package:mist_app/common_widgets/texts/user_title.dart';
import 'package:mist_app/constants/colors.dart';
import 'package:mist_app/constants/sizes.dart';
import 'package:mist_app/model/operations/user_operation.dart';

class RequestAssistanceView extends StatefulWidget {
  const RequestAssistanceView({super.key});

  @override
  State<RequestAssistanceView> createState() => _RequestAssistanceViewState();
}

class _RequestAssistanceViewState extends State<RequestAssistanceView> {
  LatLng? sharedLocation;

  // final String roadId;

  Future<void> _refreshAssistances() async {
    setState(() {});
  }

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
                  byUser: true,
                  onSelectedRoad: true,
                  notSolvedOnly: true,
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final widgets = snapshot.data!
                        .map(
                          (e) => AssistanceWidget(
                            e,
                            canSetSolved: true,
                            refresh: () => setState(() {}),
                          ),
                        )
                        .toList();
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UserTitle(
                              title: "Request Assistances",
                              roadName: selectedRoad!),
                          ...widgets,
                        ],
                      ),
                    );
                  } else {
                    return const Center(child: Loading());
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Colors.white,
        onPressed: () async {
          final bool? result = await showModalBottomSheet<bool>(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return AddRequestBottomSheet(
                  onLocationShared: (LatLng location) {
                    setState(() {
                      sharedLocation = location;
                    });
                  },
                  onRequestAdded: _refreshAssistances, // Pass the refresh function here
                );
              });

          if (result == true) {
            _refreshAssistances(); // Refresh after bottom sheet is closed
          }
        },
        child: const Icon(
          Icons.add,
          color: ColorManager.primaryColor,
          size: 30,
        ),
      ),
    );
  }
}
