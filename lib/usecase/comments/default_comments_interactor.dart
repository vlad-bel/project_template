import 'package:injectable/injectable.dart';
import 'package:project_template/domain/comments/comments_repository.dart';
import 'package:project_template/domain/models/comment.dart';
import 'package:project_template/usecase/comments/comments_interactor.dart';

@Singleton(as: CommentsInteractor)
class DefaultCommentsInteractor extends CommentsInteractor {
  final CommentsRepository repository;

  DefaultCommentsInteractor({
    required this.repository,
  });

  @override
  Future<List<Comment>> getComments({required int page, required int limit}) {
    return repository.getComments(page: page, limit: limit);
  }
}
