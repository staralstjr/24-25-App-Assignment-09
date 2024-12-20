import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EditBoard extends StatelessWidget {
  final Map<String, String> board;

  EditBoard({required this.board});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // 기존 데이터를 컨트롤러에 초기화
    titleController.text = board['title']!;
    contentController.text = board['content']!;

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Board'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: contentController,
              decoration: InputDecoration(
                labelText: 'Contents',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    contentController.text.isNotEmpty) {
                  final updatedBoard = {
                    'title': titleController.text,
                    'content': contentController.text,
                  };
                  context.pop(updatedBoard); // 수정된 데이터 반환
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill out all fields')),
                  );
                }
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
