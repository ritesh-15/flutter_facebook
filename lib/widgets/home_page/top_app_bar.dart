import 'package:facebook/theme/my_theme.dart';
import 'package:facebook/widgets/rounded_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TopAppBar extends StatefulWidget {
  const TopAppBar({Key? key}) : super(key: key);

  @override
  State<TopAppBar> createState() => _TopAppBarState();
}

class _TopAppBarState extends State<TopAppBar>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 6);
    _tabController?.addListener(_handleTabSelection);
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      sliver: SliverAppBar(
        floating: true,
        backgroundColor: Theme.of(context).canvasColor,
        title: Text(
          "facebook",
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: MyTheme.primary),
        ),
        actions: const [
          RoundedIconButton(icon: FontAwesomeIcons.plus),
          SizedBox(
            width: 12,
          ),
          RoundedIconButton(icon: FontAwesomeIcons.magnifyingGlass),
          SizedBox(
            width: 12,
          ),
          RoundedIconButton(icon: FontAwesomeIcons.facebookMessenger)
        ],
        bottom: TabBar(
            controller: _tabController,
            indicatorColor: MyTheme.primary,
            tabs: [
              Tab(
                icon: Icon(
                  FontAwesomeIcons.house,
                  color: _tabController?.index == 0
                      ? MyTheme.primary
                      : MyTheme.iconColor,
                ),
              ),
              Tab(
                icon: Icon(
                  FontAwesomeIcons.tv,
                  color: _tabController?.index == 1
                      ? MyTheme.primary
                      : MyTheme.iconColor,
                ),
              ),
              Tab(
                icon: Icon(
                  FontAwesomeIcons.shop,
                  color: _tabController?.index == 2
                      ? MyTheme.primary
                      : MyTheme.iconColor,
                ),
              ),
              Tab(
                  icon: Icon(
                _tabController?.index == 3
                    ? FontAwesomeIcons.solidCreditCard
                    : FontAwesomeIcons.creditCard,
                color: _tabController?.index == 3
                    ? MyTheme.primary
                    : MyTheme.iconColor,
              )),
              Tab(
                icon: Icon(
                  _tabController?.index == 4
                      ? FontAwesomeIcons.solidBell
                      : FontAwesomeIcons.bell,
                  color: _tabController?.index == 4
                      ? MyTheme.primary
                      : MyTheme.iconColor,
                ),
              ),
              Tab(
                  icon: Icon(
                FontAwesomeIcons.bars,
                color: _tabController?.index == 5
                    ? MyTheme.primary
                    : MyTheme.iconColor,
              )),
            ]),
      ),
    );
  }

  void _handleTabSelection() {
    setState(() {});
  }
}
