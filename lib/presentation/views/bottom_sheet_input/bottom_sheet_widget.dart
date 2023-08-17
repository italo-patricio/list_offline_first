import 'package:flutter/material.dart';
import 'package:list_offline_first/domain/models/todo_entity.dart';
import 'package:list_offline_first/presentation/views/bottom_sheet_input/bottom_sheet_input_view_model.dart';

class BottomSheetInput extends StatelessWidget {
  final BottomSheetInputViewModel _viewModel = BottomSheetInputViewModel();
  final Function(Map<String, dynamic> value) onSave;
  final Function onCancel;

  BottomSheetInput({super.key, required this.onSave, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
        bottom: 8,
        top: 16,
      ),
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: 'Insert title here',
              labelText: 'Title',
            ),
            onChanged: _viewModel.setTitle,
          ),
          TextField(
            decoration: const InputDecoration(
              hintText: 'Insert description here',
              labelText: 'Description'
            ),
            onChanged: _viewModel.setDescription,
          ),
          const SizedBox(height: 16),
          AnimatedBuilder(
              animation: _viewModel,
              builder: (context, widget) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        onCancel();
                      },
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        onSave(_viewModel.getToJson());
                      },
                      child: const Text('Save'),
                    ),
                  ],
                );
              }),
        ],
      ),
    );
  }
}
