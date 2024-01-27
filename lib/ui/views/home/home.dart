import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lueesa_app/core/models/info_box.dart';
import 'package:lueesa_app/ui/dialogs/add_info_dialog/add_info_dialog.dart';
import 'package:lueesa_app/ui/utilities/l_text.dart';
import 'package:lueesa_app/ui/views/home/home_vm.dart';
import 'package:lueesa_app/ui/widgets/l_info_box.dart';
import 'package:stacked/stacked.dart';

import '../../style/app_assets.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => HomeViewModel(),
        onViewModelReady: (viewModel) async {
          viewModel.knowGreeting();
          viewModel.scrollController = ScrollController()
            ..addListener(() {
              if (viewModel.scrollController.offset > (size.height * 0.35) &&
                  !viewModel.showInfo) {
                viewModel.showInfo = true;
              } else if (viewModel.scrollController.offset <=
                      (size.height * 0.35) &&
                  viewModel.showInfo) {
                viewModel.showInfo = false;
              }
            });
          await viewModel.getCarouselImages(context);
        },
        builder: ((context, viewModel, child) => GestureDetector(
              onTap: () {
                viewModel.isBoxTapped = false;
              },
              child: Scaffold(
                  key: scaffoldKey,
                  floatingActionButton: FloatingActionButton(onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AddInfoDialog();
                        });
                  }),
                  drawer: Drawer(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        DrawerHeader(
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: AppAssets.lueesaLogo(100))),
                        ListTile(
                          leading: const Icon(
                            Icons.image,
                            color: Colors.black,
                          ),
                          title: const TextWidget(
                            text: "Upload image",
                            fontWeight: FontWeight.bold,
                          ),
                          onTap: () => viewModel.goToPastQuestionsUpload(),
                        ),
                        ListTile(
                          leading: const Icon(
                            CupertinoIcons.book,
                            color: Colors.black,
                          ),
                          title: const TextWidget(
                            text: "Upload Note",
                            fontWeight: FontWeight.bold,
                          ),
                          onTap: () => viewModel.goToUploadNotes(),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.question_mark,
                            color: Colors.black,
                          ),
                          title: const TextWidget(
                            text: "Past Questions",
                            fontWeight: FontWeight.bold,
                          ),
                          onTap: () => viewModel.goToPastQuestionsView(),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.table_chart,
                            color: Colors.black,
                          ),
                          title: const TextWidget(
                            text: "Time table",
                            fontWeight: FontWeight.bold,
                          ),
                          onTap: () => viewModel.goToTimeTable(),
                        ),
                        // ListTile(
                        //   leading: const Icon(
                        //     Icons.subject,
                        //     color: Colors.black,
                        //   ),
                        //   title: const TextWidget(
                        //     text: "Course Information",
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        //   onTap: () {},
                        // ),
                        ListTile(
                          leading: const Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                          title: const TextWidget(
                            text: "Executives",
                            fontWeight: FontWeight.bold,
                          ),
                          onTap: () => viewModel.goToExecutives(),
                        ),
                      ],
                    ),
                  ),
                  body: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('info_board')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator.adaptive();
                        }
                        List<InfoBox> notes = snapshot.data!.docs
                            .map((doc) {
                              Map<String, dynamic> data =
                                  doc.data() as Map<String, dynamic>;
                              return InfoBox(
                                  from: data["from"],
                                  to: data["to"],
                                  message: data["data"],
                                  time: data['time']);
                            })
                            .toList()
                            .reversed
                            .toList();
                        return CustomScrollView(
                          controller: viewModel.scrollController,
                          slivers: [
                            SliverAppBar(
                              pinned: true,
                              snap: false,
                              floating: false,
                              title: viewModel.showInfo
                                  ? TextWidget(
                                      text: "Info board",
                                      fontsize: 25.sp,
                                      // fontWeight: FontWeight.bold,
                                    )
                                  : null,
                              flexibleSpace: viewModel.showInfo
                                  ? null
                                  : FlexibleSpaceBar(
                                      title: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          TextWidget(
                                            text: "Good ",
                                            fontsize: 25.sp,
                                          ),
                                          TextWidget(
                                            text: viewModel.greeting!.message,
                                            fontsize: 25.sp,
                                            fontWeight: FontWeight.w500,
                                          )
                                        ],
                                      ),
                                    ),
                            ),
                            SliverList(
                                delegate: SliverChildListDelegate([
                              if (viewModel.carouselImages.isNotEmpty)
                                HomePictures(viewModel: viewModel),
                              Gap(75.h),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 15),
                                child: TextWidget(
                                  text: "Info board",
                                  fontsize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ...notes.map((e) => LInfoBox(
                                    from: e.from,
                                    to: e.to,
                                    data: e.message,
                                    time: e.time,
                                    showMenu: viewModel.isBoxTapped,
                                    expand: viewModel.isBoxTapped,
                                  )),
                            ]))
                          ],
                        );
                      })),
            )));
  }
}

class HomePictures extends StatelessWidget {
  HomeViewModel viewModel;
  HomePictures({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: viewModel.carouselImages
            .map(
              (item) => Container(
                margin: const EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    child: Image.network(item["downloadUrl"]!,
                        fit: BoxFit.cover, width: 1000.0)),
              ),
            )
            .toList(),
        options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 2.0,
          enlargeCenterPage: true,
        ));
  }
}
