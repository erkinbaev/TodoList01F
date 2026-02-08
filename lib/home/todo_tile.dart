import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoTile extends StatelessWidget {
  final String title;
  final String dateText;
  final bool isDone;
  final ValueChanged<bool> onChanged;

  const TodoTile({
    super.key,
    required this.title,
    required this.dateText,
    required this.isDone,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 74,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF0A72FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          _SquareCheckbox(
            value: isDone,
            onChanged: onChanged,
          ),
          const SizedBox(width: 14),

          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                decoration: isDone ? TextDecoration.lineThrough : null,
                decorationColor: Colors.white,
                decorationThickness: 2,
              ),
            ),
          ),

          const SizedBox(width: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.calendar_month, color: Colors.white, size: 18),
              const SizedBox(width: 6),
              Text(
                _formatFromString(dateText),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatFromString(String dateString) {
  final date = DateTime.parse(dateString);
  return DateFormat('dd.MM.yyyy').format(date);
}
}

class _SquareCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SquareCheckbox({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: () => onChanged(!value),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: const Color(0xFFEDEDED),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.black87, width: 2),
        ),
        child: value
            ? const Icon(Icons.check, size: 20, color: Colors.black87)
            : null,
      ),
    );
  }
}