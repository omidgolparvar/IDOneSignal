<h1 dir='rtl'>
کمک‌دست وان‌سیگنال برای سوییفت
</h1>
<p dir='rtl'>
آقا وان‌سیگنال زد تحریم‌مون کرد!! طوریکه وصل نمیشه تا PlayerID بگیره. برای همین روند ثبت دستگاه توی وان‌سیگنال و بقیه کارایی که باهاش می‌کردیم رو مجبوریم خودمون یجورایی پیاده‌سازی مدیریت کنیم. 
</p>

<hr>

<h2 dir='rtl'>
☝️ قبلا
</h2>
<p dir='rtl'>
روال کلی وان‌سیگنال اینجوری بود (و هست):
<ul dir='rtl'>
  <li>وان‌سیگنال به گوشی میگه می‌خوام با APNs کار کنم. پس یه شناسه دستگاه (یا همون Device Token) بهم بده.</li>
  <li>دستگاه پیام‌های مناسب رو به کاربر نشون میده و ازش اجازه می‌گیره، و بعدش به اپل میگه آقا این دستگاه رو ثبتش کن و یه شناسه دستگاه بده من. در نهایت شناسه رو که گرفت، تحویل کلاینت وان‌سیگنال میده.</li>
  <li>کلاینت وان‌سیگنال وقتی شناسه دستگاه رو گرفت، می‌فرسته سمت سرور وان‌سیگنال (البته بهمراه یه سری اطلاعات دیگه)، تا توی پایگاه داده خودش، یه دستگاه با اطلاعات مربوطه ثبت کنه، و برای اون دستگاه یه شناسه یکتا بسازه. دقت کنین شناسه جدید، مختص خود وان‌سیگنال هست، و برای جای دیگه استفاده نمیشه.</li>
  <li>کارای ثبت دستگاه که تموم شد، و شناسه وان‌سیگنالی دستگاه که ساخته شد، سرور وان‌سیگنال، شناسه ساخته شده رو بعنوان پاسخ درخواست کلاینتش، براش می‌فرسته.</li>
  <li>حالا کلاینت وان‌سیگنال می‌دونه شناسه‌اش توی سرور وان‌سیگنال چیه. و البته این شناسه رو در اختیار شمام قرار میده، تا اگه می‌خواین باهاش کار کنین.</li>
</ul>
</p>


<h2 dir='rtl'>
👇 الان
</h2>
<p dir='rtl'>
الان اتفاقی که افتاده اینه که، وان‌سیگنال مارو تحریم کرده، و ارتباط بین کلاینت وان‌سیگنال، و سرور وان‌سیگنال، توی ایران برقرار نمیشه. پس سرور وان‌سیگنال، از وجود دستگاه با خبر نمیشه، و در نتیجه شناسه‌ای هم براش تولید نمی‌کنه. پس ما هم نمی‌تونیم با استفاده از وان‌سیگنال برای کاربرا نوتیفیکیشن بفرستیم؛ نه بصورت عمومی، و نه بصورت خصوصی.
</p>

<h2 dir='rtl'>
حالا چیکار کنیم؟ 🤔
</h2>
<p dir='rtl'>
مجبوریم اون جای خالی بین کلاینت وان‌سیگنال و سرور وان‌سیگنال رو خودمون پر کنیم. به این صورت که بین اون دوتا بشینیم، درخواست کلاینت رو تحویل بگیریم، و تحویل سرور وان‌سیگنال بدیم. 
چه زندگی داریم آخه؟!... 😕
</p>

<hr>

<h2 dir='rtl'>
توضیحات استفاده
</h2>

<h3 dir='rtl'>ایجاد پروژه در 
<a href='http://idpush.top/'>آی‌دی‌پوش</a>
و دریافت شناسه مربوط به پروژه
</h3>
<p dir='rtl'>اولین قدم برای استفاده از این کتابخانه، ساخت پروژه در سامانه 
<a href='http://idpush.top/'>آی‌دی‌پوش</a>
و دریافت <code>projectID</code> هست.
</p>
<p dir='rtl'>⚠️ حالا فعلا نمی‌تونین پروژه بسازین!! ولی چند روز دیگه سامانه در دسترس همه خواهد بود.</p>

