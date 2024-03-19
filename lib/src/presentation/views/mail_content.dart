import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ks_mail/src/presentation/riverpod/mail_provider.dart';
import 'package:ks_mail/src/presentation/views/new_mail.dart';
import 'package:ks_mail/src/presentation/widgets/popup_menu_widget/three_dot_widget.dart';
import 'package:ks_mail/src/utils/constants/variables.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../domain/entities/mail.dart';
import '../../domain/entities/new_mail.dart';
import '../../utils/constants/commom_functions.dart';
import '../../utils/constants/styles.dart';
import '../widgets/button_widgets/back_icon_button_widget.dart';
import '../widgets/button_widgets/starred_icon_button.dart';
import '../widgets/circular_avatar_widgets/circular_avatar_widget.dart';
import '../widgets/date_time_widgets/date_time_display_widget.dart';
import '../widgets/text_widgets/address_card_widget.dart';

class MailContentPage extends ConsumerStatefulWidget {
  const MailContentPage({super.key});
  static String id = "mailContent";

  @override
  ConsumerState<MailContentPage> createState() => _MailContentPageState();
}

class _MailContentPageState extends ConsumerState<MailContentPage> {
  late Mail mail;
  bool _showbody = true;
  bool _showCard = false;
  void showBodyContent() => setState(() => _showbody = !_showbody);

  void showCard(bool? value) => setState(() => _showCard = value ?? !_showCard);

  @override
  Widget build(BuildContext context) {
    NewMail arg = ModalRoute.of(context)!.settings.arguments as NewMail;
    int mailId = arg.mailId;
    mail = ref.watch(mailListNotifierProvider)[mailId - 1];
    print(mailId);
    String addresses = getData(
        page: arg.page,
        from: mail.from.mail,
        toList: mail.to,
        ccList: mail.cc,
        bccList: mail.bcc);
    return Scaffold(
      appBar: AppBar(leading: const BackIconButtonWidget(), actions: [
        IconButton(
            onPressed: () =>
                normalToBoldText(context: context, ref: ref, mailId: mailId),
            icon: const Icon(Icons.mark_as_unread_outlined)),
        // Delete Icon Button on Appbar
        IconButton(
            onPressed: () => deleteMail(
                context: context, ref: ref, mailId: mailId, delete: arg.page),
            icon: const Icon(Icons.delete_outline)),
        ThreeDotPopUpMenuButtonWidget(id: mailId, page: arg.page)
      ]),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          shrinkWrap: true,
          children: [
            // Mail subject as Title
            ListTile(
              contentPadding: const EdgeInsets.only(left: 5),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Text(
                      mail.subject,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      style: const TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w500,
                          height: 1,
                          letterSpacing: 0.2),
                    )),
                    StarredIconButtonWidget(
                        isStarred: mail.starredBy.contains(currentUser!.id),
                        id: mail.id!),
                  ],
                ),
              ),
              subtitle: InkWell(
                onTap: () {
                  showBodyContent();
                  showCard(false);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15, top: 7),
                      child: CircularAvatarWidget(text: mail.from.username[0]),
                    ),
                    Flexible(
                      child: SizedBox(
                        height: 70,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 7),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // This will show sender name and date or time
                              Row(
                                children: [
                                  Text(
                                    mail.from.username,
                                    style: titleUnreadedFont.copyWith(
                                        fontSize: 15),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Align(
                                      alignment: Alignment.bottomCenter,
                                      child: DateTimeDisplayWidget(
                                          createdAt: mail.updatedAt.isEmpty
                                              ? mail.createdAt
                                              : mail.updatedAt)),
                                ],
                              ),
                              // To, CC and Bcc Details
                              Visibility(
                                visible: _showbody,
                                child: Flexible(
                                    child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Wrap(
                                    children: [
                                      Text(
                                          addresses.length > 24
                                              ? '${addresses.substring(0, 24)}...'
                                              : addresses,
                                          textAlign: TextAlign.left,
                                          style: smallFont),
                                      IconButton(
                                        onPressed: () => showCard(null),
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 18,
                                        ),
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        padding: const EdgeInsets.only(top: 0),
                                        alignment: Alignment.topLeft,
                                      )
                                    ],
                                  ),
                                )),
                              ),
                              // Mail body summary
                              Visibility(
                                visible: !_showbody,
                                child: Flexible(
                                    child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(mail.body.replaceAll("\n", " "),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      textAlign: TextAlign.left,
                                      style: smallFont),
                                )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Edit and more action buttons
                    Visibility(
                      visible: _showbody,
                      child: Row(
                        children: [
                          // Edit Button
                          if (arg.page == 3)
                            IconButton(
                              icon: const Icon(Icons.edit_outlined),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NewMailPage(
                                              idValue: mailId,
                                              toValue: mail.to,
                                              bccValue: mail.bcc,
                                              ccValue: mail.cc,
                                              subjectValue: mail.subject,
                                              bodyValue: mail.body,
                                            )));
                              },
                            ),
                          // More actions
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.more_vert)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            // To , Cc and Bcc details
            Visibility(
                visible: _showCard,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: const BorderSide(color: Colors.black38)),
                    surfaceTintColor: const Color.fromARGB(0, 255, 255, 255),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: AddressCardWidget(
                        fromAddress: mail.from.username,
                        toAddress: getUsernamesFromList(mailList: mail.to),
                        ccAddress: getUsernamesFromList(mailList: mail.cc),
                        bccAddress: mail.from.mail == currentUser!.mail
                            ? getUsernamesFromList(mailList: mail.bcc)
                            : isContainsCurrentUser(mail.bcc)
                                ? AppLocalizations.of(context)!.you
                                : "",
                        dateAndTime: mail.updatedAt.isEmpty
                            ? mail.createdAt
                            : mail.updatedAt,
                      ),
                    ),
                  ),
                )),

            Visibility(visible: _showbody, child: Text(mail.body))
          ],
        ),
      ),
    );
  }
}
