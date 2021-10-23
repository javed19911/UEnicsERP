import '../models/CommodityResponse.dart';
import '../models/LotResponse.dart';
import '../models/default_response.dart';
import '../models/login_reponse.dart';

abstract class ApiHelper {
  Future<DefaultResponse> generateOTP(String phone_number);

  Future<LoginReponse> validateOTP(String phoneNumber, String OTP);

  Future<LoginReponse> validateUser(String email, String password);

  Future<LotResponse> getLots(String token, String email, Map filterOption);

  Future<CommodityResponse> getCommodityList(String token, String email);

  // Future<mCreateOrUpdateLot> addAndCreateLot(
  //     int lotId,
  //     int commodityId,
  //     int imageCount,
  //     bool isInternal,
  //     String token,
  //     String quantity,
  //     String price,
  //     String variety,
  //     String size);

  Future<DefaultResponse> uploadLotImage(
      String token,
      String email,
      String temp_id,
      String location_type_name,
      String job_process_name,
      int job_process_id,
      int product_id,
      String imagePath,
      String longitude,
      String latitude,
      bool is_ai_image);
}
