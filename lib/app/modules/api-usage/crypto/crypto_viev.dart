import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'crypto_controller.dart';

class CryptoScreen extends GetView<CryptoController>{
  const CryptoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kripto Borsası"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.fetchCryptoData(),
          )
        ],
      ),
      body: controller.obx(
            (state) => RefreshIndicator(
          onRefresh: () => controller.fetchCryptoData(),
          child: ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: state!.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final crypto = state[index];
              final quote = crypto.quote['USD'];
              final isPositive = (quote?.percentChange24H ?? 0) >= 0;

              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blueGrey.shade50,
                  // CoinMarketCap ID'sini kullanarak ikonları çekiyoruz
                  child: Image.network(
                    "https://s2.coinmarketcap.com/static/img/coins/64x64/${crypto.id}.png",
                    errorBuilder: (context, error, stackTrace) => Text(crypto.symbol[0]),
                  ),
                ),
                title: Text(
                  crypto.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(crypto.symbol),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "\$${(quote?.price ?? 0).toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isPositive ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                          color: isPositive ? Colors.green : Colors.red,
                        ),
                        Text(
                          "${(quote?.percentChange24H ?? 0).toStringAsFixed(2)}%",
                          style: TextStyle(
                            color: isPositive ? Colors.green : Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        onLoading: const Center(child: CircularProgressIndicator()),
        onError: (error) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(error ?? "Hata oluştu"),
              ElevatedButton(
                onPressed: () => controller.fetchCryptoData(),
                child: const Text("Tekrar Dene"),
              )
            ],
          ),
        ),
      ),
    );
  }
}