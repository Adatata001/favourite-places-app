import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpapp/providers/user_places.dart';
import 'package:fpapp/widgets/image_input.dart';
import 'dart:io';


class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

 

  @override
  ConsumerState<AddPlaceScreen> createState () => _AppPlaceScreeState();
}

class _AppPlaceScreeState extends ConsumerState<AddPlaceScreen> {

  final _titleController = TextEditingController();
  File? _selectedImage;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _savePlace () {
    final enteredTitle = _titleController.text;

    if(enteredTitle.isEmpty || _selectedImage == null) {
      return;
    }

    ref
        .read(userPlacesProvider.notifier)
        .addPlace(enteredTitle, _selectedImage!);

    Navigator.of(context).pop();
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new place'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              controller: _titleController,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(height:16),
            ImageInput(onPickImage: (image) {
              _selectedImage = image;
             },
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _savePlace,
              icon: Icon(Icons.add),
              label: Text('Add Place')
            ),
          ],
        ),
      ),
    );
  }

}
