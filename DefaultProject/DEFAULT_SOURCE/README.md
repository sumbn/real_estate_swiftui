#  HƯỚNG DẪN SỬ DỤNG DEFAULT SOURCE
Người viết: CycTrung
Ngày cập nhật cuối cùng: 4/5/2023

1. Những thứ cần Setup 
*Trong thư mục NEED_TO_SETUP chứa các thông tin của một app cần phải được config sau đây
- Chọn Project > Chọn version IOS 16.0
- AssetDefault: Di chuyển, coppy các thông gồm có Colors, AccentColor, Các asset default support cho nhiều app...
- Pods: Là các Thư viện cần để tạo ra workspace mặc định, chủ yếu là Realm, Firebase, Kingfisher,...
- InfoApp: Chứa các Info plist cần có để tạo ra app mới

2. CONTROLL APP
*Lưu trữ các source code dùng trong việc quản trị app, trong đó lưu ý các danh mục cụ thể sau đây
- GoogleService-Info.plist: Connect với Firebase
- CONSTANT: Lưu trữ tất cả các giá trị Constant được dùng trong app và hứng dữ liệu từ Firebase
    +Mặc định sẽ dùng temp_manifest.json để parse data, khi muốn dùng Firebase RealmtimeDatabase thì enble USING_MANIFEST trong CONSTANT
    +SwiftyJSON là extension hỗ trợ cho parse data
- APPCONTROLLER: Object giúp quản lý các biến toàn cục trong quá trình điều kiển app
- AppDelegate:  Quản lý vòng đời của app, đồng thời tiến hành yêu cầu quyền truy cập mặc định như Notificaton & AppTracking
=> Trong File [Name]App, cần khởi tạo các giá trị mặc định xem ở DefaultProjectApp.swift


