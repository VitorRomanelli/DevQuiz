import 'package:DevQuiz/core/core.dart';
import 'package:DevQuiz/shared/models/answer_model.dart';
import 'package:DevQuiz/shared/models/question_model.dart';
import 'package:DevQuiz/shared/models/quiz_model.dart';
import 'package:DevQuiz/shared/models/user_model.dart';
import 'package:flutter/foundation.dart';

import 'home_repository.dart';
import 'home_state.dart';

class HomeController {
  final stateNotifier = ValueNotifier<HomeState>(HomeState.empty);

  HomeState get state => stateNotifier.value;
  set state(HomeState state) => stateNotifier.value = state;

  UserModel? user;
  List<QuizModel>? quizzes;

  final repository = HomeRepository();

  void getUser() async {
    state = HomeState.loading;

    user = await repository.getUser();

    state = HomeState.success;
  }

  void getQuizzes() async {
    state = HomeState.loading;

    quizzes = await repository.getQuizzes();

    state = HomeState.success;
  }
}
