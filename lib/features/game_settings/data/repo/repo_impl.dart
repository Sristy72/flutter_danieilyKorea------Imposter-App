import '../../../../core/network/api_client.dart';
import '../../../../core/network/constants/api_constants.dart';
import '../../../../core/network/network_result.dart';
import '../../domain/repo/repo.dart';
import '../models/game_start_request_model.dart';
import '../models/game_start_response_model.dart';

class GameRepoImplementation extends GameRepo{
  final ApiClient _apiClient;
  GameRepoImplementation({required ApiClient apiClient}) : _apiClient = apiClient;

  @override
  NetworkResult<GameResponse> gameStart(GameRequest request) {
    return _apiClient.post<GameResponse>(
      ApiConstants.game.gameStart,
      data:request.toJson(),
      fromJsonT: (json) => GameResponse.fromJson(json)
    );
  }
}


