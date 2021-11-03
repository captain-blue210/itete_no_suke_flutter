import 'package:itete_no_suke/model/user/user_repository_interface.dart';

class UserRepositoryMock implements UserRepositoryInterface {
  @override
  String getCurrentUser() {
    return 'p0HnEbeA3SVggtl9Ya8k';
  }
}
