import 'package:domain/entities/friendship_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/friendships/friendships_view_events.dart';
import 'package:running_app/friendships/friendships_view_state.dart';
import 'package:domain/use_cases/friendship_use_case.dart';

import 'dart:async';

class FriendshipsViewBloc extends Bloc<FriendshipsViewEvent, FriendshipsViewState> {
  final FriendshipUseCase _friendshipUseCase;
  final StreamController<List<FriendshipEntity>> _friendshipUpdates = StreamController.broadcast();

  FriendshipsViewBloc(this._friendshipUseCase) : super(const FriendshipsViewState()) {
    on<FetchRequestsEvent>(_handleFetchRequests);

    on<InitializeNotificationService>(_handleInitializeNotificationService);
    on<CloseNotificationService>(_handleCloseNotificationService);

    on<SendFriendshipRequestEvent>(_handleSendFriendshipRequest);
    on<AcceptFriendshipRequestEvent>(_handleAcceptFriendshipRequest);
    on<DeclineFriendshipRequestEvent>(_handleDeclineFriendshipRequest);
  }

  _handleFetchRequests(FetchRequestsEvent event, Emitter<FriendshipsViewState> emit) async {
    final requests = await _friendshipUseCase.fetchRequests(event.receiverId);

    emit(state.copyWith(incomingRequests: requests));
  }

  _handleSendFriendshipRequest(SendFriendshipRequestEvent event, Emitter<FriendshipsViewState> emit) async {
    await _friendshipUseCase.sendFriendshipRequest(event.requesterId, event.receiverId);
  }

  _handleCloseNotificationService(CloseNotificationService event, Emitter<FriendshipsViewState> emit) {
    _friendshipUseCase.closeNotificationsConnection();
    _friendshipUpdates.close();
    emit(state.copyWith(isInitialized: false));
  }

  _handleAcceptFriendshipRequest(AcceptFriendshipRequestEvent event, Emitter<FriendshipsViewState> emit) async {
    await _friendshipUseCase.acceptFriendshipRequest(event.request.id);

    final updatedList = List<FriendshipEntity>.from(state.incomingRequests)..remove(event.request);

    emit(state.copyWith(incomingRequests: updatedList));
  }

  _handleDeclineFriendshipRequest(DeclineFriendshipRequestEvent event, Emitter<FriendshipsViewState> emit) async {
    await _friendshipUseCase.declineFriendshipRequest(event.request.id);
  }

  _handleInitializeNotificationService(InitializeNotificationService event, Emitter<FriendshipsViewState> emit) async {
    if (state.isInitialized) return;

    _friendshipUseCase.initializeNotificationConnection(event.userId, (err, entity) {
      if (err != 'success') {
        print('Error: $err');
        return;
      }

      _friendshipUpdates.add(List<FriendshipEntity>.from(state.incomingRequests)..add(entity!));
    });

    emit(state.copyWith(isInitialized: true));

    await emit.forEach<List<FriendshipEntity>>(_friendshipUpdates.stream,
        onData: (incomingRequests) {
          return state.copyWith(incomingRequests: incomingRequests);
        });
  }
}
