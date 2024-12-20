import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> boards = []; // 게시판 데이터 저장

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/login'); // 로그인 화면으로 이동
          },
        ),
        title: Text('Boards'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              // CreateBoard 페이지로 이동
              final newBoard = await context.push<Map<String, String>>(
                '/CreateBoard',
              );

              if (newBoard != null) {
                setState(() {
                  boards.add(newBoard); // 새 게시판 추가
                });
              }
            },
          ),
        ],
      ),
      body: boards.isEmpty
          ? Center(
              child: Text(
                '게시물을 추가해보세요!',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: boards.length,
              itemBuilder: (context, index) {
                final board = boards[index];
                return ListTile(
                  title: Text(board['title']!),
                  subtitle: Text(board['content']!),
                  onTap: () {
                    // 상세 페이지로 이동
                    context.push(
                      '/BoardDetails',
                      extra: {
                        'board': board,
                        'onDelete': () {
                          setState(() {
                            boards.removeAt(index);
                          });
                          context.pop(); // 상세 화면에서 뒤로 이동
                        },
                        'onEdit': (updatedBoard) {
                          setState(() {
                            boards[index] = updatedBoard;
                          });
                          context.pop(); // 상세 화면에서 뒤로 이동
                        },
                      },
                    );
                  },
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () async {
                          // 수정 화면으로 이동
                          final updatedBoard =
                              await context.push<Map<String, String>>(
                            '/EditBoard',
                            extra: board,
                          );

                          if (updatedBoard != null) {
                            setState(() {
                              boards[index] = updatedBoard; // 수정된 데이터 저장
                            });
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            boards.removeAt(index); // 게시물 삭제
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
