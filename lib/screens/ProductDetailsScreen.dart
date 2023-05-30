import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailScreen extends StatefulWidget {
  final String title;
  final String image;
  final String article;
  final String price;
  final String description;
  const ProductDetailScreen(
      {super.key,
      required this.title,
      required this.image,
      required this.article,
      required this.price,
      required this.description});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back)),
              toolbarHeight: 100,
              title: Text(
                widget.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              backgroundColor: Color.fromARGB(255, 10, 13, 66),
              automaticallyImplyLeading: false,
              pinned: true,
              snap: false,
              floating: false,
              expandedHeight: 350.0,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 350,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                          widget.image,
                        ),
                        colorFilter: ColorFilter.mode(
                            Color.fromARGB(106, 43, 43, 43), BlendMode.darken)),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(widget.description),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          color: Color.fromARGB(255, 249, 22, 112),
                        ),
                        margin: EdgeInsets.only(top: 20),
                        height: 56,
                        width: MediaQuery.of(context).size.width,
                        child: TextButton(
                            onPressed: () async {
                              final Uri launchUri =
                                  Uri(scheme: 'tel', path: '8(908)652-77-78');
                              await launch(launchUri.toString());
                            },
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Container(),
                                  ),
                                  Text('Позвонить',
                                      style: TextStyle(color: Colors.white))
                                ],
                              ),
                            ))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
