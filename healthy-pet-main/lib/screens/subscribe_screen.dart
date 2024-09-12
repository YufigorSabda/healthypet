import 'package:flutter/material.dart';

class SubscribeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subscribe'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Selamat datang di layanan langganan!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              _buildSubscriptionButton(
                context,
                'Langganan 1 Hari',
                10000,
                '10% OFF\nBenefit: Konsultasi online tanpa batas chat dengan dokter!',
                isFirstPurchase: true,
              ),
              SizedBox(height: 10),
              _buildSubscriptionButton(
                context,
                'Langganan 3 Hari',
                30000,
                '10% OFF\nBenefit: Konsultasi tanpa batas dengan dokter dan 1 kali pertemuan konsultasi langsung/offline.',
              ),
              SizedBox(height: 10),
              _buildSubscriptionButton(
                context,
                'Langganan 7 Hari',
                70000,
                '30% OFF\nBenefit: Konsultasi online tanpa batas, 2 kali konsultasi offline, dan 1 kali grooming voucher.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubscriptionButton(BuildContext context, String buttonText, double originalPrice, String benefitText, {bool isFirstPurchase = false}) {
    return InkWell(
      onTap: () {
        _showBenefitDialog(context, 'Detail Langganan', benefitText);
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.deepPurpleAccent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              buttonText,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Harga Asli: Rp ${originalPrice.toStringAsFixed(0)}',
              style: TextStyle(
                fontSize: 14,
                decoration: TextDecoration.lineThrough,
                color: Colors.grey,
              ),
            ),
            Text(
              'Harga Diskon: Rp ${calculateDiscountedPrice(originalPrice, isFirstPurchase ? 0.1 : 0.3).toStringAsFixed(0)}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Cukup bayar sekarang!',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBenefitDialog(BuildContext context, String title, String benefit) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(16),
            color: Colors.indigoAccent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$title Benefit',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  benefit,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Fungsi untuk menghitung harga setelah diskon
  double calculateDiscountedPrice(double originalPrice, double discountPercentage) {
    return originalPrice - (originalPrice * discountPercentage);
  }
}
