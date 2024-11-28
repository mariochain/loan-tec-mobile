import 'package:flutter/material.dart';
import '../models/loan_model.dart';

class LoanDetailView extends StatelessWidget {
  final Loan loan;

  const LoanDetailView({super.key, required this.loan});

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

    return '$day-$month-$year';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle Préstamo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Información General del Préstamo
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Estado: ${loan.status}'),
                  Text('Cantidad Prestada: ${loan.quantityLoaned}'),
                  Text('Cantidad Regresada: ${loan.quantityDelivered}'),
                  Text('Fecha Solicitada: ${formatLoanDate(loan.loanDate)}'),
                  Text('Fecha Vencimiento: ${formatLoanDate(loan.dueDate)}'),
                  Text(
                      'Fecha Entregada: ${loan.quantityDelivered > 0 ? formatLoanDate(DateTime.now()) : 'N/A'}'),
                  Text(
                      'Motivo Cancelación: ${loan.status == 'Cancelado' ? 'Motivo de cancelación aquí' : 'N/A'}'),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Tabla de Materiales
            Expanded(
              child: SingleChildScrollView(
                child: Table(
                  border: TableBorder.all(color: Colors.black),
                  columnWidths: const {
                    0: FlexColumnWidth(3),
                    1: FlexColumnWidth(1),
                    2: FlexColumnWidth(1),
                  },
                  children: [
                    // Encabezados de la tabla con fondo azul marino y texto blanco
                    TableRow(
                      children: [
                        Container(
                          color: Colors.blue.shade900,
                          padding: const EdgeInsets.all(8.0),
                          child: const Text(
                            'Material',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          color: Colors.blue.shade900,
                          padding: const EdgeInsets.all(8.0),
                          child: const Text(
                            'Ctd',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          color: Colors.blue.shade900,
                          padding: const EdgeInsets.all(8.0),
                          child: const Text(
                            'Ent.',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    // Filas de materiales
                    ...List.generate(loan.materials.length, (index) {
                      final material = loan.materials[index];
                      return TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              material.name,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${material.quantity}',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              material.delivered
                                  ? Icons.check_circle
                                  : Icons.cancel,
                              color: material.delivered
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
