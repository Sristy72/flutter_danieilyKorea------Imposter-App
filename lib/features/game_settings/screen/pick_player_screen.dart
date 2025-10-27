import 'package:danielyikorea/core/common/constants/app_images.dart';
import 'package:danielyikorea/features/game_settings/controller/player_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/common/constants/app_colors.dart';

class AddPlayerScreen extends StatelessWidget {
  final List<String>? initialPlayers;
  AddPlayerScreen({Key? key, this.initialPlayers}) : super(key: key);

  final Color darkBlue = const Color(0xFF07124A);
  final Color topInfoBg = const Color(0xFFF4F6FB);
  final Color proColor = const Color(0xFF6B4FF0);
  final Color leftBoxColor = Colors.white;
  final Color leftBoxTextColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    // Simple put as requested
    final controller = Get.put(AddPlayerController());
    controller.initWith(initialPlayers);

    return WillPopScope(
      onWillPop: () async {
        // Return players list when popping
        Get.back(result: controller.players.toList());
        return false;
      },

      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          leading: BackButton(
            onPressed: () {
              Get.back(result: controller.players.toList());
            },
          ),
          centerTitle: true,
          title: const Text('Player Names'),
        ),

        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
          child: BottomAppBar(
            color: AppColors.black1,
            child: Container(
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.black1,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: AppColors.border1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 6.0, top: 8, bottom: 8),
                        child: Obx(() {
                          final isRemovable = controller.players.length > 3;
                          return ElevatedButton.icon(
                            onPressed: isRemovable ? controller.removeLastPlayer : null,
                            icon: SizedBox(height: 20, width: 20, child: Image.asset(AppImages.removePlayer)),
                            label: const Text('Remove'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isRemovable ? Colors.transparent : Colors.grey.shade700,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 0,
                            ),
                          );
                        })
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          width: 1,
                          color: AppColors.border,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 6.0, right: 8.0, top: 8, bottom: 8),
                        child: ElevatedButton.icon(
                          onPressed: controller.addPlayer,
                          icon: Container(height: 20, width: 20, child: Image.asset(AppImages.addPlayer)),
                          label: const Text('Add'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top info card
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.imageBackground1,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.staticTextBackground
                      )
                    ),
                    child: Obx(() {
                      return Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  height: 28,
                                  width: 28,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: Colors.white,
                                  ),
                                  child: Image.asset(AppImages.player),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  '${controller.players.length} Players',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '${AddPlayerController.minPlayers}–${AddPlayerController.maxPlayers}',
                            style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                          )
                        ],
                      );
                    }),
                  ),

                  const SizedBox(height: 16),

                  // Players list
                  Expanded(
                    child: SingleChildScrollView(
                      child: Obx(() {
                        return Column(
                          children: List.generate(controller.players.length, (i) {
                            final isEditing = controller.editingIndex.value == i;
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: InkWell(
                                onTap: () {
                                  controller.startEditing(i);

                                  // give a micro delay so the TextField is built and autofocus works.
                                  Future.delayed(const Duration(milliseconds: 50), () {
                                    // nothing else required; controller provides autofocus in widget
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.playerChoose,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 36,
                                        width: 36,
                                        decoration: BoxDecoration(
                                          color: leftBoxColor,
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          '${i + 1}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: leftBoxTextColor),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: isEditing
                                            ? _buildEditingField(i, controller)
                                            : Text(
                                          controller.players[i],
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      if (isEditing)
                                        IconButton(
                                          onPressed: () => controller.saveEditing(i),
                                          icon: Icon(
                                            Icons.check_circle,
                                            color: proColor,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        );
                      }),
                    ),
                  ),

                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEditingField(int index, AddPlayerController controller) {
    final TextEditingController ctrl = controller.controllerForIndex(index);
    return Focus(
      onFocusChange: (hasFocus) {
        if (!hasFocus) {
          controller.saveEditing(index);
        }
      },
      child: TextField(
        controller: ctrl,
        autofocus: true,
        textInputAction: TextInputAction.done,
        onSubmitted: (_) => controller.saveEditing(index),
        style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
        decoration: const InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          border: InputBorder.none,
          hintText: '',
        ),
      ),
    );
  }
}
