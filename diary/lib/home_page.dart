import 'package:diary/diary_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //달력 보여주는 형식
  CalendarFormat calendarFormat = CalendarFormat.month;

  //선택된 날짜
  DateTime selectedDate = DateTime.now();

  // create text controller
  TextEditingController createTextController = TextEditingController();

  // update text controller
  TextEditingController updateTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<DiaryService>(
      builder: (context, diaryService, child) {
        List<Diary> diaryList = diaryService.getByDate(selectedDate);
        return Scaffold(
          // 키보드 올라와도 화면 밀지 않도록 _overflow 방지
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Column(
              children: [
                //달력
                TableCalendar(
                  focusedDay: selectedDate,
                  firstDay: DateTime.utc(2020, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  calendarFormat: calendarFormat,
                  onFormatChanged: (format) {
                    //달력 형식 변경 _ 우측 상단 버튼(한 달, 2주, 1주)
                    setState(() {
                      calendarFormat = format;
                    });
                  },
                  eventLoader: (date) {
                    // 각 날짜에 해당하는 diaryList 보여주기
                    return diaryService.getByDate(date);
                  },
                  calendarStyle: CalendarStyle(
                    //today 색상 제거
                    todayTextStyle: TextStyle(color: Colors.black),
                    todayDecoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),

                  // 선택한 날짜 표시
                  selectedDayPredicate: (day) {
                    return isSameDay(selectedDate, day);
                  },
                  onDaySelected: (_, focusedDay) {
                    setState(() {
                      selectedDate = focusedDay;
                    });
                  },
                ),
                Divider(height: 1),

                //선택한 날짜의 일기 목록
                Expanded(
                  child: diaryList.isEmpty
                      ? Center(
                          child: Text(
                            "한 줄 일기를 작성해 주세요.",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          ),
                        )
                      : ListView.separated(
                          itemBuilder: (context, index) {
                            //역순으로 보여주기
                            int i = diaryList.length - index - 1;
                            Diary diary = diaryList[i];
                            return ListTile(
                              //text
                              title: Text(
                                diary.text,
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                ),
                              ),

                              // createdAt
                              trailing: Text(
                                DateFormat('kk:mm').format(diary.createdAt),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),

                              /// 클릭하여 update
                              onTap: () {
                                showUpdateDialog(diaryService, diary);
                              },

                              /// 꾹 누르면 delete
                              onLongPress: () {
                                showDeleteDialog(diaryService, diary);
                              },
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            //item 사이에 Divider 추가
                            return Divider(height: 1);
                          },
                          itemCount: diaryList.length,
                        ),
                ),
              ],
            ),
          ),

          //Floating Action Button
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
            onPressed: () {
              showCreateDialog(diaryService);
            },
            child: Icon(Icons.create),
          ),
        );
      },
    );
  }

  // 작성하기
  // 엔터를 누르거나 작성 버튼을 누르는 경우 호출
  void CreateDiary(DiaryService diaryService) {
    //앞뒤 공백 삭제
    String newText = createTextController.text.trim();
    if (newText.isNotEmpty) {
      diaryService.create(newText, selectedDate);
      createTextController.text = "";
    }
  }

  //수정하기
  // 엔터를 누르거나 수정 버튼을 누르는 경우 호출
  void updateDiary(DiaryService diaryService, Diary diary) {
    // 앞뒤 공백 삭제
    String updatedText = updateTextController.text.trim();
    if (updatedText.isNotEmpty) {
      diaryService.update(diary.createdAt, updatedText);
    }
  }

  void showCreateDialog(DiaryService diaryService) {}

  void showDeleteDialog(DiaryService diaryService, Diary diary) {}

  void showUpdateDialog(DiaryService diaryService, Diary diary) {}
}
