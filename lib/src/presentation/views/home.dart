import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ks_mail/src/presentation/widgets/app_bar_widgets/long_press_app_bar_widget.dart';
import 'package:ks_mail/src/presentation/widgets/app_bar_widgets/serach_appbar_widget.dart';
import 'package:ks_mail/src/presentation/widgets/bottom_navigator_widgets/bottom_navigator_widget.dart';
import 'package:ks_mail/src/presentation/widgets/drawer_widgets/drawer_widget.dart';
import 'package:ks_mail/src/utils/constants/constant.dart';

import 'package:ks_mail/src/presentation/riverpod/mail_list.dart';
import '../../domain/entities/mail.dart';
import '../../utils/constants/commom_functions.dart';
import '../riverpod/navigator.dart';
import '../riverpod/user.dart';
import '../widgets/empty_bin_widget.dart';
import '../widgets/floating_action_button_widgets/floating_action_button_widget.dart';
import '../widgets/list_view_content_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});
  static String id = "home";

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  bool _showNavBar = true;
  late List<Mail> mailList;
  ScrollController homeScrollController = ScrollController();
  List<Mail> _filteredMails = [];

  late String titelText;
  @override
  void initState() {
    //Set currentUser knownMails
    currentUser!.knownMails = ref
        .read(mailListProvider.notifier)
        .getUserKnownMails(currentUser!.mail);
    homeScrollController.addListener(() {
      setState(() {
        _showNavBar = homeScrollController.position.userScrollDirection ==
            ScrollDirection.forward;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //To find the page
    int page = ref.watch(navigatorProvider);
    switch (page) {
      case 0: //inbox
        mailList = ref
            .watch(mailListProvider)
            .where((mail) =>
                (isContainsCurrentUser(mail.to) ||
                    isContainsCurrentUser(mail.cc) ||
                    isContainsCurrentUser(mail.bcc)) &&
                !mail.deletedBy.contains(currentUser!.id) &&
                mail.draft != true &&
                !mail.completelyDeleted.contains(currentUser!.id))
            .toList()
            .reversed
            .toList();

        titelText = AppLocalizations.of(context)!.inbox;
      case 1: //starred
        mailList = ref
            .watch(mailListProvider)
            .where((mail) =>
                mail.starredBy.contains(currentUser!.id) &&
                !mail.deletedBy.contains(currentUser!.id) &&
                !mail.completelyDeleted.contains(currentUser!.id))
            .toList()
            .reversed
            .toList();
        // mailList = ref
        //     .read(mailListProvider.notifier)
        //     .getStarredMails()
        //     .reversed
        //     .toList();
        titelText = AppLocalizations.of(context)!.starred;
      case 2: //sent
        mailList = ref
            .watch(mailListProvider)
            .where((mail) =>
                mail.from.id == currentUser!.id &&
                !mail.deletedBy.contains(currentUser!.id) &&
                !mail.completelyDeleted.contains(currentUser!.id) &&
                mail.draft == false)
            .toList()
            .reversed
            .toList();
        // mailList = ref.read(mailListProvider.notifier).getUserSentMails();
        titelText = AppLocalizations.of(context)!.sent;
      case 3: // draft
        mailList = ref
            .watch(mailListProvider)
            .where((mail) =>
                mail.from.id == currentUser!.id &&
                mail.draft == true &&
                mail.completelyDeleted.isEmpty &&
                mail.deletedBy.isEmpty)
            .toList()
            .reversed
            .toList();
        // mailList = ref.read(mailListProvider.notifier).getUserDraft();
        titelText = AppLocalizations.of(context)!.draft;
      case 4: //bin
        mailList = ref
            .watch(mailListProvider)
            .where((mail) =>
                mail.deletedBy.contains(currentUser!.id) &&
                !mail.completelyDeleted.contains(currentUser!.id))
            .toList()
            .reversed
            .toList();
        // mailList = ref.read(mailListProvider.notifier).getUserBinMails();
        titelText = AppLocalizations.of(context)!.bin;
    }

    return Scaffold(
      key: _key,
      drawer: DrawerWidget(),
      body: Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: CustomScrollView(controller: homeScrollController, slivers: [
          // Appbar with search
          SliverPadding(
            padding: const EdgeInsets.only(top: 20),
            sliver: SliverAppBar(
              toolbarHeight: 70,
              snap: false,
              pinned: false,
              floating: false,
              title: longpressAppBar
                  ? const LongpressAppBarWidget()
                  : SearchAppbar(keyvalue: _key, filterList: _filterList),
              automaticallyImplyLeading: false,
              titleSpacing: 0,
            ),
          ),
          // Title Text
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 13, bottom: 10, left: 7),
              child: Text(
                _filteredMails.isNotEmpty ? "Quick search" : titelText,
                style: const TextStyle(fontSize: 13),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          //To Empty Bin
          if (page == 4 && mailList.isNotEmpty) const EmptyBinWidget(),
          // Mail List
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) =>
                    // inbox = ref.watch(mailListProvider);\
                    ListViewContent(
                        mail: _filteredMails.isNotEmpty
                            ? _filteredMails[index]
                            : mailList[index]),
                childCount: _filteredMails.isNotEmpty
                    ? _filteredMails.length
                    : mailList.length),
          )
        ]),
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        height: _showNavBar ? 55 : 0,
        child: const Wrap(children: [BottomNavigation()]),
      ),
      floatingActionButton: const FloatingActionButtonWidget(),
    );
  }

  void _filterList(String value) {
    setState(() {
      debugPrint(value);
      _filteredMails = value.isNotEmpty
          ? mailList
              .where((mail) =>
                  mail.body.toLowerCase().contains(value) ||
                  mail.subject.toLowerCase().contains(value) ||
                  mail.from.username.toLowerCase().contains(value))
              .toList()
          : [];
      print(_filteredMails);
    });
  }
}
