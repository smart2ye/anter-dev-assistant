#!/data/data/com.termux/files/usr/bin/bash
# تشغيل خادم المساعد في الخلفية مع منع النوم
cd ~/anter-assistant || exit 1
source venv/bin/activate || exit 1

# إيقاف أي عملية سابقة
pkill -f "python3 app.py" 2>/dev/null
sleep 1

# تشغيل في الخلفية
nohup python3 app.py > ~/assistant.log 2>&1 &
echo "✅ الخادم يعمل (PID: $!)"
echo "📄 السجل: ~/assistant.log"
echo "🌐 الرابط: http://127.0.0.1:5052/"

# منع الهاتف من النوم
termux-wake-lock 2>/dev/null && echo "🔒 termux-wake-lock مُفعّل"

# انتظار للتأكد من بدء الخادم
sleep 2
curl -s http://127.0.0.1:5052/api/status > /dev/null && echo "✅ الخادم يستجيب" || echo "⚠️ الخادم لم يبدأ بعد"
