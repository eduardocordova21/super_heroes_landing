import 'package:flutter/material.dart';
import 'package:super_heroes_landing/controllers/response_controller.dart';
import '../configurations/colors.dart';
import '../models/results.dart';

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
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.charactersList[index].name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.redAccent),
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "Quadrinhos: ${widget.charactersList[index].comics.available.toString()}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  "Séries: ${widget.charactersList[index].series.available.toString()}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  "Histórias: ${widget.charactersList[index].stories.available.toString()}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  "Eventos: ${widget.charactersList[index].events.available.toString()}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
