import 'package:flutter/material.dart';
import 'cell.dart';

class IntroCard extends StatefulWidget {
  final String? manuscriptTitle;
  final String? firstAuthor;
  final String? correspondingAuthor;
  final String? submissionDate;
  const IntroCard(
      {super.key,
      required this.manuscriptTitle,
      required this.firstAuthor,
      required this.correspondingAuthor,
      required this.submissionDate});

  @override
  State<IntroCard> createState() => _IntroCardState();
}

class _IntroCardState extends State<IntroCard> {
  @override
  Widget build(BuildContext context) {
    return Cell(
      child: ListTile(
        title: Text(
          textAlign: TextAlign.justify,
          widget.manuscriptTitle ?? "",
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Wrap(
          spacing: 15,
          children: [
            Text(
              style: const TextStyle(
                fontSize: 12,
              ),
              "First Author: ${widget.firstAuthor ?? ""}",
            ),
            Text(
              style: const TextStyle(
                fontSize: 12,
              ),
              "Corresponding Author: ${widget.correspondingAuthor ?? ""}",
            ),
            Text(
              style: const TextStyle(
                fontSize: 12,
              ),
              "Submission Time: ${widget.submissionDate ?? ""}",
            ),
          ],
        ),
      ),
    );
  }
}

class ReviewEventCard extends StatefulWidget {
  final String? reviewer;
  final String? event;
  final String? time;
  const ReviewEventCard(
      {super.key,
      required this.reviewer,
      required this.event,
      required this.time});

  @override
  State<ReviewEventCard> createState() => _ReviewEventCardState();
}

class _ReviewEventCardState extends State<ReviewEventCard> {
  @override
  Widget build(BuildContext context) {
    return Cell(
      backgroundColor: Colors.blue.shade50,
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // spacing: 15,
          children: [
            Text(
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
              widget.reviewer ?? "",
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  widget.event ?? "",
                ),
                Text(
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                  widget.time ?? "",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
