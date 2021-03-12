import 'package:http/http.dart' as http;
import 'package:imagine_app_linkedin/global/enviroment.dart';
import 'package:imagine_app_linkedin/models/post_model.dart';
import 'package:imagine_app_linkedin/models/posts_response.dart';
import 'package:imagine_app_linkedin/services/auth_service.dart';

class PostService {
  static Future<List<Post>> getPosts() async {
    try {
      final Uri url = new Uri.http('${Enviroment.apiUrl}', '/api/posts');
      final resp = await http.get(
        url,
        headers: ({
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken(),
        }),
      );
      final postsResp = postsResponseFromJson(resp.body);
      print(resp.body);
      return postsResp.posts;
    } catch (error) {
      return [];
    }
  }
}
