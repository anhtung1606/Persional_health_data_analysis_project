## 📄 **[XEM FILE PDF PROJECT](./PERSONAL%20HEALTH%20DATA%20ANALYSIS%20PROJECT%20.pdf)**
# 📊 Dự Án Phân Tích Dữ Liệu Sức Khỏe Cá Nhân

##  1 Tổng Quan (Overview)

<img width="507" height="409" alt="Ảnh màn hình 2026-02-15 lúc 18 05 01" src="https://github.com/user-attachments/assets/0098e5b1-cb39-4d8a-aadc-2c9bd7ee24c8" />

Đây là một **Personal Health Data Case Study** được thực hiện nhằm phân tích xu hướng vận động và sức khỏe cá nhân trong dài hạn (2021–2025).

Dự án mô phỏng đầy đủ quy trình làm việc của một Data Analyst:

* Xác định câu hỏi phân tích từ dữ liệu
* Trích xuất dữ liệu thô từ thiết bị cá nhân
* Làm sạch và phân tích bằng R
* Lưu trữ và truy vấn bằng MySQL
* Xây dựng Dashboard trực quan bằng Excel
* Công khai dự án trên GitHub

Mục tiêu chính:

* Phân tích thói quen vận động trong 5 năm
* Lấy **Step Count** làm biến trung tâm
* Phân tích mối quan hệ giữa:

  * Vận động và Resting Heart Rate (RHR)
  * Vận động và Active Energy Burned
  * Vận động và giấc ngủ
  * Ngày thường và cuối tuần
* Đánh giá xu hướng cải thiện thể lực theo thời gian

---

## 📁 2. Dataset

### 🔹 Nguồn dữ liệu

Dữ liệu được thu thập từ nhiều thiết bị cá nhân:

* Huawei Smart Band 10 (tháng 7/2025 – đeo liên tục ngày & đêm)
* iPhone 13 Pro Max
* iPhone X

📅 Thời gian dữ liệu: **01/2021 – 30/11/2025**

Dữ liệu được export từ ứng dụng Apple Health dưới dạng:

* File nén
* File XML (raw data)

---

### 🔹 Quy mô dữ liệu

* Tổng số dòng: **317,360 records**
* Số cột chính: 8–9
* Dữ liệu liên tục trong 5 năm
* Nhiều thiết bị ghi nhận song song

---

### 🔹 Các biến chính

| Biến                   | Ý nghĩa                     |
| ---------------------- | --------------------------- |
| StepCount              | Số bước đi (biến trung tâm) |
| ActiveEnergyBurned     | Năng lượng tiêu hao (kcal)  |
| HeartRate              | Nhịp tim                    |
| RestingHeartRate       | Nhịp tim nghỉ               |
| WalkingRunningDistance | Quãng đường                 |
| SleepAnalysis          | Phân tích giấc ngủ          |

Step Count được chọn làm biến trọng tâm vì:

* Xuất hiện xuyên suốt 2021–2025
* Có mặt trên tất cả thiết bị
* Phản ánh trực tiếp mức độ vận động

---

## 🛠 3. Tools & Technologies

| Công cụ | Vai trò                                             |
| ------- | --------------------------------------------------- |
| RStudio | Làm sạch dữ liệu, phân tích xu hướng, trực quan hóa |
| MySQL   | Xử lý, chuẩn hóa, truy vấn dữ liệu                  |
| Excel   | Pivot Table & Dashboard                             |
| GitHub  | Lưu trữ & công khai dự án                           |

Kỹ năng thể hiện:

* Data Cleaning
* SQL (JOIN, GROUP BY, Aggregation)
* Time-series analysis
* Correlation analysis
* Dashboard design
* Data storytelling

---

## 🔄 4. Project Steps

### Bước 1 – Import & Cleaning (RStudio)

* Đọc file XML bằng `xml2`
* Trích xuất thẻ `<Record>`
* Chuyển thành DataFrame
* Chuẩn hóa định dạng ngày giờ
* Gộp dữ liệu theo ngày (energy_daily, sleep_daily)
* Phân tích mối quan hệ vận động – giấc ngủ

---

### Bước 2 – Phân tích chuyên sâu bằng R

#### 🔹 Phát hiện “Ngưỡng vàng vận động”

Dữ liệu cho thấy mối quan hệ giữa vận động và giấc ngủ có dạng **phi tuyến (inverted-U shape)**.

* Mức 500–600 kcal/ngày → thời gian ngủ ổn định & tối ưu
* Vận động quá thấp → giấc ngủ biến động mạnh
* Vận động quá cao → không đảm bảo cải thiện giấc ngủ

👉 Insight: Tối ưu sức khỏe không nằm ở “càng nhiều càng tốt” mà ở mức phù hợp với khả năng phục hồi.

---

### Bước 3 – Lưu trữ & Truy vấn bằng MySQL

Thực hiện:

* Import CSV vào database
* Chuẩn hóa định dạng DATETIME
* Xóa NULL
* Cast kiểu dữ liệu số
* Loại bỏ trùng lặp
* Tạo bảng `health_cleaned`

Các phân tích SQL chính:

* So sánh Weekend vs Weekday
* Ngày vận động nhiều nhất & ít nhất
* Số ngày đạt trên 8,000 bước
* JOIN StepCount & RestingHeartRate

📌 Phát hiện:

* 30 ngày đạt trên 8,000 bước
* Ngày cao nhất: 27/07/2025 – 19,109 bước
* Trong ngày vận động cao → RHR vẫn thấp và ổn định
* Không có dấu hiệu quá tải tim mạch

---

## 📊 5. Dashboard (Excel)

Dashboard tổng hợp phân tích giai đoạn 2021–2025:

### 🔹 Long-term Performance

* 2021: 162 km
* 2025: 1,038 km
* Tăng trưởng: +640%

👉 Cho thấy sự thay đổi mạnh về lối sống theo hướng tích cực.

---

### 🔹 Seasonality (Xu hướng theo tháng)

* Đỉnh điểm: Tháng 7 (trên 200 km)
* Thấp điểm: Tháng 2, 5, 6

👉 Cần cải thiện tính ổn định giữa các quý.

---

### 🔹 Weekly Distribution

* Phân bổ vận động đều trong tuần
* Không có xu hướng “tập bù” cuối tuần
* Vận động chủ yếu đến từ di chuyển hằng ngày

---

### 🔹 Daily Intensity

* Trung bình 2–4 km/ngày
* Có nhiều ngày vượt 5–6 km
* Kỷ lục: 16 km (27/07/2025)

---

## 📈 6. Results & Key Insights

### ✅ Thành tựu

* Tổng quãng đường 5 năm: **2,626 km**
* Tăng trưởng vận động 640%
* Duy trì nhiều ngày đạt chuẩn khuyến nghị (>8,000 steps)

### ✅ Insight chuyên môn

* Vận động cao không làm tăng nhịp tim nghỉ
* Mối quan hệ vận động – giấc ngủ là phi tuyến
* Tháng 7 là giai đoạn thể lực tối ưu
* Tính ổn định quan trọng hơn các ngày đạt đỉnh

---

## 🚀 Business Thinking & Recommendations

1. Duy trì mục tiêu 1,200 km cho năm 2026
2. Cải thiện các tháng thấp điểm
3. Theo dõi thêm chỉ số Aerobic Threshold để tối ưu hiệu suất
4. Tập trung vào tính bền vững dài hạn thay vì đột biến ngắn hạn





