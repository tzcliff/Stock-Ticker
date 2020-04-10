import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsListItem extends StatelessWidget {
  final String title;
  final String link;
  final String image;

  const NewsListItem({
    @required this.title,
    @required this.link,
    @required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        elevation: 5,
        child: Padding(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
//              FlatButton(
//                onPressed: _launchURL(link),
//                child: Text(title),
//              ),
            Text(title.toString()),
              Image.network(
                image
              )
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
      ),
    );
  }
}

_launchURL(String link) async {
  String url = link;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}