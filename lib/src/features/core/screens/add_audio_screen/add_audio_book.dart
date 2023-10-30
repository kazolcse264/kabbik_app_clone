import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kabbik_ui_clone/src/features/core/models/audio_book.dart';
import 'package:provider/provider.dart';

import '../../../../constants/colors.dart';
import '../../../../utils/global_functions.dart';
import '../../controllers/audio_book_controller_firebase.dart';
import '../../models/audio_book_chapter.dart';

//@RoutePage()
class AddAudioBookPage extends StatefulWidget {
  static const String routeName = '/add_audio_book';
  const AddAudioBookPage({Key? key}) : super(key: key);

  @override
  State<AddAudioBookPage> createState() => _AddAudioBookPageState();
}

class _AddAudioBookPageState extends State<AddAudioBookPage> {
  late AudioBooksProviderFirebase audioBooksProviderFirebase;
  final _albumController = TextEditingController();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _urlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? thumbnail;
  String? isCarousel;

  ImageSource _imageSource = ImageSource.gallery;
  List<TextEditingController> chapterNameControllers = [];
  List<TextEditingController> chapterAudioFileControllers = [];

  @override
  void didChangeDependencies() {
    audioBooksProviderFirebase =
        Provider.of<AudioBooksProviderFirebase>(context, listen: false);
    super.didChangeDependencies();
  }

  void addChapterNameTextField() {
    setState(() {
      chapterNameControllers.add(TextEditingController());
    });
  }

/*  void addChapterAudioFileTextField() {
    setState(() {
      chapterAudioFileControllers.add(TextEditingController());
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: const Text('New Audio Book'),
        actions: [
          IconButton(onPressed: _saveAudioBook, icon: const Icon(Icons.save))
        ],
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            children: [
              ///Check Carousal Image
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                ),
                child: SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Is Carousel Image?",
                          style: TextStyle(
                            fontSize: 18,
                            color: kWhiteColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          contentPadding: const EdgeInsets.all(0),
                          visualDensity: VisualDensity.compact,
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => kWhiteColor),
                          title: const Text("True",
                              style: TextStyle(
                                color: kWhiteColor,
                                fontSize: 16,
                              )),
                          value: "true",
                          groupValue: isCarousel,
                          onChanged: (value) {
                            setState(() {
                              isCarousel = value.toString();
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          visualDensity: VisualDensity.compact,
                          contentPadding: const EdgeInsets.all(0),
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => kWhiteColor),
                          title: const Text("False",
                              style: TextStyle(
                                color: kWhiteColor,
                                fontSize: 16,
                              )),
                          value: "false",
                          groupValue: isCarousel,
                          onChanged: (value) {
                            setState(() {
                              isCarousel = value.toString();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              buildTextFormField(
                controller: _albumController,
                label: 'Album Name',
                hint: 'Album Name',
                icon: Icons.album,
              ),
              buildTextFormField(
                controller: _titleController,
                label: 'Title Name',
                hint: 'Title Name',
                icon: Icons.title,
              ),
              buildTextFormField(
                controller: _descriptionController,
                label: 'Enter Description',
                hint: 'Enter Description',
                maxLines: null, // Dynamically adjust maxLines
              ),
              // Chapter Name text fields
              Column(
                children: chapterNameControllers.map((controller) {
                  return buildTextFormField(
                    controller: controller,
                    label: 'Chapter Name',
                    hint: 'Chapter Name',
                    icon: Icons.book,
                    maxLines: null, // Dynamically adjust maxLines
                  );
                }).toList(),
              ),

              // Plus button to add more Chapter Name text fields
              buildElevatedButton(
                onPressed: addChapterNameTextField,
                text: 'Add Chapter Name',
              ),

              buildTextFormField(
                controller: _urlController,
                label: 'Audio path',
                hint: 'Audio path',
                icon: Icons.audio_file,
              ),
              buildElevatedButton(
                onPressed: () {
                  pickAudio(_urlController);
                },
                text: 'Pick Audio',
              ),

              //Audio artUri pick section
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Card(
                      child: thumbnail == null
                          ? const Icon(
                              Icons.photo,
                              size: 100,
                            )
                          : Image.file(
                              File(thumbnail!),
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton.icon(
                          style: const ButtonStyle(
                            backgroundColor:MaterialStatePropertyAll(kWhiteColor),
                            iconColor:
                                MaterialStatePropertyAll(kBlackColor),
                          ),
                          onPressed: () {
                            _imageSource = ImageSource.camera;
                            _getImage();
                          },
                          icon: const Icon(Icons.camera),
                          label: const Text('Open Camera',style: TextStyle(color: kBlackColor),),
                        ),
                        const SizedBox(width: 10,),
                        TextButton.icon(
                          style: const ButtonStyle(
                            backgroundColor:MaterialStatePropertyAll(kWhiteColor),
                            iconColor:
                            MaterialStatePropertyAll(kBlackColor),
                          ),
                          onPressed: () {
                            _imageSource = ImageSource.gallery;
                            _getImage();
                          },
                          icon: const Icon(Icons.photo_album),
                          label: const Text('Open Gallery',style: TextStyle(color: kBlackColor),),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              //Multiple audio file path section
              Column(
                children: [
                  for (int i = 0; i < chapterAudioFileControllers.length; i++)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: const TextStyle(
                          color: kWhiteColor,
                          fontSize: 16,
                        ),
                        cursorColor: kWhiteColor,
                        controller: chapterAudioFileControllers[i],
                        readOnly: true,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.audiotrack),
                          prefixIconColor: kWhiteColor,
                          hintText: 'Audio file $i',
                          labelText: 'Audio file $i',
                          labelStyle: TextStyle(
                            color: kWhiteColor.withOpacity(0.8),
                            fontSize: 16,
                          ),
                          hintStyle: TextStyle(
                            color: kWhiteColor.withOpacity(0.5),
                            fontSize: 14,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide:
                                const BorderSide(color: kWhiteColor, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide:
                                const BorderSide(color: kWhiteColor, width: 1),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              /* Column(
                  children: chapterAudioFileControllers.map((controller) {
                    return buildTextFormField(
                      controller: controller,
                      label: 'Chapter Audio File Path',
                      hint: 'Chapter Audio File Path',
                      icon: Icons.audio_file,
                      maxLines: null, // Dynamically adjust maxLines
                    );
                  }).toList(),
                ),*/

