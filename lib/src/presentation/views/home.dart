import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ks_mail/src/domain/entities/home_page.dart';
import 'package:ks_mail/src/presentation/widgets/app_bar_widgets/long_press_app_bar_widget.dart';
import 'package:ks_mail/src/presentation/widgets/app_bar_widgets/serach_appbar_widget.dart';
import 'package:ks_mail/src/presentation/widgets/bottom_navigator_widgets/bottom_navigator_widget.dart';
import 'package:ks_mail/src/presentation/widgets/drawer_widgets/drawer_widget.dart';
import 'package:ks_mail/src/utils/constants/commom_functions.dart';
import 'package:ks_mail/src/utils/constants/variables.dart';

import '../../domain/entities/mail.dart';
import '../riverpod/navigator.dart';
import '../widgets/button_widgets/empty_bin_widget.dart';
import '../widgets/floating_action_button_widgets/floating_action_button_widget.dart';
import '../widgets/list_view_content_widget.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});
  static String id = "home";

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  bool _showNavBar = true;
  ScrollController homeScrollController = ScrollController();
  List<Mail> _filteredMails = [];
  List<Mail> mailList = [];
  List<Mail> inboxMails = [];
  List<Mail> mailListResult = [];
  bool isLoading = true;
  late int page;
  bool firstTime = true;

  @override
  void initState() {
    homeScrollController.addListener(() {
      setState(() {
        _showNavBar = homeScrollController.position.userScrollDirection ==
            ScrollDirection.forward;
      });
    });
    super.initState();
    firstTime = false;
  }

  @override
  Widget build(BuildContext context) {
    //To find the page
    page = ref.watch(navigatorProvider);
    //PageData data getHomeData(ref: ref, context: context, page: page);
    PageData data = getHomePageData(ref: ref, context: context, page: page);
    mailList = data.mailList;

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
                _filteredMails.isNotEmpty ? "Quick search" : data.titleText,
                style: const TextStyle(fontSize: 13),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          //To Empty Bin
          if (page == 4 && mailList.isNotEmpty) const EmptyBinButtnWidget(),
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
