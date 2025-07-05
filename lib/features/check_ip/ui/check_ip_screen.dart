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
        r'^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}'
        r'(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$';
    return RegExp(pattern).hasMatch(value);
  }

  Widget _buildDetailRow(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String? value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Theme.of(context).primaryColor),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value ?? "N/A",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
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
                          decoration: const InputDecoration(
                            hintText: "Enter Your Ip",
                            border: OutlineInputBorder(),
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
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<CheckipBloc>(
                              context,
                            ).add(FetchIpLookupEvent(ipCOntroller.text.trim()));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text("Search"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (state is CheckipLoading)
                    const Center(child: CircularProgressIndicator()),
                  if (state is CheckipError)
                    Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red, fontSize: 24),
                      ),
                    ),
                  if (state is CheckipLoaded) ...[
                    const SizedBox(height: 24),
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDetailRow(
                              context,
                              icon: Icons.public,
                              title: "Hostname",
                              value: state.responseData.hostname,
                            ),
                            _buildDetailRow(
                              context,
                              icon: Icons.domain,
                              title: "Domain",
                              value: state.responseData.domain,
                            ),
                            _buildDetailRow(
                              context,
                              icon: Icons.confirmation_number,
                              title: "ASN Number",
                              value: state.responseData.asnNumber,
                            ),
                            _buildDetailRow(
                              context,
                              icon: Icons.flag,
                              title: "Country",
                              value: state.responseData.country,
                            ),
                            _buildDetailRow(
                              context,
                              icon: Icons.code,
                              title: "Country Code",
                              value: state.responseData.countryCode,
                            ),
                            _buildDetailRow(
                              context,
                              icon: Icons.map,
                              title: "Region",
                              value: state.responseData.region,
                            ),
                            _buildDetailRow(
                              context,
                              icon: Icons.local_post_office,
                              title: "Zip Code",
                              value: state.responseData.zipCode,
                            ),
                            _buildDetailRow(
                              context,
                              icon: Icons.location_city,
                              title: "City",
                              value: state.responseData.city,
                            ),
                            _buildDetailRow(
                              context,
                              icon: Icons.code_off,
                              title: "State Code",
                              value: state.responseData.stateCode,
                            ),
                            _buildDetailRow(
                              context,
                              icon: Icons.receipt_long,
                              title: "Longitude",
                              value: state.responseData.longitude.toString(),
                            ),
                            _buildDetailRow(
                              context,
                              icon: Icons.receipt_long,
                              title: "Latitude",
                              value: state.responseData.latitude.toString(),
                            ),
                            _buildDetailRow(
                              context,
                              icon: Icons.settings_input_antenna,
                              title: "ISP ASN",
                              value: state.responseData.ispAsn.toString(),
                            ),
                          ],
                        ),
                      ),
                    ),
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
