import 'package:flutter/material.dart';
import '../theme/neon_theme.dart';
import '../../domain/models/passport_model.dart';
import '../../core/i18n/localization_service.dart';
import '../../core/audio/sound_service.dart';

class PassportScreen extends StatelessWidget {
  final LocalizationService loc;
  const PassportScreen({super.key, required this.loc});

  @override
  Widget build(BuildContext context) {
    final stamps = PassportService.stamps.values.toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: NeonTheme.surface,
        title: const Text('🛂 PASAPORTE DE EXPLORADOR', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5, color: NeonTheme.gold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: NeonTheme.cyan),
          onPressed: () {
            SoundService.playKeyClick();
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Resumen de Logros
              Container(
                padding: const EdgeInsets.all(16),
                decoration: NeonTheme.neonBoxDecoration,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Text('PAÍSES CONQUISTADOS', style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text('⭐ ${PassportService.totalMasteredCountries} / 177', style: const TextStyle(color: NeonTheme.cyan, fontSize: 22, fontWeight: FontWeight.w900)),
                      ],
                    ),
                    Column(
                      children: [
                        const Text('RANGO DE EXPLORADOR', style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(
                          PassportService.totalMasteredCountries >= 50 ? '👑 LEYENDA' : (PassportService.totalMasteredCountries >= 20 ? '🌟 CAPITÁN' : '🧭 CADETE'),
                          style: const TextStyle(color: NeonTheme.gold, fontSize: 18, fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),
              const Text('ESTAMPILLAS COLECCIONADAS', style: TextStyle(color: NeonTheme.cyan, fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
              const SizedBox(height: 10),

              // Rejilla de Estampillas
              Expanded(
                child: stamps.isEmpty
                    ? Center(
                        child: Text('¡Juega y acierta capitales para ganar tus primeras estampillas doradas!', style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 15), textAlign: TextAlign.center),
                      )
                    : GridView.builder(
                        gridDelegate: const GridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1.35,
                        ),
                        itemCount: stamps.length,
                        itemBuilder: (context, idx) {
                          final s = stamps[idx];
                          return Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              gradient: const RadialGradient(colors: [Color(0xFF231606), Color(0xFF0F0A04)]),
                              border: Border.all(color: NeonTheme.gold, width: 2),
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(color: NeonTheme.gold.withOpacity(0.35), blurRadius: 10),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('⭐ ${s.countryName}', style: const TextStyle(color: NeonTheme.gold, fontWeight: FontWeight.w900, fontSize: 15), maxLines: 1, overflow: TextOverflow.ellipsis),
                                const SizedBox(height: 4),
                                Text(s.capital, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 2),
                                Text('x${s.timesMastered} aciertos', style: const TextStyle(color: NeonTheme.neonGreen, fontSize: 11, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
