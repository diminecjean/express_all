import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:express_all/src/controllers/prioritySettingExercise_controller.dart';
import 'package:express_all/src/models/prioritySettingExerciseQuestions.dart';
import 'package:reorderables/reorderables.dart';
import '../../config/style/constants.dart';
import './option.dart';

class QuestionCard extends StatefulWidget {
  const QuestionCard({
    Key? key,
    required this.question,
  }) : super(key: key);

  final PrioritySettingQuestions question;

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  List<int> selectedSequence = [];
  late List<Widget> _options;

  @override
  void initState() {
    super.initState();
    _options = List<Widget>.generate(
      widget.question.options.length,
      (index) => Option(
        index: index,
        image: widget.question.optionImages[index],
        text: widget.question.options[index],
      ),
    );
    selectedSequence =
        List<int>.generate(widget.question.options.length, (index) => index);
  }

  @override
  Widget build(BuildContext context) {
    void onReorder(int oldIndex, int newIndex) {
      setState(() {
        // reorder the position of the moved widget
        Widget row = _options.removeAt(oldIndex);
        _options.insert(newIndex, row);
        // update the sequence of the selected answer
        final int removedItem = selectedSequence.removeAt(oldIndex);
        selectedSequence.insert(newIndex, removedItem);
      });
    }

    var wrap = ReorderableWrap(
        direction: Axis.horizontal,
        spacing: 5.0,
        runSpacing: 1.0,
        padding: const EdgeInsets.all(8),
        onReorder: onReorder,
        onNoReorder: (int index) {
          debugPrint(
              '${DateTime.now().toString().substring(5, 22)} reorder cancelled. index:$index');
        },
        onReorderStarted: (int index) {
          debugPrint(
              '${DateTime.now().toString().substring(5, 22)} reorder started: index:$index');
          debugPrint(_options.toString());
        },
        children: _options);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    PrioritySettingExerciseController controller =
        Get.put(PrioritySettingExerciseController());
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: const EdgeInsets.all(kDefaultPadding / 3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: kDefaultPadding / 3, right: kDefaultPadding / 3),
            child: Text(
              widget.question.question,
              style: const TextStyle(
                color: primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: kDefaultPadding / 3, right: kDefaultPadding / 3),
            child: Text(
              widget.question.subtitle,
              style: const TextStyle(
                color: primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.65,
            width: screenWidth * 0.8,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: wrap,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () => controller.reset(),
                  child: const Text("Restart")),
              ElevatedButton(
                  onPressed: () =>
                      controller.checkAns(widget.question, selectedSequence),
                  child: const Text("Submit")),
            ],
          )
        ],
      ),
    );
  }
}