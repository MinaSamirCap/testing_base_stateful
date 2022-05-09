import 'package:testing_base_stateful/api/api_manager.dart';
import 'package:testing_base_stateful/ui/second/bloc/second_bloc.dart';

abstract class BaseSecondRepository {
  Future<SecondState> callApi();
}

class SecondRepository implements BaseSecondRepository {
  late ApiManager apiManager;

  SecondRepository(this.apiManager);

  @override
  Future<SecondState> callApi() async {
    late SecondState state;
    await apiManager.homeApi(false, () {
      state = LoadedSte();
    }, () {
      state = ErrorSte();
    });
    return state;
  }
}
