import 'dart:convert';
import 'dart:developer';
import 'package:blog_explorer/api/base/base_repository.dart';
import 'package:blog_explorer/model/blog_data.dart';
import 'package:http/http.dart';

class BlogListRepository extends BaseRepository {
  Future<BlogData> fetchBlogListData() async {
    Map<String, String> headers = {
      "x-hasura-admin-secret":
          "32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6",
    };
    Response response = await requestHttps(
      RequestType.GET,
      "https://intent-kit-16.hasura.app/api/rest/blogs",
      null,
      headers: headers,
    );
    log(response.statusCode.toString());
    log(response.body);
    return BlogData.fromJson(jsonDecode(response.body));
  }
}
