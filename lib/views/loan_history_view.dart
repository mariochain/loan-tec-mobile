import 'package:flutter/material.dart';
import 'package:materials_loan_lab/widgets/loan_card.dart';
import 'package:provider/provider.dart';
import '../viewmodels/loan_history_viewmodel.dart';
import 'loan_detail_view.dart';
import '../app_scaffold.dart';

class LoanHistoryView extends StatelessWidget {
  const LoanHistoryView({super.key});

  String formatLoanDate(DateTime date) {
    const monthNames = {
      '01': 'Ene',
      '02': 'Feb',
      '03': 'Mar',
      '04': 'Abr',
      '05': 'May',
      '06': 'Jun',
      '07': 'Jul',
      '08': 'Ago',
      '09': 'Sep',
      '10': 'Oct',
      '11': 'Nov',
      '12': 'Dic'
    };

    final dateParts = date.toLocal().toString().split(' ')[0].split('-');
    final year = dateParts[0];
    final month = monthNames[dateParts[1]] ?? '';
    final day = dateParts[2];

    return '$day\n$month\n$year';
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Historial de Préstamos',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<LoanHistoryViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (viewModel.loanHistory.isEmpty) {
              return const Center(child: Text('No hay historial de préstamos'));
            }

            return ListView.builder(
              itemCount: viewModel.loanHistory.length,
              itemBuilder: (context, index) {
                final loan = viewModel.loanHistory[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoanDetailView(loan: loan),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: IntrinsicHeight(
                        child: LoanCard(
                            loan: loan,
                            viewModel: viewModel,
                            formatLoadDate: formatLoanDate)),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
