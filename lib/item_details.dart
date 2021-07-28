import 'package:f_split_view/item.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class ItemDetails extends StatelessWidget {
  ItemDetails({
    @required this.isInTabletLayout,
    @required this.item,
  });

  final bool isInTabletLayout;
  final Item item;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Widget content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          item?.title ?? 'No item selected!',
          style: textTheme.headline,
        ),
        Text(
          item?.subtitle ?? 'Please select one on the left.',
          style: textTheme.subhead,
        ),
        FlatButton(
          child: Text('点击'),
          onPressed: () {
            Navigator.of(context)
                .pushNamed('signup/choose_credentials', arguments: {"title": "新页面"});
          },
        )
      ],
    );

    if (isInTabletLayout) {
      return Center(child: content);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: FlatButton(
          child: Text('点击'),
          onPressed: () {},
        ),
      ),
    );
  }
}
