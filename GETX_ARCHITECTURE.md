# Flutter GetX Mimarisi — Akademik Rehber
### Model → Provider → Repository → Controller → View

---

## İçindekiler

1. [Mimari Neden Önemlidir?](#1-mimari-neden-önemlidir)
2. [Katmanlı Mimari Prensibi](#2-katmanlı-mimari-prensibi)
3. [Model Katmanı](#3-model-katmanı)
4. [Provider Katmanı](#4-provider-katmanı)
5. [Repository Katmanı](#5-repository-katmanı)
6. [Controller Katmanı](#6-controller-katmanı)
7. [View Katmanı](#7-view-katmanı)
8. [Binding — Bağımlılık Enjeksiyonu](#8-binding--bağımlılık-enjeksiyonu)
9. [Tam Veri Akış Diyagramı](#9-tam-veri-akış-diyagramı)
10. [Sık Yapılan Hatalar](#10-sık-yapılan-hatalar)
11. [Prensiplerin Özeti](#11-prensiplerin-özeti)

---

## 1. Mimari Neden Önemlidir?

Yazılım geliştirmede **mimari**, kodun nasıl organize edileceğini belirleyen yapısal iskelet sistemidir.
Mimarisiz yazılan kod kısa vadede hızlı görünse de şu sorunlara yol açar:

- **Spaghetti Code:** Her şeyin birbirine karıştığı, okunması ve değiştirilmesi güç kod.
- **Test Edilemezlik:** Birbirine bağımlı bileşenler izole test yapmayı engeller.
- **Ölçeklenemezlik:** Yeni özellik eklemek mevcut kodu kırar.
- **Tekrar Kullanılamazlık:** Aynı kod farklı yerlerde tekrar yazılmak zorunda kalınır.

**GetX mimarisi** bu sorunları şu prensipler ile çözer:

| Prensip | Açıklama |
|---|---|
| **Separation of Concerns (SoC)** | Her katman yalnızca kendi sorumluluğunu yerine getirir |
| **Single Responsibility (SRP)** | Her sınıfın yalnızca bir değişme nedeni olmalıdır |
| **Dependency Inversion (DIP)** | Üst katmanlar alt katmanlara değil, soyutlamalara bağımlı olmalıdır |
| **DRY (Don't Repeat Yourself)** | Aynı kod iki kez yazılmamalıdır |

---

## 2. Katmanlı Mimari Prensibi

```
┌─────────────────────────────────┐
│            VIEW                 │  ← Kullanıcı arayüzü (UI)
├─────────────────────────────────┤
│          CONTROLLER             │  ← İş mantığı & State yönetimi
├─────────────────────────────────┤
│          REPOSITORY             │  ← Veri erişim soyutlaması
├─────────────────────────────────┤
│           PROVIDER              │  ← Ağ/Veritabanı iletişimi
├─────────────────────────────────┤
│            MODEL                │  ← Veri yapısı & JSON dönüşümü
└─────────────────────────────────┘
```

**Temel kural:** Oklar **yalnızca yukarıdan aşağıya** akar.
View, Controller'ı bilir. Controller, Repository'yi bilir. Repository, Provider'ı bilir.
**Hiçbir alt katman üst katmanı bilmez.**

---

## 3. Model Katmanı

### 3.1 Nedir?

Model, API'den veya veritabanından gelen **ham veriyi** anlamlı Dart nesnelerine dönüştüren katmandır.
Veri transferi için kullanılan bu nesnelere **DTO (Data Transfer Object)** da denir.

### 3.2 Sorumlulukları

- JSON → Dart objesi dönüşümü (`fromJson`)
- Dart objesi → JSON dönüşümü (`toJson`)
- Veri tipi güvenliği sağlamak
- İş mantığı **içermez**

### 3.3 Yapısı

```dart
class Recipe {
  final int id;
  final String title;
  final String image;
  final int readyInMinutes;

  Recipe({
    required this.id,
    required this.title,
    required this.image,
    required this.readyInMinutes,
  });

  // ⭐ JSON'dan Dart nesnesine dönüşüm
  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
    id: (json["id"] as num).toInt(),
    title: json["title"] ?? '',
    image: json["image"] ?? '',
    readyInMinutes: (json["readyInMinutes"] as num).toInt(),
  );

  // ⭐ Dart nesnesinden JSON'a dönüşüm
  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
    "readyInMinutes": readyInMinutes,
  };
}
```

### 3.4 Dikkat Edilmesi Gerekenler

```dart
// ❌ YANLIŞ — Dart int bekler ama API double dönebilir (30.0)
id: json["id"],

// ✅ DOĞRU — Her iki tipi de güvenle handle eder
id: (json["id"] as num).toInt(),

// ❌ YANLIŞ — Alan null gelirse crash
title: json["title"],

// ✅ DOĞRU — Null güvenliği
title: json["title"] ?? '',

// ❌ YANLIŞ — Enum map null dönerse crash
status: statusValues.map[json["status"]]!,

// ✅ DOĞRU — Bilinmeyen değer için fallback
status: statusValues.map[json["status"]] ?? Status.UNKNOWN,
```

---

## 4. Provider Katmanı

### 4.1 Nedir?

Provider, **yalnızca HTTP isteğini** atan katmandır. Ağ kütüphanesi (Dio, Http) ile doğrudan iletişim kuran tek yerdir. Gelen yanıtı **asla işlemez**, **olduğu gibi döndürür**.

### 4.2 Sorumlulukları

- HTTP GET / POST / PUT / DELETE istekleri atmak
- Header, query parameter, timeout ayarlarını yönetmek
- Ham `Response` döndürmek
- Parse etmek, hata yakalamak **sorumluluğu yoktur**

### 4.3 Yapısı

```dart
class RecipeProvider {
  // ⭐ Dio konfigürasyonu burada yapılır
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.spoonacular.com/recipes',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );

  // ⭐ Sadece ham Response döner — içini açma!
  Future<Response> searchRecipes(String query) async {
    return await _dio.get(
      '/complexSearch',
      queryParameters: {
        'apiKey': 'API_KEY',
        'query': query,
        'number': 10,
      },
    );
  }
}
```

### 4.4 Dikkat Edilmesi Gerekenler

```dart
// ❌ YANLIŞ — Provider içinde parse yapılıyor
Future<Response> getRecipes() async {
  final response = await _dio.get('/search');
  return response.data['results']; // List<dynamic> döner, Response değil!
}

// ✅ DOĞRU — Tüm response olduğu gibi döner
Future<Response> getRecipes() async {
  return await _dio.get('/search');
}

// ❌ YANLIŞ — API Key koda gömülmüş
'apiKey': 'abc123xyz',

// ✅ DOĞRU — .env dosyasından okunur
'apiKey': dotenv.env['API_KEY'] ?? '',
```

---

## 5. Repository Katmanı

### 5.1 Nedir?

Repository, **Provider ile Controller arasındaki arabulucudur**. Provider'dan gelen ham veriyi alır, parse eder, hataları yakalar ve Controller'a temiz bir Dart nesnesi sunar.

Bu katman sayesinde Controller, verinin nereden geldiğini (API mi? Cache mi? Veritabanı mı?) bilmez — bu **soyutlama** yazılımın temel prensiplerinden biridir.

### 5.2 Sorumlulukları

- Provider'ı çağırmak
- HTTP response'ı parse etmek (`fromJson`)
- `try/catch` ile hata yönetimi yapmak
- Controller'a `Model` nesnesi döndürmek
- Gerekirse cache katmanını yönetmek

### 5.3 Yapısı

```dart
class RecipeRepository {
  final RecipeProvider _provider;

  // ⭐ Bağımlılık enjeksiyonu — Provider dışarıdan verilir
  RecipeRepository({required RecipeProvider provider})
      : _provider = provider;

  Future<List<Recipe>> searchRecipes(String query) async {
    try {
      // Adım 1: Provider'dan ham response al
      final Response response = await _provider.searchRecipes(query);

      // Adım 2: Status kontrolü
      if (response.statusCode != 200) {
        throw Exception('Sunucu hatası: ${response.statusCode}');
      }

      // Adım 3: JSON parse — response.data içindeki yapıya göre
      final List<dynamic> dataList = response.data['results'];
      return dataList.map((e) => Recipe.fromJson(e)).toList();

    } on DioException catch (e) {
      // Ağ hataları (timeout, internet yok vs.)
      throw Exception('Bağlantı hatası: ${e.message}');
    } catch (e) {
      // Diğer hatalar (parse hatası vs.)
      throw Exception('Beklenmeyen hata: $e');
    }
  }
}
```

### 5.4 Response Yapısı Analizi

Her API farklı JSON yapısı döndürür. Repository'de doğru key'i bulmak kritiktir:

```dart
// Spoonacular API:
// { "results": [...], "offset": 0, "totalResults": 100 }
final list = response.data['results'];

// CoinMarketCap API:
// { "status": {...}, "data": [...] }
final list = response.data['data'];

// EventRegistry (News) API:
// { "articles": { "results": [...], "totalResults": 50 } }
final list = response.data['articles']['results'];

// WeatherAPI — Tekil nesne:
// { "location": {...}, "current": {...} }
return WeatherModel.fromJson(response.data); // Liste değil, direkt parse
```

---

## 6. Controller Katmanı

### 6.1 Nedir?

Controller, **iş mantığını** barındıran ve **state'i yöneten** katmandır. Repository'den veri alır, gerekli işlemleri yapar ve View'ın dinleyebileceği state'i günceller.

GetX'te `StateMixin` üç temel state sağlar:

| State | Anlamı | View'da Gösterilen |
|---|---|---|
| `RxStatus.loading()` | Veri yükleniyor | Loading spinner |
| `RxStatus.success()` | Veri başarıyla geldi | Liste / içerik |
| `RxStatus.empty()` | Veri boş | "Sonuç bulunamadı" mesajı |
| `RxStatus.error(msg)` | Hata oluştu | Hata mesajı + tekrar dene |

### 6.2 Sorumlulukları

- Repository'yi çağırmak
- State yönetimi (`loading` → `success` / `error`)
- UI'a özel hesaplamalar (filtreleme, sıralama vs.)
- `TextEditingController` gibi UI kaynaklarını yönetmek
- Lifecycle yönetimi (`onInit`, `onClose`)

### 6.3 Yapısı

```dart
class RecipeController extends GetxController
    with StateMixin<List<Recipe>> {   // ⭐ State tipi belirlenir

  final RecipeRepository _repository;

  // ⭐ Bağımlılık enjeksiyonu
  RecipeController({required RecipeRepository repository})
      : _repository = repository;

  // UI kaynakları burada tanımlanır
  final TextEditingController searchController = TextEditingController();

  // ⭐ Uygulama açılınca otomatik çalışır
  @override
  void onInit() {
    super.onInit();
    fetchRecipes('');
  }

  // ⭐ Widget ağacından çıkınca kaynakları serbest bırak
  @override
  void onClose() {
    searchController.dispose(); // Memory leak önlenir
    super.onClose();
  }

  Future<void> fetchRecipes(String query) async {
    // Adım 1: Loading state — View spinner gösterir
    change(null, status: RxStatus.loading());

    try {
      final data = await _repository.searchRecipes(query);

      if (data.isEmpty) {
        // Adım 2a: Boş state
        change(null, status: RxStatus.empty());
      } else {
        // Adım 2b: Başarı state — View listeyi gösterir
        change(data, status: RxStatus.success());
      }
    } catch (e) {
      // Adım 3: Hata state — View hata mesajı gösterir
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
```

### 6.4 Dikkat Edilmesi Gerekenler

```dart
// ❌ YANLIŞ — onInit içinde veri çekilmemiş, ekran boş açılır
@override
void onInit() {
  super.onInit();
  // fetchRecipes çağrılmamış
}

// ❌ YANLIŞ — dispose unutulmuş → memory leak
@override
void onClose() {
  // searchController.dispose() yok!
  super.onClose();
}

// ❌ YANLIŞ — loading state set edilmemiş
Future<void> fetchRecipes() async {
  // change(null, status: RxStatus.loading()) yok
  final data = await _repository.searchRecipes();
  change(data, status: RxStatus.success());
}
```

---

## 7. View Katmanı

### 7.1 Nedir?

View, **yalnızca kullanıcı arayüzünü** oluşturan katmandır. Controller'ı dinler, state değişimlerine göre farklı widgetlar gösterir. **Hiçbir iş mantığı içermez.**

`GetView<T>` kullanmak, `controller` getter'ını otomatik sağlar — `Get.find()` çağırmaya gerek yoktur.

### 7.2 Sorumlulukları

- Controller'ı `GetView<Controller>` ile bağlamak
- `obx()` veya `controller.obx()` ile state dinlemek
- Her state için uygun widget göstermek
- Kullanıcı etkileşimlerini Controller'a iletmek
- İş mantığı **içermez**

### 7.3 Yapısı

```dart
class RecipeView extends GetView<RecipeController> {
  const RecipeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tarifler')),
      body: Column(
        children: [
          // ⭐ Kullanıcı girdisi — Controller'a iletilir
          TextField(
            controller: controller.searchController,
            onSubmitted: (value) => controller.fetchRecipes(value.trim()),
            decoration: const InputDecoration(
              hintText: 'Tarif ara...',
              prefixIcon: Icon(Icons.search),
            ),
          ),

          // ⭐ State dinleme — tek nokta yönetimi
          Expanded(
            child: controller.obx(
              // ✅ Success state
              (state) => ListView.builder(
                itemCount: state!.length,
                itemBuilder: (_, i) => RecipeCard(recipe: state[i]),
              ),
              // ⏳ Loading state
              onLoading: const Center(
                child: CircularProgressIndicator(),
              ),
              // 📭 Empty state
              onEmpty: const Center(
                child: Text('Tarif bulunamadı'),
              ),
              // ❌ Error state
              onError: (error) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(error ?? 'Hata oluştu'),
                    ElevatedButton(
                      onPressed: () => controller.fetchRecipes(''),
                      child: const Text('Tekrar Dene'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

### 7.4 Widget Ayrıştırma Prensibi

Büyük View dosyaları alt widget sınıflarına bölünmelidir:

```dart
// ❌ YANLIŞ — Her şey tek widget içinde, okunması zor
ListView.builder(
  itemBuilder: (_, i) => Card(
    child: Column(
      children: [
        Image.network(recipe.image),
        Text(recipe.title),
        Row(children: [...]),
        // 50+ satır daha...
      ],
    ),
  ),
);

// ✅ DOĞRU — Ayrı widget sınıfı
ListView.builder(
  itemBuilder: (_, i) => RecipeCard(recipe: state![i]),
);

// Ayrı dosyada veya aynı dosyanın altında:
class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Card(/* ... */);
  }
}
```

---

## 8. Binding — Bağımlılık Enjeksiyonu

### 8.1 Nedir?

Binding, bir route (ekran) açıldığında **gerekli tüm bağımlılıkları** GetX konteynerine kaydeden katmandır. Katmanlar arası sıralı bağımlılık zincirini burada kurulur.

### 8.2 Bağımlılık Zinciri

```dart
class RecipeBinding extends Bindings {
  @override
  void dependencies() {
    // ⭐ Sıra önemlidir — alt katman önce kaydedilir

    // 1. Provider — bağımlılığı yok
    Get.lazyPut<RecipeProvider>(
      () => RecipeProvider(),
    );

    // 2. Repository — Provider'a bağımlı
    Get.lazyPut<RecipeRepository>(
      () => RecipeRepository(provider: Get.find()),
    );

    // 3. Controller — Repository'ye bağımlı
    Get.lazyPut<RecipeController>(
      () => RecipeController(repository: Get.find()),
    );
  }
}
```

### 8.3 `lazyPut` vs `put`

| Yöntem | Davranış |
|---|---|
| `Get.lazyPut()` | Nesne ilk kullanıldığında oluşturulur (önerilir) |
| `Get.put()` | Binding çalışır çalışmaz anında oluşturulur |
| `Get.putAsync()` | Asenkron başlatma gereken bileşenler için |

### 8.4 Route Tanımında Kullanım

```dart
GetPage(
  name: '/recipes',
  page: () => const RecipeView(),
  binding: RecipeBinding(), // ⭐ Ekranla birlikte bağımlılıklar yüklenir
),
```

---

## 9. Tam Veri Akış Diyagramı

```
KULLANICI
    │
    │ Arama yapar (Enter'a basar)
    ▼
VIEW (RecipeView)
    │
    │ controller.fetchRecipes("pasta")
    ▼
CONTROLLER (RecipeController)
    │
    │ change(null, status: loading())   ──→  VIEW spinner gösterir
    │
    │ repository.searchRecipes("pasta")
    ▼
REPOSITORY (RecipeRepository)
    │
    │ provider.searchRecipes("pasta")
    ▼
PROVIDER (RecipeProvider)
    │
    │ HTTP GET /complexSearch?query=pasta
    ▼
API (spoonacular.com)
    │
    │ Response { "results": [...] }
    ▼
PROVIDER
    │
    │ Response döner (ham, parse edilmemiş)
    ▼
REPOSITORY
    │
    │ response.data['results']
    │ .map((e) => Recipe.fromJson(e)).toList()
    ▼
MODEL (Recipe.fromJson)
    │
    │ List<Recipe> döner
    ▼
REPOSITORY
    │
    │ List<Recipe> döner
    ▼
CONTROLLER
    │
    │ change(data, status: success())   ──→  VIEW listeyi gösterir
    ▼
VIEW (RecipeView)
    │
    ▼
KULLANICI — Tarifleri görür
```

---

## 10. Sık Yapılan Hatalar

### 10.1 Provider'da Parse Yapmak
```dart
// ❌ Provider parse yapıyor — YANLIŞ
Future<Response> getRecipes() async {
  final res = await _dio.get('/search');
  return res.data['results']; // Response değil, List dönüyor — tip hatası!
}

// ✅ Provider sadece Response döndürür
Future<Response> getRecipes() async {
  return await _dio.get('/search');
}
```

### 10.2 Controller'da Ağ İsteği Atmak
```dart
// ❌ Controller doğrudan Dio kullanıyor — YANLIŞ
Future<void> fetchData() async {
  final dio = Dio();
  final response = await dio.get('https://api.example.com/data');
  // ...
}

// ✅ Controller sadece Repository çağırır
Future<void> fetchData() async {
  final data = await _repository.getData();
  // ...
}
```

### 10.3 Loading State Unutmak
```dart
// ❌ Loading state yok — ekran donuk kalır
Future<void> fetchData() async {
  final data = await _repository.getData();
  change(data, status: RxStatus.success());
}

// ✅ Her zaman loading ile başla
Future<void> fetchData() async {
  change(null, status: RxStatus.loading());
  final data = await _repository.getData();
  change(data, status: RxStatus.success());
}
```

### 10.4 Error State'i Atlamak
```dart
// ❌ Hata durumu handle edilmemiş
Future<void> fetchData() async {
  change(null, status: RxStatus.loading());
  final data = await _repository.getData();
  change(data, status: RxStatus.success());
}

// ✅ try/catch ile hata state'i
Future<void> fetchData() async {
  change(null, status: RxStatus.loading());
  try {
    final data = await _repository.getData();
    change(data, status: RxStatus.success());
  } catch (e) {
    change(null, status: RxStatus.error(e.toString()));
  }
}
```

### 10.5 Null Check Operatörü ile Enum Parse
```dart
// ❌ API beklenmeyen bir değer gönderirse crash
type: typeValues.map[json["type"]]!,

// ✅ Fallback değeri ile güvenli parse
type: typeValues.map[json["type"]] ?? Type.UNKNOWN,
```

### 10.6 dispose() Unutmak
```dart
// ❌ Memory leak — TextEditingController serbest bırakılmamış
@override
void onClose() {
  super.onClose();
}

// ✅ Kaynaklar serbest bırakılır
@override
void onClose() {
  searchController.dispose();
  super.onClose();
}
```

---

## 11. Prensiplerin Özeti

| Katman | Sorumluluk | İçermez |
|---|---|---|
| **Model** | JSON ↔ Dart dönüşümü | İş mantığı, ağ isteği |
| **Provider** | HTTP isteği atmak | Parse, hata yönetimi, iş mantığı |
| **Repository** | Parse + hata yönetimi | UI mantığı, state yönetimi |
| **Controller** | State yönetimi + iş mantığı | Ağ isteği, widget kodu |
| **View** | UI gösterimi | İş mantığı, ağ isteği, parse |
| **Binding** | Bağımlılık kaydı | İş mantığı, UI |

```
Her katman yalnızca bir alt katmanı çağırır.
Hiçbir alt katman üst katmanı bilmez.
Hata yönetimi Repository'de yapılır.
State yönetimi Controller'da yapılır.
UI kararları View'da yapılır.
```

---

*Bu doküman `api_usage` projesindeki Crypto, Movie, News, Weather ve Food modülleri incelenerek hazırlanmıştır.*
