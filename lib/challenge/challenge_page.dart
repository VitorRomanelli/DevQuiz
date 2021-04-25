import 'package:DevQuiz/challenge/widgets/next_button/next_button_widget.dart';
import 'package:DevQuiz/challenge/widgets/question_indicator/question_indicator_widget.dart';
import 'package:DevQuiz/challenge/widgets/quiz/quiz_widget.dart';
import 'package:DevQuiz/shared/models/question_model.dart';
import 'package:flutter/material.dart';

import 'challenge_controller.dart';

class ChallengePage extends StatefulWidget {
  final List<QuestionModel> questions;

  ChallengePage({Key? key, required this.questions}) : super(key: key);

  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  final controller = ChallengeController();
  final pageController = PageController();

  void nextPage() async {
    if (controller.currentPage < widget.questions.length) {
      await Future.delayed(Duration(milliseconds: 600));
      pageController.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.linear);
    }
  }

  @override
  void initState() {
    pageController.addListener(() {
      controller.currentPage = pageController.page!.toInt() + 1;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(86),
        child: SafeArea(
          top: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              ValueListenableBuilder<int>(
                valueListenable: controller.currentPageNotifier,
                builder: (context, value, _) => QuestionIndicatorWidget(
                  currentPage: value,
                  length: widget.questions.length,
                ),
              )
            ],
          ),
        ),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: widget.questions
            .map((e) => QuizWidget(
                  question: e,
                  toNext: nextPage,
                ))
            .toList(),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: ValueListenableBuilder<int>(
          valueListenable: controller.currentPageNotifier,
          builder: (context, value, _) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (value < widget.questions.length)
                Expanded(
                  child: NextButtonWidget.white(
                    label: 'Pular',
                    onTap: nextPage,
                  ),
                ),
              if (value == widget.questions.length) SizedBox(width: 7),
              if (value == widget.questions.length)
                Expanded(
                  child: NextButtonWidget.green(
                      label: 'Confirmar',
                      onTap: () {
                        Navigator.pop(context);
                      }),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
