import 'package:flutter/material.dart';
import 'package:news_test/mock_api.dart';
import 'package:news_test/mock_data.dart';
import 'package:url_launcher/url_launcher.dart';


class NewsListPage extends StatefulWidget {
  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> with SingleTickerProviderStateMixin {

  late TabController _tabController;
  List<NewsArticle> articles = [];
  int currentPage = 0;
  bool hasMore = true;  // 뉴스 더 있는지 확인 

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    loadMoreArticles();
  }

  // 뉴스 5개씩 불러오기 
  void loadMoreArticles() async {
    List<NewsArticle> newArticles = await MockApi().fetchNewsArticles(page: currentPage, limit: 5);
    if (newArticles.length < 5) {
      hasMore = false;
    }
    setState(() {
      articles.addAll(newArticles);
      currentPage++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: 800),
        child: Scaffold(
          appBar: AppBar(
            title: Text('News Example!!'),
            bottom: TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey[700],
              labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              unselectedLabelStyle: TextStyle(fontSize: 16),
              indicatorColor: Colors.blue[700],
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: EdgeInsets.symmetric(horizontal: 10),
              tabs: [
                Tab(text: '품목정보'),
                Tab(text: 'BPI'),
                Tab(text: '농산물 뉴스'),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TabBarView(
              controller: _tabController,
              children: [
                Center(child: Text('Screen A')),
                Center(child: Text('Screen B')),
                viewList(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 뉴스 클릭 시, 해당 url로 이동 
  void _launchURL(String urlString) async {
  final Uri url = Uri.parse(urlString);
  // print(url);
  try {
    if (await canLaunchUrl(url)) {
      bool launched = await launchUrl(url);
      if (!launched) {
        print('Launching URL failed.');
      }
    } else {
      print('URL cannot be launched.');
    }
  } catch (e) {
    print('Error launching URL: $e');
  }
}

  // 뉴스 불러오기 
  Widget viewList(BuildContext context) {
    return ListView.separated(
      itemCount: articles.length + (hasMore ? 1 : 0), 
      itemBuilder: (context, index) {
        if (index < articles.length) {
          NewsArticle article = articles[index];
          return ListTile(
            title: Text(article.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            subtitle: Text(article.date),
            trailing: article.imageurl.isNotEmpty ? Image.network(article.imageurl, fit: BoxFit.cover, width: 100) : null,
            onTap: () => _launchURL(article.newsurl),
          );
        } else {  // 뉴스 더 있으면 '더보기' 버튼 추가 
          return Container(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: loadMoreArticles,
              child: Text("더보기", style: TextStyle(color: Colors.grey[700]),),
            ),
          );
        }
      },
      // 마지막 제외 구분선 추가 
      separatorBuilder: (context, index) {
        if (index < articles.length - 1 || (index == articles.length - 1 && hasMore)) {
          return Divider(color: Colors.grey[300]);
        } else {
          return Container();
        }
      },
    );
  }

  /// (수정 전)농산물 뉴스 탭 하위 화면: 뉴스 불러오기 
  // Widget viewList(BuildContext context) {
  //   return Column(
  //     children: [
  //       Expanded(
  //         child: ListView.separated(
  //           itemCount: articles.length,
  //           itemBuilder: (context, index) {
  //             NewsArticle article = articles[index];
  //             return ListTile(
  //               title: Text(article.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
  //               subtitle: Text(article.date),
  //               trailing: article.imageurl.isNotEmpty ? Image.network(article.imageurl, fit: BoxFit.cover, width: 100) : null,
  //               onTap: () => _launchURL(article.newsurl),
  //             );
  //           },
  //           separatorBuilder: (context, index) => Divider(color: Colors.grey[300]),
  //         ),
  //       ),
  //       if (hasMore)
  //         TextButton(
  //           onPressed: loadMoreArticles,
  //           child: Text("더보기"),
  //         )
  //     ],
  //   );
  // }


}