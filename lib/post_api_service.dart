import 'package:chopper/chopper.dart';

part 'post_api_service.chopper.dart';

@ChopperApi(baseUrl: '/')
abstract class PostApiService extends ChopperService {
  @Get()
  Future<Response> getPosts();

  @Get(path: 'posts/{id}')
  Future<Response> getPost(@Path('id') int id);

  @Get(path: 'posts', headers: {'Constant-Header-Name': 'Header-Value'})
  Future<Response> getPostsWithHeader([
    @Header('Changeable-Header-Name') String headerValue,
  ]);

  @Get(path: 'todos/{id}')
  Future<Response> getTodos(@Path('id') int id);

  @Post(path: 'posts')
  Future<Response> postPost(
    @Body() Map<String, dynamic> body,
  );

  static PostApiService create() {
    final client = ChopperClient(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      services: [
        _$PostApiService(),
      ],
      converter: JsonConverter(),
    );

    return _$PostApiService(client);
  }
}
