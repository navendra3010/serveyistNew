import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ExcelReaderPage extends StatefulWidget {
  const ExcelReaderPage({super.key});

  @override
  State<ExcelReaderPage> createState() => _ExcelReaderPageState();
}

class _ExcelReaderPageState extends State<ExcelReaderPage> {
  List<List<String>> _excelData = [];

  Future<void> _pickAndReadExcelFile() async {
    try {
      // Open file picker
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions:  ['xlsx', 'xls'],
      );

      if (result != null) {
        File file = File(result.files.single.path!);

        // Read the Excel file
        var bytes = file.readAsBytesSync();
        var excel = Excel.decodeBytes(bytes);

        List<List<String>> data = [];

        // Iterate over the rows and columns in the first sheet
        for (var table in excel.tables.keys) {
          for (var row in excel.tables[table]!.rows) {
            // Filter out null cells and convert them to strings
            List<String> filteredRow = row
                .where((cell) => cell != null) // Skip null cells
                .map((cell) => cell!.value.toString()) // Convert non-null cells to strings
                .toList();

            if (filteredRow.isNotEmpty) {
              data.add(filteredRow); // Add non-empty rows
            }
          }
          break; // Read only the first sheet
        }

        setState(() {
          _excelData = data;
        });
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error reading file: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Excel File Reader'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _pickAndReadExcelFile,
            child: const Text('Choose Excel File'),
          ),
          Expanded(
            child: _excelData.isEmpty
                ? const Center(child: Text('No data loaded'))
                : ListView.builder(
                    itemCount: _excelData.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_excelData[index].join(' | ')),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}