import 'package:flutter/material.dart';

abstract class Language {
  static Language of(BuildContext context) {
    return Localizations.of(context, Language);
  }

  String get selectedLanguage;

  String get userLabel;

  String get passwordLabel;

  String get loginLabel;

  String get logOutLabel;

  String get requiredWarningText;

  String get selectedLanguageCode;

  String get requestCameraPermissionTile;

  String get requestCameraPermissionDescription;

  String get requestLocationPermissionTile;

  String get requestLocationPermissionDescription;

  String get labelCreateNewLot;

  String get labelReferAndEarn;

  String get labelSelectItems;

  String get labelClaimOffer;

  String get labelYouHaveNotCreateAnyLotsToday;

  String get labelWatchHowToUseTheApp;

  String get labelContactUsOnWhatsapp;

  String get labelItem;

  String get labelLanguagePreference;

  String get labelSave;

  String get labelRetake;

  String get labelAddAnotherPhotos;

  String get labelCreateLot;

  String get labelContactToBuy;

  String get labelEditLotDetails;

  String get labelMarkAsSold;

  String get labelQualityReport;

  String get labelMarkAsIncorrect;

  String get labelPercentage;

  String get labelPhotos;

  String get labelReportUrl;

  String get labelSendViaWhatsApp;

  String get labelLots;

  String get labelMy;

  String get labelBuy;

  String get labelNotify;

  String get labelToday;

  String get labelDate;

  String get labelNotifyBuyers;

  String get addToContact;

  String get addSelected;

  String get buyThisLot;

  String get displayText;

  String get enterDetails;

  String get quantity;

  String get price;

  String get variety;

  String get size;

  String get required;

  String get addAndCreateLot;

  String get updateLot;

  String get addBuyers;

  String get searchContacts;

  String get addContactsHereToUpdateThemViaSms;

  String get theseContactsWillReceiveSmsWhenEverYouCreateYourLots;

  String get removeBuyerContact;

  String get descriptionRemoveBuyerContacts;

  String get cancel;

  String get remove;

  String get areYouSureYouHaveSoldLot;

  String get soldLotDescription;

  String get markAsSold;

  String get editLot;

  String get areYouSureQualityReportIsIncorrect;

  String get qualityReportIsIncorrectDescription;

  String get lotDetails;

  String get saveDetails;

  String get sold;

  String get lot;

  String get referDescription;

  String get shareWithContacts;

  String get collect;

  String get order;

  String get placeYourRequirement;

  String get deliveryLocation;

  String get provideUPIId;

  String get yourUPId;

  String get UPIId;

  String get verifyUPIId;

  String get confirmUPIId;

  String get enterAgain;

  String get provideDetails;

  String get enterFirstName;

  String get enterLastName;

  String get emailAddress;

  String get contactNumber;

  String get collectWithin24hrs;

  String get amountPayable;

  String get verified;

  String get discoverNewLots;

  String get todayLots;

  String get yesterdayLots;

  String get mySellerLots;

  String get availableForPurchase;

  String get wholeSale;

  String get rate;

  String get quality;

  String get labelContinue;

  String get views;

  String get generatingQualityReport;

  String get sellerName;

  String get sellerContact;

  String get firstName;

  String get lastName;

  String get loadingFeed;

  String get lotNotAvailable;

  String get pleaseEnterFirstName;

  String get pleaseEnterLastName;

  String get type;

  String get pleaseEnterSellerName;

  String get pleaseEnterSellerContact;

  String get pleaseEnterLotQuantity;

  String get pleaseEnterLotPrice;

  String get uploading;

  String get processing;

  String get update;

  String get fetchingLocation;

  String get noImageAdded;

  String get updateAvailableOnPlayStore;

  String get updateAvailableOnAppStore;

  String get pleaseUpdateYourAppForTheLatestFeatures;

  String get markIncorrect;

  String get labelPhoto;

  String quantityShouldBeLessThen(String quantity);

  String quantityShouldBeGraterThen(String minQuantity);

  String get pramanTermsAndCondition;

  String get termsConditionDescription;

  String get acceptTermsAndCondition;

  String get ok;

  String get pleaseAcceptTermsAndConditionToContinue;

  String get shareUpdateLotDetailsWithYourContacts;

  String get skip;

  String get pleaseAddPhotoToContinue;

  String get badPhoto;

  String get appOutDated;

  String get unableToPerformRequest;

  String get checkYourInternetConnection;

  String get invalidPhoneNumber;

  String get invalidOTP;

  String get pleaseEnterPrice;

  String priceShouldLessThan(String price);

  String priceShouldBeGraterThen(String price);

  String get pleaseEnterQuantity;

  String get pleaseEnterDeliveryAddress;

  String minimumQuantityIs(String commodity, String minQuantity);

  String get requestContactsPermissionTile;

  String get requestContactsPermissionDescription;

  ///auction
  String get loggedInAs;
  String get dashboard;
  String get auctionHistory;
  String get noAuctionsHaveBeenScheduled;
  String get registeredAuctions;
  String get startBid;
  String get photos;
  String get viewPhoto;
  String get youAreTheHighestBidder;
  String get bidHigherToWinThisLot;
  String get highestBid;
  String get youHaveNotRegisteredForThisAuction;
  String get noAuctionAvailable;
  String get auctioneer;
  String get pleaseBidHigherToWinThisLot;
  String get yourBid;
  String get registeredForAuction;
  String get registerForAuction;
  String get placeBid;
  String get or;
  String get bid;
  String get cancelRegistration;
  String get toHighestBid;
  String get auctionStartIn;
  String get auctions;
  String get auction;
  String get auctionsStartIn;
  String get actualPaymentValueWillBe;
  String get platformCharges;
  String get totalValue;
  String get whileYourAuctionHistoryIsBeingFetched;
  String get noAuctionHistoryAvailable;
  String get pleaseWait;
  String get whileAuctionsIsBeingFetched;
  String valueCanNotBeEmpty({required String text});
  String shouldGreaterThenValue({required String text, required String value});
  String shouldLessThenValue({required String text, required String value});
}
