import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ip_lookup_check/features/check_ip/bloc/checkip_bloc.dart';

class CheckIpScreen extends StatefulWidget {
  const CheckIpScreen({super.key});

  @override
  State<CheckIpScreen> createState() => _CheckIpScreenState();
}

class _CheckIpScreenState extends State<CheckIpScreen> {
  final TextEditingController ipCOntroller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    ipCOntroller.dispose();
    super.dispose();
  }

  bool isValidIp(String value) {
    const pattern =
        r'^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$';
    return RegExp(pattern).hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          "Ip Lookup Check",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<CheckipBloc, CheckipState>(
          builder: (context, state) {
            return Form(
              key: formKey,
              child: ListView(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: ipCOntroller,
                          decoration: InputDecoration(
                            hintText: "Enter Your Ip",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Ip field Cannot be empty";
                            }
                            if (!isValidIp(value)) {
                              return "Please Enter a valid ip";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<CheckipBloc>(
                              context,
                            ).add(FetchIpLookupEvent(ipCOntroller.text.trim()));
                          }
                        },
                        child: Text("Search"),
                      ),
                    ],
                  ),
                  if (state is CheckipLoading)
                    Center(child: CircularProgressIndicator()),
                  if (state is CheckipError)
                    Center(
                      child: Text(
                        state.message,
                        style: TextStyle(color: Colors.red, fontSize: 24),
                      ),
                    ),

                  if (state is CheckipLoaded) ...[
                    SizedBox(height: 16),
                    Text("Hostname: ${state.responseData.hostname ?? "N/A"}"),
                    Text("Domain: ${state.responseData.domain ?? "N/A"}"),
                    Text(
                      "ASN_Number: ${state.responseData.asnNumber ?? "N/A"}",
                    ),
                    Text("Country: ${state.responseData.country ?? "N/A"}"),
                    Text(
                      "Country_Code: ${state.responseData.countryCode ?? "N/A"}",
                    ),
                    Text("Region: ${state.responseData.region ?? "N/A"}"),
                    Text("Zip_Code: ${state.responseData.zipCode ?? "N/A"}"),
                    Text("City: ${state.responseData.city ?? "N/A"}"),
                    Text(
                      "State_Code: ${state.responseData.stateCode ?? "N/A"}",
                    ),
                    Text("Longitude: ${state.responseData.longitude ?? "N/A"}"),
                    Text("Latitude: ${state.responseData.latitude ?? "N/A"}"),
                    Text("ISP_ASN: ${state.responseData.ispAsn ?? "N/A"}"),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
