import 'package:flutter/material.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/models/language_translate.dart';

class IMMessageItemText extends StatefulWidget {
  final IMMessage message;

  const IMMessageItemText({Key? key, required this.message}) : super(key: key);

  @override
  State<IMMessageItemText> createState() => IMMessageItemTextState();
}

class IMMessageItemTextState extends State<IMMessageItemText> {
  String? translatedText;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () => _doTranslateIfNeed());
  }

  _doTranslateIfNeed() async {
    translatedText = widget.message.translatedText;
    if (IMKit.instance.internal.state.cloudTranslateActive &&
        !widget.message.isMe &&
        (translatedText == null || translatedText!.isEmpty)) {
      Map<String, dynamic> parameters = {"q": widget.message.text};
      parameters["target"] = Localizations.localeOf(context).toString();
      LanguageTranslate result = await IMKit.instance.action.doTranslate(
          IMKit.instance.internal.state.translationApiKey, parameters);

      String? translate;
      if (result.data != null &&
          result.data!.translations != null &&
          result.data!.translations!.isNotEmpty) {
        translate = result.data!.translations![0].translatedText;
      }
      if (mounted) {
        setState(() {
          if (translate != null && translate.isNotEmpty) {
            translatedText = IMKit.S.n_translation + ": " + translate;
          }
        });
      }

      // todo update to be if need?
      // widget.message.translatedText = translatedText;
      // await IMKit.instance.internal.data.updateMessage(message: widget.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(widget.message.text ?? "",
              style: widget.message.isMe
                  ? IMKit.style.message.outgoing.textSytle
                  : IMKit.style.message.incoming.textSytle),
          Visibility(
            visible: IMKit.instance.internal.state.cloudTranslateActive &&
                translatedText != null &&
                translatedText!.isNotEmpty,
            child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(translatedText ?? "",
                    style: IMKit.style.message.outgoing.translateTextStyle)),
          ),
        ]));
  }
}
