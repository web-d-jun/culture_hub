import 'package:flutter/material.dart';

class CultureItem {
  final String title;
  final String location;
  final String period;
  final String category;
  final Color categoryColor;

  const CultureItem({
    required this.title,
    required this.location,
    required this.period,
    required this.category,
    required this.categoryColor,
  });
}

const List<CultureItem> _sampleItems = [
  CultureItem(
    title: '2028 서울 현대미술전',
    location: '국립현대미술관 · 서울',
    period: '2026.03.01 ~ 2026.05.31',
    category: '전시',
    categoryColor: Color(0xFF5C6BC0),
  ),
  CultureItem(
    title: '봄의 소리 클래식 콘서트',
    location: '예술의전당 콘서트홀',
    period: '2026.03.15',
    category: '공연',
    categoryColor: Color(0xFF26A69A),
  ),
  CultureItem(
    title: '한국 전통 공예 특별전',
    location: '국립민속박물관 · 서울',
    period: '2026.02.10 ~ 2026.04.20',
    category: '전시',
    categoryColor: Color(0xFF5C6BC0),
  ),
  CultureItem(
    title: '뮤지컬 레미제라블',
    location: '블루스퀘어 마스터카드홀',
    period: '2026.03.01 ~ 2026.06.30',
    category: '뮤지컬',
    categoryColor: Color(0xFFEF5350),
  ),
  CultureItem(
    title: '광주 비엔날레 2026',
    location: '광주비엔날레전시관',
    period: '2026.04.07 ~ 2026.07.09',
    category: '전시',
    categoryColor: Color(0xFF5C6BC0),
  ),
  CultureItem(
    title: '국악 한마당 페스티벌',
    location: '남산국악당',
    period: '2026.03.20 ~ 2026.03.22',
    category: '축제',
    categoryColor: Color(0xFFFF7043),
  ),
  CultureItem(
    title: '영화제: 아시아 단편영화',
    location: 'CGV 아트하우스 홍대',
    period: '2026.03.18 ~ 2026.03.25',
    category: '영화',
    categoryColor: Color(0xFF66BB6A),
  ),
  CultureItem(
    title: '조각가 이우환 회고전',
    location: '리움미술관',
    period: '2026.03.05 ~ 2026.06.01',
    category: '전시',
    categoryColor: Color(0xFF5C6BC0),
  ),
];

class CultureListScreen extends StatefulWidget {
  const CultureListScreen({super.key});

  @override
  State<CultureListScreen> createState() => _CultureListScreenState();
}

class _CultureListScreenState extends State<CultureListScreen> {
  String _selectedCategory = '전체';

  static const List<String> _categories = [
    '전체',
    '전시',
    '공연',
    '뮤지컬',
    '축제',
    '영화',
  ];

  List<CultureItem> get _filteredItems {
    if (_selectedCategory == '전체') return _sampleItems;
    return _sampleItems
        .where((item) => item.category == _selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Culture Hub',
          style: TextStyle(
            color: Color(0xFF1A1A2E),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF1A1A2E)),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined,
                color: Color(0xFF1A1A2E)),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCategoryFilter(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              '${_filteredItems.length}개의 문화 행사',
              style: const TextStyle(
                color: Color(0xFF757575),
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) {
                return _CultureCard(item: _filteredItems[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: _categories.map((category) {
            final isSelected = _selectedCategory == category;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(category),
                selected: isSelected,
                onSelected: (_) =>
                    setState(() => _selectedCategory = category),
                selectedColor: const Color(0xFF1A1A2E),
                checkmarkColor: Colors.white,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : const Color(0xFF424242),
                  fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                backgroundColor: const Color(0xFFF0F0F0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide.none,
                ),
                showCheckmark: false,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _CultureCard extends StatelessWidget {
  final CultureItem item;

  const _CultureCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildThumbnail(),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _CategoryBadge(
                      label: item.category,
                      color: item.categoryColor,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A2E),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    _InfoRow(
                      icon: Icons.location_on_outlined,
                      text: item.location,
                    ),
                    const SizedBox(height: 4),
                    _InfoRow(
                      icon: Icons.calendar_today_outlined,
                      text: item.period,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.bookmark_border,
                    color: Color(0xFFBDBDBD), size: 22),
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThumbnail() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 80,
        height: 80,
        color: item.categoryColor.withOpacity(0.15),
        child: Icon(
          _categoryIcon(item.category),
          color: item.categoryColor,
          size: 36,
        ),
      ),
    );
  }

  IconData _categoryIcon(String category) {
    switch (category) {
      case '전시':
        return Icons.museum_outlined;
      case '공연':
        return Icons.music_note_outlined;
      case '뮤지컬':
        return Icons.theater_comedy_outlined;
      case '축제':
        return Icons.celebration_outlined;
      case '영화':
        return Icons.movie_outlined;
      default:
        return Icons.event_outlined;
    }
  }
}

class _CategoryBadge extends StatelessWidget {
  final String label;
  final Color color;

  const _CategoryBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 13, color: const Color(0xFF9E9E9E)),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF757575),
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
