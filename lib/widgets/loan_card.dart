import 'package:flutter/material.dart';
import 'package:materials_loan_lab/models/loan_model.dart';
import 'package:materials_loan_lab/viewmodels/loan_history_viewmodel.dart';

typedef FormatLoadDate = String Function(DateTime date);

class LoanCard extends StatelessWidget {
  final Loan loan;

  final LoanHistoryViewModel viewModel;
  final FormatLoadDate formatLoadDate;

  const LoanCard(
      {super.key,
      required this.loan,
      required this.viewModel,
      required this.formatLoadDate});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.15,
          color: viewModel.getStatusColor(loan.status),
          child: Center(
            child: Text(
              formatLoadDate(loan.loanDate),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Estado: ${loan.status}'),
                Text('Cantidad Prestada: ${loan.quantityLoaned}'),
                Text('Cantidad Devuelta: ${loan.quantityDelivered}'),
                Text(
                    'Fecha de Vencimiento: ${loan.dueDate.toLocal().toString().split(' ')[0]}'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
