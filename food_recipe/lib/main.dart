import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(), // 홈페이지 보여주기
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 음식 사진 데이터
    List<Map<String, dynamic>> dataList = [
      {
        "category": "수제버거",
        "imgUrl":
            "https://i.ibb.co/HBGKYn4/foodiesfeed-com-summer-juicy-beef-burger.jpg",
      },
      {
        "category": "건강식",
        "imgUrl":
            "https://i.ibb.co/mB5YNs2/foodiesfeed-com-pumpkin-soup-with-pumpkin-seeds-on-top.jpg",
      },
      {
        "category": "한식",
        "imgUrl":
            "https://i.ibb.co/Kzzpc97/Beautiful-vibrant-shot-of-traiditonal-Korean-meals.jpg",
      },
      {
        "category": "디저트",
        "imgUrl":
            "https://i.ibb.co/DL5vJVZ/foodiesfeed-com-carefully-putting-a-blackberry-on-tiramisu.jpg",
      },
      {
        "category": "피자",
        "imgUrl": "https://i.ibb.co/qsm8QH4/pizza.jpg",
      },
      {
        "category": "볶음밥",
        "imgUrl":
            "https://i.ibb.co/yQDkq2X/foodiesfeed-com-hot-shakshuka-in-a-cast-iron-pan.jpg",
      },
    ];

    // 화면에 보이는 영역
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Food Recipe',
          style: TextStyle(
            color: Color.fromARGB(255, 69, 69, 69),
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              print("go my page");
            },
            icon: const Icon(
              Icons.person_outline,
            ),
            iconSize: 30,
            color: const Color.fromARGB(255, 69, 69, 69),
          )
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(18.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: "상품을 검색해주세요.",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 69, 69, 69),
                    ),
                  ),
                  suffixIcon:
                      IconButton(onPressed: null, icon: Icon(Icons.search))),
            ),
          ),
          const Divider(
            height: 1,
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              // 보여주려는 데이터 개수
              itemCount: dataList.length,
              // itemCount 만큼 반복되며 화면에 보여주려는 위젯
              // index가 0부터 dataList.length - 1까지 증가하며 전달됩니다.
              itemBuilder: (context, index) {
                // dataList에서 index에 해당하는 data 꺼내기
                Map<String, dynamic> data = dataList[index];
                String category = data["category"];
                String imgUrl = data["imgUrl"];

                // 카드 형태의 위젯
                return Card(
                  margin: const EdgeInsets.fromLTRB(18.0, 8.0, 18.0, 8.0),
                  // 위젯들을 위로 중첩하기 위해 Stack 위젯 사용
                  child: Stack(
                    alignment: Alignment.center, // 중앙 정렬
                    children: [
                      /// 배경 이미지
                      Image.network(
                        imgUrl,
                        width: double.infinity, // 가득 채우기
                        height: 120,
                        fit: BoxFit
                            .cover, // 이미지 비율을 유지하며 주어진 width와 height를 가득 채우기
                      ),

                      /// 배경 위에 글씨가 보이도록 반투명한 박스 추가
                      Container(
                        width: double.infinity,
                        height: 120,
                        color: Colors.black.withOpacity(0.5), // 투명도 50%
                      ),

                      /// 카테고리
                      Text(
                        category,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              margin: EdgeInsets.all(0),
              decoration:
                  BoxDecoration(color: Color.fromARGB(255, 248, 210, 97)),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/123.jpeg'),
                      radius: 36,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "jinigenie",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "genie9185@gmail.com",
                      style: TextStyle(
                          fontSize: 16, color: Color.fromARGB(255, 69, 69, 69)),
                    )
                  ],
                ),
              ),
            ),

            //event banner
            AspectRatio(
              aspectRatio: 12 / 4,
              child: PageView(
                children: [
                  Image.network(
                    "https://i.ibb.co/Q97cmkg/sale-event-banner1.jpg",
                  ),
                  Image.network(
                    "https://i.ibb.co/GV78j68/sale-event-banner2.jpg",
                  ),
                  Image.network(
                    "https://i.ibb.co/R3P3RHw/sale-event-banner3.jpg",
                  ),
                  Image.network(
                    "https://i.ibb.co/LRb1VYs/sale-event-banner4.jpg",
                  ),
                ],
              ),
            ),

            // 구매내역
            ListTile(
              title: const Text(
                '구매내역',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
              onTap: () {
                Navigator.pop(context); // 클릭시 drawer 닫기
              },
            ),
            const Divider(
              height: 1,
            ),
            ListTile(
              title: const Text(
                '저장한 레시피',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
              onTap: () {
                Navigator.pop(context); // 클릭시 drawer 닫기
              },
            ),
            const Divider(
              height: 1,
            ),
          ],
        ),
      ),
    );
  }
}
