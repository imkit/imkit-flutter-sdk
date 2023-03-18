import 'package:flutter/material.dart';
import 'package:imkit/imkit_sdk.dart';

class IMMessageItemText extends StatelessWidget {
  final IMMessage message;
  const IMMessageItemText({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message.text ?? "", style: message.isMe ? IMKit.style.message.outgoing.textSytle : IMKit.style.message.incoming.textSytle),
            translateWidget(context)
          ],
        ),
      );
}

extension on IMMessageItemText {
  Widget translateWidget(BuildContext context) {
    if (!IMKit.instance.internal.state.cloudTranslateActive || message.isMe) {
      return const SizedBox();
    } else if (IMKit.translatedMessage.containsKey(message.id)) {
      return translatedTextWidget(IMKit.translatedMessage[message.id]);
    } else {
      return FutureBuilder<String>(
        future: fetchTranslateText(context),
        builder: (context, snapshot) => translatedTextWidget(snapshot.data),
      );
    }
  }

  Widget translatedTextWidget(String? text) => Visibility(
        visible: (text ?? "").isNotEmpty,
        child: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            "${IMKit.S.n_translation}: ${text ?? ""}",
            style: IMKit.style.message.outgoing.translateTextStyle,
          ),
        ),
      );

  Future<String> fetchTranslateText(BuildContext context) => IMKit.instance.action
      .doTranslate(IMKit.instance.internal.state.translationApiKey, {"q": message.text, "target": Localizations.localeOf(context).toString()})
      .then((result) => result.data?.translations?.first.translatedText ?? "")
      .then((translate) {
        if (translate.isNotEmpty) {
          IMKit.translatedMessage[message.id] = translate;
        }
        return translate;
      })
      .catchError((error) => "");
}
