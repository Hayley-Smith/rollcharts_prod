import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TextWithLinks extends StatelessWidget {
  const TextWithLinks({super.key});

  @override
  Widget build(BuildContext context) {

    final Uri _urlWiki = Uri.parse('https://www.reddit.com/r/BehindTheTables/wiki/index/');
    final Uri _urlOrkishBlade = Uri.parse('https://www.reddit.com/user/OrkishBlade/');
    final Uri _urlLinkedIn = Uri.parse('https://www.linkedin.com/in/hsmithh/');

    Future<void> _launchUrl(Uri uri) async {
      if (!await launchUrl(uri)) {
        throw Exception('Could not launch $uri');
      }
    }



    return  Padding(
      padding: const EdgeInsets.all(16.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            const TextSpan(
              text: 'This is a collection of random tables originally posted to ',
              style: TextStyle(color: Colors.black),
            ),
            TextSpan(
              text: '/r/BehindTheTables and /r/BehindTheScreen',
              style: const TextStyle(
                color: Colors.black,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  _launchUrl(_urlWiki);

                },
            ),
            const TextSpan(
              text: ', and compiled by',
              style: TextStyle(color: Colors.black),
            ),
            TextSpan(
              text: '/r/OrkishBlade.',
              style: const TextStyle(
                color: Colors.black,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  _launchUrl(_urlOrkishBlade);

                },
            ),
            const TextSpan(
              text: 'Website design and development by',
              style: TextStyle(color: Colors.black),
            ),
            TextSpan(
              text: ' Hayley Smith',
              style: const TextStyle(
                color: Colors.black,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  _launchUrl(_urlLinkedIn);

                },
            ),
          ],
        ),
      ),
    );
  }
}
