abstract class ApiService {
  Future<dynamic> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryparams,
  });
  Future<dynamic> post(String path,
      {dynamic data,
      Map<String, dynamic>? queryparams,
      bool isformDta = false});
}
