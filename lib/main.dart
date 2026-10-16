import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:battery_plus/battery_plus.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

void main() {
  runApp(const EcoComputeApp());
}

class EcoComputeApp extends StatelessWidget {
  const EcoComputeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EcoCompute',
      navigatorObservers: [
        routeObserver,
      ],
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFF5F9F5),
        fontFamily: 'Roboto',
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
  onPressed: () {
    // Add Asset screen will come next
  },
  backgroundColor: Colors.green,
  child: const Icon(Icons.add),
),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.green.shade600,
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Icon(
                Icons.eco,
                color: Colors.white,
                size: 60,
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'EcoCompute',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF245C35),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Intelligent Green IT Monitoring',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 35),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;

  void login() {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter email and password'),
        ),
      );
      return;
    }

    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password must contain at least 6 characters'),
        ),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const DashboardScreen(),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              const SizedBox(height: 55),

              Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                  color: Colors.green.shade600,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.eco,
                  color: Colors.white,
                  size: 45,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Welcome to EcoCompute',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Monitor. Optimize. Save Energy.',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 45),

              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              TextField(
                controller: passwordController,
                obscureText: obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child:  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              Text(
                'Green IT • Energy Efficiency • Sustainability',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState
    extends State<DashboardScreen>
    with RouteAware {
  DashboardData? dashboardData;
  int monitoredDeviceCount = 1;

  @override
  void initState() {
    super.initState();
    loadDashboardData();
    
  }

 Future<void> loadDashboardData() async {
  final data = await DashboardData.load();

  final assets = await AssetStorage.loadAssets();

  if (!mounted) {
    return;
  }

  setState(() {
    dashboardData = data;
    monitoredDeviceCount = 1 + assets.length;
  });
}
@override
void didChangeDependencies() {
  super.didChangeDependencies();

  final route = ModalRoute.of(context);

  if (route is PageRoute) {
    routeObserver.subscribe(this, route);
  }
}

@override
void didPopNext() {
  loadDashboardData();
}

@override
void dispose() {
  routeObserver.unsubscribe(this);
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9F5),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green.shade600,
        foregroundColor: Colors.white,
        title: const Text(
          'EcoCompute',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('No new alerts'),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Good day! 👋',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFF245C35),
              ),
            ),

            const SizedBox(height: 5),

            Text(
              'Here is your Green IT overview',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 22),

            // Eco Score
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.green.shade600,
                    Colors.green.shade400,
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        dashboardData == null
                            ? 'Loading...'
                            : dashboardData!.ecoScore.toStringAsFixed(0),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 18),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Eco Score',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          dashboardData == null
                            ? 'Calculating efficiency...'
                            : dashboardData!.ecoScore >= 90
                                ? 'Excellent energy efficiency'
                                : dashboardData!.ecoScore >= 75
                                    ? 'Good energy efficiency'
                                    : dashboardData!.ecoScore >= 60
                                        ? 'Moderate energy efficiency'
                                        : 'Energy usage needs attention',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            const Text(
              'Energy Overview',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _metricCard(
                    icon: Icons.bolt,
                    title: 'Energy Today',
                    value: dashboardData == null
                      ? 'Loading...'
                      : '${dashboardData!.energy.toStringAsFixed(3)} kWh',
                    subtitle: 'Estimated',
                    iconColor: Colors.orange,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _metricCard(
                    icon: Icons.timer,
                    title: 'Monitoring',
                    value: 'Active',
                    subtitle: 'Phone monitored',
                    iconColor: Colors.blue,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _metricCard(
                    icon: Icons.currency_rupee,
                    title: 'Est. Cost',
                    value: dashboardData == null
                      ? 'Loading...'
                      : '₹${dashboardData!.cost.toStringAsFixed(2)}',
                    subtitle: 'This month',
                    iconColor: Colors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _metricCard(
                    icon: Icons.cloud_outlined,
                    title: 'CO₂ Emissions',
                    value: dashboardData == null
                      ? 'Loading...'
                      : '${dashboardData!.co2.toStringAsFixed(3)} kg',
                    subtitle: 'Estimated',
                    iconColor: Colors.grey,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            const Text(
              'IT Assets',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

          Container(
  padding: const EdgeInsets.all(18),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(18),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.05),
        blurRadius: 8,
        offset: const Offset(0, 3),
      ),
    ],
  ),
  child: Row(
    children: [
      Container(
        width: 55,
        height: 55,
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(
          Icons.devices,
          color: Colors.green.shade600,
          size: 30,
        ),
      ),

      const SizedBox(width: 15),

      Expanded(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              '$monitoredDeviceCount '
              '${monitoredDeviceCount == 1 ? 'Monitored Device' : 'Monitored Devices'}',
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              monitoredDeviceCount == 1
                  ? 'Your phone is being monitored'
                  : 'Your phone and added assets are registered',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    ],
  ),
),

            const SizedBox(height: 25),

            const Text(
              'Energy Wastage',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: dashboardData == null
                    ? Colors.grey.shade100
                    : dashboardData!.energy > 3.0
                        ? Colors.red.shade50
                        : Colors.green.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: dashboardData == null
                      ? Colors.grey.shade300
                      : dashboardData!.energy > 3.0
                          ? Colors.red.shade200
                          : Colors.green.shade200,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    dashboardData == null
                        ? Icons.hourglass_empty
                        : WastageDetector.getIcon(
                            dashboardData!.energy,
                          ),
                    color: dashboardData == null
                        ? Colors.grey
                        : dashboardData!.energy > 3.0
                            ? Colors.red
                            : Colors.green,
                    size: 30,
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dashboardData == null
                              ? 'Checking Energy Usage'
                              : WastageDetector.getStatus(
                                  dashboardData!.energy,
                                ),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          dashboardData == null
                              ? 'Analyzing your monitoring data...'
                              : WastageDetector.getMessage(
                                  dashboardData!.energy,
                                ),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            const Text(
              'Recommendations',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            if (dashboardData != null)
              ...RecommendationEngine
                  .getRecommendations(dashboardData!.energy)
                  .map(
                    (recommendation) => Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.eco,
                              color: Colors.green.shade700,
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: Text(
                              recommendation,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

            const SizedBox(height: 25),

InkWell(
  borderRadius: BorderRadius.circular(18),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const OptimizationScreen(),
      ),
    );
  },
  child: Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.green.shade50,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(
        color: Colors.green.shade100,
      ),
    ),
    child: Row(
      children: [
        Icon(
          Icons.analytics,
          color: Colors.green.shade700,
          size: 35,
        ),
        const SizedBox(width: 14),

        const Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                'Monitoring',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Energy estimation active',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF245C35),
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Tap to view optimization impact',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),

        const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.green,
        ),
      ],
    ),
  ),
),
            const SizedBox(height: 14),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const AlertsScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.notifications_active,
                    ),
                    label: const Text('Alerts'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const MonitoringReportScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.description,
                    ),
                    label: const Text('Report'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
onTap: (index) {
  if (index == 1) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AssetsScreen(),
      ),
    );
  }
  if (index == 2) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const AnalyticsScreen(),
    ),
  );
}
if (index == 3) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const TipsScreen(),
    ),
  );
}
if (index == 4) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const ProfileScreen(),
    ),
  );
}
},
        selectedItemColor: Colors.green.shade600,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.devices_outlined),
            activeIcon: Icon(Icons.devices),
            label: 'Assets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            activeIcon: Icon(Icons.analytics),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb_outline),
            activeIcon: Icon(Icons.lightbulb),
            label: 'Tips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _metricCard({
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 28,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _recommendationCard(
    IconData icon,
    String title,
    String description,
  ) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
              color: Colors.green.shade600,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class AssetsScreen extends StatefulWidget {
  const AssetsScreen({super.key});

  @override
  State<AssetsScreen> createState() =>
      _AssetsScreenState();
}

