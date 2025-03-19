import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surveyist/adminProvider/comman_provider_for_admin.dart';

class ImageSelect extends StatefulWidget {
  const ImageSelect({super.key});
  @override
  State<ImageSelect> createState() => _MyImageUi();
}

class _MyImageUi extends State<ImageSelect> {
  @override
  Widget build(BuildContext context) {
    final cameraProvider = Provider.of<CommanproviderAdmin>(context);
    return Scaffold(
      
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          ElevatedButton(
            onPressed: () {
              cameraProvider.selectMultipleImage();
            },
            child: const Text("Select Multiple Images"),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: cameraProvider.imageFileList.length,
                itemBuilder: (context, index) {
                  return Image.file(
                    File(cameraProvider.imageFileList[index].path),
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
         // SizedBox(height: 10),
          CircleAvatar(
            radius: 100,
            child: cameraProvider.image == null
                ? const Text("No Image")
                : ClipOval(
                    child: Image.file(
                      cameraProvider.image!,
                      fit: BoxFit.cover,
                      width: 200,
                      height: 200,
                    ),
                  ),
          ),
          const SizedBox(height: 10),
          IconButton(
            onPressed: () {
             // print("Camera button working");
              showImagePickerOption(context);
            },
            icon: const Icon(Icons.add_a_photo),
          ),
        ],
      ),
    );
  }

  void showImagePickerOption(BuildContext context) {
    final camera = Provider.of<CommanproviderAdmin>(context, listen: false);
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        camera.getImageFromGallery();
                      },
                      child: const SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.image,
                              size: 70,
                            ),
                            Text("Gallery"),
                          ],
                        ),
                      )),
                ),
                Expanded(
                  child: InkWell(
                      onTap: () {
                        camera.getImageFromCamera();
                        Navigator.pop(context);
                      },
                      child: const SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 70,
                            ),
                            Text("Camera"),
                          ],
                        ),
                      )),
                )
              ],
            ),
          );
        });
  }
}
