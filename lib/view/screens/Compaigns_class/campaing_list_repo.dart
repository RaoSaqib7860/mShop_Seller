import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../api_repo/api_utils.dart';
import '../../../model/Compaigns/compaign_model.dart';
import '../../../model/all_ware_house/all_ware_house_model.dart';
import '../../../view_model/campaigns_blocs/campaigns_bloc.dart';
import '../../../view_model/campaigns_blocs/campaigns_states.dart';


class getCompaingsPagination{
  MyCompaignsBloc myCompaignsBloc = MyCompaignsBloc(MyCompaignsInitialState());

  var refreshController = RefreshController(initialRefresh: false);
  int? page = 1 ;
  int? count = 6  ;
  Future<CompaignModel> getCampaingList() async {
    page= page! + 1;
    CompaignModel res = await DataProvider()
        .get_compaign_function(page: page,count: count);

    return res;
  }
}