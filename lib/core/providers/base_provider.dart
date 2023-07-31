import 'dart:async';

import 'package:flutter/material.dart';

import 'package:rxdart/streams.dart';
import 'package:rxdart/subjects.dart';

import 'package:unegvirtual_app/core/error/failures.dart';
import 'package:unegvirtual_app/core/providers/page_state.dart';
import 'package:unegvirtual_app/core/services/notifications_service.dart';
import 'package:unegvirtual_app/core/utils/utils.dart';

abstract class BaseProvider extends ChangeNotifier {
  late StreamSubscription<PageState> _subscription;
  late BehaviorSubject<PageState> _stateController;

  /// The [stream] of the controller.
  ValueStream<PageState> get stream => _stateController.stream;

  /// The [initialState].
  PageState get initialState => Empty();

  /// The current [state].
  PageState get state => _stateController.stream.value;

  set state(PageState nextState) {
    if (_stateController.isClosed) return;

    _stateController.add(nextState);
  }

  bool _isDisposed = false;

  /// Tells if the object [isDisposed].
  bool get isDisposed => _isDisposed;

  BaseProvider() {
    _handleStateChange();
  }

  /// Handles the state change.
  void _handleStateChange() {
    _stateController = BehaviorSubject();
    state = initialState;

    // Notifies the changes.
    _subscription = _stateController.stream.listen((event) {
      notifyListeners();
    });
  }

  /// Sets the [state] to [Error] and displays
  /// an [SnackBar] with a readable message.
  void onFailure(Failure failure) {
    final message = Utils.getErrorMessage(failure);

    state = Error(message: message);
    NotificationsService.showSnackBar(message);
  }

  @override
  void dispose() {
    _isDisposed = true;

    _subscription.cancel();
    _stateController.close();

    super.dispose();
  }
}
