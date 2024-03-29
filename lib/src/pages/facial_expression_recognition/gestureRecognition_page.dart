import 'package:express_all/src/components/gesture_recognition/body.dart';
import 'package:express_all/src/config/style/constants.dart';
import 'package:express_all/src/controllers/gestureRecognitionExercise_controller.dart';
import 'package:express_all/src/pages/score_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class GestureRecognitionPage extends StatelessWidget {
  const GestureRecognitionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Gesture and Body Language Exercise',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).primaryColor),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Image.asset(
                  'assets/images/emotion_gesture_recognition/gesture_recognition.png',
                  height: 350,
                ),
                const SizedBox(height: 20),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 240, 154, 89),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const GestureRecognitionExercisePage())),
                    label: const Text(
                      'Start Now',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}

class GestureRecognitionExercisePage extends StatelessWidget {
  const GestureRecognitionExercisePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    GestureRecognitionExerciseController questionController =
        Get.put(GestureRecognitionExerciseController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Questions ${questionController.questionNumber.value}",
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: primaryColor)),
              Text(
                  "(${questionController.questionNumber.value}/${questionController.questions.length})",
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: primaryColor)),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: const Body(),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
              style: TextButton.styleFrom(
                foregroundColor: primaryColor,
              ),
              onPressed: questionController.previousQuestion,
              child: const Text("Back")),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: primaryColor,
            ),
            onPressed: () {
              if (questionController.questionNumber.value !=
                  questionController.questions.length) {
                Logger().i('Next Question');
                questionController.nextQuestion();
              } else {
                Logger().i('Score Screen');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ScoreScreen(
                              questionType: "GestureRecognition",
                            )));
              }
            },
            child: const Text("Next"),
          )
        ],
      ),
    );
  }
}
