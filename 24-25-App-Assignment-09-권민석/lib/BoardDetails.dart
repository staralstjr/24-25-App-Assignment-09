import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BoardDetails extends StatelessWidget {
  final Map<String, String> board;
  final VoidCallback onDelete;
  final Function(Map<String, String>) onEdit;

  BoardDetails({
    required this.board,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Board Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              board['title']!,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              board['content']!,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    onDelete(); // 삭제 콜백 호출
                  },
                  child: Text('Delete'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final updatedBoard =
                        await context.push<Map<String, String>>(
                      '/edit-board',
                      extra: board,
                    );

                    if (updatedBoard != null) {
                      onEdit(updatedBoard); // 수정 콜백 호출
                    }
                  },
                  child: Text('Edit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
