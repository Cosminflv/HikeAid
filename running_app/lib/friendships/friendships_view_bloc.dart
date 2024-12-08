import 'package:domain/entities/friendship_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/friendships/friendships_view_events.dart';
import 'package:running_app/friendships/friendships_view_state.dart';
import 'package:domain/use_cases/friendship_use_case.dart';

class FriendshipsViewBloc extends Bloc<FriendshipsViewEvent, FriendshipsViewState> {
  final FriendshipUseCase _friendshipUseCase;

  FriendshipsViewBloc(this._friendshipUseCase) : super(const FriendshipsViewState()) {
    on<InitializeNotificationService>(_handleInitializeNotificationService);
    on<CloseNotificationService>(_handleCloseNotificationService);

    on<SendFriendshipRequestEvent>(_handleSendFriendshipRequest);
    on<AcceptFriendshipRequestEvent>(_handleAcceptFriendshipRequest);
    on<DeclineFriendshipRequestEvent>(_handleDeclineFriendshipRequest);
  }

  _handleSendFriendshipRequest(SendFriendshipRequestEvent event, Emitter<FriendshipsViewState> emit) async {
    await _friendshipUseCase.sendFriendshipRequest(event.requesterId, event.receiverId);
  }

  _handleCloseNotificationService(CloseNotificationService event, Emitter<FriendshipsViewState> emit) {
    _friendshipUseCase.closeNotificationsConnection();
    emit(state.copyWith(isInitialized: false));
  }

  _handleAcceptFriendshipRequest(AcceptFriendshipRequestEvent event, Emitter<FriendshipsViewState> emit) async {
    await _friendshipUseCase.acceptFriendshipRequest(event.requestId);
  }

  _handleDeclineFriendshipRequest(DeclineFriendshipRequestEvent event, Emitter<FriendshipsViewState> emit) async {
    await _friendshipUseCase.declineFriendshipRequest(event.requestId);
  }

  _handleInitializeNotificationService(InitializeNotificationService event, Emitter<FriendshipsViewState> emit) async {
    if (state.isInitialized) return;
    List<FriendshipEntity> updatedFriendships = [];

    _friendshipUseCase.initializeNotificationConnection(event.userId, (err, entity) {
      if (err != 'success') {
        print('Error: $err');
        return;
      }
      updatedFriendships = List<FriendshipEntity>.from(state.incomingRequests)..add(entity!);
    });
    emit(state.copyWith(isInitialized: true, incomingRequests: updatedFriendships));
  }
}
