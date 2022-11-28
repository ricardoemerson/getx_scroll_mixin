import 'package:get/get.dart';
import 'package:getx_scroll_mixin/models/user_model.dart';

import '../../repositories/user/user_repository.dart';

class UserController extends GetxController with StateMixin<List<UserModel>>, ScrollMixin {
  final UserRepository _userRepository;

  final _page = 1.obs;
  final _limit = 12;

  final _loading = false.obs;
  bool get isLoading => _loading.value;

  late Worker workerPage;

  UserController({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  @override
  void onInit() {
    workerPage = ever<int>(_page, (_) {
      _getUsers();
    });

    super.onInit();
  }

  @override
  void onReady() {
    _getUsers();

    super.onReady();
  }

  @override
  void onClose() {
    workerPage();

    super.onClose();
  }

  Future<void> _getUsers() async {
    _loading(true);

    final result = await _userRepository.getUsers(_page.value, _limit);

    final stateResult = state ?? [];
    stateResult.addAll(result);

    change(stateResult, status: RxStatus.success());

    _loading(false);
  }

  void loadMorePages() {
    _page.value++;
  }

  @override
  Future<void> onTopScroll() async {}

  @override
  Future<void> onEndScroll() async {
    if (!isLoading) {
      _page.value++;
    }
  }
}
