import 'package:express_all/src/config/style/constants.dart';
import 'package:express_all/src/controllers/exerciseController.dart';
import 'package:express_all/src/controllers/gestureRecognitionExercise_controller.dart';
import 'package:express_all/src/services/auth/firebase_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:express_all/src/controllers/faceExpressionExercise_controller.dart';
import 'package:express_all/src/controllers/prioritySettingExercise_controller.dart';
import 'package:express_all/src/controllers/taskIdentificationExercise_controller.dart';
import 'package:express_all/src/controllers/taskSequencingExercise_controller.dart';
import 'package:logger/logger.dart';

class ScoreScreen extends StatefulWidget {
  final String questionType;
  const ScoreScreen({Key? key, required this.questionType}) : super(key: key);

  @override
  _ScoreScreenState createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  late ExerciseController controller;
  final FirebaseFirestoreService _firestore = FirebaseFirestoreService();
  Future<Map<String, dynamic>?>? scoreData;

  @override
  void initState() {
    super.initState();
    if (widget.questionType == "FacialExpression") {
      controller = Get.find<FaceExpressionExerciseController>();
    } else if (widget.questionType == "GestureRecognition") {
      controller = Get.find<GestureRecognitionExerciseController>();
    } else if (widget.questionType == "TaskIdentification") {
      controller = Get.find<TaskIdentificationExerciseController>();
    } else if (widget.questionType == "TaskSequencing") {
      controller = Get.find<TaskSequencingExerciseController>();
    } else if (widget.questionType == "PrioritySetting") {
      controller = Get.find<PrioritySettingExerciseController>();
    } else {
      controller = Get.find<FaceExpressionExerciseController>();
    }

    Logger().i(controller);

    scoreData =
        _addScore(controller.numOfCorrectAns, controller.questions.length);
  }

  @override
  void dispose() {
    Get.delete<ExerciseController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
        future: scoreData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // return CircularProgressIndicator();
            return Container(
                color: backgroundColor,
                child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 10),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(color: primaryColor),
                      ),
                      SizedBox(height: 10),
                    ])); // Replace 'return null;' with a valid widget.
          } else if (snapshot.hasError) {
            Logger().e(snapshot.error);
            return Text(
                'Error: ${snapshot.error}'); // Show an error message if something went wrong
          } else {
            var scoreData = snapshot.data;
            double score =
                scoreData?['correctAnsNum'] / scoreData?['totalQnNum'];

            String getTheRightHeader() {
              String header = "";
              if (score < 0.3) {
                header = "Room for Improvement~";
              } else if (score < 0.7) {
                header = "Well Done Buddy!";
              } else {
                header = "Great Job There!";
              }
              return header;
            }

            String getTheRightImage() {
              String image = "";
              if (score < 0.3) {
                image = "assets/images/score_page/1-star.png";
              } else if (score < 0.7) {
                image = "assets/images/score_page/2-star.png";
              } else {
                image = "assets/images/score_page/3-star.png";
              }
              return image;
            }

            return Scaffold(
              appBar: AppBar(),
              body: Stack(
                fit: StackFit.expand,
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            getTheRightHeader(),
                            style: const TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                                color: primaryColor),
                          ),
                          const SizedBox(height: 30),
                          Image.asset(
                            getTheRightImage(),
                            height: 120,
                          ),
                          Text(
                            "Your score is ${scoreData?['correctAnsNum']} out of ${scoreData?['totalQnNum']}",
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: primaryColor),
                          ),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: orangeColor,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 20),
                                          fixedSize: const Size(280, 65),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          )),
                                      onPressed: () => {
                                            debugPrint(
                                                "Next stage to be developed")
                                          },
                                      child: const Text(
                                        "Next Stage",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: orangeColor,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 20),
                                          fixedSize: const Size(280, 65),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          )),
                                      onPressed: () {
                                        Logger().i(controller);
                                        controller.reset();
                                        Navigator.pushNamed(
                                            context, "/${widget.questionType}");
                                      },
                                      child: const Text(
                                        "Play Again",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: orangeColor,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 20),
                                          fixedSize: const Size(280, 65),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          )),
                                      onPressed: () {
                                        Logger().i(controller);
                                        controller.reset();
                                        Navigator.pushNamed(
                                            context, "/MainMenu");
                                      },
                                      child: const Text(
                                        "Main Menu",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      )),
                                )
                              ]),
                        ],
                      )),
                ],
              ),
            );
          }
        });
  }

  Future<Map<String, dynamic>?> _addScore(
    int correctAnsNum,
    int totalQnNum,
  ) async {
    double score = correctAnsNum / totalQnNum;
    return _firestore.setExerciseScore(widget.questionType, correctAnsNum,
        totalQnNum, 1, score, DateTime.now());
  }
}