<br>
<h3 dir='rtl'>نصب و اضافه‌کردن به پروژه</h3>
<p dir='rtl'>
با استفاده از CocoaPod خیلی راحت می‌تونین این کتابخونه رو به پروژه خودتون اضافه‌اش کنین.
</p>

```swift
pod 'IDOneSignal'
```

<p dir='rtl'>بعد توی کدتون، برای استفاده، بصورت زیر <code>import</code> کنین:</p>

```swift
import IDOneSignal
```

<br>
<h3 dir='rtl'>پیکربندی</h3>
<p dir='rtl'>
برای پیکربندی، باید اول برین توی وبسایت ما، و بعد از ثبت‌نام و این کارا، یه پروژه تعریف کنین و اطلاعات مورد نیازش رو بهش بدین. بعد سامانه یه <code>projectID</code> بهتون میده. حالا توی نرم‌افزار آی‌او‌اس، کتابخانه رو با استفاده از این <code>projectID</code> پیکربندی می‌کنین.</p>

```swift
IDOneSignal.Setup(projectID: "abcdefghijklmnopqrstuvwxyz")
```

<br>
<h3 dir='rtl'>انجام امور</h3>
<p dir='rtl'>
متد کلی برای انجام امور، بصورت زیر تعریف شده:
</p>

```swift
IDOneSignal.Perform(action: IDOneSignalAction, then callback: (IDOneSignalActionError?, Any?) -> Void)
```

<ul dir='rtl'>
  <li>پارامتر <code>action</code> از نوع <code>IDOneSignalAction</code> هست، که در واقع یکی از گزینه‌های این  <code>enum</code> هست:
  </li>
</ul>

```swift
public enum IDOneSignalAction {
    case addDevice(token: String)
    case subscribe
    case unsubscribe
    case setTags(tags: [String: Any])
    case editDevice(parameters: [String: Any])
}
```
<ul dir='rtl'>
  <li>پارامتر <code>callback</code> هم از نوع <code dir='ltr'>(IDOneSignalActionError?, Any?) -> Void</code> هست که در واقع یه <code>Closure</code> هست که نتیجه اون عمل رو برمیگردونه. خودش دوتا پارامتر داره. اولی خطای احتمالی رو مشخص می‌کنه، و دومی داده دریافتی احتمالی رو. اون خطای احتمالی، یکی از خطاهای زیر خواهد بود:
  </li>
</ul>

```swift
public enum IDOneSignalActionError: Error, CustomStringConvertible {
    case missingDeviceToken
    case missingPlayerID
    case isNotConfigured
    case invalidResponse
    case custom(message: String)
}
```

<br>
<h3 dir='rtl'>
گرفتن شناسه وان‌سیگنالی دستگاه
</h3>
<p dir='rtl'>
اگه همه‌چی درست و بدون مشکل انجام بشه، و دستگاه بواسطه سرور، بدون مشکل توی وان‌سیگنال ثبت بشه، شما برای گرفتن <code>PlayerID</code> مربوط به وان‌سیگنال، از کد زیر می‌تونین استفاده کنین:
</p>

```swift
let playerID = IDOneSignal.GetPlayerID()
```

<p dir='rtl'>
⚠️ 
دقت داشته باشین، مقداری که این متد برمی‌گردونه از نوع <code dir='ltr'>String?</code> هست؛ و اگه مشکلی پیش اومده باشه، یا دستگاه بدرستی ثبت نشده باشه، مقدار این متغیر برابر <code>nil</code> خواهد بود.
</p>
<br>
<hr>

<h2 dir='rtl'>توضیحات تکمیلی</h2>

<p dir='rtl'>بطور کلی روند پیاده‌سازی Apple Push Notification میشه اینجوری:</p>

<h3 dir='rtl'>تنظیمات مورد نیاز توی خود پروژه</h3>
<p dir='rtl'>توی ایکس‌کد، توی قسمتی که تنظیمات کلی پروژه هست، میریم به قسمت Capabilities و گزینه‌های Push Notifications و گزینه Background Mode و گزینه Remote Notifications (از زیرگزینه‌های Background Mode) رو فعال می‌کنیم.</p>

