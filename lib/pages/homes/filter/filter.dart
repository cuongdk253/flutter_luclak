import 'dart:convert';

import 'package:appchat/components/format_number.dart';
import 'package:appchat/components/text.dart';
import 'package:appchat/pages/homes/match/match.dart';
import 'package:appchat/services/constant.dart';
import 'package:appchat/services/others/local_storage.dart';
import 'package:appchat/services/themes/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'filter_language.dart';

class FilterController extends GetxController {
  final MatchesController _matchesController = Get.find();

  RxDouble minAge = 0.0.obs;
  RxDouble maxAge = 100.0.obs;

  final double maxPubget = 10000.0;
  final double itemValuePubget = 100.0;
  RxDouble pubgetStart = 0.0.obs;
  RxDouble pubgetEnd = 10000.0.obs;

  FixedExtentScrollController? pubgetStartController;
  FixedExtentScrollController? pubgetEndController;

  RxBool checkToggle = false.obs;

  RxBool checkMan = false.obs;
  RxBool checkWoman = false.obs;
  RxBool checkOther = false.obs;

  RxString languageSort = 'select_language'.tr.obs;

  List listLanguage = [];
  List listLanguageShow = [];
  List listLanguageCode = [];

  RxBool filterChange = false.obs;

  @override
  void onReady() async {
    super.onReady();

    await loadFilter();

    loadPhoneCode();
  }

  loadFilter() {
    checkMan.value =
        _matchesController.matchFilter['genders'].contains(Gender.male);
    checkWoman.value =
        _matchesController.matchFilter['genders'].contains(Gender.female);
    checkOther.value =
        _matchesController.matchFilter['genders'].contains(Gender.nonbinary);
    changeToggle();

    minAge.value = _matchesController.matchFilter['age']['from'];
    maxAge.value = _matchesController.matchFilter['age']['to'];

    pubgetStart.value = _matchesController.matchFilter['pubget']['from'];
    pubgetEnd.value = _matchesController.matchFilter['pubget']['to'];

    listLanguageCode = _matchesController.matchFilter['languages'];
  }

  loadPhoneCode() async {
    String _phoneCode =
        await rootBundle.loadString('assets/jsons/phone_code.json');

    if (_phoneCode.isNotEmpty) {
      listLanguageShow = listLanguage = jsonDecode(_phoneCode);

      String _language = '';

      for (int i = 0; i < listLanguageShow.length; i++) {
        if (listLanguageCode.contains(listLanguageShow[i]['country_code'])) {
          listLanguageShow[i]['checked'] = true;
          listLanguage[i]['checked'] = true;
          _language = _language + listLanguage[i]['name'] + ', ';
        }
      }
      if (_language != '') {
        languageSort.value = _language;
      }
    }
  }

  onClickBack() {
    Get.back();
  }

  onFilterViewLocation() {
    // Get.to(() => FilterDetailView());
  }

  onFilterViewLanguage() {
    Get.bottomSheet(
      FilterLanguageView(),
      isScrollControlled: true,
    );
  }

  onChangeToggle() {
    filterChange.value = true;

    checkToggle.value = !checkToggle.value;
    if (checkToggle.value) {
      checkMan.value = true;
      checkWoman.value = true;
      checkOther.value = true;
    } else {
      checkMan.value = false;
      checkWoman.value = false;
      checkOther.value = false;
    }
  }

  onCheckMan() {
    filterChange.value = true;

    checkMan.value = !checkMan.value;

    changeToggle();
  }

  onCheckWoman() {
    filterChange.value = true;

    checkWoman.value = !checkWoman.value;

    changeToggle();
  }

  changeToggle() {
    if (checkMan.value &&
        checkWoman.value &&
        checkOther.value &&
        !checkToggle.value) {
      checkToggle.value = true;
    } else {
      checkToggle.value = false;
    }
  }

  onCheckNonbinary() {
    filterChange.value = true;

    checkOther.value = !checkOther.value;

    changeToggle();
  }

  onAgeChange(RangeValues value) {
    filterChange.value = true;

    minAge.value = value.start;
    maxAge.value = value.end;
  }

  onPubgetChange(RangeValues value) {
    filterChange.value = true;

    pubgetStart.value = value.start;
    pubgetEnd.value = value.end;
  }

