import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../utils/global_functions.dart';
import '../../../../auth/controllers/user_provider.dart';
import '../../../models/user_model.dart';

class UserProfileImageSection extends StatefulWidget {
  final UserProvider userProvider;
  const UserProfileImageSection({Key? key, required this.userProvider}) : super(key: key);

  @override
  State<UserProfileImageSection> createState() => _UserProfileImageSectionState();
}

class _UserProfileImageSectionState extends State<UserProfileImageSection> {
   ImageSource imageSource = ImageSource.gallery;
   String? thumbnail;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      color: Theme.of(context).primaryColor,
      child: Row(
        children: [
          Card(
            elevation: 5,
            child: widget.userProvider.userModel!.imageUrl == null
                ? GestureDetector(
              onTap: () {
                _getImage();
              },
                  child: const Icon(
              Icons.person,
              size: 100,
              color: Colors.grey,
            ),
                )
                : CachedNetworkImage(
              width: 90,
              height: 90,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) =>
              const Icon(Icons.error),
              imageUrl: widget.userProvider.userModel!.imageUrl!,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    widget.userProvider.userModel!.displayName ?? 'No Display Name',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10,),
                  IconButton(
                    onPressed: () {
                      showSingleTextFieldInputDialog(
                        context: context,
                        title: 'User Name',
                        onSubmit: (value) {
                          widget.userProvider.updateUserProfileField(
                              userFieldDisplayName,
                              value);
                        },
                      );
                    },
                    icon: const Icon(Icons.edit,color: Colors.white,),
                  ),
                ],
              ),
              Text(
                widget.userProvider.userModel!.email,
                style: const TextStyle(color: Colors.white60),
              )
            ],
          ),
        ],
      ),
    );
  }

  void _getImage() async {
    final file =
    await ImagePicker().pickImage(source: imageSource, imageQuality: 70);
    if (file != null) {
      final imageModel = await widget.userProvider.uploadImage(
          file.path,widget.userProvider.userModel!.email,'false');
      widget.userProvider.updateUserProfileField(userFieldUserImageUrl,
          imageModel.audioBookImageDownloadUrl);
    }
  }
}
