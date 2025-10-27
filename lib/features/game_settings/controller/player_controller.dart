// player_names_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPlayerController extends GetxController {
  static const int minPlayers = 3;
  static const int maxPlayers = 100;

  // Reactive players list
  final RxList<String> players = <String>[].obs;

  // -1 means no editing
  final RxInt editingIndex = RxInt(-1);

  // store controllers per index
  final Map<int, TextEditingController> _controllers = {};

  /// Initialize with optional initial players
  void initWith(List<String>? initialPlayers) {
    if (initialPlayers != null && initialPlayers.isNotEmpty) {
      players.assignAll(initialPlayers);
    } else {
      players.assignAll(List<String>.generate(minPlayers, (i) => _defaultNameForIndex(i)));
    }
  }

  String _defaultNameForIndex(int index) {
    final int offset = index % 26;
    return String.fromCharCode(97 + offset); // 'a'..'z'
  }

  TextEditingController controllerForIndex(int i) {
    if (!_controllers.containsKey(i)) {
      _controllers[i] = TextEditingController(text: players[i]);
    } else {
      // keep controller text in sync
      _controllers[i]!.text = players[i];
      _controllers[i]!.selection = TextSelection.fromPosition(
        TextPosition(offset: _controllers[i]!.text.length),
      );
    }
    return _controllers[i]!;
  }

  void startEditing(int i) {
    editingIndex.value = i;
    controllerForIndex(i);
  }

  void saveEditing(int i) {
    final ctrl = _controllers[i];
    if (ctrl == null) {
      editingIndex.value = -1;
      return;
    }
    final newName = ctrl.text.trim();
    if (newName.isEmpty) {
      players[i] = _defaultNameForIndex(i);
    } else {
      players[i] = newName;
    }
    editingIndex.value = -1;
  }

  void addPlayer() {
    if (players.length >= maxPlayers) {
      Get.snackbar('Limit', 'Maximum $maxPlayers players allowed',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    players.add(_defaultNameForIndex(players.length));
  }

  void removeLastPlayer() {
    if (players.length <= minPlayers) {
      Get.snackbar('Minimum', 'At least $minPlayers players required',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    final removedIndex = players.length - 1;
    players.removeLast();

    // clean controller if exists
    if (_controllers.containsKey(removedIndex)) {
      _controllers[removedIndex]!.dispose();
      _controllers.remove(removedIndex);
    }

    if (editingIndex.value == removedIndex) {
      editingIndex.value = -1;
    }
  }

  @override
  void onClose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    _controllers.clear();
    super.onClose();
  }
}
