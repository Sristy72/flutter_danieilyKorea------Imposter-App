import 'package:danielyikorea/features/game_settings/data/models/game_start_request_model.dart';
import 'package:danielyikorea/features/game_settings/data/models/game_start_response_model.dart';
import '../../../../core/network/network_result.dart';


abstract class GameRepo{
  NetworkResult<GameResponse> gameStart(GameRequest request);
}