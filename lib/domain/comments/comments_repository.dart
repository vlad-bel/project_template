import 'package:project_template/domain/models/comment.dart';

abstract class CommentsRepository {
  Future<List<Comment>> getComments({
    required int page,
    required int limit,
  });
}
