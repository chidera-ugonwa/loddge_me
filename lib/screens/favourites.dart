import 'package:flutter/material.dart';
import 'package:loddge_me/models/services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:loddge_me/screens/findLodges/lodge_detail.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final Services _services = Services();
  bool isFilled = false;
  bool isLoading = true;
  Map listingDetail = {};
  List urls = [];
  List<dynamic> items = [];
  List<List> imageUrls = [];
  int activePage = 0;
  String? nextPageToken = '';
  late ScrollController _scrollController;

//snackBar widget
  void showSnackBar(context) {
    const snackBar = SnackBar(
      duration: Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(50),
      backgroundColor: Colors.white,
      showCloseIcon: true,
      closeIconColor: Colors.black,
      content: Text('Listing has been removed from your favorites',
          style: TextStyle(color: Colors.black)),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  //position indicator widget
  List<Widget> indicators(int imagesLength, int currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: const EdgeInsets.fromLTRB(3, 0, 3, 0),
        width: currentIndex == index ? 8 : 5,
        height: currentIndex == index ? 8 : 5,
        decoration:
            const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      );
    });
  }

  //get favorites from firestore
  Future getFavorites() async {
    var result = await _services.getListingsFromFireStore();
    // debugPrint(items.data().toString());
    for (var item in result) {
      listingDetail = await item.data();
      items.add(listingDetail['name']);
      imageUrls.add(listingDetail['urls']);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    getFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: JumpingDots(
              color: Colors.black,
              radius: 6,
              numberOfDots: 3,
              innerPadding: 2.0,
              verticalOffset: 10,
              animationDuration: const Duration(milliseconds: 300),
            ))
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 80, 20, 0),
                    child: Text('Favorites',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: NotificationListener<ScrollEndNotification>(
                        onNotification: (ScrollNotification notification) {
                          if (notification.metrics.pixels ==
                              notification.metrics.maxScrollExtent) {
                            // getUserList();
                          }
                          return true;
                        },
                        child: GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisExtent: 380,
                          ),
                          controller: _scrollController,
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 300,
                                  child: GridTile(
                                    header: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              color: Colors.white,
                                              icon: const Icon(Icons
                                                  .favorite_border_outlined),
                                              onPressed: () {
                                                _services
                                                    .deleteListing(items[index])
                                                    .then((value) =>
                                                        showSnackBar(context));
                                              },
                                            )
                                          ],
                                        )),
                                    footer: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: indicators(5, activePage)),
                                    ),
                                    child: CarouselSlider.builder(
                                      itemCount: 5,
                                      options: CarouselOptions(
                                        onPageChanged: (val, _) {
                                          setState(() {
                                            activePage = val;
                                          });
                                        },
                                        aspectRatio: 1,
                                        viewportFraction: 1,
                                        enableInfiniteScroll: true,
                                      ),
                                      itemBuilder:
                                          (context, itemIndex, realIndex) {
                                        return Container(
                                          margin: const EdgeInsets.all(10),
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10.0)),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return LodgeDetail(
                                                      imageUrls[index],
                                                      items[index]);
                                                }));
                                              },
                                              child: Image.network(
                                                imageUrls[index][itemIndex],
                                                fit: BoxFit.fill,
                                                width: 1000.0,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(items[index],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      const Text(
                                        'A self contain apartment',
                                        style: TextStyle(
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.w300),
                                      ),
                                      const Text('N250K')
                                    ],
                                  ),
                                )
                              ],
                            );
                          },
                        )),
                  ),
                ],
              ),
            ),
    );
  }
}
