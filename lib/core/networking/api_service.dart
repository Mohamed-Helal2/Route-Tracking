abstract class ApiService{
    Future<dynamic> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryparams,
    
  });
}