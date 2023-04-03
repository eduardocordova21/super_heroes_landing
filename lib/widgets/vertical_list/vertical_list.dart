import 'package:flutter/material.dart';
import 'package:super_heroes_landing/controllers/response_controller.dart';
import 'package:super_heroes_landing/widgets/vertical_list/vertical_list_text.dart';
import '../../configurations/colors.dart';
import '../../models/results.dart';

class VerticalList extends StatefulWidget {
  List<Results> charactersList = [];
  int totalCharacters = 0;

  VerticalList(
      {Key? key, required this.charactersList, required this.totalCharacters})
      : super(key: key);

  @override
  State<VerticalList> createState() => _VerticalListState();
}

class _VerticalListState extends State<VerticalList> {
  final ResponseController _responseController = ResponseController();
  final _scrollController = ScrollController();
  bool _hasMoreCharacters = true;
  int _offset = 25;

  @override
  void initState() {
    super.initState();

    widget.charactersList.removeRange(0, 5);

    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        if (widget.charactersList.length == widget.totalCharacters) {
          _hasMoreCharacters = false;
        }

        if (widget.charactersList.length <= widget.totalCharacters) {
          _responseController
              .fetchResponse(_offset)
              .then((response) => setState(() {
                    widget.charactersList.addAll(response.requestdata.results);
                    _offset += 25;
                  }));
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        controller: _scrollController,
        itemCount: widget.charactersList.length + 1,
        itemBuilder: (context, index) {
          if (index < widget.charactersList.length) {
            return Card(
              elevation: 40,
              margin: const EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: primaryBlack,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.width / 3,
                        child: Image.network(
                          "${widget.charactersList[index].thumbnail.path}.${widget.charactersList[index].thumbnail.extension}",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                  VerticalListText(character: widget.charactersList[index])
                ],
              ),
            );
          } else {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
