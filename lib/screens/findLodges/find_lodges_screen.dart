import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';

class LodgesScreen extends StatefulWidget {
  const LodgesScreen({super.key});

  @override
  State<LodgesScreen> createState() => _LodgesScreenState();
}

class _LodgesScreenState extends State<LodgesScreen> {
  bool isLoading = true;
  List<List> urlsList = [];
  List urls = [];
  List<String> items = [];
  List<List> imageUrls = [];
  String? nextPageToken = '';
  late ScrollController _scrollController;

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
    //get firebase storage data
    final storageRef = FirebaseStorage.instance.ref();
    final userRef = storageRef.child('users/photos');
    var result = await userRef.list(ListOptions(
      maxResults: 5,
      pageToken: pageToken,
    ));
    result.nextPageToken != null ? nextPageToken = result.nextPageToken : null;
    //debugPrint(result.nextPageToken);
    for (var prefix in result.prefixes) {
      ListResult result = await prefix.list(ListOptions(
        maxResults: 5,
        pageToken: pageToken,
      ));
      result.nextPageToken != null
          ? nextPageToken = result.nextPageToken
          : null;
      debugPrint(result.nextPageToken);
      for (var name in result.prefixes) {
        items.add(name.name);
        // imageUrls.add([name.name]);
        ListResult resolt = await name.list(ListOptions(
          maxResults: 5,
          pageToken: pageToken,
        ));
        imageUrls.add(resolt.items);
        result.nextPageToken != null
            ? nextPageToken = result.nextPageToken
            : null;
        for (var item in resolt.items) {
          String result = await item.getDownloadURL();
          urls.add(result);
        }
      }
    }
  }

  @override
  void initState() {
    getUserList(nextPageToken).then((value) => parseUrls());
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          ? const CircularProgressIndicator()
          : Column(
              children: [
                Expanded(
                  child: NotificationListener<ScrollEndNotification>(
                      onNotification: (ScrollNotification notification) {
                        if (notification.metrics.pixels ==
                            notification.metrics.maxScrollExtent) {
                          getUserList(nextPageToken)
                              .then((value) => parseUrls());
                        }
                        return true;
                      },
                      child: GridView.builder(
                        controller: _scrollController,
                        itemCount: items.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1.3,
                          crossAxisCount: 1,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: GridTile(
                                footer: Text(items[index]),
                                child: CarouselSlider.builder(
                                    itemCount: 5,
                                    options: CarouselOptions(
                                      enableInfiniteScroll: false,
                                    ),
                                    itemBuilder:
                                        (context, itemIndex, realIndex) {
                                      return Image.network(
                                          imageUrls[index][itemIndex],
                                          fit: BoxFit.fill);
                                    })),
                          );
                        },
                      )),
                )
              ],
            ),
    );
  }
}
