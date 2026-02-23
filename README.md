**📄 Xem file PDF tại đây:  
[PERSONAL HEALTH DATA ANALYSIS PROJECT](./PERSONAL%20HEALTH%20DATA%20ANALYSIS%20PROJECT%20.pdf)**

[📥 Tải xuống báo cáo PDF đầy đủ tại đây](./PERSONAL_HEALTH_DATA_ANALYSIS_PROJECT.pdf)
# Dự Án Phân Tích Dữ Liệu Sức Khỏe Cá Nhân

##  1 Tổng Quan Dự Án 

<img width="507" height="409" alt="Ảnh màn hình 2026-02-15 lúc 18 05 01" src="https://github.com/user-attachments/assets/0098e5b1-cb39-4d8a-aadc-2c9bd7ee24c8" />

Đây là một **Personal Health Data Case Study** được thực hiện nhằm phân tích xu hướng vận động và sức khỏe cá nhân trong dài hạn (2021–2025).

Dự án mô phỏng đầy đủ quy trình làm việc của một Data Analyst:

* Trích xuất dữ liệu thô từ thiết bị cá nhân
* Xác định câu hỏi phân tích từ dữ liệu
* Làm sạch và phân tích bằng ngôn ngữ R
* Lưu trữ và truy vấn bằng MySQL
* Xây dựng Dashboard trực quan bằng Excel
* Công khai dự án trên GitHub

Mục tiêu chính:

* Phân tích thói quen vận động trong 5 năm
* Lấy **Step Count** làm biến trung tâm
* Phân tích mối quan hệ giữa:

  * Vận động và nhịp tim (RHR)
  * Vận động và số năng lượng tiêu hao khi vận động
  * Vận động và giấc ngủ
  * Ngày thường và cuối tuần
* Đánh giá xu hướng cải thiện và nâng cao sức khoẻ  
* Đánh giá thói quen vận động từ đó đưa ra đề xuất phù hợp  với cá nhân cụ thể
---

## 2. Dataset

### Nguồn dữ liệu

Dữ liệu được thu thập từ nhiều thiết bị cá nhân:

* Huawei Smart Band 10 
* iPhone 13 Pro Max
* iPhone X

📅 Thời gian dữ liệu: **01/01/2021 – 30/11/2025**

Dữ liệu được export từ ứng dụng Apple Health dưới dạng: File XML (raw data)

###  Quy mô dữ liệu

* Tổng số dòng: **317,360 records**
* Số cột chính: 8–9
* Dữ liệu liên tục trong 5 năm
* Nhiều thiết bị ghi nhận song song

### Các biến chính

| Biến                   | Ý nghĩa                     |
| ---------------------- | --------------------------- |
| StepCount              | Số bước đi (biến trung tâm) |
| ActiveEnergyBurned     | Năng lượng tiêu hao (kcal)  |
| HeartRate              | Nhịp tim                    |
| RestingHeartRate       | Nhịp tim nghỉ               |
| WalkingRunningDistance | Quãng đường                 |
| SleepAnalysis          | Phân tích giấc ngủ          |

---

## 3. Công cụ sử dụng trong dự án
| Công cụ | Vai trò                                             |
| ------- | --------------------------------------------------- |
| RStudio | Làm sạch dữ liệu, phân tích xu hướng, trực quan hóa |
| MySQL   | Xử lý, chuẩn hóa, truy vấn dữ liệu                  |
| Excel   | Pivot Table & Dashboard                             |
| GitHub  | Lưu trữ & công khai dự án                           |

---

## 4. Quy trình chính trong Project

### Bước 1 – Import & Cleaning (RStudio)

* Đọc file XML bằng `xml2`
* Trích xuất thẻ `<Record>`
* Chuyển thành DataFrame
* Chuẩn hóa định dạng ngày giờ
* Gộp dữ liệu theo ngày (energy_daily, sleep_daily)
* Phân tích mối quan hệ vận động – giấc ngủ

### Bước 2 – Phân tích chuyên sâu bằng R

####  Phát hiện “Ngưỡng vàng vận động”

