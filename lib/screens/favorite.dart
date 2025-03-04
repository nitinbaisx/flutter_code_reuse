import 'package:flutter/material.dart';
import 'package:newproject/provider/newsProvider.dart';
import 'package:newproject/utils/utils.dart';
import 'package:provider/provider.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  final url =
      'https://img4.s3wfg.com/web/img/images_uploaded/5/8/cbwallstreetsombra.jpg';
  @override
  void initState() {
    super.initState();
    final NewsList = Provider.of<NewsProvider>(context, listen: false);
    NewsList.fetchCartList();
  }

  @override
  Widget build(BuildContext context) {
    final NewsList = Provider.of<NewsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Favorite',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: NewsList.newsList == null
          ? const Center(child: CircularProgressIndicator())
          : NewsList.newsList!.isEmpty
              ? const Center(child: Text('No favorite articles'))
              : ListView.builder(
                  itemCount: NewsList.newsList!.length,
                  itemBuilder: (context, index) {
                    final article = NewsList.newsList![index];
                    return Card(
                      child: ListTile(
                        leading: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircleAvatar(
                            backgroundImage: (article.urlToImage == null ||
                                    article.urlToImage!.isEmpty)
                                ? NetworkImage(url)
                                : NetworkImage(article.urlToImage!),
                            onBackgroundImageError: (exception, stackTrace) {
                              debugPrint('Error loading image: $exception');
                            },
                          ),
                        ),
                        title: Text(
                          UtilsFun()
                              .truncateTitleWords(article.title ?? 'No Title'),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          UtilsFun().truncateDescptionWords(
                              article.description ?? 'No Description'),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.favorite),
                          onPressed: () async {
                            await NewsList.deleteNewsArticle(article.id!);
                            UtilsFun().getSuccessSnackbar(
                              'Removed from favorites',
                              context,
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