class _AssetsScreenState extends State<AssetsScreen> {
  String deviceName = 'Detecting...';
  String model = 'Detecting...';
  String osVersion = 'Detecting...';
  int batteryLevel = 0;

  List<String> manualAssets = [];

  @override
  void initState() {
    super.initState();
    loadDeviceData();
    loadAssets();
  }

  Future<void> loadDeviceData() async {
    final deviceInfo = DeviceInfoPlugin();
    final battery = Battery();

    try {
      final androidInfo =
          await deviceInfo.androidInfo;

      final level =
          await battery.batteryLevel;

      if (!mounted) {
        return;
      }

      setState(() {
        deviceName = androidInfo.device;
        model = androidInfo.model;
        osVersion =
            'Android ${androidInfo.version.release}';
        batteryLevel = level;
      });
    } catch (e) {
      if (!mounted) {
        return;
      }

      setState(() {
        deviceName = 'Unable to detect';
        model = 'Unable to detect';
        osVersion = 'Unable to detect';
      });
    }
  }

  Future<void> loadAssets() async {
    final assets =
        await AssetStorage.loadAssets();

    if (!mounted) {
      return;
    }

    setState(() {
      manualAssets = assets;
    });
  }

  Future<void> addAsset(String assetName) async {
    final name = assetName.trim();

    if (name.isEmpty) {
      return;
    }

    manualAssets.add(name);

    await AssetStorage.saveAssets(
      manualAssets,
    );

    if (!mounted) {
      return;
    }

    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$name added successfully',
        ),
      ),
    );
  }

  Future<void> deleteAsset(int index) async {
    final removedAsset =
        manualAssets[index];

    manualAssets.removeAt(index);

    await AssetStorage.saveAssets(
      manualAssets,
    );

    if (!mounted) {
      return;
    }

    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$removedAsset removed',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Devices & Assets'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              await loadDeviceData();
              await loadAssets();
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius:
                  BorderRadius.circular(18),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.eco,
                  color: Colors.green,
                  size: 32,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'EcoCompute automatically monitors the device running the app.',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 22),

          const Text(
            'Primary Monitored Device',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                          color:
                              Colors.green.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.phone_android,
                          color: Colors.green,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Phone',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Monitoring Active',
                              style: TextStyle(
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const Divider(height: 28),

                  _assetInfoRow(
                    'Device Name',
                    deviceName,
                  ),

                  _assetInfoRow(
                    'Model',
                    model,
                  ),

                  _assetInfoRow(
                    'Operating System',
                    osVersion,
                  ),

                  _assetInfoRow(
                    'Battery',
                    '$batteryLevel%',
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Other IT Assets',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          if (manualAssets.isEmpty)
            Card(
              child: Padding(
                padding:
                    const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Icon(
                      Icons.inventory_2_outlined,
                      size: 45,
                      color: Colors.grey.shade500,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'No additional assets added',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Additional IT assets can be registered manually.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          if (manualAssets.isNotEmpty)
            ...manualAssets.asMap().entries.map(
              (entry) {
                final index = entry.key;
                final asset = entry.value;

                return Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.devices,
                      color: Colors.green,
                    ),
                    title: Text(
                      asset,
                      style: const TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                    subtitle: const Text(
                      'Manual asset • Monitoring not connected',
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        deleteAsset(index);
                      },
                    ),
                  ),
                );
              },
            ),

          const SizedBox(height: 16),

          SizedBox(
            height: 50,
            child: OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddAssetScreen(
                      onAssetAdded: addAsset,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text(
                'Add Asset',
              ),
            ),
          ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius:
                  BorderRadius.circular(16),
            ),
            child: const Text(
              'The phone is the primary monitored device. Other assets can be registered manually, while direct energy monitoring requires external hardware.',
              style: TextStyle(
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _assetInfoRow(
    String title,
    String value,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class AddAssetScreen extends StatefulWidget {
  final Future<void> Function(String) onAssetAdded;

  const AddAssetScreen({
    super.key,
    required this.onAssetAdded,
  });

  @override
  State<AddAssetScreen> createState() =>
      _AddAssetScreenState();
}

class _AddAssetScreenState extends State<AddAssetScreen> {
  final TextEditingController assetNameController =
      TextEditingController();

  String selectedType = 'Laptop';

  final List<String> assetTypes = [
    'Laptop',
    'Desktop',
    'Monitor',
    'Server',
    'Printer',
    'Other',
  ];

  @override
  void dispose() {
    assetNameController.dispose();
    super.dispose();
  }

  Future<void> addAsset() async {
    final assetName =
        assetNameController.text.trim();

    if (assetName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please enter an asset name',
          ),
        ),
      );
      return;
    }

    final fullAssetName =
        '$assetName ($selectedType)';

    await widget.onAssetAdded(
      fullAssetName,
    );

    if (!mounted) {
      return;
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add IT Asset'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius:
                  BorderRadius.circular(18),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.devices,
                  color: Colors.green,
                  size: 32,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Register an additional IT asset for EcoCompute.',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Asset Information',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          TextField(
            controller: assetNameController,
            decoration: InputDecoration(
              labelText: 'Asset Name',
              hintText: 'e.g. College Laptop',
              prefixIcon: const Icon(
                Icons.devices,
              ),
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(12),
              ),
            ),
          ),

          const SizedBox(height: 18),

          DropdownButtonFormField<String>(
            initialValue: selectedType,
            decoration: InputDecoration(
              labelText: 'Asset Type',
              prefixIcon: const Icon(
                Icons.category,
              ),
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(12),
              ),
            ),
            items: assetTypes.map(
              (type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type),
                );
              },
            ).toList(),
            onChanged: (value) {
              if (value == null) {
                return;
              }

              setState(() {
                selectedType = value;
              });
            },
          ),

          const SizedBox(height: 24),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius:
                  BorderRadius.circular(14),
            ),
            child: const Text(
              'Additional assets are registered manually. Direct energy monitoring of these assets requires external hardware.',
              style: TextStyle(
                fontSize: 13,
              ),
            ),
          ),

          const SizedBox(height: 28),

          SizedBox(
            height: 52,
            child: ElevatedButton.icon(
              onPressed: addAsset,
              icon: const Icon(Icons.add),
              label: const Text(
                'Add Asset',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() =>
      _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  DashboardData? analyticsData;

  int batteryLevel = 0;
  String monitoringDuration = 'Not available';
  String deviceName = 'Monitored Phone';

  @override
  void initState() {
    super.initState();
    loadAnalyticsData();
  }

  Future<void> loadAnalyticsData() async {
    final data = await DashboardData.load();
    final monitoringData =
        await MonitoringStorage.loadMonitoringData();

    String durationText = 'Not available';

    if (monitoringData['startTime'] != null) {
      final startTime =
          DateTime.tryParse(monitoringData['startTime']);

      if (startTime != null) {
        final duration =
            DateTime.now().difference(startTime);

        final hours = duration.inHours;
        final minutes = duration.inMinutes.remainder(60);

        if (hours > 0) {
          durationText = '$hours h $minutes min';
        } else {
          durationText = '$minutes min';
        }
      }
    }

    if (!mounted) {
      return;
    }

    setState(() {
      analyticsData = data;
      batteryLevel =
          monitoringData['currentBattery'] ?? 0;
      monitoringDuration = durationText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
  IconButton(
    icon: const Icon(Icons.refresh),
    onPressed: () async {
      await loadAnalyticsData();

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Analytics refreshed',
          ),
          duration: Duration(seconds: 1),
        ),
      );
    },
  ),
],
      ),

      body: analyticsData == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [

                // Monitoring Summary
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.monitor_heart,
                          color: Colors.green.shade700,
                          size: 30,
                        ),
                      ),

                      const SizedBox(width: 14),

                      const Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Energy Monitoring',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Your phone is currently being monitored',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Energy Analytics',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                // Energy
                Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.bolt,
                      color: Colors.orange,
                    ),
                    title: const Text(
                      'Estimated Energy',
                    ),
                    subtitle: Text(
                      '${analyticsData!.energy.toStringAsFixed(3)} kWh',
                    ),
                    trailing: const Text(
                      'Current',
                    ),
                  ),
                ),

                // Cost
                Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.currency_rupee,
                      color: Colors.green,
                    ),
                    title: const Text(
                      'Estimated Electricity Cost',
                    ),
                    subtitle: Text(
                      '₹${analyticsData!.cost.toStringAsFixed(2)}',
                    ),
                    trailing: const Text(
                      'Estimated',
                    ),
                  ),
                ),

                // CO2
                Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.cloud,
                      color: Colors.blueGrey,
                    ),
                    title: const Text(
                      'CO₂ Emissions',
                    ),
                    subtitle: Text(
                      '${analyticsData!.co2.toStringAsFixed(3)} kg',
                    ),
                    trailing: const Text(
                      'Estimated',
                    ),
                  ),
                ),

                // Eco Score
                Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.eco,
                      color: Colors.green,
                    ),
                    title: const Text(
                      'Eco Score',
                    ),
                    subtitle: Text(
                      '${analyticsData!.ecoScore.toStringAsFixed(0)} / 100',
                    ),
                    trailing: const Text(
                      'Current',
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Monitoring Information',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                // Device
                Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.phone_android,
                      color: Colors.green,
                    ),
                    title: const Text(
                      'Monitored Device',
                    ),
                    subtitle: Text(
                      deviceName,
                    ),
                    trailing: const Text(
                      '1 device',
                    ),
                  ),
                ),

                // Monitoring duration
                Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.timer,
                      color: Colors.green,
                    ),
                    title: const Text(
                      'Monitoring Duration',
                    ),
                    subtitle: Text(
                      monitoringDuration,
                    ),
                    trailing: const Text(
                      'Active',
                    ),
                  ),
                ),

                // Battery
                Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.battery_full,
                      color: Colors.green,
                    ),
                    title: const Text(
                      'Current Battery',
                    ),
                    subtitle: Text(
                      '$batteryLevel%',
                    ),
                    trailing: const Text(
                      'Device',
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Information note
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Energy, cost and CO₂ values are estimated using the monitoring data available from the device.',
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Green IT Tips'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.bedtime, color: Colors.green),
              title: const Text('Enable Sleep Mode'),
              subtitle: const Text(
                'Set computers to sleep when they are not being used.',
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.power_settings_new, color: Colors.green),
              title: const Text('Shut Down Unused Devices'),
              subtitle: const Text(
                'Turn off computers and equipment after working hours.',
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.schedule, color: Colors.green),
              title: const Text('Optimize Operating Hours'),
              subtitle: const Text(
                'Avoid running IT equipment longer than necessary.',
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.co2, color: Colors.green),
              title: const Text('Reduce CO₂ Emissions'),
              subtitle: const Text(
                'Reducing energy consumption also helps lower carbon emissions.',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const CircleAvatar(
            radius: 45,
            backgroundColor: Colors.green,
            child: Icon(
              Icons.person,
              size: 50,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 16),

          const Center(
            child: Text(
              'EcoCompute User',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 6),

          const Center(
            child: Text(
              'Personal Device Monitoring',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),

          const SizedBox(height: 30),

          Card(
            child: ListTile(
              leading: const Icon(
                Icons.phone_android,
                color: Colors.green,
              ),
              title: const Text(
                'Monitored Device',
              ),
              subtitle: const Text(
                'This Phone',
              ),
              trailing: const Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(
                Icons.monitor_heart,
                color: Colors.green,
              ),
              title: const Text(
                'Monitoring Status',
              ),
              subtitle: const Text(
                'Energy estimation active',
              ),
              trailing: const Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(
                Icons.bolt,
                color: Colors.orange,
              ),
              title: const Text(
                'Monitoring Type',
              ),
              subtitle: const Text(
                'Software-based energy estimation',
              ),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(
                Icons.info_outline,
                color: Colors.blue,
              ),
              title: const Text(
                'App Version',
              ),
              subtitle: const Text(
                '1.0.0',
              ),
            ),
          ),

          const SizedBox(height: 10),

          Card(
            child: ListTile(
              leading: const Icon(
                Icons.settings,
                color: Colors.green,
              ),
              title: const Text(
                'Monitoring Settings',
              ),
              subtitle: const Text(
                'Configure energy and alert settings',
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const SettingsScreen(),
                  ),
                );
              },
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(
                Icons.phone_android,
                color: Colors.green,
              ),
              title: const Text(
                'Device Information',
              ),
              subtitle: const Text(
                'View automatically detected device information',
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const DeviceInfoScreen(),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              'EcoCompute monitors the phone running the application and provides software-based energy consumption estimates.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() =>
      _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController tariffController =
      TextEditingController(text: '8');

  final TextEditingController emissionController =
      TextEditingController(text: '0.82');

  bool notificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  Future<void> loadSettings() async {
    final settings =
        await SettingsStorage.loadSettings();

    if (!mounted) {
      return;
    }

    setState(() {
      tariffController.text =
          (settings['tariff'] ?? 8.0).toString();

      emissionController.text =
          (settings['emissionFactor'] ?? 0.82)
              .toString();

      notificationsEnabled =
          settings['notifications'] ?? true;
    });
  }

  @override
  void dispose() {
    tariffController.dispose();
    emissionController.dispose();
    super.dispose();
  }

  Future<void> saveSettings() async {
    final tariff =
        double.tryParse(
              tariffController.text.trim(),
            ) ??
            8.0;

    final emissionFactor =
        double.tryParse(
              emissionController.text.trim(),
            ) ??
            0.82;

    await SettingsStorage.saveSettings(
      organization: 'EcoCompute',
      tariff: tariff,
      emissionFactor: emissionFactor,
      notificationsEnabled:
          notificationsEnabled,
    );

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Monitoring settings saved successfully',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monitoring Settings'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.eco,
                  color: Colors.green,
                  size: 32,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Configure how EcoCompute estimates energy cost, CO₂ emissions and alerts.',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Energy Calculation Settings',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          TextField(
            controller: tariffController,
            keyboardType:
                const TextInputType.numberWithOptions(
              decimal: true,
            ),
            decoration: InputDecoration(
              labelText:
                  'Electricity Tariff (₹/kWh)',
              helperText:
                  'Used to estimate electricity cost',
              prefixIcon: const Icon(
                Icons.currency_rupee,
              ),
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(12),
              ),
            ),
          ),

          const SizedBox(height: 16),

          TextField(
            controller: emissionController,
            keyboardType:
                const TextInputType.numberWithOptions(
              decimal: true,
            ),
            decoration: InputDecoration(
              labelText:
                  'CO₂ Emission Factor (kg/kWh)',
              helperText:
                  'Used to estimate carbon emissions',
              prefixIcon: const Icon(
                Icons.cloud,
              ),
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(12),
              ),
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Alert Settings',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          Card(
            child: SwitchListTile(
              title: const Text(
                'Energy Alerts',
              ),
              subtitle: const Text(
                'Show energy wastage alerts and recommendations',
              ),
              secondary: const Icon(
                Icons.notifications_active,
                color: Colors.green,
              ),
              value: notificationsEnabled,
              activeColor: Colors.green,
              onChanged: (value) {
                setState(() {
                  notificationsEnabled = value;
                });
              },
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Monitoring Information',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          Card(
            child: ListTile(
              leading: const Icon(
                Icons.phone_android,
                color: Colors.green,
              ),
              title: const Text(
                'Primary Monitored Device',
              ),
              subtitle: const Text(
                'The phone running EcoCompute',
              ),
              trailing: const Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
            ),
          ),

          const SizedBox(height: 10),

          Card(
            child: ListTile(
              leading: const Icon(
                Icons.bolt,
                color: Colors.orange,
              ),
              title: const Text(
                'Energy Measurement',
              ),
              subtitle: const Text(
                'Estimated using available device monitoring data',
              ),
            ),
          ),

          const SizedBox(height: 10),

          Card(
            child: ListTile(
              leading: const Icon(
                Icons.info_outline,
                color: Colors.blue,
              ),
              title: const Text(
                'Measurement Limitation',
              ),
              subtitle: const Text(
                'EcoCompute does not directly measure wall-power consumption. Exact electrical measurement requires external hardware such as a smart meter or smart plug.',
              ),
            ),
          ),

          const SizedBox(height: 24),

          SizedBox(
            height: 52,
            child: ElevatedButton.icon(
              onPressed: saveSettings,
              icon: const Icon(Icons.save),
              label: const Text(
                'Save Settings',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
class DeviceInfoScreen extends StatefulWidget {
  const DeviceInfoScreen({super.key});

  @override
  State<DeviceInfoScreen> createState() => _DeviceInfoScreenState();
}

class _DeviceInfoScreenState extends State<DeviceInfoScreen> {
  static const MethodChannel _memoryChannel =
    MethodChannel('com.example.ecocompute/memory');
  String deviceName = 'Detecting...';
  String model = 'Detecting...';
  String osVersion = 'Detecting...';
  String ram = 'Detecting...';
  String cpu = 'Detecting...';

  int batteryLevel = 0;
  BatteryState batteryState = BatteryState.unknown;

  DateTime? monitoringStartTime;
  int startingBatteryLevel = 0;
  double estimatedEnergyToday = 0.0;
  double electricityTariff = 8.0;
  double co2EmissionFactor = 0.82;

  Timer? monitoringTimer;

  @override
  void initState() {
    super.initState();

    initializeMonitoring();

    monitoringTimer = Timer.periodic(
      const Duration(minutes: 1),
      (timer) async {
        await loadDeviceInfo();
        await calculateEnergyEstimate();
      },
    );
  }

Future<void> initializeMonitoring() async {
  await loadSavedMonitoringData();
  await loadDeviceInfo();
  await calculateEnergyEstimate();
}

Future<void> loadSavedMonitoringData() async {
  final data = await MonitoringStorage.loadMonitoringData();

  if (data['startTime'] != null) {
    setState(() {
      monitoringStartTime =
          DateTime.tryParse(data['startTime']);

      startingBatteryLevel =
          data['startingBattery'] ?? 0;

      batteryLevel =
          data['currentBattery'] ?? batteryLevel;

      estimatedEnergyToday =
          data['estimatedEnergy'] ?? 0.0;
    });
  }
}

Future<void> loadDeviceInfo() async {
  final deviceInfo = DeviceInfoPlugin();
  final battery = Battery();

  try {
    final androidInfo = await deviceInfo.androidInfo;
    final Map<dynamic, dynamic> memoryInfo =
      await _memoryChannel.invokeMethod('getMemoryInfo');

    final int totalRamBytes = memoryInfo['totalRamBytes'] as int;
    final int availableRamBytes = memoryInfo['availableRamBytes'] as int;

    final double totalRamGB =
        totalRamBytes / (1024 * 1024 * 1024);

    final double availableRamGB =
        availableRamBytes / (1024 * 1024 * 1024);

    final level = await battery.batteryLevel;
    final state = await battery.batteryState;

    if (monitoringStartTime == null) {
      monitoringStartTime = DateTime.now();
      startingBatteryLevel = level;
    }

    setState(() {
      deviceName = androidInfo.device;
      model = androidInfo.model;
      osVersion = 'Android ${androidInfo.version.release}';
      ram =
    'Total: ${totalRamGB.toStringAsFixed(1)} GB | '
    'Available: ${availableRamGB.toStringAsFixed(1)} GB';
      cpu = androidInfo.hardware;

      batteryLevel = level;
      batteryState = state;
    });
  } catch (e) {
    setState(() {
      deviceName = 'Unable to detect';
      model = 'Unable to detect';
      osVersion = 'Unable to detect';
      ram = 'Unable to detect';
      cpu = 'Unable to detect';
    });
  }
}

Future<void> calculateEnergyEstimate() async {
  if (monitoringStartTime == null) {
    return;
  }

  final elapsedHours =
      DateTime.now().difference(monitoringStartTime!).inMinutes / 60.0;

  if (elapsedHours <= 0) {
    return;
  }

  final energy =
      EnergyEstimator.calculateEnergy(elapsedHours);

  setState(() {
    estimatedEnergyToday = energy;
  });

  await MonitoringStorage.saveMonitoringData(
    startTime: monitoringStartTime!,
    startingBattery: startingBatteryLevel,
    currentBattery: batteryLevel,
    estimatedEnergy: estimatedEnergyToday,
  );
}

EnergySummary getEnergySummary() {
  final cost = EnergyEstimator.calculateCost(
    estimatedEnergyToday,
    electricityTariff,
  );

  final co2 = EnergyEstimator.calculateCO2(
    estimatedEnergyToday,
    co2EmissionFactor,
  );

  final ecoScore =
      EnergyEstimator.calculateEcoScore(
    estimatedEnergyToday,
  );

  return EnergySummary(
    energyKwh: estimatedEnergyToday,
    cost: cost,
    co2: co2,
    ecoScore: ecoScore,
  );
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Information'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Icon(
            Icons.phone_android,
            size: 80,
            color: Colors.green,
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text(
              'Detected Device',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 24),

          _infoCard(
            Icons.devices,
            'Device Name',
            deviceName,
          ),

          _infoCard(
            Icons.phone_android,
            'Model',
            model,
          ),

          _infoCard(
            Icons.android,
            'Operating System',
            osVersion,
          ),

          _infoCard(
            Icons.memory,
            'RAM',
            ram,
          ),

          _infoCard(
            Icons.developer_board,
            'Processor / Hardware',
            cpu,
          ),
          _infoCard(
            Icons.battery_full,
            'Battery Level',
            '$batteryLevel%',
          ),
          _infoCard(
            Icons.battery_charging_full,
            'Battery Status',
            batteryState == BatteryState.charging
            ? 'Charging'
            : 'Not Charging',
          ),
          _infoCard(
            Icons.bolt,
           'Estimated Energy',
           '${estimatedEnergyToday.toStringAsFixed(3)} kWh',
          ),
          _infoCard(
            Icons.currency_rupee,
           'Estimated Electricity Cost',
           '₹${getEnergySummary().cost.toStringAsFixed(2)}',
          ),

          _infoCard(
            Icons.cloud,
            'Estimated CO₂ Emission',
            '${getEnergySummary().co2.toStringAsFixed(3)} kg',
          ),

          _infoCard(
            Icons.eco,
            'Eco Score',
            '${getEnergySummary().ecoScore.toStringAsFixed(0)}/100',
          ),
        ],
      ),
    );
  }

  Widget _infoCard(
    IconData icon,
    String title,
    String value,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.green,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(value),
      ),
    );
  }
  @override
  void dispose() {
    monitoringTimer?.cancel();
    super.dispose();
  }
}
class EnergyEstimator {
  // Estimated average phone power consumption.
  // This is an estimate, not direct electrical measurement.
  static const double estimatedPowerWatts = 5.0;

  static double calculateEnergy(double hoursUsed) {
    if (hoursUsed <= 0) {
      return 0.0;
    }

    return (estimatedPowerWatts * hoursUsed) / 1000;
  }

  static double calculateCost(
    double energyKwh,
    double tariff,
  ) {
    if (energyKwh <= 0 || tariff <= 0) {
      return 0.0;
    }

    return energyKwh * tariff;
  }

  static double calculateCO2(
    double energyKwh,
    double emissionFactor,
  ) {
    if (energyKwh <= 0 || emissionFactor <= 0) {
      return 0.0;
    }

    return energyKwh * emissionFactor;
  }

  static double calculateEcoScore(double energyKwh) {
    if (energyKwh <= 1) {
      return 95;
    } else if (energyKwh <= 2) {
      return 85;
    } else if (energyKwh <= 3) {
      return 75;
    } else if (energyKwh <= 5) {
      return 65;
    } else {
      return 50;
    }
  }
}
class EnergySummary {
  final double energyKwh;
  final double cost;
  final double co2;
  final double ecoScore;

  EnergySummary({
    required this.energyKwh,
    required this.cost,
    required this.co2,
    required this.ecoScore,
  });
}
class WastageDetector {
  static String getStatus(double energyKwh) {
    if (energyKwh <= 1.0) {
      return 'No significant wastage detected';
    } else if (energyKwh <= 3.0) {
      return 'Normal energy usage';
    } else {
      return 'Potential energy wastage detected';
    }
  }

  static String getMessage(double energyKwh) {
    if (energyKwh <= 1.0) {
      return 'Your phone is currently within the expected energy range.';
    } else if (energyKwh <= 3.0) {
      return 'Energy usage is currently within a normal range.';
    } else {
      return 'Extended energy usage may indicate an opportunity to reduce consumption.';
    }
  }

  static IconData getIcon(double energyKwh) {
    if (energyKwh <= 1.0) {
      return Icons.check_circle;
    } else if (energyKwh <= 3.0) {
      return Icons.info;
    } else {
      return Icons.warning;
    }
  }
}
class RecommendationEngine {
  static List<String> getRecommendations(double energyKwh) {
    if (energyKwh <= 1.0) {
      return [
        'Keep up your efficient energy usage.',
        'Continue using battery-saving features when possible.',
      ];
    } else if (energyKwh <= 3.0) {
      return [
        'Enable battery saver when the battery is low.',
        'Close unnecessary background applications.',
      ];
    } else {
      return [
        'Reduce extended screen usage when possible.',
        'Close unnecessary applications running in the background.',
        'Use battery saver to reduce energy consumption.',
      ];
    }
  }
}
class AlertEngine {
  static List<String> getAlerts({
    required double energy,
    required double ecoScore,
    required int batteryLevel,
  }) {
    final alerts = <String>[];

    if (energy > 3.0) {
      alerts.add(
        'High estimated energy usage detected.',
      );
    }

    if (ecoScore < 60) {
      alerts.add(
        'Eco Score is low. Consider reducing unnecessary device usage.',
      );
    }

    if (batteryLevel <= 20) {
      alerts.add(
        'Battery level is low. Consider enabling battery saver.',
      );
    }

    if (alerts.isEmpty) {
      alerts.add(
        'No critical alerts. Your current usage looks good.',
      );
    }

    return alerts;
  }
}
class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() =>
      _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  DashboardData? dashboardData;
  int batteryLevel = 0;

  @override
  void initState() {
    super.initState();
    loadAlertData();
  }

  Future<void> loadAlertData() async {
    final data = await DashboardData.load();
    final monitoringData =
        await MonitoringStorage.loadMonitoringData();

    if (!mounted) {
      return;
    }

    setState(() {
      dashboardData = data;
      batteryLevel =
          monitoringData['currentBattery'] ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (dashboardData == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final alerts = AlertEngine.getAlerts(
      energy: dashboardData!.energy,
      ecoScore: dashboardData!.ecoScore,
      batteryLevel: batteryLevel,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Alerts'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: loadAlertData,
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.notifications_active,
                  color: Colors.green,
                  size: 32,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Energy Monitoring Alerts',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'Current Alerts',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          ...alerts.map(
            (alert) => Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: Icon(
                  alert.contains('No critical')
                      ? Icons.check_circle
                      : Icons.warning,
                  color: alert.contains('No critical')
                      ? Colors.green
                      : Colors.orange,
                ),
                title: Text(alert),
              ),
            ),
          ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              'Alerts are generated from the available device monitoring data and estimated energy values.',
              style: TextStyle(
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class MonitoringReportScreen extends StatefulWidget {
  const MonitoringReportScreen({super.key});

  @override
  State<MonitoringReportScreen> createState() =>
      _MonitoringReportScreenState();
}

class _MonitoringReportScreenState
    extends State<MonitoringReportScreen> {
  DashboardData? dashboardData;
  int batteryLevel = 0;
  String monitoringDuration = 'Not available';

  @override
  void initState() {
    super.initState();
    loadReportData();
  }

  Future<void> loadReportData() async {
    final data = await DashboardData.load();
    final monitoringData =
        await MonitoringStorage.loadMonitoringData();

    String durationText = 'Not available';

    if (monitoringData['startTime'] != null) {
      final startTime =
          DateTime.tryParse(monitoringData['startTime']);

      if (startTime != null) {
        final duration =
            DateTime.now().difference(startTime);

        final hours = duration.inHours;
        final minutes = duration.inMinutes.remainder(60);

        if (hours > 0) {
          durationText = '$hours h $minutes min';
        } else {
          durationText = '$minutes min';
        }
      }
    }

    if (!mounted) {
      return;
    }

    setState(() {
      dashboardData = data;
      batteryLevel =
          monitoringData['currentBattery'] ?? 0;
      monitoringDuration = durationText;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (dashboardData == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Monitoring Report'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'EcoCompute Monitoring Report',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Current device energy monitoring summary',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          _reportRow(
            'Monitored Device',
            '1 Phone',
            Icons.phone_android,
          ),

          _reportRow(
            'Monitoring Duration',
            monitoringDuration,
            Icons.timer,
          ),

          _reportRow(
            'Estimated Energy',
            '${dashboardData!.energy.toStringAsFixed(3)} kWh',
            Icons.bolt,
          ),

          _reportRow(
            'Estimated Cost',
            '₹${dashboardData!.cost.toStringAsFixed(2)}',
            Icons.currency_rupee,
          ),

          _reportRow(
            'Estimated CO₂',
            '${dashboardData!.co2.toStringAsFixed(3)} kg',
            Icons.cloud,
          ),

          _reportRow(
            'Eco Score',
            '${dashboardData!.ecoScore.toStringAsFixed(0)} / 100',
            Icons.eco,
          ),

          _reportRow(
            'Current Battery',
            '$batteryLevel%',
            Icons.battery_full,
          ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              'This report contains estimated values based on device monitoring data. Actual electrical consumption may differ.',
              style: TextStyle(
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _reportRow(
    String title,
    String value,
    IconData icon,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.green,
        ),
        title: Text(title),
        trailing: Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
class OptimizationResult {
  final double beforeEnergy;
  final double afterEnergy;
  final double energySaved;
  final double beforeCost;
  final double afterCost;
  final double costSaved;
  final double beforeCO2;
  final double afterCO2;
  final double co2Saved;

  OptimizationResult({
    required this.beforeEnergy,
    required this.afterEnergy,
    required this.energySaved,
    required this.beforeCost,
    required this.afterCost,
    required this.costSaved,
    required this.beforeCO2,
    required this.afterCO2,
    required this.co2Saved,
  });
}

class OptimizationCalculator {
  static Future<OptimizationResult> calculate(
    double currentEnergy,
  ) async {
    final settings =
        await SettingsStorage.loadSettings();

    final tariff =
        settings['tariff'] ?? 8.0;

    final emissionFactor =
        settings['emissionFactor'] ?? 0.82;

    // Estimated 15% reduction after optimization.
    final afterEnergy =
        currentEnergy * 0.85;

    final energySaved =
        currentEnergy - afterEnergy;

    final beforeCost =
        currentEnergy * tariff;

    final afterCost =
        afterEnergy * tariff;

    final costSaved =
        beforeCost - afterCost;

    final beforeCO2 =
        currentEnergy * emissionFactor;

    final afterCO2 =
        afterEnergy * emissionFactor;

    final co2Saved =
        beforeCO2 - afterCO2;

    return OptimizationResult(
      beforeEnergy: currentEnergy,
      afterEnergy: afterEnergy,
      energySaved: energySaved,
      beforeCost: beforeCost,
      afterCost: afterCost,
      costSaved: costSaved,
      beforeCO2: beforeCO2,
      afterCO2: afterCO2,
      co2Saved: co2Saved,
    );
  }
}
class OptimizationScreen extends StatefulWidget {
  const OptimizationScreen({super.key});

  @override
  State<OptimizationScreen> createState() =>
      _OptimizationScreenState();
}

class _OptimizationScreenState
    extends State<OptimizationScreen> {
  DashboardData? dashboardData;

  OptimizationResult? optimizationResult;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final data = await DashboardData.load();

    if (!mounted) {
      return;
    }

    setState(() {
      dashboardData = data;
    });

    await calculateOptimization();
  }

  Future<void> calculateOptimization() async {
    if (dashboardData == null) {
      return;
    }

    final result =
        await OptimizationCalculator.calculate(
      dashboardData!.energy,
    );

    if (!mounted) {
      return;
    }

    setState(() {
      optimizationResult = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (dashboardData == null ||
        optimizationResult == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final result = optimizationResult!;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Before vs After Optimization',
        ),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius:
                  BorderRadius.circular(18),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.eco,
                  color: Colors.green,
                  size: 35,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Estimated impact of energy optimization',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'Energy Comparison',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          _comparisonCard(
            'Before Optimization',
            '${result.beforeEnergy.toStringAsFixed(3)} kWh',
            Icons.bolt,
            Colors.orange,
          ),

          _comparisonCard(
            'After Optimization',
            '${result.afterEnergy.toStringAsFixed(3)} kWh',
            Icons.eco,
            Colors.green,
          ),

          const SizedBox(height: 20),

          const Text(
            'Savings',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          _savingCard(
            'Energy Saved',
            '${result.energySaved.toStringAsFixed(3)} kWh',
            Icons.bolt,
          ),

          _savingCard(
            'Cost Saved',
            '₹${result.costSaved.toStringAsFixed(2)}',
            Icons.currency_rupee,
          ),

          _savingCard(
            'CO₂ Reduced',
            '${result.co2Saved.toStringAsFixed(3)} kg',
            Icons.cloud,
          ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius:
                  BorderRadius.circular(16),
            ),
            child: const Text(
              'The after-optimization values are estimated using a 15% reduction assumption. Actual savings may vary depending on device usage and optimization actions.',
              style: TextStyle(
                fontSize: 13,
              ),
            ),
          ),

          const SizedBox(height: 20),

          SizedBox(
            height: 50,
            child: OutlinedButton.icon(
              onPressed: () async {
                await loadData();
              },
              icon: const Icon(Icons.refresh),
              label: const Text(
                'Refresh Analysis',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _comparisonCard(
    String title,
    String value,
    IconData icon,
    Color iconColor,
  ) {
    return Card(
      margin:
          const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(
          icon,
          color: iconColor,
          size: 30,
        ),
        title: Text(title),
        subtitle: Text(
          value,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _savingCard(
    String title,
    String value,
    IconData icon,
  ) {
    return Card(
      margin:
          const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.green,
        ),
        title: Text(title),
        trailing: Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
class MonitoringStorage {
  static const String startTimeKey = 'monitoring_start_time';
  static const String startingBatteryKey = 'starting_battery_level';
  static const String currentBatteryKey = 'current_battery_level';
  static const String estimatedEnergyKey = 'estimated_energy_today';

  static Future<void> saveMonitoringData({
    required DateTime startTime,
    required int startingBattery,
    required int currentBattery,
    required double estimatedEnergy,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      startTimeKey,
      startTime.toIso8601String(),
    );

    await prefs.setInt(
      startingBatteryKey,
      startingBattery,
    );

    await prefs.setInt(
      currentBatteryKey,
      currentBattery,
    );

    await prefs.setDouble(
      estimatedEnergyKey,
      estimatedEnergy,
    );
  }

  static Future<Map<String, dynamic>> loadMonitoringData() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      'startTime': prefs.getString(startTimeKey),
      'startingBattery': prefs.getInt(startingBatteryKey) ?? 0,
      'currentBattery': prefs.getInt(currentBatteryKey) ?? 0,
      'estimatedEnergy': prefs.getDouble(estimatedEnergyKey) ?? 0.0,
    };
  }
}
class SettingsStorage {
  static const String organizationKey =
      'organization_name';

  static const String tariffKey =
      'electricity_tariff';

  static const String emissionFactorKey =
      'co2_emission_factor';

  static const String notificationsKey =
      'notifications_enabled';

  static Future<void> saveSettings({
    required String organization,
    required double tariff,
    required double emissionFactor,
    required bool notificationsEnabled,
  }) async {
    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setString(
      organizationKey,
      organization,
    );

    await prefs.setDouble(
      tariffKey,
      tariff,
    );

    await prefs.setDouble(
      emissionFactorKey,
      emissionFactor,
    );

    await prefs.setBool(
      notificationsKey,
      notificationsEnabled,
    );
  }

  static Future<Map<String, dynamic>>
      loadSettings() async {
    final prefs =
        await SharedPreferences.getInstance();

    return {
      'organization':
          prefs.getString(organizationKey) ??
              'EcoCompute Demo',

      'tariff':
          prefs.getDouble(tariffKey) ?? 8.0,

      'emissionFactor':
          prefs.getDouble(emissionFactorKey) ??
              0.82,

      'notifications':
          prefs.getBool(notificationsKey) ??
              true,
    };
  }
}
class AssetStorage {
  static const String assetsKey = 'manual_assets';

  static Future<void> saveAssets(
    List<String> assets,
  ) async {
    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setStringList(
      assetsKey,
      assets,
    );
  }

  static Future<List<String>> loadAssets() async {
    final prefs =
        await SharedPreferences.getInstance();

    return prefs.getStringList(assetsKey) ?? [];
  }
}
class DashboardData {
  final double energy;
  final double cost;
  final double co2;
  final double ecoScore;

  DashboardData({
    required this.energy,
    required this.cost,
    required this.co2,
    required this.ecoScore,
  });

  static Future<DashboardData> load() async {
    final data =
        await MonitoringStorage.loadMonitoringData();

    final settings =
        await SettingsStorage.loadSettings();

    final energy =
        data['estimatedEnergy'] ?? 0.0;

    final tariff =
        settings['tariff'] ?? 8.0;

    final emissionFactor =
        settings['emissionFactor'] ?? 0.82;

    final cost =
        EnergyEstimator.calculateCost(
      energy,
      tariff,
    );

    final co2 =
        EnergyEstimator.calculateCO2(
      energy,
      emissionFactor,
    );

    final ecoScore =
        EnergyEstimator.calculateEcoScore(
      energy,
    );

    return DashboardData(
      energy: energy,
      cost: cost,
      co2: co2,
      ecoScore: ecoScore,
    );
  }
}