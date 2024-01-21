import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.help),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.helpWelcome,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)!.helpIntroduction,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              _buildSection(
                context,
                AppLocalizations.of(context)!.helpGettingStarted,
                [
                  AppLocalizations.of(context)!.helpGettingStartedDetailsA,
                  AppLocalizations.of(context)!.helpGettingStartedDetailsB,
                  AppLocalizations.of(context)!.helpGettingStartedDetailsC,
                ],
              ),
              SizedBox(height: 20),
              _buildSection(
                context,
                AppLocalizations.of(context)!.helpReadingModbusRegisters,
                [
                  AppLocalizations.of(context)!.helpReadingModbusRegistersDetailsA,
                  AppLocalizations.of(context)!.helpReadingModbusRegistersDetailsB,
                  AppLocalizations.of(context)!.helpReadingModbusRegistersDetailsC,
                ],
              ),
              SizedBox(height: 20),
              _buildSection(
                context,
                AppLocalizations.of(context)!.helpRegisterDetailsAndCharts,
                [
                  AppLocalizations.of(context)!.helpRegisterDetailsAndChartsDetailsA,
                  AppLocalizations.of(context)!.helpRegisterDetailsAndChartsDetailsB,
                ],
              ),
              SizedBox(height: 20),
              _buildSection(
                context,
                AppLocalizations.of(context)!.helpPasswordAndAccountOperations,
                [
                  AppLocalizations.of(context)!.helpPasswordAndAccountOperationsDetailsA,
                ],
              ),
              SizedBox(height: 20),
              _buildSection(
                context,
                AppLocalizations.of(context)!.helpTroubleshooting,
                [
                  AppLocalizations.of(context)!.helpTroubleshootingDetailsA,
                  AppLocalizations.of(context)!.helpTroubleshootingDetailsB,
                  AppLocalizations.of(context)!.helpTroubleshootingDetailsC,
                ],
              ),
              SizedBox(height: 20),
              _buildSection(
                context,
                AppLocalizations.of(context)!.helpFrequentlyAskedQuestions,
                [
                  AppLocalizations.of(context)!.helpFAQDetailsA,
                  AppLocalizations.of(context)!.helpFAQDetailsB,
                ],
              ),
              SizedBox(height: 20),
              _buildSection(
                context,
                AppLocalizations.of(context)!.helpContactInformation,
                [
                  AppLocalizations.of(context)!.helpContactInformationDetails,
                  AppLocalizations.of(context)!.helpContactInformationEmail,
                  AppLocalizations.of(context)!.helpContactInformationPhone,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<String> details) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        for (String detail in details)
          Text(
            '   $detail',
            style: TextStyle(fontSize: 16),
          ),
      ],
    );
  }
}
