import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wateen_energy/models/alarm.dart';
import 'package:wateen_energy/widgets/input_form_field.dart';
import 'package:wateen_energy/widgets/item_sites.dart';
import '../models/sites.dart';
import '../services/network_api.dart';
import '../services/service_url.dart';
import '../utils/AppScale.dart';
import '../utils/colour.dart';
import '../utils/site_list_cn.dart';
import '../utils/strings.dart';
import '../utils/user_table.dart';
import '../utils/utility.dart';
import '../widgets/base_app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/main_drawer.dart';
import '../widgets/search_form_field.dart';

class ReportingScreen extends StatefulWidget {
  static const routeName = '/reporting';
  static bool isChecked = false;

  @override
  State<ReportingScreen> createState() => _ReportingScreenState();
}

class _ReportingScreenState extends State<ReportingScreen> {
  final box = GetStorage();
  Future<Map<String, dynamic>>? futureSites;

  @override
  void initState() {
    super.initState();
  //  getSites();
  }



  String searchResult = "";
  void onSearch(String? result) {
    print("result " + result!);
    setState(() {
      searchResult =result;

      sites.removeWhere(
          (e) => !(e.name.toLowerCase().contains(result.toLowerCase())));
      //  Provider.of<SiteListCN>(context, listen: false).updateData(sites);

      context.read<SiteListCN>().clear();
      context.read<SiteListCN>().updateData(sites);

    });
  }

  @override
  Widget build(BuildContext context) {
    AppScale _scale = AppScale(context);
    bool isChecked = false;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        bottomNavigationBar: BottomNavBar(),
        appBar: BaseAppBar(AppBar(), Strings.sitesTitle),
        drawer: MainDrawer(),
        body: SingleChildScrollView(
          child: Container(
            color: AppColors.greyBg,
            // height:  MediaQuery.of(context).size.height,
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
            alignment: Alignment.topLeft,
            child: Column(
              //mainAxisSize: MainAxisSize.max,
              children: [

              ],
            ),
          ),
        ));
  }

  List<Site> sites = [];

  Widget getSitesList(AsyncSnapshot snapshot) {
    sites = formSitesList(snapshot.data);

    return searchResult.isEmpty ? getSiteData(sites) : getSearchData();

  }

  Widget getSiteData(List<Site> sites)
  {
      return Container(
        padding: EdgeInsets.only(bottom: 6.h),
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: sites.length,
          itemBuilder: (context, index) {
            return SiteItem(sites![index]);
          },
        ),
      );

  }

  Widget getSearchData()
  {
    return Consumer<SiteListCN>(builder: (context, siteList, child) {
      return Container(
        padding: EdgeInsets.only(bottom: 6.h),
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: siteList.data.length,
          itemBuilder: (context, index) {
            return SiteItem(siteList.data![index]);
          },
        ),
      );
    });
  }

  List<Site> formSitesList(Map<String, dynamic> data) {
    List<Site> sitesData = [];

    if (data.entries.isNotEmpty) {
      List sites = data['sites'];
      for (int i = 0; i < sites.length; i++) {
        List data = sites[i];
        Site site = Site(data[0], data[5], data[3], data[2], data[4]);
        sitesData.add(site);
      }
    }

    //  data.forEach((k, v) => print('${k}: ${v}'));
    return sitesData;
  }

  void getSites() async {
    GetStorage box = GetStorage();

    Map<String, String> headers = {
      //   'Authorization': "Bearer " + box.read("token"),
    };

    Map<String, String> params = {
      UserTableKeys.epcName: "EFC",
    };

    try {
      futureSites =
          NetworkAPI().httpGetGraphData(ServiceUrl.getSitesUrl, null, params);
    } catch (e) {
      Utility.showSubmitAlert(context, Strings.noRecordTxt, "", null);
    }
  }
}