Dữ liệu cho thấy mối quan hệ giữa vận động và giấc ngủ có dạng **phi tuyến (inverted-U shape)**.

* Mức 500–600 kcal/ngày → thời gian ngủ ổn định & tối ưu
* Vận động quá thấp → giấc ngủ biến động mạnh
* Vận động quá cao → không đảm bảo cải thiện giấc ngủ

 Insight: Tối ưu sức khỏe không nằm ở “càng nhiều càng tốt” mà ở mức phù hợp với khả năng phục hồi.

### Bước 3 – Lưu trữ & Truy vấn bằng MySQL

Thực hiện:

* Import CSV vào database
* Chuẩn hóa định dạng DATETIME
* Xóa NULL
* Cast kiểu dữ liệu số
* Loại bỏ trùng lặp
* Tạo bảng `health_cleaned`

Các phân tích SQL chính:

* So sánh tần suất vận động vào 2 ngày cuối tuần
* Truy vấn ngày vận động nhiều nhất & ít nhất
* Số ngày đạt trên 8,000 bước
* Truy vấn mối liên hệ giữa tần suất đi lại và nhịp tim trung bình 

 Phát hiện:

* 30 ngày đạt trên 8,000 bước
* Ngày cao nhất: 27/07/2025 – 19,109 bước
* Trong ngày vận động cao → RHR vẫn thấp và ổn định
* Không có dấu hiệu quá tải tim mạch

---

## 5. Dashboard (Excel)

Dashboard tổng hợp phân tích giai đoạn 2021–2025:

### Số Km đi được qua mỗi năm 

* 2021: 162 km
* 2025: 1,038 km
* Tăng trưởng: +640%
 Cho thấy sự thay đổi mạnh về lối sống theo hướng tích cực.

### Xu hướng đi lại theo tháng

* Đỉnh điểm: Tháng 7 (trên 200 km)
* Thấp điểm: Tháng 2, 5, 6

 Cần cải thiện tính ổn định giữa các quý.

### Cường độ vận động hàng ngày 

* Trung bình 2–4 km/ngày
* Có nhiều ngày vượt 5–6 km
* Kỷ lục: 16 km (27/07/2025)

## 6. Kết luận
### 1. Xu hướng vận động dài hạn

* Sự tăng trưởng đột phá: Tổng quãng đường vận động tăng từ 162 km (2021) lên 1,038 km (2025), tương đương mức tăng trưởng 640%.


* Tính chu kỳ: Tháng 7 hàng năm thường là thời điểm vận động cao nhất (vượt mốc 200 km/tháng).

* Thói quen hằng tuần: Hoạt động dàn trải đều qua các ngày trong tuần, cho thấy vận động chủ yếu đến từ việc di chuyển sinh hoạt thay vì tập luyện tập trung vào cuối tuần.

### 2. Tương quan giữa Vận động và Giấc ngủ

* Ngưỡng vận động tối ưu: Mối quan hệ giữa vận động và giấc ngủ có dạng phi tuyến (inverted-U shape).


 * Phát hiện: Mức vận động vừa phải (khoảng 300 - 400 kcal/ngày) mang lại thời gian ngủ ổn định và tối ưu nhất. Vận động quá ít hoặc quá nhiều đều gây dao động lớn và không có lợi  cho chất lượng nghỉ ngơi.

* 3. Sức khỏe tim mạch
Trong những ngày vận động cường độ cao (trên 8,000 bước), nhịp tim nghỉ (RHR) vẫn duy trì ổn định ở mức thấp.

Điều này chứng minh hệ tim mạch thích nghi tốt với cường độ vận động và cơ thể có khả năng phục hồi tích cực.

### Đề xuất

* Duy trì tính ổn định: Cần cải thiện chỉ số ở các tháng thấp điểm (tháng 2, tháng 6) để đảm bảo sức bền lâu dài thay vì vận động dồn nén.

* Mục tiêu 2026: Dựa trên đà tăng trưởng, đặt mục tiêu tổng quãng đường đạt 1,200 km cho năm tiếp theo.






