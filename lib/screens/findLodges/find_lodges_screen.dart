import 'package:flutter/material.dart';
import 'package:loddge_me/models/services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:loddge_me/screens/findLodges/lodge_detail.dart';

class LodgesScreen extends StatefulWidget {
  const LodgesScreen({super.key});

  @override
  State<LodgesScreen> createState() => _LodgesScreenState();
}

class _LodgesScreenState extends State<LodgesScreen>
    with AutomaticKeepAliveClientMixin {
  final Services _services = Services();
  bool isFilled = false;
  bool isLoading = true;
  List<List> urlsList = [];
  List urls = [];
  List<String> items = [];
  List<List> imageUrls = [];
  int activePage = 0;
  String? nextPageToken = '';
  late ScrollController _scrollController;

  @override
  bool get wantKeepAlive => true;

  //snackBar widget
  void showSnackBar(context) {
    const snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 1),
        margin: EdgeInsets.all(50),
        backgroundColor: Colors.white,
        showCloseIcon: true,
        closeIconColor: Colors.black,
        content: Text('Listing has been added to your favorites',
            style: TextStyle(color: Colors.black)));
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

  parseUrls() {
    // ignore: unused_local_variable
    for (var l in imageUrls) {
      var val = urls.take(5);
      urlsList.add(val.toList());
      urls.removeRange(0, 5);
    }
    imageUrls.replaceRange(imageUrls.indexOf(imageUrls.first),
        imageUrls.indexOf(imageUrls.last) + 1, urlsList);
    setState(() {
      isLoading = false;
    });
    return null;
  }

  Future getUserList(String? pageToken) async {
    final storageRef = FirebaseStorage.instance.ref();
    final userRef = storageRef.child('users/photos');
    final result = await userRef.list(ListOptions(
      maxResults: 5,
      pageToken: pageToken,
    ));
    for (var prefix in result.prefixes) {
      ListResult result = await prefix.list(ListOptions(
        maxResults: 5,
        pageToken: pageToken,
      ));
      for (var name in result.prefixes) {
        items.add(name.name);
        ListResult resolt = await name.list(ListOptions(
          maxResults: 5,
          pageToken: pageToken,
        ));
        imageUrls.add(resolt.items);
        for (var item in resolt.items) {
          String result = await item.getDownloadURL();
          urls.add(result);
        }
        pageToken = resolt.nextPageToken;
      }
      pageToken = result.nextPageToken;
    }
    pageToken = result.nextPageToken;
    parseUrls();
  }

  @override
  void initState() {
    getUserList(nextPageToken);
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Material(
            elevation: 3,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.transparent, //New
                        blurRadius: 25.0,
                        offset: Offset(0, -25))
                  ],
                ),
                width: double.infinity,
                height: 40,
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search by Name',
                    prefixIcon: const Icon(Icons.search, color: Colors.black),
                    suffixIcon: IconButton(
                        color: Colors.black,
                        onPressed: () {},
                        icon: const Icon(Icons.filter_list_rounded)),
                  ),
                )),
          )),
      body: isLoading
          ? Center(
              child: JumpingDots(
              color: Colors.black,
              radius: 6,
              numberOfDots: 3,
              innerPadding: 2.0,
              verticalOffset: 11,
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
                    padding: EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                    child: Text('Listings',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24)),
                  ),
                  const SizedBox(
                    height: 20,
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
                                                    .saveListingsToFireStore(
                                                        items[index],
                                                        '250k',
                                                        imageUrls[index],
                                                        '',
                                                        '',
                                                        '',
                                                        '',
                                                        [],
                                                        '',
                                                        '',
                                                        '')
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
