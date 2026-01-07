import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TopSellingFoodGraphScreen extends StatelessWidget {
  const TopSellingFoodGraphScreen({super.key});

  final List<Map<String, dynamic>> topFoods = const [
    {
      "rank": 1,
      "name": "Chicken Biryani",
      "rating": 4.9,
      "sales": 320,
    },
    {
      "rank": 2,
      "name": "Veg Burger",
      "rating": 4.7,
      "sales": 260,
    },
    {
      "rank": 3,
      "name": "Pizza",
      "rating": 4.6,
      "sales": 210,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( backgroundColor: Colors.blue.shade50,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new)),
        title: Text("Top Rated & Best Sellers",style: GoogleFonts.merriweather(),),
        centerTitle: true,
      ),
      backgroundColor: Colors.blue.shade50,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Top Selling Food Items",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
        
              SizedBox(height: 12.h),

              Container(
                height: 260.h,
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border(
                    left: BorderSide(
                      color: Colors.blue.shade700,
                      width: 5,
                    ),
                  ),
                ),
                child: BarChart(
                  BarChartData(
                    maxY: 350,
                    barTouchData: BarTouchData(enabled: true),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value.toInt().toString(),
                              style: TextStyle(fontSize: 12.sp),
                            );
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return Padding(
                              padding: EdgeInsets.only(top: 4.h),
                              child: Text(
                                topFoods[value.toInt()]["name"],
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      rightTitles:
                      const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles:
                      const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    borderData: FlBorderData(show: false),
                    gridData: FlGridData(show: true),
                    barGroups: List.generate(topFoods.length, (index) {
                      return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: topFoods[index]["sales"].toDouble(),
                            width: 28,
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.blue.shade600,
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ),
        
              SizedBox(height: 24.h),

              Text(
                "Ranking Details",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
        
              SizedBox(height: 12.h),
        
              ...topFoods.map((food) => _rankCard(food)).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _rankCard(Map<String, dynamic> food) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.blue.shade600,
            child: Text(
              food["rank"].toString(),
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),

          SizedBox(width: 12.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  food["name"],
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "⭐ Rating: ${food["rating"]}  |  🔥 Sold: ${food["sales"]}",
                  style: TextStyle(fontSize: 13.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
