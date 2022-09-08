// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'fr';

  static String m0(args) => "${args} tapent...";

  static String m1(args) => "${args} tape...";

  static String m2(args) => "${args} sélectionné";

  static String m3(args) => "${args} salles de discussions";

  static String m4(args) => "${args} envoyé";

  static String m5(args1, args2) => "${args1}Inviter ${args2} à rejoindre";

  static String m6(args) => "${args} vous inviter à rejoindre le chat";

  static String m7(args) => "${args} Rejoindre le chat";

  static String m8(args1, args2) => "${args1} expuls ${args2} du groupe";

  static String m9(args) => "${args} Quitter le chat";

  static String m10(args) => "Rechercher \"${args}\"";

  static String m11(args1, args2) => "${args1} vous a envoyé ${args2}";

  static String m12(args) => "${args} a supprimé le message";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "folder_choose_room": MessageLookupByLibrary.simpleMessage(
            "Choisissez les salles de discussion"),
        "folder_create":
            MessageLookupByLibrary.simpleMessage("Créer le dossier"),
        "folder_edit":
            MessageLookupByLibrary.simpleMessage("Modifier le dossier"),
        "folder_name": MessageLookupByLibrary.simpleMessage("Nom de dossier"),
        "messages_action_cancel":
            MessageLookupByLibrary.simpleMessage("Annuler"),
        "messages_action_copy": MessageLookupByLibrary.simpleMessage("Copier"),
        "messages_action_delete":
            MessageLookupByLibrary.simpleMessage("Supprimer"),
        "messages_action_edit":
            MessageLookupByLibrary.simpleMessage("Modifier"),
        "messages_action_forward":
            MessageLookupByLibrary.simpleMessage("Transférer"),
        "messages_action_reply":
            MessageLookupByLibrary.simpleMessage("Répondre"),
        "messages_action_report": MessageLookupByLibrary.simpleMessage("Prose"),
        "messages_action_resend":
            MessageLookupByLibrary.simpleMessage("Retransmission"),
        "messages_action_shareLocation":
            MessageLookupByLibrary.simpleMessage("Emplacement partagé"),
        "messages_action_unsend":
            MessageLookupByLibrary.simpleMessage("Annuler la transmission"),
        "messages_edited": MessageLookupByLibrary.simpleMessage("Édité"),
        "messages_fileCell_size":
            MessageLookupByLibrary.simpleMessage("Taille du fichier"),
        "messages_linkPreview_tapOpen": MessageLookupByLibrary.simpleMessage(
            "Cliquez ici pour ouvrir ce lien"),
        "messages_location":
            MessageLookupByLibrary.simpleMessage("Localisation"),
        "messages_location_current":
            MessageLookupByLibrary.simpleMessage("position actuelle"),
        "messages_multiple_typing": m0,
        "messages_outgoingCell_read":
            MessageLookupByLibrary.simpleMessage("Ont lu"),
        "messages_several_typing": MessageLookupByLibrary.simpleMessage(
            "Plusieurs personnes tapent..."),
        "messages_single_typing": m1,
        "n_file": MessageLookupByLibrary.simpleMessage("Ficher"),
        "n_groupMembers": MessageLookupByLibrary.simpleMessage("Participants"),
        "n_location": MessageLookupByLibrary.simpleMessage("Localisation"),
        "n_message": MessageLookupByLibrary.simpleMessage("Message"),
        "n_noMembers":
            MessageLookupByLibrary.simpleMessage("Aucun autre membre"),
        "n_photo": MessageLookupByLibrary.simpleMessage("Photo"),
        "n_room_search_history":
            MessageLookupByLibrary.simpleMessage("Recherche récente"),
        "n_sticker": MessageLookupByLibrary.simpleMessage("Sticker"),
        "n_today": MessageLookupByLibrary.simpleMessage("Aujourd\'hui"),
        "n_translation": MessageLookupByLibrary.simpleMessage("Traduction"),
        "n_unsupported_message": MessageLookupByLibrary.simpleMessage(
            "Format de message pas encore pris en charge"),
        "n_video": MessageLookupByLibrary.simpleMessage("Vidéo"),
        "n_voice_message":
            MessageLookupByLibrary.simpleMessage("Message vocal"),
        "n_yesterday": MessageLookupByLibrary.simpleMessage("hier"),
        "p_p_saved": MessageLookupByLibrary.simpleMessage("Sauvegardé"),
        "photo_select_count": m2,
        "rooms_action_delete":
            MessageLookupByLibrary.simpleMessage("Supprimer"),
        "rooms_action_edit": MessageLookupByLibrary.simpleMessage("Éditer"),
        "rooms_action_hide": MessageLookupByLibrary.simpleMessage("cacher"),
        "rooms_action_hide_alert": MessageLookupByLibrary.simpleMessage(
            "Le contenu du chat ne sera pas supprimé"),
        "rooms_action_mute": MessageLookupByLibrary.simpleMessage("Muet"),
        "rooms_action_pin": MessageLookupByLibrary.simpleMessage("Épingler"),
        "rooms_action_read": MessageLookupByLibrary.simpleMessage("Lis"),
        "rooms_action_tag": MessageLookupByLibrary.simpleMessage("Étiqueter"),
        "rooms_cell_emptyChat":
            MessageLookupByLibrary.simpleMessage("Aucun membre"),
        "rooms_count": m3,
        "rooms_empty": MessageLookupByLibrary.simpleMessage(
            "Il n\'y a actuellement aucune salle de chat"),
        "rooms_leave": MessageLookupByLibrary.simpleMessage(
            "Vous avez quitté la salle de discussion"),
        "rooms_title":
            MessageLookupByLibrary.simpleMessage("Salles de discussion"),
        "s_You_sent_a": m4,
        "s_You_unsent_a_message": MessageLookupByLibrary.simpleMessage(
            "Vous avez supprimé le message"),
        "s_You_were_mentioned":
            MessageLookupByLibrary.simpleMessage("You were mentioned."),
        "s_clear_all_of_your_recent_searches": MessageLookupByLibrary.simpleMessage(
            "Voulez-vous vraiment supprimer tout l\'historique de recherche récent?"),
        "s_invited": m5,
        "s_invited_you_to_join_the_chat": m6,
        "s_joined_the_chat": m7,
        "s_kicked": m8,
        "s_left_the_chat": m9,
        "s_no_results_found": MessageLookupByLibrary.simpleMessage(
            "Aucune donnée correspondante trouvée"),
        "s_no_search_records": MessageLookupByLibrary.simpleMessage(
            "Pas d\'historique de recherche"),
        "s_search_chat_history": MessageLookupByLibrary.simpleMessage(
            "Rechercher dans l\'historique du chat"),
        "s_search_chat_room": MessageLookupByLibrary.simpleMessage(
            "Rechercher des salles de chat"),
        "s_search_keyword": m10,
        "s_sent_a": m11,
        "s_unsent_a_message": m12,
        "tag_add":
            MessageLookupByLibrary.simpleMessage("Ajouter une étiquette"),
        "tag_choose_color":
            MessageLookupByLibrary.simpleMessage("Choisir la couleur"),
        "tag_color_message": MessageLookupByLibrary.simpleMessage(
            "Entrez le code de couleur  (#02B13F)"),
        "tag_create": MessageLookupByLibrary.simpleMessage("Créer une balise"),
        "tag_edit": MessageLookupByLibrary.simpleMessage("Édition d\'édition"),
        "tag_name_placeholder":
            MessageLookupByLibrary.simpleMessage("Entrez le nom de la balise"),
        "v_cancel": MessageLookupByLibrary.simpleMessage("Annuler"),
        "v_clear": MessageLookupByLibrary.simpleMessage("Supprimer"),
        "v_clear_all": MessageLookupByLibrary.simpleMessage("Tout supprimer"),
        "v_confirm": MessageLookupByLibrary.simpleMessage("déterminer"),
        "v_create": MessageLookupByLibrary.simpleMessage("Créer"),
        "v_join": MessageLookupByLibrary.simpleMessage("Joindre"),
        "v_leaveGroup":
            MessageLookupByLibrary.simpleMessage("Quitter le groupe"),
        "v_ok": MessageLookupByLibrary.simpleMessage("déterminer"),
        "v_open_google_map":
            MessageLookupByLibrary.simpleMessage("Ouvrir la carte Google"),
        "v_open_map": MessageLookupByLibrary.simpleMessage("Ouvrir la carte"),
        "v_save": MessageLookupByLibrary.simpleMessage("sauver"),
        "v_send": MessageLookupByLibrary.simpleMessage("Envoyer"),
        "v_shareWith":
            MessageLookupByLibrary.simpleMessage("Choisissez d\'envoyer à")
      };
}
