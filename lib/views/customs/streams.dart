import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:secondapp/constants/constants.dart';
import 'package:secondapp/views/customs/custombutton.dart';
import 'package:secondapp/views/customs/customtext.dart';
import 'package:secondapp/views/customs/customtextfield.dart';
import 'package:secondapp/services/api.dart'; // Import your ApiService
import 'package:secondapp/models/streammodel.dart'; // Import your StreamModel
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Streams extends StatefulWidget {
  const Streams({Key? key}) : super(key: key);

  @override
  State<Streams> createState() => _StreamsState();
}

class _StreamsState extends State<Streams> {
  final ApiService _apiService = ApiService(); // Initialize your ApiService
  TextEditingController searchController = TextEditingController();
  List<StreamModel> _streams = [];
  List<StreamModel> _filteredStreams = [];

  @override
  void initState() {
    super.initState();
    _fetchStreams();
    searchController.addListener(_filterStreams);
  }

  @override
  void dispose() {
    searchController.removeListener(_filterStreams);
    searchController.dispose();
    super.dispose();
  }

  void _fetchStreams() async {
    try {
      List<StreamModel> streams = await _apiService.fetchStreams();
      setState(() {
        _streams = streams;
        _filteredStreams = streams;
      });
    } catch (e) {
      print('Error fetching streams: $e');
    }
  }

  void _filterStreams() {
    String searchQuery = searchController.text.toLowerCase();
    setState(() {
      _filteredStreams = _streams.where((stream) {
        return stream.stream.toLowerCase().contains(searchQuery);
      }).toList();
    });
  }

  Future<void> _generatePdf(List<StreamModel> streams) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Table.fromTextArray(
            headers: ['Stream'],
            data: streams.map((stream) {
              return [stream.stream];
            }).toList(),
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
      name: 'streams_list.pdf',
    );
  }

  @override
  Widget build(BuildContext context) {
    var currentwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundcolor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 20),
                    IconButton(
                      icon: const Icon(Icons.print_outlined),
                      onPressed: () async {
                        try {
                          await _generatePdf(_filteredStreams);
                        } catch (e) {
                          print('Error generating PDF: $e');
                        }
                      },
                    ),
                    const CustomText(
                      text: "Export",
                      textcolor: primarycolor,
                    ),
                  ],
                ),
                AppButton(
                  label: "Add New",
                  color: primarycolor,
                  size: 120,
                  //onPressed: _showAddStreamDialog,
                )
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                height: 38,
                child: CustomTextField(
                  controller: searchController,
                  hint: "Search streams",
                  prefixicon: const Icon(Icons.search),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  child: StreamsDataTable(
                    streams: _filteredStreams,
                    onView: (stream) {
                      // Implement view action
                    },
                    onEdit: (stream) {
                      // Implement edit action
                    },
                    onDelete: (stream) {
                      // Implement delete action
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: AppButton(
                label: "Print",
                color: primarycolor,
                size: currentwidth * 0.9,
                action: () async {
                  try {
                    await _generatePdf(_filteredStreams);
                  } catch (e) {
                    print('Error generating PDF: $e');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StreamsDataTable extends StatelessWidget {
  final List<StreamModel> streams;
  final void Function(StreamModel) onView;
  final void Function(StreamModel) onEdit;
  final void Function(StreamModel) onDelete;

  const StreamsDataTable({
    Key? key,
    required this.streams,
    required this.onView,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Expanded(child: HeaderCell(text: 'Streams')),
            Expanded(flex: 2, child: HeaderCell(text: 'Actions')),
          ],
        ),
        ...streams.map((item) {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(child: DataCellWidget(content: item.stream)),
                  Expanded(
                    flex: 2,
                    child: DataCellWidget(content: _buildActions(item)),
                  ),
                ],
              ),
              const Divider(
                color: primarycolor,
                thickness: 1,
                height: 0,
              ),
            ],
          );
        }).toList(),
      ],
    );
  }

  List<Widget> _buildActions(StreamModel stream) {
    return [
      IconButton(
        onPressed: () => onView(stream),
        icon: const Icon(Icons.remove_red_eye, color: primarycolor),
      ),
      IconButton(
        onPressed: () => onEdit(stream),
        icon: const Icon(Icons.edit, color: primarycolor),
      ),
      IconButton(
        onPressed: () => onDelete(stream),
        icon: const Icon(Icons.delete, color: Colors.red),
      ),
    ];
  }
}

class HeaderCell extends StatelessWidget {
  final String text;
  const HeaderCell({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[300],
      ),
      child: Center(
        child: CustomText(
          text: text,
          textcolor: primarycolor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class DataCellWidget extends StatelessWidget {
  final dynamic content;

  const DataCellWidget({required this.content, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Center(
        child: content is String
            ? CustomText(
                text: content,
                textcolor: primarycolor,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: (content as List<Widget>),
              ),
      ),
    );
  }
}
