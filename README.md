# Flutter Custom Keyboard

Dự án Flutter này minh họa cách xây dựng **Custom Keyboard** và **3 TabView** (Grammar / Translate / Paraphrasing) theo giao diện giống ứng dụng thực tế, sử dụng **Provider** và kiến trúc sạch (**Clean Architecture**).

## ✨ Tính năng

- **3 Tab chính**:
  - **Grammar**: Kiểm tra ngữ pháp, hiển thị thông báo và nút "Open Keyboard".
  - **Translate**: Danh sách ngôn ngữ với flag/icon.
  - **Paraphrasing**: Danh sách tone/style để biến đổi câu văn.
- **Custom Keyboard**:
  - QWERTY hoặc bàn phím số (Number Keyboard).
  - Giao diện có thể tùy chỉnh màu sắc, kích thước, icon.
- **Clean Architecture + Provider**:
  - Chia tách `data`, `domain`, `presentation`.
  - `ChangeNotifier` để quản lý state.
  - `UseCase` cho xử lý logic.

## 🛠 Công nghệ sử dụng

- [Flutter](https://flutter.dev) (>=3.0)
- [Provider](https://pub.dev/packages/provider)
- Clean Architecture
- Dart null safety

---
