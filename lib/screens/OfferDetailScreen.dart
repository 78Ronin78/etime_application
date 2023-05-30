import 'package:flutter/material.dart';

class OfferDetailScreen extends StatefulWidget {
  final String title;
  final String chortDescription;
  final String description;
  final String image;
  const OfferDetailScreen(
      {super.key,
      required this.title,
      required this.chortDescription,
      required this.description,
      required this.image});

  @override
  State<OfferDetailScreen> createState() => _OfferDetailScreenState();
}

class _OfferDetailScreenState extends State<OfferDetailScreen> {
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
              expandedHeight: 300.0,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
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
                    Text(
                      widget.title,
                      style: TextStyle(
                          color: Color.fromARGB(255, 249, 22, 112),
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                    Text(widget.description),
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
