import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ks_mail/src/domain/entities/mail.dart';
import 'package:ks_mail/src/presentation/widgets/date_time_widgets/date_time_display_widget.dart';
import 'package:ks_mail/src/presentation/widgets/text_widgets/address_widget.dart';
import 'package:ks_mail/src/utils/constants/styles.dart';
import 'package:ks_mail/src/presentation/riverpod/navigator.dart';
import '../../../utils/constants/variables.dart';
import '../../../utils/constants/commom_functions.dart';
import '../button_widgets/starred_icon_button.dart';
import '../circular_avatar_widgets/circular_avatar_widget.dart';

class ListViewContent extends ConsumerStatefulWidget {
  const ListViewContent({
    super.key,
    required this.mail,
  });
  final Mail mail;

  @override
  ConsumerState<ListViewContent> createState() => _ListViewContentState();
}

class _ListViewContentState extends ConsumerState<ListViewContent> {
  @override
  Widget build(BuildContext context) {
    int page = ref.watch(navigatorProvider);
    bool ifSentPage = page == 2;
    bool ifDraftPage = page == 3;
    bool ifUserAlreadyReaded = ifSentPage || ifDraftPage
        ? true
        : widget.mail.readedBy.contains(currentUser!.id);
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      // Move to bin or Delete Permanently based on page value
      onDismissed: (direction) async {
        await deleteMail(
            context: context,
            ref: ref,
            mailId: widget.mail.id!,
            delete: page,
            swipe: true);
      },
      // This content will display if horizontal swipe happens
      background: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Spacer(),
            Icon(
              Icons.delete_outline,
              color: Colors.red,
              size: 25,
            ),
          ],
        ),
      ),
      child: InkWell(
        onTap: () {
          setState(() {});
          // Convert bold to normal text
          boldToNormalText(
              context: context, ref: ref, mailId: widget.mail.id!, page: page);
        },

        // // On development
        // onLongPress: () {
        //   longpressAppBar = true;
        //   debugPrint("show appbar");
        // },
        child: Padding(
          padding: const EdgeInsets.only(top: 7),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10, top: 5),
                //leading circle with text
                child: CircularAvatarWidget(
                    text: ifDraftPage ? "D" : widget.mail.from.username[0]),
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Sender name
                        AddressWidget(mail: widget.mail),
                        // Mail created date or time
                        DateTimeDisplayWidget(
                            createdAt: widget.mail.updatedAt.isEmpty
                                ? widget.mail.createdAt
                                : widget.mail.updatedAt)
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Mail Subject
                              Text(
                                widget.mail.subject,
                                overflow: TextOverflow.ellipsis,
                                style: ifUserAlreadyReaded
                                    ? subjectReadedFont
                                    : subjectUnreadedFont,
                              ),
                              // Mail body
                              Text(widget.mail.body.replaceAll("\n", ""),
                                  overflow: TextOverflow.ellipsis,
                                  // maxLines: 1,
                                  style: smallFont)
                            ],
                          ),
                        ),
                        StarredIconButtonWidget(
                          isStarred:
                              widget.mail.starredBy.contains(currentUser!.id),
                          id: widget.mail.id!,
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
