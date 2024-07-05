import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mist_app/common_widgets/containers/custom_decoration.dart';
import 'package:mist_app/common_widgets/images/custom_images.dart';
import 'package:mist_app/common_widgets/show_bottom_sheet/more_user_info_bottom_sheet.dart';
import 'package:mist_app/constants/colors.dart';
import 'package:mist_app/constants/sizes.dart';
import 'package:mist_app/constants/strings.dart';
import 'package:mist_app/model/operations/data_models/assistance_data_model.dart';
import 'package:mist_app/model/operations/user_operation.dart';

class AssistanceWidget extends StatefulWidget {
  final AssistanceDataModel a;
  final bool showRoadName;
  final bool canSetSolved;
  final void Function() refresh;

  const AssistanceWidget(this.a,
      {this.canSetSolved = false,
      this.showRoadName = false,
      required this.refresh,
      super.key});

  @override
  State<AssistanceWidget> createState() => _AssistanceWidgetState();
}

class _AssistanceWidgetState extends State<AssistanceWidget> {
  // bool isSolved = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 10),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return MoreInfoBottomSheet(
                      contactInfo: widget.a.mobile,
                      details: widget.a.details,
                      location: LatLng(widget.a.latitude, widget.a.longitude),
                      //  onSolved: markAsSolved,
                    );
                  });
            },
            child: CustomDecoration(
              height: 240,
              width: double.infinity,
              content: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _buildPic(),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${widget.a.user!.fname} ${widget.a.user!.lname}',
                          style: TextStyle(
                              fontSize: defaultFontSize,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    //SizedBox(height: 20,),
                    Row(
                      children: [
                        Text(
                          dateFormatter.format(widget.a.time).toString(),
                          // "01/04/2024 12:34 PM",
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        widget.canSetSolved
                            ? IconButton(
                                onPressed: widget.a.solved
                                    ? null
                                    : () async {
                                        String? msg =
                                            await UserOperations.setSolved(
                                                assistanceId: widget.a.id!);

                                        if (msg == null) {
                                          // setState(() => isSolved = true);
                                          widget.refresh();
                                        }
                                        if (!context.mounted) return;
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(msg ??
                                                    'set as solved successfully!')));
                                      },
                                icon: widget.a.solved
                                    ? const Icon(
                                        Icons.check_box,
                                        color: ColorManager.primaryColor,
                                      )
                                    : const Icon(Icons.alarm))
                            : const SizedBox(height: 48),
                      ],
                    ),
                    widget.showRoadName == true
                        ? Text(
                            widget.a.road!.name,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          )
                        : const SizedBox.shrink(),

                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.a.details,
                      style: TextStyle(fontSize: defaultFontSize),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    const Spacer(),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Tap to show location or contact"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          //============
        ],
      ),
    );
  }

  _buildPic() {
    return Container(
      height: 60,
      width: 60,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(100), boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          offset: const Offset(0, 1),
          blurRadius: 3,
          spreadRadius: 1,

          //spreadRadius: 10,
        ),
      ]),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: FutureBuilder(
            future: UserOperations.getProfilePic(widget.a.user!.uid!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Image.memory(
                  snapshot.data!,
                  fit: BoxFit.fill,
                );
              } else {
                return Image.asset(profileImage);
              }
            },
          )),
    );
  }
}
