import 'dart:ui';
import 'package:flutter/material.dart';

class TicketCardWidget extends StatelessWidget {
  final Map<String, dynamic> ticket;
  final VoidCallback onTap;

  const TicketCardWidget({
    super.key,
    required this.ticket,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        height: 240,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipPath(
          clipper: TicketClipper(),
          child: CustomPaint(
            foregroundPainter: TicketBorderPainter(),
            child: Row(
              children: [
                // Left Panel (Dark Blue)
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF031A32), Color(0xFF012C57)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        // Background Image
                        ImageFiltered(
                          imageFilter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                          child: RotatedBox(
                            quarterTurns: 3,
                            child: Image.asset(
                              'assets/ticket.png',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const SizedBox(),
                            ),
                          ),
                        ),
                        // Logo
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RotatedBox(
                                quarterTurns: 3,
                                child: Image.asset(
                                  'assets/lotto_logo.png',
                                  width: 140, // Increased width so it looks prominent when rotated
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.star, color: Colors.amber, size: 48),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Right Panel (White)
                Expanded(
                  flex: 7,
                  child: Container(
                    color: Colors.white,
                    child: Row(
                      children: [
                        // Main Content
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // ID and Status
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'TICKET ID',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          ticket['id'],
                                          style: const TextStyle(
                                            color: Color(0xFF031A32),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: ticket['statusColor'].withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            width: 8,
                                            height: 8,
                                            decoration: BoxDecoration(
                                              color: ticket['statusColor'],
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            ticket['status'],
                                            style: TextStyle(
                                              color: ticket['statusColor'],
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                
                                // Ticket Number
                                const Text(
                                  'TICKET NUMBER',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  ticket['number'],
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFF031A32),
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                
                                // Draw Info
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE3F2FD), // Light blue
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.calendar_month, color: Color(0xFF031A32), size: 16),
                                      const SizedBox(width: 8),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Draw ${ticket['draw']}',
                                            style: const TextStyle(
                                              color: Color(0xFF031A32),
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            ticket['date'],
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                
                                // Bottom section (Amount & View Details)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.monetization_on, color: Colors.amber, size: 20),
                                        const SizedBox(width: 4),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'AMOUNT',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 8,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              ticket['amount'],
                                              style: const TextStyle(
                                                color: Color(0xFF031A32),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    // Vertical divider
                                    Container(
                                      height: 24,
                                      width: 1,
                                      color: Colors.grey.shade300,
                                    ),
                                    // View Details Button
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: const Color(0xFFD4AF37)), // Gold border
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: const Row(
                                        children: [
                                          Text(
                                            'Details',
                                            style: TextStyle(
                                              color: Color(0xFF031A32),
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(width: 4),
                                          Icon(Icons.arrow_forward, color: Color(0xFF031A32), size: 14),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        
                        // Dashed line and Barcode
                        CustomPaint(
                          size: const Size(40, double.infinity),
                          painter: BarcodePainter(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    const double notchRadius = 10.0;
    const double cornerRadius = 16.0;
    const double cutoutTop = 40.0;
    const double cutoutBottom = 40.0;
    
    // Start at top left, after corner
    path.moveTo(cornerRadius, 0);
    // Top line
    path.lineTo(size.width - cornerRadius, 0);
    // Top Right Corner
    path.quadraticBezierTo(size.width, 0, size.width, cornerRadius);
    
    // Right line to top notch
    path.lineTo(size.width, cutoutTop);
    // Top Notch Right
    path.arcToPoint(
      Offset(size.width, cutoutTop + notchRadius * 2), 
      radius: const Radius.circular(notchRadius), 
      clockwise: false,
    );
    
    // Right line to bottom notch
    path.lineTo(size.width, size.height - cutoutBottom - notchRadius * 2);
    // Bottom Notch Right
    path.arcToPoint(
      Offset(size.width, size.height - cutoutBottom), 
      radius: const Radius.circular(notchRadius), 
      clockwise: false,
    );
    
    // Right line to bottom right corner
    path.lineTo(size.width, size.height - cornerRadius);
    // Bottom Right Corner
    path.quadraticBezierTo(size.width, size.height, size.width - cornerRadius, size.height);
    
    // Bottom line
    path.lineTo(cornerRadius, size.height);
    // Bottom Left Corner
    path.quadraticBezierTo(0, size.height, 0, size.height - cornerRadius);
    
    // Left line to bottom notch
    path.lineTo(0, size.height - cutoutBottom);
    // Bottom Notch Left
    path.arcToPoint(
      Offset(0, size.height - cutoutBottom - notchRadius * 2), 
      radius: const Radius.circular(notchRadius), 
      clockwise: false,
    );
    
    // Left line to top notch
    path.lineTo(0, cutoutTop + notchRadius * 2);
    // Top Notch Left
    path.arcToPoint(
      Offset(0, cutoutTop), 
      radius: const Radius.circular(notchRadius), 
      clockwise: false,
    );
    
    // Left line to top left corner
    path.lineTo(0, cornerRadius);
    // Top Left Corner
    path.quadraticBezierTo(0, 0, cornerRadius, 0);
    
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class TicketBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFD4AF37) // Gold border
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final path = TicketClipper().getClip(size);
    canvas.drawPath(path, paint);

    // Draw perforated edge (tear-off boundary)
    final double dividerX = size.width * 0.3;
    final dotPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
      
    double dotY = 12.0;
    while (dotY < size.height - 12) {
      canvas.drawCircle(Offset(dividerX, dotY), 3.0, dotPaint);
      dotY += 12.0; // Spacing between perforations
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class BarcodePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Draw vertical dashed line
    final dashPaint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const dashHeight = 4.0;
    const dashSpace = 4.0;
    double startY = 10.0;
    
    while (startY < size.height - 10) {
      canvas.drawLine(
        Offset(0, startY),
        Offset(0, startY + dashHeight),
        dashPaint,
      );
      startY += dashHeight + dashSpace;
    }

    // Draw horizontal barcode lines
    final barcodePaint = Paint()
      ..color = const Color(0xFF031A32)
      ..style = PaintingStyle.fill;

    // Pattern of line thicknesses
    final List<double> lineThicknesses = [2, 1, 3, 1, 1, 4, 1, 2, 1, 3, 2, 1, 1, 4, 2, 3, 1, 2, 1, 4, 1, 1, 2, 3, 1];
    
    double currentY = 20.0;
    int index = 0;
    
    // Fill the available vertical space
    while (currentY < size.height - 20) {
      double thickness = lineThicknesses[index % lineThicknesses.length];
      
      // Ensure we don't draw past the bottom margin
      if (currentY + thickness > size.height - 20) break;
      
      canvas.drawRect(
        Rect.fromLTWH(10, currentY, size.width - 20, thickness),
        barcodePaint,
      );
      
      currentY += thickness + 2.0; // Space between lines
      index++;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
