import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ks_mail/src/domain/entities/user_details.dart';
import 'package:ks_mail/src/presentation/riverpod/user.dart';
import '../../utils/constants/commom_functions.dart';
import '../widgets/button_widgets/back_icon_button_widget.dart';
import '../widgets/button_widgets/send_mail_button_widget.dart';
import '../widgets/chip_widgets/display_text_chip_widget.dart';
import '../widgets/popup_menu_widget/save_draft_popup_menu.dart';
import '../widgets/text_field_widgets/multi_line_text_field_widget.dart';
import '../widgets/text_field_widgets/prefix_hint_text_field_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewMailPage extends ConsumerStatefulWidget {
  NewMailPage(
      {super.key,
      this.idValue,
      this.toValue,
      this.bccValue,
      this.ccValue,
      this.subjectValue,
      this.bodyValue});
  static String id = "newMail";
  int? idValue;
  List<UserDetails>? toValue;
  List<UserDetails>? bccValue;
  List<UserDetails>? ccValue;
  String? subjectValue;
  String? bodyValue;

  @override
  ConsumerState<NewMailPage> createState() => _NewMailPageState();
}

class _NewMailPageState extends ConsumerState<NewMailPage> {
  var subFieldVisible = false;
  FocusNode toFocus = FocusNode();
  var isEnable = false;
  final _createMailFormKey = GlobalKey<FormState>();
  TextEditingController toController = TextEditingController();
  TextEditingController bccController = TextEditingController();
  TextEditingController ccController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  TextEditingController fromController =
      TextEditingController(text: currentUser!.mail);

  List<UserDetails> toList = [];
  List<UserDetails> bccList = [];
  List<UserDetails> ccList = [];
  List<String> _filteredMailId = [];
  late int idValue;
  @override
  void initState() {
    idValue = widget.idValue ?? 0;
    toList = widget.toValue ?? [];
    bccList = widget.bccValue ?? [];
    ccList = widget.ccValue ?? [];
    subjectController.text = widget.subjectValue ?? "";
    bodyController.text = widget.bodyValue ?? "";

    super.initState();
  }

