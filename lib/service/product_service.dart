import 'package:http/http.dart' as http;

class ProductService {
  Future<http.Response?> getProduct() async {
    const baseUrl = 'fakestoreapi.com';
    try {
      final url = Uri.https(baseUrl, '/products');
      final response = await http.get(url);
      return response;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
