import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lueesa_app/app/routing/screen_path.dart';
import 'package:lueesa_app/ui/style/app_colors.dart';
import 'package:lueesa_app/ui/utilities/l_text.dart';
import 'package:lueesa_app/ui/views/home/home_vm.dart';
import 'package:lueesa_app/ui/widgets/l_info_box.dart';
import 'package:stacked/stacked.dart';

import '../../style/app_assets.dart';
import '../../widgets/l_rich_text.dart';

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
        onViewModelReady: (viewModel) {
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
        },
        builder: ((context, viewModel, child) => Scaffold(
              key: scaffoldKey,
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
                    ListTile(
                      leading: const Icon(
                        Icons.subject,
                        color: Colors.black,
                      ),
                      title: const TextWidget(
                        text: "Course Information",
                        fontWeight: FontWeight.bold,
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      title: const TextWidget(
                        text: "Executives",
                        fontWeight: FontWeight.bold,
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              body: CustomScrollView(
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
                              crossAxisAlignment: CrossAxisAlignment.end,
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
                    CarouselSlider(
                        items: viewModel.carouselImages
                            .map(
                              (item) => Container(
                                margin: const EdgeInsets.all(5.0),
                                child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5.0)),
                                    child: Image.asset(item,
                                        fit: BoxFit.cover, width: 1000.0)),
                              ),
                            )
                            .toList(),
                        options: CarouselOptions(
                          autoPlay: true,
                          aspectRatio: 2.0,
                          enlargeCenterPage: true,
                        )),
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
                    LInfoBox(),
                    LInfoBox(),
                    LInfoBox(),
                    LInfoBox(),
                    LInfoBox(),
                    LInfoBox(),
                    LInfoBox(),
                    LInfoBox(),
                    LInfoBox(),
                    LInfoBox(),
                    LInfoBox(),
                    LInfoBox(),
                  ]))
                ],
              ),
            )));
  }
}