  @override
  void dispose() {
    fromController.dispose();
    toController.dispose();
    bccController.dispose();
    ccController.dispose();
    subjectController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackIconButtonWidget(),
        actions: [
          // For attachments
          // IconButton(
          //     onPressed: () {}, icon: const Icon(Icons.attachment_outlined)),
          //Send mail
          SendMailButtonWidget(
              toList: toList,
              ccList: ccList,
              bccList: bccList,
              ref: ref,
              idValue: idValue,
              subjectController: subjectController,
              bodyController: bodyController),
          // Save as Draft
          ThreeSaveDraftDotPopUpMenuButtonWidget(
              subjectController: subjectController,
              bodyController: bodyController,
              ref: ref,
              toList: toList,
              bccList: bccList,
              ccList: ccList,
              id: idValue,
              idReturn: (id) => idValue = id),
        ],
      ),
      //Text fields
      body: ListView(
        padding: const EdgeInsets.all(15.0),
        children: [
          Form(
              key: _createMailFormKey,
              child: Wrap(
                children: [
                  // From text field
                  PrefixTextFieldWidget(
                    controller: fromController,
                    text: "${AppLocalizations.of(context)!.from}   ",
                  ),
                  //For To mails
                  DisplayTextInChipWidget(
                      valueList: toList.map((user) => user.mail).toList(),
                      onDelete: (value) {
                        setState(() {
                          toList.removeWhere(
                            (user) => user.mail == value,
                          );
                        });
                      },
                      onPress: (value) {
                        setState(() {
                          toList.removeWhere(
                            (user) => user.mail == value,
                          );
                          toController.text = value;
                        });
                      }),

                  //To text field
                  PrefixTextFieldWithFunctionWidget(
                    toController: toController,
                    text: AppLocalizations.of(context)!.to,
                    onFieldSubmit: (value) {
                      setState(() {
                        // print("to: $value");
                        UserDetails user = ref
                            .read(userProvider.notifier)
                            .getUserByMail(value);
                        if (user.mail == value) {
                          toList.add(user);
                          toController.text = '';
                        } else {
                          snakeBar(
                              context: context,
                              text: "Mail Id not found in our database");
                        }
                      });
                    },
                    onTap: () {
                      print("a");
                      setState(() => subFieldVisible = !subFieldVisible);
                    },
                    filterList: _toFilterList,
                  ),

                  //Hidden fields
                  Visibility(
                    visible: subFieldVisible,
                    child: Wrap(children: [
                      // For CC mails
                      DisplayTextInChipWidget(
                        valueList: ccList.map((user) => user.mail).toList(),
                        onDelete: (value) {
                          setState(() {
                            ccList.removeWhere(
                              (user) => user.mail == value,
                            );
                          });
                        },
                        onPress: (value) {
                          setState(() {
                            ccList.removeWhere(
                              (user) => user.mail == value,
                            );
                            ccController.text = value;
                          });
                        },
                      ),
                      //CC text field
                      PrefixTextFieldWidget(
                        controller: ccController,
                        text: "${AppLocalizations.of(context)!.cc}   ",
                        onFieldSubmit: (value) {
                          setState(() {
                            UserDetails user = ref
                                .read(userProvider.notifier)
                                .getUserByMail(value);
                            if (user.mail == value) {
                              ccList.add(user);
                              ccController.text = '';
                            } else {
                              snakeBar(
                                  context: context,
                                  text: "Mail Id not found in our database");
                            }
                          });
                        },
                        filterList: _ccFilterList,
                      ),
                      //For BCC mails
                      DisplayTextInChipWidget(
                        valueList: bccList.map((user) => user.mail).toList(),
                        onDelete: (value) {
                          setState(() {
                            bccList.removeWhere(
                              (user) => user.mail == value,
                            );
                          });
                        },
                        onPress: (value) {
                          setState(() {
                            bccList.removeWhere(
                              (user) => user.mail == value,
                            );
                            bccController.text = value;
                          });
                        },
                      ),
                      //BCC text field
                      PrefixTextFieldWidget(
                        controller: bccController,
                        text: "${AppLocalizations.of(context)!.bcc}   ",
                        onFieldSubmit: (value) {
                          setState(() {
                            UserDetails user = ref
                                .read(userProvider.notifier)
                                .getUserByMail(value);
                            if (user.mail == value) {
                              bccList.add(user);
                              bccController.text = '';
                            } else {
                              snakeBar(
                                  context: context,
                                  text: "Mail Id not found in our database");
                            }
                          });
                        },
                        filterList: _bccFilterList,
                      ),
                    ]),
                  ),
                  //Subject text field
                  HintTextFieldWidget(
                      controller: subjectController,
                      hintText: AppLocalizations.of(context)!.subject),
                  //Body text field
                  MultiLineTextFieldWidget(
                      controller: bodyController,
                      hintText: AppLocalizations.of(context)!.body_hint),
                ],
              ))
        ],
      ),
    );
  }

  void _toFilterList(String value) {
    setState(() {
      debugPrint(value);
      _filteredMailId = currentUser!.knownMails.where((mailId) {
        if (!isContainsMail(toList, mailId)) {
          return mailId.contains(toController.text.toLowerCase());
        }
        return false;
      }).toList();
      print(_filteredMailId);
    });
  }

  void _ccFilterList(String value) {
    setState(() {
      debugPrint(value);
      _filteredMailId = currentUser!.knownMails.where((mailId) {
        if (!isContainsMail(ccList, mailId)) {
          return mailId.contains(toController.text.toLowerCase());
        }
        return false;
      }).toList();
      print(_filteredMailId);
    });
  }

  void _bccFilterList(String value) {
    setState(() {
      debugPrint(value);
      _filteredMailId = currentUser!.knownMails.where((mailId) {
        if (!isContainsMail(bccList, mailId)) {
          return mailId.contains(toController.text.toLowerCase());
        }
        return false;
      }).toList();
      print(_filteredMailId);
    });
  }
}
