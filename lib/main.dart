// GFGril - Flutter prototype (single-file)
// Style inspired by Apple Home app, colors pulled from brandbook images.
// This is a starting point: UI, navigation, device control mock, recipes, support.
// Add platform-specific Bluetooth/WiFi integration (flutter_blue / wifi_iot / native) as needed.

import 'package:flutter/material.dart';

void main() => runApp(GFGrilApp());

class GFGrilApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GFGril',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.accentOrange,
        ),
        fontFamily: 'Inter',
      ),
      home: HomeScreen(),
    );
  }
}

class AppColors {
  // Palette sampled from brandbook images
  static const Color bg = Color(0xFFF9F4D4); // light cream
  static const Color base1 = Color(0xFFD1D09A);
  static const Color greenDeep = Color(0xFF1A2E12); // dark green
  static const Color greenMid = Color(0xFF63714D);
  static const Color accentOrange = Color(0xFFF88B52);
  static const Color dark = Color(0xFF2D2D2D);
  static const Color brandDark = Color(0xFF222E1A);
}

// Mock device model
class KitchenDevice {
  final String id;
  final String name;
  final String model;
  bool isConnected;
  bool isRunning;
  int temperature; // C
  Duration remaining;
  String currentProgram;

  KitchenDevice({
    required this.id,
    required this.name,
    required this.model,
    this.isConnected = false,
    this.isRunning = false,
    this.temperature = 20,
    this.remaining = const Duration(minutes: 0),
    this.currentProgram = 'Idle',
  });
}

// Sample data
final devices = <KitchenDevice>[
  KitchenDevice(id: '1', name: 'GFGril Pro', model: 'GF-KP100', isConnected: true),
  KitchenDevice(id: '2', name: 'AirGrill', model: 'GFA-5500'),
];

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.brandDark,
        elevation: 0,
        title: Text('GFGril', style: TextStyle(letterSpacing: 2, fontFamily: 'Serif', fontSize: 28)),
        actions: [
          IconButton(onPressed: () => _openSupport(context), icon: Icon(Icons.email_outlined))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Устройства', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            SizedBox(height: 12),
            SizedBox(
              height: 160,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: devices.length,
                separatorBuilder: (_,__)=>SizedBox(width:12),
                itemBuilder: (context, idx){
                  final d = devices[idx];
                  return DeviceCard(device: d, onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_) => DeviceDetailScreen(device: d)));
                  });
                }
              ),
            ),
            SizedBox(height: 18),
            Text('Рецепты', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            SizedBox(height: 12),
            Expanded(child: RecipeList()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.accentOrange,
        onPressed: ()=>_showAddDevice(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _openSupport(BuildContext ctx){
    Navigator.push(ctx, MaterialPageRoute(builder: (_) => SupportScreen()));
  }

  void _showAddDevice(BuildContext ctx){
    showDialog(context: ctx, builder: (_) => AlertDialog(
      title: Text('Добавить устройство'),
      content: Text('Интеграция Bluetooth / Wi‑Fi реализуется нативно. Здесь — заглушка.'),
      actions: [TextButton(onPressed: ()=>Navigator.pop(ctx), child: Text('Закрыть'))],
    ));
  }
}

class DeviceCard extends StatelessWidget {
  final KitchenDevice device;
  final VoidCallback onTap;
  const DeviceCard({required this.device, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 220,
        decoration: BoxDecoration(
          color: AppColors.greenMid,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0,4))]
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(device.name, style: TextStyle(color: Colors.white, fontSize:16, fontWeight: FontWeight.w700)),
                    Text(device.model, style: TextStyle(color: Colors.white70, fontSize:12)),
                  ],
                ),
                Icon(device.isConnected?Icons.bluetooth_connected:Icons.bluetooth_disabled, color: Colors.white)
              ],
            ),
            Spacer(),
            Row(
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.brandDark, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  onPressed: (){},
                  icon: Icon(Icons.play_arrow),
                  label: Text('Запустить'),
                ),
                SizedBox(width:8),
                OutlinedButton(onPressed: (){}, child: Text('Программы'))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DeviceDetailScreen extends StatefulWidget {
  final KitchenDevice device;
  DeviceDetailScreen({required this.device});
  @override
  _DeviceDetailScreenState createState() => _DeviceDetailScreenState();
}

class _DeviceDetailScreenState extends State<DeviceDetailScreen> {
  late KitchenDevice d;
  @override
  void initState(){
    super.initState();
    d = widget.device;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(title: Text(d.name), backgroundColor: AppColors.brandDark),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Device visual
            Container(
              height: 220,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [AppColors.greenMid.withOpacity(0.9), AppColors.brandDark.withOpacity(0.9)]),
                borderRadius: BorderRadius.circular(16)
              ),
              child: Center(child: Text(d.model, style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold))),
            ),
            SizedBox(height:12),
            Row(
              children: [
                Expanded(child: _statCard('Темп', '${d.temperature}°C')),
                SizedBox(width:8),
                Expanded(child: _statCard('Осталось', _formatDuration(d.remaining))),
              ],
            ),
            SizedBox(height:12),
            _programSelector(),
            SizedBox(height:12),
            Row(children: [
              Expanded(child: ElevatedButton.icon(onPressed: _toggleStart, icon: Icon(d.isRunning?Icons.stop:Icons.play_arrow), label: Text(d.isRunning? 'Остановить' : 'Старт'), style: ElevatedButton.styleFrom(backgroundColor: AppColors.accentOrange))),
              SizedBox(width:8),
              ElevatedButton(onPressed: _syncNow, child: Text('Синхр.'))
            ])
          ],
        ),
      ),
    );
  }

  Widget _statCard(String title, String value){
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: TextStyle(color: Colors.black54)), SizedBox(height:8), Text(value, style: TextStyle(fontSize:18, fontWeight: FontWeight.w600))]),
    );
  }

  String _formatDuration(Duration d){
    if(d.inMinutes==0) return '-';
    return '${d.inMinutes} мин';
  }

  Widget _programSelector(){
    final programs = ['Суп', 'Тушить', 'Жарка', 'Выпечка', 'Йогурт'];
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Программа', style: TextStyle(color: Colors.black54)),
        SizedBox(height:8),
        Wrap(spacing:8, children: programs.map((p){
          final selected = d.currentProgram==p;
          return ChoiceChip(label: Text(p), selected: selected, onSelected: (_){ setState(()=>d.currentProgram=p); });
        }).toList())
      ]),
    );
  }

  void _toggleStart(){
    // Placeholder: send command over Bluetooth/WiFi
    setState(()=>d.isRunning = !d.isRunning);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(d.isRunning? 'Запущено' : 'Остановлено')));
  }

  void _syncNow(){
    // Placeholder for device sync (pull timers / temps). Implement platform code.
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Синхронизация...')));
  }
}

