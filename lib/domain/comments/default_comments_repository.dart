import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:project_template/domain/comments/comments_repository.dart';
import 'package:project_template/domain/models/app_error.dart';
import 'package:project_template/domain/models/comment.dart';
import 'package:project_template/services/network/api_manager.dart';

@Singleton(as: CommentsRepository)
class DefaultCommentsRepository extends CommentsRepository {
  final ApiManager apiManager;

  DefaultCommentsRepository({required this.apiManager});

  @override
  Future<List<Comment>> getComments({
    required int page,
    required int limit,
  }) async {
    late Response response;
    try {
      response = await apiManager.get(
        'comments',
        queryParameters: {
          "_page": page,
          "_limit": limit,
        },
      );

      final commentList = List<Comment>.from(
        response.data.map(
          (x) => Comment.fromJson(x),
        ),
      );

      return commentList;
    } catch (e) {
      throw AppError(error: e.toString());
    }
  }
}