  onClickPubget() async {
    pubgetStartController = FixedExtentScrollController(
        initialItem: pubgetStart.value != 0
            ? (pubgetStart.value / itemValuePubget).round()
            : 0);
    pubgetEndController = FixedExtentScrollController(
        initialItem: pubgetEnd.value != 0
            ? (pubgetEnd.value / itemValuePubget).round()
            : 0);

    await Get.bottomSheet(
      SizedBox(
        height: 250,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  height: 52,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom:
                          BorderSide(width: 1, color: AppTheme.colorDisable),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      SizedBox(
                        width: Get.width,
                        child: TextCustom(
                          'your_pubget'.tr,
                          style: AppTheme.textStyle16.medium().textDark(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: InkWell(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            child: TextCustom(
                              'done'.tr,
                              style: AppTheme.textStyle16.medium().secondary(),
                            ),
                          ),
                          onTap: () => Get.back(),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            const SizedBox(height: 4),
                            TextCustom(
                              'min_pubget'.tr,
                              style: AppTheme.textStyle.textDark(),
                            ),
                            Expanded(
                              child: CupertinoPicker(
                                itemExtent: 36,
                                scrollController: pubgetStartController,
                                onSelectedItemChanged: (int index) {
                                  pubgetStart.value = index * itemValuePubget;
                                  if (pubgetEnd.value <= pubgetStart.value) {
                                    pubgetEndController!.animateToItem(
                                      index + 1,
                                      duration:
                                          const Duration(milliseconds: 100),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                                },
                                children: List.generate(
                                  (maxPubget / itemValuePubget).round(),
                                  (int index) => Center(
                                    child: TextCustom(
                                      formatNumberString(
                                          index * itemValuePubget),
                                      style: AppTheme.textStyle16.textDark(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            const SizedBox(height: 4),
                            TextCustom(
                              'max_pubget'.tr,
                              style: AppTheme.textStyle.textDark(),
                            ),
                            Expanded(
                              child: CupertinoPicker(
                                itemExtent: 36,
                                scrollController: pubgetEndController,
                                onSelectedItemChanged: (int index) {
                                  pubgetEnd.value = index * itemValuePubget;
                                  if (pubgetEnd.value <= pubgetStart.value) {
                                    pubgetEndController!.animateToItem(
                                      index + 1,
                                      duration:
                                          const Duration(milliseconds: 100),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                                },
                                children: List.generate(
                                  (maxPubget / itemValuePubget).round(),
                                  (int index) => Center(
                                    child: TextCustom(
                                      formatNumberString(
                                          index * itemValuePubget),
                                      style: AppTheme.textStyle16.textDark(),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onLanguageChange(String value) {
    filterChange.value = true;

    listLanguageShow = listLanguage
        .where((e) => e['name'].toLowerCase().contains(value.toLowerCase()))
        .toList();

    update();
  }

  onClickLanguageItem(int index) {
    filterChange.value = true;

    if (listLanguageShow[index]['checked'] == true) {
      listLanguageShow[index]['checked'] = false;
    } else {
      listLanguageShow[index]['checked'] = true;
    }

    update();

    var _item = listLanguage.firstWhereOrNull((e) =>
        listLanguageShow[index]['country_code'] == e['country_code'] &&
        listLanguageShow[index]['checked'] == true);
    if (_item != null) {
      _item['checked'] = true;
    }
  }

  onClickDoneFilterLanguage() {
    Get.back();

    String _language = '';
    listLanguageCode = [];

    for (var i in listLanguage) {
      if (i['checked'] == true) {
        _language = _language + i['name'] + ', ';
        listLanguageCode.add(i['country_code']);
      }
    }
    if (_language != '') {
      languageSort.value = _language;
    } else {
      languageSort.value = 'select_language'.tr;
    }
  }

  onClickApplyFilter() {
    Get.back();

    List _listGender = [];
    if (checkMan.value) {
      _listGender.add(Gender.male);
    }
    if (checkWoman.value) {
      _listGender.add(Gender.female);
    }
    if (checkOther.value) {
      _listGender.add(Gender.nonbinary);
    }

    Map _filter = {
      "genders": _listGender,
      "age": {
        "from": minAge.value,
        "to": maxAge.value,
      },
      "pubget": {
        "from": pubgetStart.value,
        "to": pubgetEnd.value,
      },
      "languages": listLanguageCode
    };

    SPreferentModule().setItem(StorageKey.matchFilter, _filter);

    _matchesController.page = 0;
    _matchesController.hasMore = true;
    _matchesController.matchFilter = _filter;

    _matchesController.onFindMatch();
  }
}
