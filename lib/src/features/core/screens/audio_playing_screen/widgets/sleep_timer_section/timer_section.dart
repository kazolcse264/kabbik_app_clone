import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kabbik_ui_clone/src/features/core/screens/audio_playing_screen/widgets/sleep_timer_section/sleep_timer_options.dart';
import 'package:provider/provider.dart';
import '../../../../../../common_widgets/custom_timer_text_field.dart';
import '../../../../../../common_widgets/gradiant_button.dart';
import '../../../../../../constants/colors.dart';
import '../../../../../../services/page_manager.dart';
import '../../../../../../services/service_locator.dart';
import '../../../../controllers/audio_book_controller.dart';

class TimerSectionWidget extends StatefulWidget {
  final PageManager pageManager;

  const TimerSectionWidget({
    super.key,
    required this.pageManager,
  });

  @override
  State<TimerSectionWidget> createState() => _TimerSectionWidgetState();
}

class _TimerSectionWidgetState extends State<TimerSectionWidget> {
  double timeStretchFactor = 1.0;
  final double _minStretchFactor = 0.5;
  final double _maxStretchFactor = 3.0;
  final double _increment = 0.5;
  bool _increasing = true;
  int sleepTimeInMinutes = 0;
  String formattedCountdownTime = '';
  int remainingTimeInSeconds = 0;
  Timer? countdownTimer;
  final _hourController = TextEditingController();
  final _minuteController = TextEditingController();
  var customSelectedTime = 0;
  final _formKey = GlobalKey<FormState>();
  final FocusNode _hourFocusNode = FocusNode();
  final FocusNode _minuteFocusNode = FocusNode();
  @override
  void dispose() {
    countdownTimer?.cancel();
    _hourController.dispose();
    _minuteController.dispose();
    _hourFocusNode.dispose();
    _minuteFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final audioBookProvider = Provider.of<AudioBookProvider>(context);
    final pageManager = getIt<PageManager>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () => _changeStretchFactor(audioBookProvider, pageManager),
          child: _buildSpeedControl(),
        ),
        InkWell(
          onTap: () => _showSleepTimerModal(context, pageManager),
          child: _buildSleepTimerUI(),
        ),
      ],
    );
  }

  double _changeStretchFactor(
      AudioBookProvider audioBookProvider, PageManager pageManager) {
    if (_increasing) {
      timeStretchFactor += _increment;
      if (timeStretchFactor >= _maxStretchFactor) {
        setState(() {
          timeStretchFactor = _maxStretchFactor;
          _increasing = false;
        });
      }
    } else {
      timeStretchFactor -= _increment;
      if (timeStretchFactor <= _minStretchFactor) {
        setState(() {
          timeStretchFactor = _minStretchFactor;
          _increasing = true;
        });
      }
    }
    audioBookProvider.setTimeStretchFactor(timeStretchFactor);
    pageManager.setSpeed(timeStretchFactor);
    return timeStretchFactor;
  }

  void _startTimer(PageManager pageManager) {
    final totalSeconds = sleepTimeInMinutes * 60;
    setState(() {
      remainingTimeInSeconds = totalSeconds;
    });

    countdownTimer?.cancel(); // Cancel any existing timer

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTimeInSeconds > 0) {
        setState(() {
          remainingTimeInSeconds--;

          int hours = remainingTimeInSeconds ~/ 3600;
          int minutes = (remainingTimeInSeconds % 3600) ~/ 60;
          int seconds = remainingTimeInSeconds % 60;

          formattedCountdownTime =
              '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
        });
      } else {
        timer.cancel();
        pageManager.pause();
      }
    });
  }

  Widget _buildSpeedControl() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
           '',
          style: TextStyle(
            color: Colors.tealAccent,
          ),
        ),
        Text(
          '${timeStretchFactor}x',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
          ),
        ),
        Text(
          'speed',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
          ),
        ),
      ],
    );
  }

  void _showSleepTimerModal(
      BuildContext context, PageManager pageManager) async {
    final selectedTime = await showModalBottomSheet<int>(
      context: context,
      backgroundColor: kSleepTimerBottomSheetBGColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: _buildBottomSheetContent(),
        );
      },
    );

    if (selectedTime != null) {
      if (selectedTime > 0 && selectedTime <= 60) {
        setState(() {
          sleepTimeInMinutes = selectedTime;
        });
        _startTimer(pageManager);
      } else if (selectedTime == 0) {
        setState(() {
          formattedCountdownTime = selectedTime.toString();
          countdownTimer?.cancel();
        });
      } else if (selectedTime > 60) {
        if (mounted) {
          final cSelectedTime = await showModalBottomSheet<int>(
            context: context,
            backgroundColor: kSleepTimerBottomSheetBGColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            isScrollControlled: true,
            builder: (BuildContext context) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildSetTimerButton(),
                      //TextEditing Section
                      LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          final maxHeight = MediaQuery.of(context).size.height *
                              0.8; // Adjust this factor as needed
                          final availableHeight = constraints.maxHeight -
                              100.0; // Adjust header height
                          final contentHeight =
                              availableHeight.clamp(100.0, maxHeight);
                          return SingleChildScrollView(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: contentHeight,
                                minHeight: 100.0,
                              ),
                              child: buildTimeForm() ,
                            ),
                          );
                        },
                      ),

                      //Submit Button
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 30.0,
                          right: 30.0,
                          bottom: 10.0,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: GradientButton(
                                buttonText: "Ok",
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    int hours =
                                        int.tryParse(_hourController.text ) ?? 0;
                                    int minutes =
                                        int.tryParse(_minuteController.text ) ?? 0;
                                    customSelectedTime = (hours * 60) + minutes;
                                    Navigator.of(context).pop(customSelectedTime);
                                    // Clear the text field controllers
                                    _hourController.clear();
                                    _minuteController.clear();
                                  }
                                },
                                gradientColors: const [
                                  Color(0xFF6057EC),
                                  Color(0xFF4FD4C4)
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: const [0.4, 1],
                              ),
                            )
                          ],
                        ),
                      ),
                      // ... Other UI elements ...
                    ],
                  ),
                ),
              );
            },
          );

          if (cSelectedTime != null) {
            setState(() {
              sleepTimeInMinutes = cSelectedTime;
            });
            _startTimer(pageManager);
          }
        }
      }
    }
  }

  /*TextField myTextField(TextEditingController controller) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.center,
      cursorColor: Colors.blue,

      style: const TextStyle(color: Colors.white),
      decoration: const InputDecoration(
        hintText: '00',
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.white), // Set the default underline color to white
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.white), // Set the focused underline color to white
        ),
      ),
    );
  }*/
  Form buildTimeForm() {
    return Form(
      key: _formKey, // You'll need to define _formKey in your widget class
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
                width: 40,
                child: CustomTextField(
                  controller: _hourController,
                  focusNode: _hourFocusNode,
                  nextFocusNode: _minuteFocusNode,
                  labelText: 'Hours',
                  minValue: 0,
                  maxValue: 24,
                ),
              ),
              const Text(
                'Hours',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 10,),
              SizedBox(
                height: 40,
                width: 40,
                child: CustomTextField(
                  controller: _minuteController,
                  focusNode: _minuteFocusNode,
                  labelText: 'Minutes',
                  nextFocusNode: _hourFocusNode,
                ),
              ),
              const Text(
                'Minutes',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheetContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildSetTimerButton(),
        const SleepTimerOptions(),
        //Close Button
        _buildCloseButton(),
        // ... Other UI elements ...
      ],
    );
  }

  Padding _buildCloseButton() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 30.0,
        right: 30.0,
        bottom: 10.0,
      ),
      child: Row(
        children: [
          Expanded(
            child: GradientButton(
              buttonText: "Close",
              onPressed: () {
                Navigator.of(context).pop();
              },
              gradientColors: const [Color(0xFF6057EC), Color(0xFF4FD4C4)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.4, 1],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSetTimerButton() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 5.0,
      ),
      child: Row(
        children: [
          Expanded(
            child: GradientButton(
              buttonText: "Set Sleep Timer",
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSleepTimerUI() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          formattedCountdownTime == '0' ? '' : formattedCountdownTime,
          style: const TextStyle(
            color: Colors.tealAccent,
          ),
        ),
        const Icon(
          Icons.alarm,
          color: Colors.white,
        ),
        const Text(
          'Sleep Timer',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}


