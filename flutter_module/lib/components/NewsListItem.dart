import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsListItem extends StatelessWidget {
  String title;
  String link;
  String image;

   NewsListItem({
    @required this.title,
    @required this.link,
    @ required this.image,
  });

  @override
  Widget build(BuildContext context) {
    if (image == null) { // a null image will cause a red error screen where the app  can't be used so if it's null just give it some value
      image = 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fbluegadgettooth.com%2Fwp-content%2Fuploads%2F2017%2F10%2Fap_currently_not_in_use-1024x574.png&f=1&nofb=1'; // error image
    }
    double c_width = MediaQuery.of(context).size.width*0.8;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        elevation: 5,
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: IconButton(
                  onPressed: _launchURL, // link to article
                  icon: Icon(Icons.receipt),
                ),
              ),
              Container (
                padding: const EdgeInsets.all(16.0),
                width: c_width,
                child: new Column (
                  children: <Widget>[
                    new Text (title.toString(), textAlign: TextAlign.left),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                width: 50,
                child: Image.network(
                    image // article thumbnail
                )
              )
            ],
          ),
        ),
      ),
    );
  }

  _launchURL() async { // launches the web browser to go to the url
    var url = this.link;
    if (url == null) {
      url = 'www.newsapi.org';
      return;
    }
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true,);
    } else {
      throw 'Could not launch $url';
    }
  }
}

