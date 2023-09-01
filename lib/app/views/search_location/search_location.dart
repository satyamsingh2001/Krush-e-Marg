import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:krush_e_marg/app/colors/colors_const.dart';

import '../../auth/map_page.dart';

class SearchLocation extends StatefulWidget {
  const SearchLocation({super.key});

  @override
  State<SearchLocation> createState() => _SearchLocationState();
}

class _SearchLocationState extends State<SearchLocation> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: SizedBox(
                  width: size.width*0.95,
                  child: TextFormField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search for area, landmark',
                      prefixIcon: IconButton(
                          onPressed: () {
                            Get.to(const MapPage());
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 25,
                            color: Colors.black,
                          )),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.cancel,size: 30,
                            color: Color.fromRGBO(226, 62, 87, 1)),
                        onPressed: () => _searchController.clear(),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: AppColors.primary700,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: AppColors.primary700,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ListTile(
                title: const Text('Use Current Location'),
                subtitle: const Text('Kanwali Road, Shakti Enclave, Kaonli ....'),
                leading: const Icon(
                  Icons.location_searching_outlined,
                  color: AppColors.primary700,
                ),
                onTap: () {
                  Get.to(const MapPage());
                },
              ),
              const Divider(
                color: AppColors.neutralLight,
                height: 5,
              ),
              ListTile(
                title: const Text('Kanwali Road, Shakti Enclave, Kaonli, Dehradun,'),
                subtitle: const Text('Uttarakhand'),
                leading: const Icon(
                  Icons.location_on_rounded,
                  color: AppColors.primary700,
                ),
                onTap: () {
                  Get.to(const MapPage());
                },
              ),
              const Divider(
                color: AppColors.neutralLight,
                height: 5,
              ),
              ListTile(
                title:
                    const Text('Balliwala Chowk, Shakti Enclave, Kaonli, Dehradun,'),
                subtitle: const Text('Uttarakhand'),
                leading: const Icon(
                  Icons.location_on_rounded,
                  color: AppColors.primary700,
                ),
                onTap: () {
                  Get.to(const MapPage());
                },
              ),
              const Divider(
                color: AppColors.neutralLight,
                height: 5,
              ),
              ListTile(
                title: const Text('Friends Colony, Ram Vihar, Ballupur, Dehradun,'),
                subtitle: const Text('Uttarakhand'),
                leading: const Icon(
                  Icons.location_on_rounded,
                  color: AppColors.primary700,
                ),
                onTap: () {
                  Get.to(const MapPage());
                },
              ),
              const Divider(
                color: AppColors.neutralLight,
                height: 5,
              ),
              ListTile(
                title:
                    const Text('Uttarakhand Jal Nigam, E&M Division, Ballupur Road,'),
                subtitle:
                    const Text('Friends Colony, Ram Vihar, Ballupur, Dehradun,'),
                leading: const Icon(
                  Icons.location_on_rounded,
                  color: AppColors.primary700,
                ),
                onTap: () {
                  Get.to(const MapPage());
                },
              ),
              const Divider(
                color: AppColors.neutralLight,
                height: 5,
              ),
              ListTile(
                title:
                    const Text('Balliwala Chowk, Shakti Enclave, Kaonli, Dehradun,'),
                subtitle: const Text('Uttarakhand'),
                leading: const Icon(
                  Icons.location_on_rounded,
                  color: AppColors.primary700,
                ),
                onTap: () {
                  Get.to(const MapPage());
                },
              ),
              const Divider(
                color: AppColors.neutralLight,
                height: 5,
              ),
            ],
          );
        },
      ),
    );
  }
}
