import 'package:flutter/material.dart';

import 'forward_button.dart';

class InfoCard extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final Color bgColor;
  final Color iconColor;
  final IconData icon;
  final Function() onTap;
  final String? value;
  final bool isEditing;
  const InfoCard({
    super.key,
    required this.controller,
    required this.bgColor,
    required this.iconColor,
    required this.icon,
    required this.onTap,
    this.value,
    required this.title,
    required this.isEditing,
  });

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  @override
  void initState() {
    widget.controller.text = widget.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.bgColor,
            ),
            child: Icon(
              widget.icon,
              color: widget.iconColor,
            ),
          ),
          const SizedBox(width: 20),
          // Text(
          //   title,
          //   style: const TextStyle(
          //     fontSize: 16,
          //     fontWeight: FontWeight.w500,
          //   ),
          // ),
          Expanded(
            child: TextField(
              controller: widget.controller,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ),
          const SizedBox(width: 8),
          widget.value != null
              ? Text(
                  widget.value!,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                )
              : const SizedBox(),
          const SizedBox(width: 20),
          if (widget.isEditing)
            ForwardButton(
              onTap: widget.onTap,
            ),
        ],
      ),
    );
  }
}
