import 'package:unegvirtual_app/core/entities/access_token.dart';
import 'package:unegvirtual_app/core/providers/base_provider.dart';
import 'package:unegvirtual_app/core/providers/page_state.dart';
import 'package:unegvirtual_app/core/utils/utils.dart';
import 'package:unegvirtual_app/features/user/domain/entities/unsaved_user.dart';
import 'package:unegvirtual_app/features/user/domain/use_cases/create_user.dart';

class UserProvider extends BaseProvider {
  final CreateUser _createUser;

  UserProvider({
    required CreateUser createUser,
  }) : _createUser = createUser;

  /// Creates an [user].
  Future<void> createUser(
      {required AccessToken accessToken,
      required UnsavedUser unsavedUser}) async {
    state = Loading();

    final failureOrVoid = await _createUser(
      CreateUserParams(
        accessToken: accessToken,
        unsavedUser: unsavedUser,
      ),
    );

    failureOrVoid.fold(
      (failure) {
        state = Error(message: Utils.getErrorMessage(failure));
      },
      (_) {
        state = const Loaded();
      },
    );
  }
}
