import 'package:flutter/material.dart';
import 'package:mist_app/common_widgets/containers/custom_decoration.dart';
import 'package:mist_app/common_widgets/buttons/custom_button.dart';
import 'package:mist_app/common_widgets/dropdown_list/select_road_drop_down_list.dart';
import 'package:mist_app/common_widgets/images/default_background.dart';
import 'package:mist_app/common_widgets/loading.dart';
import 'package:mist_app/common_widgets/sizedbox20.dart';
import 'package:mist_app/constants/fonts.dart';
import 'package:mist_app/model/auth/models/profile_data_model.dart';
import 'package:mist_app/model/operations/admin_operations.dart';
import 'package:mist_app/view/admin_view/admin_controls/confirm_delete_coordinator.dart';
import 'package:mist_app/view/admin_view/coordinator_uid_screen.dart';

class AddCoordinator extends StatefulWidget {
  const AddCoordinator({super.key});

  @override
  State<AddCoordinator> createState() => _AddCoordinatorState();
}

class _AddCoordinatorState extends State<AddCoordinator> {
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
                  future: AdminOperations.getCoordinators(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final coWidgets = snapshot.data!.map((e) =>
                          CoWidget(co: e, onRemove: () => setState(() {})));
                      return Column(
                        crossAxisAlignment:CrossAxisAlignment.start ,
                        children: [
                          InkWell(
                            child: const Icon(
                              Icons.arrow_back_ios_sharp,
                              size: 15,
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          const SizedBox20(),
                          Text(
                            selectedRoad!,
                            style: TextStyle(
                                fontSize: 36, fontFamily: fontFamily2),
                          ),
                          Text(
                            "Coordinators ",
                            style: TextStyle(
                                fontSize: 26, fontFamily: fontFamily2),
                          ),
                          const SizedBox20(),
                          ...coWidgets,
                          const SizedBox(
                            height: 100,
                          ),

                          CustomButton(
                              text: "Add coordinator",
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const CoordinatorUID()))
                                    .then((value) => setState(() {}));
                              }),
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

class CoWidget extends StatelessWidget {
  final ProfileDataModel co;
  final VoidCallback? onRemove;
  final bool showRemoveIcon;
  const CoWidget(
      {required this.co, this.showRemoveIcon = true, this.onRemove, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
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
              child: co.picUrl == null
                  ? Image.asset("assets/images/profile image.jpg")
                  : Image.network(co.picUrl!, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 8),
          CustomDecoration(
            height: 140,
            width: 245,
            content: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${co.fname} ${co.lname}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      showRemoveIcon
                          ? InkWell(
                              onTap: () {
                                Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ConfirmDeleteCoordinator(co: co)))
                                    .then((value) => onRemove!());
                              },
                              child: const Icon(Icons.delete))
                          : const SizedBox.shrink(),
                    ],
                  ),const SizedBox(height: 5,),
                  _buildCoRow('Email', co.email!),
                  const SizedBox(height: 5,),
                  _buildCoRow('Phone', co.phone!),
                  const SizedBox(height: 5,),
                  _buildCoRow('NID', co.nid!),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 150,
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 16),
            // overflow: TextOverflow.ellipsis,
            // softWrap: true,
          ),
        ),
      ],
    );
  }
}
