# 📊 Dự Án Phân Tích Dữ Liệu Sức Khỏe Cá Nhân

## 🧭 Tổng Quan (Overview)

<img width="488" height="420" alt="Ảnh màn hình 2026-02-15 lúc 17 59 27" src="https://github.com/user-attachments/assets/59fa818f-946f-44fc-87d2-0264b341903f" />


Đây là dự án phân tích dữ liệu sức khỏe cá nhân được thu thập từ điện thoại và thiết bị đeo thông minh.

Mục tiêu của dự án là mô phỏng **quy trình làm việc thực tế của một Data Analyst**, bao gồm:

* Xuất dữ liệu thô (XML) từ điện thoại
* Làm sạch và xử lý dữ liệu bằng R
* Lưu trữ và truy vấn dữ liệu bằng MySQL
* Xây dựng Dashboard tổng quan bằng Excel
* Triển khai và trình bày dự án trên GitHub

Dự án thể hiện khả năng làm việc với **dữ liệu thô → xử lý → lưu trữ → phân tích → trực quan hóa → rút ra insight** theo quy trình chuyên nghiệp.

## 📁 Dataset (Bộ Dữ Liệu)

**Nguồn dữ liệu:**

* Apple Health / Smart Band (xuất file XML)
* Thời gian thu thập: 07/2025 – 08/2025
* Dữ liệu ghi nhận liên tục ngày và đêm

**Các chỉ số chính:**

| Thuộc tính             | Mô tả               |
| ---------------------- | ------------------- |
| StepCount              | Số bước đi          |
| HeartRate              | Nhịp tim (BPM)      |
| RestingHeartRate       | Nhịp tim nghỉ       |
| DistanceWalkingRunning | Quãng đường         |
| ActiveEnergyBurned     | Lượng calo tiêu hao |
| FlightsClimbed         | Số tầng leo         |
| StartDate / EndDate    | Thời gian ghi nhận  |
| Device / Source        | Nguồn thiết bị      |

Dữ liệu ban đầu ở định dạng **XML**, sau đó được chuyển đổi sang **CSV** để xử lý.

---

## 🛠 Công Cụ Sử Dụng

* **RStudio** → Làm sạch & tiền xử lý dữ liệu
* **MySQL Workbench** → Thiết kế database & truy vấn SQL
* **Microsoft Excel** → Xây dựng Dashboard
* **GitHub** → Lưu trữ và quản lý dự án

Kỹ năng thể hiện trong dự án:

* Data Cleaning
* Data Transformation
* SQL (GROUP BY, JOIN, Aggregation, Date Filtering)
* Phân tích chuỗi thời gian (Time-series)
* Thiết kế Dashboard
* Data Storytelling


## 🔄 Quy Trình Thực Hiện (Steps)

### Bước 1 – Xác định câu hỏi phân tích

Một số câu hỏi chính:

* Trung bình mỗi ngày tôi đi bao nhiêu bước?
* Ngày nào vận động nhiều nhất / ít nhất?
* Cuối tuần có khác ngày thường không?
* Có mối liên hệ giữa số bước và nhịp tim không?

### Bước 2 – Trích xuất dữ liệu

* Xuất file XML từ điện thoại
* Chuyển đổi XML → CSV
* Kiểm tra cấu trúc dữ liệu

### Bước 3 – Làm sạch dữ liệu bằng R

Thực hiện trong RStudio:

* Chuẩn hóa định dạng ngày giờ
* Lọc các thuộc tính cần thiết (Step, HeartRate,...)
* Loại bỏ dữ liệu trùng lặp
* Kiểm tra giá trị thiếu
* Xuất file dữ liệu sạch

### Bước 4 – Phân tích bằng MySQL

* Tạo database
* Import dữ liệu đã làm sạch
* Chuyển đổi kiểu dữ liệu sang DATETIME
* Tổng hợp số bước theo ngày
* Lọc dữ liệu cuối tuần
* Xác định ngày vận động cao nhất & thấp nhất
* Chuẩn bị dữ liệu để phân tích tương quan Step – Heart Rate

Các thao tác SQL tiêu biểu:

* GROUP BY theo ngày
* Lọc step > 6000
* So sánh Weekend vs Weekday
* Truy vấn tổng hợp

## 📊 Dashboard

Dashboard Excel bao gồm:

✔ Tổng số bước
✔ Trung bình bước/ngày
✔ Ngày hoạt động nhiều nhất
✔ Ngày hoạt động ít nhất
✔ Biểu đồ xu hướng số bước
✔ Biểu đồ nhịp tim
✔ So sánh cuối tuần – ngày thường

Dashboard được thiết kế theo hướng:

* Trình bày KPI rõ ràng
* Dễ đọc với nhà quản lý
* Tập trung vào insight thay vì chỉ hiển thị biểu đồ


## 📈 Kết Quả & Insight

Một số phát hiện chính:

* Số bước dao động đáng kể giữa các ngày
* Cuối tuần có xu hướng vận động khác ngày thường
* Những ngày có số bước cao thường đi kèm nhịp tim tăng
* Tính ổn định trong vận động quan trọng hơn các ngày “đột biến”

Dự án chứng minh khả năng:

* Xử lý dữ liệu thô
* Thiết kế & quản lý database
* Viết truy vấn SQL
* Phân tích dữ liệu thực tế
* Chuyển dữ liệu thành insight có giá trị
* Trình bày kết quả theo phong cách business

## 🚀 Ý Nghĩa Dự Án

Đây không chỉ là dự án theo dõi sức khỏe cá nhân.

Đây là một **case study Data Analyst hoàn chỉnh**, mô phỏng đúng quy trình làm việc trong doanh nghiệp:

Dữ liệu thô → Làm sạch → Database → Truy vấn → Trực quan hóa → Insight

Dự án thể hiện khả năng làm việc độc lập và tư duy phân tích toàn diện.

## 👤 Tác Giả

**Tùng Bùi**
Data Analyst (Intern)
Kỹ năng trọng tâm: SQL • Data Cleaning • Dashboard • Analytics Workflow