              // Plus button to add more Chapter Audio File Path fields
              /*  buildElevatedButton(
                  onPressed: addChapterAudioFileTextField,
                  text: 'Add Chapter Audio File',
                ),*/
              buildElevatedButton(
                onPressed: () {
                  pickMultipleAudio();
                },
                text: 'Pick Chapter Audio Files',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _getImage() async {
    final file =
        await ImagePicker().pickImage(source: _imageSource, imageQuality: 70);
    if (file != null) {
      setState(() {
        thumbnail = file.path;
      });
    }
  }

  // Function to handle picking an audio file
  Future<void> pickAudio(TextEditingController controller) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      controller.text = result.files.single.path ?? '';
    } else {
      if (kDebugMode) {
        print('File Picker failed');
      }
    }
  }

  Future<void> pickMultipleAudio() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true, // Allow multiple file selection
      type: FileType.audio, // Filter for audio files
    );

    if (result != null) {
      setState(() {
        chapterAudioFileControllers.clear(); // Clear existing controllers
        for (var file in result.files) {
          final controller = TextEditingController();
          controller.text = file.path ?? '';
          chapterAudioFileControllers
              .add(controller); // Add new controllers for each file
        }
      });
    } else {
      if (kDebugMode) {
        print('File Picker failed');
      }
    }
  }



  Future<String> getFileNameWithoutExtension(String filePath) async {
// Split the file path by '/'
    List<String> pathParts = filePath.split('/');

// Get the last part of the path (the file name)
    String fileNameWithExtension = pathParts.last;

// Split the file name by '.' to separate the name and extension
    List<String> fileNameParts = fileNameWithExtension.split('.');

// Get the name without the extension (assuming there is at least one part)
    String fileNameWithoutExtension = fileNameParts.first;
    return fileNameWithoutExtension;
  }

  Widget buildTextFormField({
    required TextEditingController controller,
    required String label,
    required String hint,
    IconData? icon,
    int? maxLines,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        cursorColor: kWhiteColor,
        style: const TextStyle(
          color: kWhiteColor,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          prefixIcon: icon != null ? Icon(icon) : const Icon(Icons.description),
          prefixIconColor: kWhiteColor,
          labelText: label,
          labelStyle: TextStyle(
            color: kWhiteColor.withOpacity(0.8),
            fontSize: 16,
          ),
          hintText: hint,
          hintStyle: TextStyle(
            color: kWhiteColor.withOpacity(0.5),
            fontSize: 14,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: kWhiteColor, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: kWhiteColor, width: 1),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field must not be empty';
          }
          return null;
        },
      ),
    );
  }

  Widget buildElevatedButton({
    required VoidCallback onPressed,
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: const ButtonStyle(
          elevation: MaterialStatePropertyAll(5),
          shadowColor: MaterialStatePropertyAll(Colors.grey),
          backgroundColor: MaterialStatePropertyAll(kWhiteColor),
          padding: MaterialStatePropertyAll(
            EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 8,
            ),
          ),
          /*  side: MaterialStateProperty.all(
            const BorderSide(
              color: Colors.grey,
            ),
          ),*/
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: kBlackColor,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
  void _saveAudioBook() async {
    if (thumbnail == null) {
      showMsg(context, 'Please Select an Image');
      return;
    }
    if (isCarousel == null) {
      showMsg(context, 'Please Select an Option, True or False');
      return;
    }

    if (_formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Please wait',);
      try {
        final List<String> chapterAudioFileUrlList = [];
        final List<String> chapterNameList = [];
        String mainFileNameWithoutExtension = await getFileNameWithoutExtension(
            _urlController.text);
        final imageModel = await audioBooksProviderFirebase.uploadImage(
            thumbnail!, _titleController.text, isCarousel!);
        final audioFileUrl = await audioBooksProviderFirebase.uploadAudio(
            path: _urlController.text, audioFileName: mainFileNameWithoutExtension);

        if (chapterAudioFileControllers.isNotEmpty) {
          for (var i = 0; i < chapterAudioFileControllers.length; i++) {
            String fileNameWithoutExtension = await getFileNameWithoutExtension(
                chapterAudioFileControllers[i].text);
            final chapterAudioFileUrl =
            await audioBooksProviderFirebase.uploadAudio(
                path: chapterAudioFileControllers[i].text,
                audioFileName: fileNameWithoutExtension,
                mainAudioFileName : mainFileNameWithoutExtension,
                count: i);
            chapterAudioFileUrlList.add(chapterAudioFileUrl);
          }
        }
        if (chapterNameControllers.isNotEmpty) {
          for (var i = 0; i < chapterNameControllers.length; i++) {
            chapterNameList.add(chapterNameControllers[i].text);
          }
        }
        //final audioFileUrlC1 = await audioBooksProviderFirebase.uploadAudio(_urlC1Controller.text);
        //final audioFileUrlC2 = await audioBooksProviderFirebase.uploadAudio(_urlC2Controller.text);
        final audioBookChapterModel = AudioBookChapter(
          chapterNames: chapterNameList,
          chapterUrls: chapterAudioFileUrlList,
        );

        final audioBookModel = AudioBookF(
          album: _albumController.text,
          title: _titleController.text,
          description: _descriptionController.text,
          thumbnailImageModel: imageModel,
          chapters: audioBookChapterModel,
          url: audioFileUrl,
        );

        await audioBooksProviderFirebase.addNewAudioBook(audioBookModel);
        EasyLoading.dismiss();
        if (mounted) showMsg(context, 'Saved Successfully');
        resetFields();
      } catch (error) {
        EasyLoading.dismiss();
        if (mounted) {
          showMsg(context, 'Could not save, Please check your connection');
        }
        rethrow;
      }
    }
  }
  void resetFields() {
    FocusScope.of(context).unfocus();
    setState(() {
      isCarousel = null;
      _albumController.clear();
      _titleController.clear();
      _descriptionController.clear();
      _urlController.clear();
      for (var controller in chapterAudioFileControllers) {
        controller.clear();
      }
      for (var controller in chapterNameControllers) {
        controller.clear();
      }
      thumbnail = null;
      chapterNameControllers.clear();
      chapterAudioFileControllers.clear();
    });
  }

  @override
  void dispose() {
    _albumController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _urlController.dispose();
    for (var controller in chapterAudioFileControllers) {
      controller.dispose();
    }
    for (var controller in chapterNameControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
