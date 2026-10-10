# منصة الأستاذ محمد عبد المقصود

## النشر على Vercel (مع Supabase لحفظ البيانات)

لا تحتاج تحديد أي رابط مسبقاً: Vercel يعطيك رابطاً بعد النشر والمنصة تعمل على أي رابط تلقائياً.

### 1) شكل المستودع على GitHub (مهم جداً)

```
index.html
server.js
sw.js
manifest.webmanifest
app-icon-192.png
app-icon-512.png
package.json
vercel.json
api/index.js          <- داخل فولدر اسمه api
```

بقية الملفات (`scripts` و`supabase` و`start.bat` و`.env.example` و`.gitignore` و`.vercelignore`) اختيارية للنشر.
لإنشاء `api/index.js` من موقع GitHub: **Add file > Create new file** واكتب في خانة الاسم `api/index.js` (علامة `/` تنشئ الفولدر).

### 2) Supabase
1. أنشئ مشروعاً على https://supabase.com
2. افتح **SQL Editor** وانسخ فيه محتوى `supabase/schema.sql` ثم **Run**.
3. من **Project Settings > API** انسخ `Project URL` و`service_role key`.

### 3) Vercel
1. **Add New > Project** واختر المستودع. اترك Framework Preset = **Other** واترك Build Command وOutput Directory فاضيين.
2. قبل الضغط على Deploy افتح **Environment Variables** وأضف:
   - `SUPABASE_URL` = رابط المشروع
   - `SUPABASE_SERVICE_ROLE_KEY` = المفتاح (سري، لا تضعه في GitHub)
   - `SESSION_SECRET` = أي نص عشوائي طويل
   - `TEACHER_PASSWORD` = كلمة مرور المعلم (12 حرفاً على الأقل)
   - اختياري: `GEMINI_API_KEY` للمساعد الذكي، و`KASHIER_MID` و`KASHIER_API_KEY` و`KASHIER_SECRET_KEY` و`KASHIER_MODE` للدفع الإلكتروني.
3. اضغط **Deploy**. بعد أي تعديل على المتغيرات اضغط **Redeploy**.
4. افتح `رابطك/api/public`، يجب أن ترى اسم المنصة. أول زيارة تجهّز قاعدة البيانات تلقائياً.

### لو عندك بيانات قديمة (db.json وuploads)
قبل أول زيارة للموقع: ضع `db.json` في `data/` والملفات في `data/uploads/` على جهازك، واضبط `SUPABASE_URL` و`SUPABASE_SERVICE_ROLE_KEY` في PowerShell ثم شغّل `npm run migrate:supabase`. السكربت يرفض استبدال بيانات موجودة.

## التشغيل على جهازك (ويندوز)
1. ثبّت Node.js (LTS). 2. اضغط مرتين على `start.bat`. 3. احفظ كلمة مرور المعلم التي تظهر في النافذة (أو ضع `TEACHER_PASSWORD` في ملف `.env`). 4. افتح `http://localhost:3000`.
البيانات تُحفظ في فولدر `data/`، خذ منه نسخة احتياطية.

## تسجيل الدخول
- الطالب يسجّل برقم هاتفه ويختار كلمة سر (4 أحرف على الأقل)، وفي مساحة الطالب خياران: **طالب قديم** و**طالب جديد**.
- ولي الأمر يدخل برقم هاتف الطالب ونفس كلمة السر.
- نسيان كلمة السر: من لوحة المعلم اضغط **"كلمة سر جديدة"** على كارت الطالب. والمعلم يبحث عن الطالب بالاسم أو الرقم.
- المشرف: يرقّيه المعلم من كارت الطالب، ويدخل من شاشة دخول الأستاذ بكود الطالب الظاهر في الكارت.

## الدفع
- يدوي: يكتب المعلم طرق الدفع من الإعدادات فتظهر للزوار ويولّد كود الكورس بعد استلام المبلغ.
- إلكتروني (اختياري) عبر Kashier: يظهر زر "ادفع إلكترونياً" ويُفعَّل الكورس تلقائياً بعد نجاح الدفع.

## المساعد الذكي (اختياري)
أضف `GEMINI_API_KEY` من https://aistudio.google.com/apikey. بدونه يعمل التصحيح يدوياً.

لا ترفع `.env` ولا `data/` إلى GitHub.