<br>
<h3 dir='rtl'>پیکربندی کتابخانه برای استفاده</h3>

<p dir='rtl'>اول از همه کتابخانه رو <code>import</code> کنین:</p>

```swift
import IDOneSignal
```

<p dir='rtl'>بعد توی پروژه‌تون با استفاده از کد زیر، کتابخانه رو با <code>projectID</code> دریافتی‌تون، پیکربندی می‌کنین.</p>

```swift
IDOneSignal.Setup(projectID: "abcd...")
```

<br>
<h3 dir='rtl'>پیکربندی نرم‌افزار با استفاده از API سیستم عامل iOS</h3>
<p dir='rtl'>توی اپ، باید به سیستم عامل بگین که اپ می‌خواد از قابلیت Push Notification استفاده کنه، و امور مربوط به این روند رو انجام بدین.</p>
<p dir='rtl'>معمولا روند اینه که توی فایل <code>AppDelegate</code> این روند رو قرار میدن، تا کارای مورد نیاز، در زمان باز شدن اپ انجام بشه.</p>
<p dir='rtl'>قطعه کد زیر، کدهای مربوط به ثبت دستگاه برای دریافت شناسه یکتا برای APNS، و نیز ثبت نرم‌افزار برای نمایش این اعلان‌ها به کاربر است. برای این کار ابتدا از کاربر برای نمایش اعلان اجازه گرفته میشه، و بعد نمایش اعلان‌ها براساس اجازه کاربر نمایشه داده خواهد شد (یا نخواهد شد).</p>

```swift
application.registerForRemoteNotifications()
UNUserNotificationCenter.current().delegate = self
UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (_, _) in
    print("Permission granted: \(granted)")
}
```

<p dir='rtl'>کدی که بالا نوشته شده، برای نسخه ۱۰ به بعد iOS هست. از نسخه ۱۰، یه فریم‌ورک جدید معرفی و اضافه شده که باید از اون استفاده بشه. پس این رو هم فراموش نکنین:</p>

```swift
import UserNotifications
```

<h4 dir='rtl'>⚠️ توجه داشته باشین ⚠️</h4>
<p dir='rtl'>اگه اپ شما برای نسخه‌های قبل از ۱۰ هست، کدها متفاوت خواهند بود. توی اینترنت با یه سرچ کوچک، می‌تونین کدهای مورد نیاز برای نسخه‌های قدیمی آی‌او‌اس رو هم پیدا کنین.</p>


<br>
<h3 dir='rtl'>دریافت شناسه دستگاه و استفاده از اون</h3>
<p dir='rtl'>یه متدی توی <code>UIApplicationDelegate</code> هست که برای این کار در نظر گرفته شده و مورد استفاده قرار می‌گیره:</p>

```swift
func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    let tokenChars = (deviceToken as NSData).bytes.bindMemory(to: CChar.self, capacity: deviceToken.count)
    var tokenString = ""
    for i in 0..<deviceToken.count {
        tokenString += String(format: "%02.2hhx", arguments: [tokenChars[i]])
    }
    print("APNs Token:", tokenString)

    IDOneSignal.Perform(action: .addDevice(token: tokenString)) { (error, data) in
        if let error = error {
            print("IDOneSignal.AddDevice: Error: \(error.description)")
            return
        }

        guard let playerID = IDOneSignal.GetPlayerID() else { return }
        print("IDOneSignal.AddDevice: Done: \(playerID)")
    }
}
```

<p dir='rtl'>توی این قطعه کد، شناسه که توسط این متد در اختیار ما قرار گرفت، با استفاده از <code>IDOneSignal</code> و اکشن <code dir='ltr'>addDevice(token: String)</code> این شناسه رو ثبت می‌کنیم. اگه توی <code>Closure</code> ادامه‌اش، خطایی رخ نداده باشه، <code>playerID</code> وان‌سیگنالی این دستگاه از طریق اون <code dir='ltr'>guard let ... else { ... }</code> قابل بررسی و دریافت خواهد بود.</p>

<br>

<h2 dir='rtl'>تمام</h2>
<p dir='rtl'>😎✋</p>