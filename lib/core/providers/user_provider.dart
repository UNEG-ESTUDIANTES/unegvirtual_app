import 'package:classroom_app/core/entities/access_token.dart';
import 'package:classroom_app/core/entities/user.dart';
import 'package:classroom_app/core/providers/base_provider.dart';
import 'package:classroom_app/core/providers/page_state.dart';
import 'package:classroom_app/core/utils/utils.dart';
import 'package:classroom_app/features/user/domain/use_cases/get_current_user.dart';

class UserProvider extends BaseProvider {
  final GetCurrentUser getCurrentUserUseCase;

  /// The current [user].
  User? user;

  UserProvider({required this.getCurrentUserUseCase});

  /// Gets the [User].
  Future<void> getCurrentUser(AccessToken accessToken) async {
    state = Loading();

    final failureOrUser = await getCurrentUserUseCase(
      GetCurrentUserParams(accessToken: accessToken),
    );

    failureOrUser.fold(
      (failure) {
        state = Error(message: Utils.getErrorMessage(failure));
        user = null;
      },
      (currentUser) {
        state = const Loaded();
        user = currentUser;
      },
    );
  }
}
