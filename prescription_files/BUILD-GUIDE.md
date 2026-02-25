# دليل بناء تطبيق MediCare Pro

## 📋 متطلبات البناء

### 1. تثبيت البرامج المطلوبة

#### Windows:
1. **Node.js** - حمل من [nodejs.org](https://nodejs.org/) (اختر LTS)
2. **Android Studio** - حمل من [developer.android.com/studio](https://developer.android.com/studio)
3. **JDK 11** - يأتي مع Android Studio

#### Mac:
```bash
# تثبيت Node.js
brew install node

# تثبيت Android Studio
brew install --cask android-studio
```

#### Linux (Ubuntu/Debian):
```bash
# تثبيت Node.js
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs

# تثبيت Android Studio
sudo snap install android-studio --classic
```

### 2. إعداد Android SDK

بعد تثبيت Android Studio:

1. افتح Android Studio
2. اذهب إلى **Tools → SDK Manager**
3. تأكد من تثبيت:
   - Android SDK Platform 33
   - Android SDK Build-Tools 33
   - Android Emulator
   - Android SDK Platform-Tools

4. أضف متغيرات البيئة:

**Windows:**
```cmd
setx ANDROID_SDK_ROOT "C:\Users\%USERNAME%\AppData\Local\Android\Sdk"
setx PATH "%PATH%;%ANDROID_SDK_ROOT%\platform-tools"
```

**Mac/Linux:**
```bash
echo 'export ANDROID_SDK_ROOT=$HOME/Library/Android/Sdk' >> ~/.bashrc
echo 'export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools' >> ~/.bashrc
source ~/.bashrc
```

## 🚀 خطوات البناء

### الطريقة 1: استخدام سكربت البناء (أسهل)

#### Windows:
```cmd
cd prescription-app
build.bat
```

#### Mac/Linux:
```bash
cd prescription-app
chmod +x build.sh
./build.sh
```

### الطريقة 2: خطوات يدوية

#### 1. تثبيت Capacitor CLI
```bash
npm install -g @capacitor/cli
```

#### 2. تثبيت تبعيات المشروع
```bash
cd prescription-app
npm install
```

#### 3. إضافة منصة Android
```bash
npx cap add android
```

#### 4. تثبيت إضافة SQLite
```bash
npm install @capacitor-community/sqlite
```

#### 5. مزامنة المشروع
```bash
npx cap sync
```

#### 6. فتح في Android Studio
```bash
npx cap open android
```

#### 7. بناء APK
في Android Studio:
1. انتظر حتى ينتهي Gradle من التحميل
2. اذهب إلى **Build → Build Bundle(s) / APK(s) → Build APK(s)**
3. انتظر حتى ينتهي البناء

## 📦 الحصول على ملف APK

بعد البناء بنجاح:

### نسخة Debug (للاختبار):
```
prescription-app/android/app/build/outputs/apk/debug/app-debug.apk
```

### نسخة Release (للنشر):
```
prescription-app/android/app/build/outputs/apk/release/app-release-unsigned.apk
```

## 🔐 توقيع ملف APK (للنشر على Google Play)

### 1. إنشاء مفتاح توقيع
```bash
cd prescription-app/android
keytool -genkey -v -keystore my-release-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias my-alias
```

### 2. توقيع APK
```bash
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore my-release-key.jks app-release-unsigned.apk my-alias
```

### 3. تحسين APK
```bash
zipalign -v 4 app-release-unsigned.apk app-release.apk
```

## 🛠️ استكشاف الأخطاء

### خطأ: "ANDROID_SDK_ROOT not found"

**الحل:**
```bash
# تأكد من تعيين المتغير
export ANDROID_SDK_ROOT=/path/to/android/sdk

# أو أضفه إلى ~/.bashrc
```

### خطأ: "Gradle sync failed"

**الحل:**
```bash
cd prescription-app/android
./gradlew clean
./gradlew build
```

### خطأ: "Could not find module"

**الحل:**
```bash
cd prescription-app
rm -rf node_modules
npm install
npx cap sync
```

### خطأ: "SQLite plugin not working"

**الحل:**
```bash
cd prescription-app
npm install @capacitor-community/sqlite
npx cap sync
cd android
./gradlew clean
```

## 📱 اختبار التطبيق

### على محاكي Android:

1. افتح Android Studio
2. اذهب إلى **Tools → AVD Manager**
3. أنشئ جهاز افتراضي جديد
4. اضغط على زر التشغيل ▶️

### على جهاز حقيقي:

1. فعّل "خيارات المطور" على جهازك
2. فعّل "USB Debugging"
3. وصل الجهاز بالكمبيوتر
4. اضغط على زر التشغيل في Android Studio

## 🔄 تحديث التطبيق

لإجراء تغييرات على الكود:

1. عدل ملفات `www/index.html` أو `www/app.js`
2. شغّل:
```bash
npx cap sync
```
3. أعد البناء في Android Studio

## 📚 موارد مفيدة

- [Capacitor Documentation](https://capacitorjs.com/docs)
- [Android Developer Guide](https://developer.android.com/guide)
- [SQLite Plugin Documentation](https://github.com/capacitor-community/sqlite)

## 💡 نصائح

1. **استخدم Android Studio** - أسهل من سطر الأوامر
2. **اختبر على جهاز حقيقي** - المحاكي أبطأ
3. **فعّل Auto-import** في Android Studio
4. **استخدم Logcat** لتتبع الأخطاء

## 📞 دعم فني

للمساعدة:
- راجع سجلات الأخطاء في Android Studio (Logcat)
- تأكد من جميع المتطلبات
- جرّب تنظيف المشروع وإعادة البناء
