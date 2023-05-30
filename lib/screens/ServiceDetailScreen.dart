import 'package:etime_application/widgets/OffersListWidget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceDetailScreen extends StatefulWidget {
  final String title;
  final String description;
  final String url;
  final String image;
  final String banner;
  final bool isOffer;
  final bool isPrice;

  const ServiceDetailScreen(
      {super.key,
      required this.title,
      required this.description,
      required this.url,
      required this.image,
      required this.banner,
      required this.isOffer,
      required this.isPrice});

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  launch(url) async {
    if (await launchUrl(Uri.parse(url))) {
      final Uri launchUri = Uri.parse(url);
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $url';
    }
  }

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
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                          widget.banner,
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
                    widget.url == ''
                        ? Container()
                        : Container(
                            margin: EdgeInsets.only(top: 15, bottom: 15.0),
                            height: 55,
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(25),
                                  topLeft: Radius.circular(25),
                                  bottomLeft: Radius.circular(25),
                                  bottomRight: Radius.circular(25),
                                ),
                              ),
                              color: Color.fromARGB(255, 249, 22, 112),
                              child: TextButton(
                                  onPressed: () async {
                                    await launch(widget.url);
                                  },
                                  child: Text(
                                    'Просмотреть рейтинг',
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.white),
                                  )),
                            ),
                          ),
                    //проверяем контент - акции?
                    widget.isOffer == false
                        //проверяем контент - цены?
                        ? widget.isPrice == true
                            //проверяем изображение есть или нет
                            ? widget.image == ''
                                ? Container()
                                : Image.asset(widget.image)
                            : Container()
                        : Container(
                            height: MediaQuery.of(context).size.height * 1.5,
                            child: OfferListWidget()),
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
