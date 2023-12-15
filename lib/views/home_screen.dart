import 'package:flutter/material.dart';
import 'package:participant/utils/constants.dart';
import 'package:participant/view_models/home_screen_view_model.dart';
import 'package:participant/widgets/search_bar_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final viewModel = HomeScreenViewModel();

  @override
  void initState() {
    viewModel.fetchParticipants();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange) {
      viewModel.loadMoreData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        body: SingleChildScrollView(
          controller: _scrollController,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 30.0,
                    ),
                    child: Text(
                      'Home',
                      style: headerTextStyle,
                    ),
                  ),
                  // space12,
                  Consumer<HomeScreenViewModel>(
                    builder: (context, vm, _) {
                      return Column(
                        children: [
                          SearchBarWidget(
                            onTextChanged: (query)async {                                                            
                              await vm.setSearchQuery(query);                              
                            },
                            onClear: () {                              
                              vm.setSearchQuery('');                           
                            },
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: vm.participantData.length,
                            itemBuilder: (context, index) {
                              final data = vm.participantData[index];
                              return vm.participantData.isNotEmpty
                                  ? ExpansionTile(
                                      title: Text('#${data!.participantId}'),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('${data.firstName} ${data.lastName}'),
                                          Text('State: ${data.state}'),
                                        ],
                                      ),
                                      children: <Widget>[
                                        ListTile(
                                          title: const Text('Additional Data'),
                                          titleTextStyle: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Address: ${data.address}'),
                                              Text('State: ${data.state}'),
                                              Text('Zip: ${data.zip}'),
                                              Text('Email: ${data.email}'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  : Center(
                                      child: Text(
                                        'No images to show ${viewModel.errorMessage}',
                                      ),
                                    );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  if (viewModel.isLoading)
                    const Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