// Recipes
class Recipe {
  final String id; final String title; final String time; final List<String> steps; final String thumbnail;
  Recipe({required this.id, required this.title, required this.time, required this.steps, required this.thumbnail});
}
final sampleRecipes = [
  Recipe(id:'r1', title:'Крем-суп из тыквы', time: '45 мин', steps:['Порезать овощи','Обжарить','Готовить 20 мин','Пюрировать'], thumbnail: ''),
  Recipe(id:'r2', title:'Рис с овощами', time: '30 мин', steps:['Промыть рис','Нарезать овощи','Закладывать и варить','Подавать'], thumbnail: ''),
];

class RecipeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: sampleRecipes.length,
      separatorBuilder: (_,__)=>SizedBox(height:12),
      itemBuilder: (ctx, idx){
        final r = sampleRecipes[idx];
        return ListTile(
          tileColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          leading: CircleAvatar(backgroundColor: AppColors.accentOrange, child: Text(r.title[0])),
          title: Text(r.title, style: TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Text(r.time),
          trailing: ElevatedButton(onPressed: ()=>Navigator.push(ctx, MaterialPageRoute(builder: (_)=>RecipeDetail(recipe:r))), child: Text('Открыть')),
        );
      }
    );
  }
}

class RecipeDetail extends StatefulWidget {
  final Recipe recipe;
  RecipeDetail({required this.recipe});
  @override
  _RecipeDetailState createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  int step = 0;
  @override
  Widget build(BuildContext context) {
    final r = widget.recipe;
    return Scaffold(
      appBar: AppBar(title: Text(r.title), backgroundColor: AppColors.brandDark),
      backgroundColor: AppColors.bg,
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Интерактивный рецепт', style: TextStyle(fontSize:18, fontWeight: FontWeight.w700)),
            SizedBox(height:8),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
                  // Placeholder for short video per step
                  Container(height:180, color: Colors.black12, child: Center(child: Text('Видео шага ${step+1}'))),
                  SizedBox(height:12),
                  Text('Шаг ${step+1}: ${r.steps[step]}', style: TextStyle(fontSize:16, fontWeight: FontWeight.w600)),
                  Spacer(),
                  Row(children:[
                    OutlinedButton(onPressed: step>0?(){setState(()=>step--);} : null, child: Text('Назад')),
                    SizedBox(width:8),
                    ElevatedButton(onPressed: step<r.steps.length-1?(){setState(()=>step++);} : null, child: Text('Далее'))
                  ])
                ])
              )
            )
          ],
        ),
      ),
    );
  }
}

// Support screen with send-to-email
class SupportScreen extends StatelessWidget {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Поддержка'), backgroundColor: AppColors.brandDark),
      backgroundColor: AppColors.bg,
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(children:[
          Text('Опишите проблему или вопрос. Мы ответим по почте.', style: TextStyle(fontSize:16)),
          SizedBox(height:12),
          TextField(controller: _controller, maxLines:8, decoration: InputDecoration(fillColor: Colors.white, filled:true, hintText: 'Текст обращения', border: OutlineInputBorder())),
          SizedBox(height:12),
          Row(children:[
            Expanded(child: ElevatedButton(onPressed: (){ _sendEmail(context); }, child: Text('Отправить')))
          ])
        ])
      )
    );
  }

  void _sendEmail(BuildContext ctx){
    // Simple mailto: approach. For production use proper email API on backend.
    final body = Uri.encodeComponent(_controller.text);
    final mailto = 'mailto:support@gfgril.example?subject=${Uri.encodeComponent('Запрос из приложения')}&body=$body';
    // In a real app use url_launcher to open mail client.
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text('Откроется почтовый клиент: $mailto')));
  }
}

/*
Notes / Integration tips:
- Bluetooth: use flutter_reactive_ble or flutter_blue for direct local control (no cloud). Implement device discovery, pairing, and GATT characteristics for commands and telemetry.
- Wi‑Fi (local): use MDNS/UDP or manufacturer protocol. Consider native platform channels for robust sockets.
- Secure pairing: exchange short-lived keys over BLE with user confirmation.
- Interactive recipes: store short step videos locally or stream via CDN. Use video_player package for playback.
- For uploading diagnostics or support attachments, send to backend via HTTPS. Keep user credentials secure.
- Accessibility: follow large tap targets, readable contrast (we used brand colors but verify WCAG for text on color backgrounds).
*/
