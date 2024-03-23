import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../domain/entities/apps.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/icons.dart';
import '../../../utils/constants/styles.dart';

class AppListViewWidget extends StatelessWidget {
  const AppListViewWidget({
    super.key,
    required this.appList,
  });

  final List<App> appList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: appList.length,
      itemBuilder: (context, index) {
        return Card(
          color: dullBlueTrans,
          margin: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(children: [
            Container(
              width: 100,
              height: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: dullBlueTrans,
                  borderRadius: BorderRadius.circular(12)),
              // Image or appname first letter
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  appList[index].applogo,
                  errorBuilder: (context, error, stackTrace) => Text(
                    appList[index].appname[0],
                    style: textStyle,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  // appname
                  Text(
                    appList[index].appname,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                    textAlign: TextAlign.left,
                  ),
                  verticalSpace10px,
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(children: [
                          //icon and filesize
                          downloadIcon,
                          Text("${appList[index].filesize} MB")
                        ]),
                        Column(
                          children: [
                            // download count
                            Text(
                              "${appList[index].downloads}M+",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(AppLocalizations.of(context)!.download),
                          ],
                        ),
                        Column(children: [
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.start,
                            children: [
                              // review count
                              Text(
                                '${appList[index].id}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const Icon(Icons.star, size: 15)
                            ],
                          ),
                          Text("${appList[index].review}K Reviews")
                        ]),
                      ]),
                ],
              ),
            ),
          ]),
        );
      },
    );
  }
}
