import 'package:flutter/material.dart';
import 'package:kabbik_ui_clone/src/features/core/screens/audio_book_details_page/widgets/custom_tabbar_delegate.dart';
import '../../../../common_widgets/dismissible_bottom_container.dart';
import 'imports.dart';

//@RoutePage()
class DetailsPage extends StatefulWidget {
  static const String routeName = '/details_page';
  final AudioBookF audioBook;

  const DetailsPage({
    super.key,
    required this.audioBook,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DetailsPageAppBarWidget(widget: widget),
      backgroundColor: kPrimaryColor,
      body: Stack(
        children: [
          NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate([
                    ClickedItemImageWidget(
                      artUri: widget.audioBook.thumbnailImageModel.audioBookImageDownloadUrl,
                    ),
                    ItemClickedTitleAlbumWidget(
                      title: widget.audioBook.title,
                      album: widget.audioBook.album,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    DetailsPageFavouriteAndPlayButtonWidget(
                      audioBook: widget.audioBook,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    const ListeningWidget(),
                    SizedBox(
                      height: 20.h,
                    ),
                    const RatingWidget(),
                    SizedBox(
                      height: 20.h,
                    ),
                    DescriptionSectionWidget(
                      description: widget.audioBook.description,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    AuthorSectionWidget(title: widget.audioBook.title),
                    SizedBox(
                      height: 10.h,
                    ),
                    const Divider(
                      thickness: 3,
                      color: Colors.white,
                    ),
                  ]),
                ),
                SliverOverlapAbsorber(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverPersistentHeader(
                    // pinned: true,
                    delegate: CustomTabBarDelegate(_tabController),
                  ),
                ),
              ];
            },
            body: TabBarContentView(
              tabController: _tabController,
              audioBook: widget.audioBook,
            ),
          ),
           const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: DismissibleBottomContainer(),
          ),
        ],
      )
    );
  }
}

