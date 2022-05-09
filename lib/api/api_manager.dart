import 'dart:ffi';

class ApiManager {
  Future<void> homeApi(
      bool successOrFail, Function success, Function fail) async {
    await Future.delayed(const Duration(seconds: 3)).then((value) {
      if (successOrFail) {
        success();
      } else {
        fail();
      }
    });
  }
}
