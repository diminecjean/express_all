import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:express_all/src/models/gestureRecognitionExerciseQuestions.dart';
import 'package:express_all/src/controllers/exerciseController.dart';

// We use get package for our state management

class GestureRecognitionExerciseController extends ExerciseController {
  late PageController _pageController;
  @override
  PageController get pageController => _pageController;

  final List<GestureRecognitionExerciseQuestions> _questions =
      gesture_recognition_exercise_question
          .map(
            (question) => GestureRecognitionExerciseQuestions(
                id: question['id'],
                image: question['image'],
                question: question['question'],
                options: question['options'],
                answer: question['answer_index']),
          )
          .toList();
  @override
  List<GestureRecognitionExerciseQuestions> get questions => _questions;

  bool _isAnswered = false;
  @override
  bool get isAnswered => _isAnswered;

  late int _correctAns;
  @override
  int get correctAns => _correctAns;

  late int _selectedAns;
  @override
  int get selectedAns => _selectedAns;

  // for more about obs please check documentation
  final RxInt _questionNumber = 1.obs;
  @override
  RxInt get questionNumber => _questionNumber;

  int _numOfCorrectAns = 0;
  @override
  int get numOfCorrectAns => _numOfCorrectAns;

  // called immediately after the widget is allocated memory
  @override
  void onInit() {
    _pageController = PageController();
    super.onInit();
  }

  // called just before the Controller is deleted from memory
  @override
  void onClose() {
    super.onClose();
    _pageController.dispose();
  }

  @override
  void checkAns(dynamic question, dynamic selectedIndex) {
    _isAnswered = true;
    _correctAns = question.answer;
    _selectedAns = selectedIndex;

    if (_correctAns == _selectedAns) _numOfCorrectAns++;
    Logger().i(_numOfCorrectAns);
    update();
  }

  @override
  void nextQuestion() {
    if (_questionNumber.value != _questions.length) {
      _isAnswered = false;
      _pageController.nextPage(
          duration: const Duration(milliseconds: 150), curve: Curves.ease);
    }
  }

  @override
  void previousQuestion() {
    if (_questionNumber.value != 1) {
      _isAnswered = false;
      _pageController.previousPage(
          duration: const Duration(milliseconds: 150), curve: Curves.ease);
    }
  }

  @override
  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }

  @override
  void reset() {
    _isAnswered = false;
    _questionNumber.value = 1;
    _numOfCorrectAns = 0;
    _pageController.jumpToPage(0);
  }

  @override
  int getAnswerIndex(dynamic question) {
    return question.answer;
  }
}