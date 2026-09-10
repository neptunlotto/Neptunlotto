import 'package:flutter/material.dart';
import 'dart:ui';

class TicketDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> ticket;

  const TicketDetailsScreen({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/splash_back.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
        child: Container(
          color: Colors.black.withOpacity(
            0.3,
          ), // Darken the blurred image slightly
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 28),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 16.0,
                  ),
                  child: Column(
                    children: [
                      // The actual Ticket
                      CustomPaint(
                        foregroundPainter: TicketBorderPainter(),
                        child: ClipPath(
                          clipper: TicketClipper(),
                          child: Container(
                            color: const Color(
                              0xFFF4F7FB,
                            ), // Off-white ticket color
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [_buildHeader(), _buildTicketBody()],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Share Button (optional, kept from original but restyled)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.share, size: 20),
                          label: const Text(
                            'Share Ticket',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.1),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: const BorderSide(
                                color: Colors.white24,
                                width: 1,
                              ),
                            ),
                            elevation: 0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      height: 170, // Increased to prevent layout overflow
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      decoration: BoxDecoration(
        color: const Color(0xFF031A32), // Deep ocean blue fallback
        image: DecorationImage(
          image: const AssetImage('assets/ticket.png'),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.3),
            BlendMode.darken,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Neptun Lotto Full Logo
          Image.asset(
            'assets/lotto_logo.png',
            height: 90, // Adjust height to fit the new wide logo nicely
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.image_not_supported,
              color: Colors.white54,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketBody() {
    return Stack(
      children: [
        // Wavy Background
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: 120,
          child: CustomPaint(painter: WavePainter()),
        ),
        // Content
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            children: [
              // Official Ticket & Good Luck
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'OFFICIAL TICKET',
                        style: TextStyle(
                          color: Color(0xFF4A5568),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'NEPTUNLOTTO',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: const [
                      Text(
                        'GOOD LUCK!',
                        style: TextStyle(
                          color: Color(0xFFD4AF37), // Gold
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.emoji_events,
                        color: Color(0xFFD4AF37),
                        size: 16,
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Huge Ticket Number Box
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFE2EAF4), // Light blue tint
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      'TICKET NUMBER',
                      style: TextStyle(
                        color: Color(0xFF4A5568),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      ticket['number'] ?? '58392017462',
                      style: const TextStyle(
                        color: Color(0xFF031A32),
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '11 DIGIT LUCKY NUMBER',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // 2x3 Grid of Details
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Column
                  Expanded(
                    child: Column(
                      children: [
                        _buildGridItem(
                          Icons.confirmation_num_outlined,
                          'TICKET ID',
                          ticket['id'] ?? 'LOT-1001',
                        ),
                        const SizedBox(height: 8),
                        _buildGridItem(
                          Icons.calendar_today_outlined,
                          'DRAW',
                          ticket['draw'] ?? '#1023',
                        ),
                        const SizedBox(height: 8),
                        _buildGridItem(
                          Icons.monetization_on_outlined,
                          'AMOUNT',
                          ticket['amount'] ?? '\$10',
                        ),
                      ],
                    ),
                  ),

                  // Faint Vertical Divider
                  Container(
                    width: 1,
                    height: 130,
                    color: Colors.grey.withOpacity(0.3),
                  ),

                  // Right Column
                  Expanded(
                    child: Column(
                      children: [
                        _buildGridItem(
                          Icons.event_available_outlined,
                          'PURCHASE DATE',
                          ticket['date'] ?? '07 Sep 2026',
                        ),
                        const SizedBox(height: 8),
                        _buildGridItem(
                          Icons.access_time_outlined,
                          'DRAW DATE',
                          '07 Sep 2026',
                        ),
                        const SizedBox(height: 8),
                        _buildStatusGridItem(
                          'STATUS',
                          ticket['status'] ?? 'ACTIVE',
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Dashed Divider
              LayoutBuilder(
                builder: (context, constraints) {
                  return Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      (constraints.constrainWidth() / 8).floor(),
                      (index) {
                        return SizedBox(
                          width: 4,
                          height: 1,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              // Footer (Barcode + QR)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Barcode
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: List.generate(35, (index) {
                            final isThick = index % 4 == 0 || index % 7 == 0;
                            final isMedium = index % 3 == 0;
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 1.5,
                              ),
                              width: isThick ? 3 : (isMedium ? 2 : 1),
                              height: 40,
                              color: const Color(0xFF031A32),
                            );
                          }),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'L O T - 1 0 0 1 - 5 8 3 9 2 0 1 7 4 6 2',
                          style: TextStyle(
                            fontSize: 8,
                            color: Colors.grey,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGridItem(IconData icon, String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Icon(icon, color: const Color(0xFF4A5568), size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  color: Color(0xFF031A32),
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusGridItem(String title, String status) {
    final isActive = status.toUpperCase() == 'ACTIVE';
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFE2EAF4),
            shape: BoxShape.circle,
          ),
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFF00C853) : Colors.grey,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: isActive
                      ? const Color(0xFF00C853).withOpacity(0.2)
                      : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  status.toUpperCase(),
                  style: TextStyle(
                    color: isActive
                        ? const Color(0xFF00C853)
                        : Colors.grey.shade700,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Custom Clipper for the Jagged Ticket Shape
class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double cornerRadius = 12.0;
    double splitY = 170.0; // The height of the dark blue header
    double splitRadius = 16.0; // Large cutout at the split

    // Top left
    path.moveTo(0, cornerRadius);
    path.arcToPoint(
      Offset(cornerRadius, 0),
      radius: Radius.circular(cornerRadius),
    );

    // Top straight edge (no dip)
    path.lineTo(size.width - cornerRadius, 0);
    path.arcToPoint(
      Offset(size.width, cornerRadius),
      radius: Radius.circular(cornerRadius),
    );

    // Right jagged edge
    double holeRadius = 8.0;
    double spacing = 16.0;
    double y = cornerRadius + spacing;

    while (y < size.height - cornerRadius - holeRadius * 2) {
      if (y > splitY - splitRadius - 10 && y < splitY + splitRadius + 10) {
        // We are near the split point, skip small holes and draw the large cutout
        path.lineTo(size.width, splitY - splitRadius);
        path.arcToPoint(
          Offset(size.width, splitY + splitRadius),
          radius: Radius.circular(splitRadius),
          clockwise: false,
        );
        y = splitY + splitRadius + spacing;
      } else {
        path.lineTo(size.width, y);
        path.arcToPoint(
          Offset(size.width, y + holeRadius * 2),
          radius: Radius.circular(holeRadius),
          clockwise: false,
        );
        y += (holeRadius * 2) + spacing;
      }
    }

    path.lineTo(size.width, size.height - cornerRadius);
    path.arcToPoint(
      Offset(size.width - cornerRadius, size.height),
      radius: Radius.circular(cornerRadius),
    );

    // Bottom straight edge (no dip)
    path.lineTo(cornerRadius, size.height);
    path.arcToPoint(
      Offset(0, size.height - cornerRadius),
      radius: Radius.circular(cornerRadius),
    );

    // Left jagged edge
    y = size.height - cornerRadius - spacing - holeRadius * 2;
    while (y > cornerRadius) {
      if (y > splitY - splitRadius - 10 && y < splitY + splitRadius + 10) {
        // We are near the split point, skip small holes and draw the large cutout
        path.lineTo(0, splitY + splitRadius);
        path.arcToPoint(
          Offset(0, splitY - splitRadius),
          radius: Radius.circular(splitRadius),
          clockwise: false,
        );
        y = splitY - splitRadius - (holeRadius * 2) - spacing;
      } else {
        path.lineTo(0, y + holeRadius * 2);
        path.arcToPoint(
          Offset(0, y),
          radius: Radius.circular(holeRadius),
          clockwise: false,
        );
        y -= (holeRadius * 2) + spacing;
      }
    }

    path.lineTo(0, cornerRadius);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Custom Painter to draw the Gold Border around the ticket
class TicketBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color =
          const Color(0xFFD4AF37) // Gold
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Draw the border for the top blue header
    Path topPath = Path();
    double cornerRadius = 12.0;
    double splitY = 170.0;
    double splitRadius = 16.0;

    // Start just above the left cutout
    topPath.moveTo(0, splitY - splitRadius);

    // Go up the left edge
    topPath.lineTo(0, cornerRadius);

    // Top-left corner
    topPath.arcToPoint(
      Offset(cornerRadius, 0),
      radius: Radius.circular(cornerRadius),
    );

    // Top edge
    topPath.lineTo(size.width - cornerRadius, 0);

    // Top-right corner
    topPath.arcToPoint(
      Offset(size.width, cornerRadius),
      radius: Radius.circular(cornerRadius),
    );

    // Go down the right edge
    topPath.lineTo(size.width, splitY - splitRadius);

    // Arc into the right cutout (top quarter circle)
    topPath.arcToPoint(
      Offset(size.width - splitRadius, splitY),
      radius: Radius.circular(splitRadius),
      clockwise: false,
    );

    // Straight line across the ticket separating blue header from white body
    topPath.lineTo(splitRadius, splitY);

    // Arc out of the left cutout (top quarter circle)
    topPath.arcToPoint(
      Offset(0, splitY - splitRadius),
      radius: Radius.circular(splitRadius),
      clockwise: false,
    );

    canvas.drawPath(topPath, paint);

    // Draw only the bottom edge
    Path bottomPath = Path();
    bottomPath.moveTo(size.width, size.height - cornerRadius);
    bottomPath.arcToPoint(
      Offset(size.width - cornerRadius, size.height),
      radius: Radius.circular(cornerRadius),
    );
    bottomPath.lineTo(cornerRadius, size.height); // Straight line across
    bottomPath.arcToPoint(
      Offset(0, size.height - cornerRadius),
      radius: Radius.circular(cornerRadius),
    );

    canvas.drawPath(bottomPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom Painter for the Wavy Background at the bottom
class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Draw 3 layers of waves
    final Paint paint1 = Paint()
      ..color = const Color(0xFFE0F0FE).withOpacity(0.7)
      ..style = PaintingStyle.fill;

    final Paint paint2 = Paint()
      ..color = const Color(0xFFBCE0FE).withOpacity(0.7)
      ..style = PaintingStyle.fill;

    final Paint paint3 = Paint()
      ..color = const Color(0xFF90CFFE).withOpacity(0.7)
      ..style = PaintingStyle.fill;

    // First wave (back)
    Path path1 = Path();
    path1.moveTo(0, size.height * 0.4);
    path1.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.1,
      size.width * 0.5,
      size.height * 0.5,
    );
    path1.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.9,
      size.width,
      size.height * 0.2,
    );
    path1.lineTo(size.width, size.height);
    path1.lineTo(0, size.height);
    path1.close();
    canvas.drawPath(path1, paint1);

    // Second wave (middle)
    Path path2 = Path();
    path2.moveTo(0, size.height * 0.6);
    path2.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.3,
      size.width * 0.5,
      size.height * 0.7,
    );
    path2.quadraticBezierTo(
      size.width * 0.75,
      size.height * 1.1,
      size.width,
      size.height * 0.4,
    );
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();
    canvas.drawPath(path2, paint2);

    // Third wave (front)
    Path path3 = Path();
    path3.moveTo(0, size.height * 0.8);
    path3.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.6,
      size.width * 0.6,
      size.height * 0.9,
    );
    path3.quadraticBezierTo(
      size.width * 0.85,
      size.height * 1.1,
      size.width,
      size.height * 0.6,
    );
    path3.lineTo(size.width, size.height);
    path3.lineTo(0, size.height);
    path3.close();
    canvas.drawPath(path3, paint3);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
