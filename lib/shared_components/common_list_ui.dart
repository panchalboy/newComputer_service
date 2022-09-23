import 'package:computer_service/Routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardListui extends StatefulWidget {
  final String image;
  final String productName;
  final String shortDec;
  final String fullDec;
  final String delerPrice;
  final String selesePrice;
  final Icons icon;
  final validity;
  final Function ontap;

  const CardListui(
      {Key key,
      this.image,
      this.productName,
      this.shortDec,
      this.fullDec,
      this.delerPrice,
      this.selesePrice,
      this.icon,
      this.validity,
      this.ontap})
      : super(key: key);

  @override
  State<CardListui> createState() => _CardListuiState();
}

class _CardListuiState extends State<CardListui> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.ontap,
      child: Card(
        elevation: 2.0,
        margin: EdgeInsets.all(0.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: widget.image != null
                    ? Image.network(
                        widget.image,
                        fit: BoxFit.contain,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace stackTrace) {
                          return Image.asset('assets/m1.jpg');
                        },
                      )
                    : Image.asset('assets/m1.jpg'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                widget.productName,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.indigo[900],
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                "${widget.shortDec == null ? "" : widget.shortDec}",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 10, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\u{20B9}${widget.delerPrice}",
                    style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        decorationThickness: 4,
                        color: Colors.black54,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.validity != null
                        ? "validity: ${widget.validity}"
                        : "\u{20B9}${widget.selesePrice}",
                    style: TextStyle(
                        color: Colors.green[500],
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
