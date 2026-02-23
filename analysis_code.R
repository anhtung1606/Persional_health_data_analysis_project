# Chuyển cột ngày tạo và ngày kết thúc về đúng định dạng ngày giờ :
clean_data$startDate <- as.POSIXct(clean_data$startDate)
clean_data$endDate   <- as.POSIXct(clean_data$endDate)
# Gộp năng lượng vận động theo ngày 
energy_daily <- clean_data %>%
  filter(type == "HKQuantityTypeIdentifierActiveEnergyBurned") %>%
  mutate(date = as.Date(startDate)) %>%
  group_by(date) %>%
  summarise(
    active_energy = sum(value, na.rm = TRUE)
  )
# Gộp thời gian ngủ theo ngày 
sleep_daily <- clean_data %>%
  filter(type == "HKCategoryTypeIdentifierSleepAnalysis") %>%
  mutate(
    date = as.Date(startDate),
    sleep_hours = as.numeric(difftime(endDate, startDate, units = "hours"))
  ) %>%
  group_by(date) %>%
  summarise(
    total_sleep = sum(sleep_hours, na.rm = TRUE)
  )
# Dùng Inner_join để kết hợp 2 bảng energy và sleep lại với nhau
energy_sleep <- energy_daily %>%
  inner_join(sleep_daily, by = "date")

# Tạo biểu đồ 
ggplot(energy_sleep, aes(x = active_energy, y = total_sleep)) +
  geom_point(alpha = 0.7) +
  geom_smooth(method = "loess", se = TRUE) +
  labs(
    title = "Ảnh hưởng của vận động trong ngày đến thời gian ngủ",
    x = "Active Energy Burned (kcal)",
    y = "Tổng thời gian ngủ (giờ)"
  ) +
  theme_minimal()
# Chia thành 3 ngưỡng vận động theo energy (low,moderate,high)
energy_sleep <- energy_sleep %>%
  mutate(
    activity_level = case_when(
      active_energy < quantile(active_energy, 0.33) ~ "Low activity",
      active_energy < quantile(active_energy, 0.66) ~ "Moderate activity",
      TRUE ~ "High activity"
    )
  )
ggplot(energy_sleep, aes(active_energy, total_sleep)) +
  geom_point(alpha = 0.7) +
  geom_vline(xintercept = gold_energy, linetype = "dashed", color = "red") +
  annotate(
    "text",
    x = gold_energy,
    y = max(energy_sleep$total_sleep),
    label = "Ngưỡng vàng vận động",
    hjust = 1.2
  ) +
  labs(
    title = "Ngưỡng vận động tối ưu cho giấc ngủ",
    x = "Active Energy Burned (kcal)",
    y = "Tổng thời gian ngủ (giờ)"
  ) +
  theme_minimal()

# Ngưỡng vàng vận động theo biểu đồ là 250-550 calo (Vì ngủ trên 6 tiếng)
# Vận động trên 550 calo ngủ dưới 6 tiếng 


# ---- RHR trung bình theo ngày ----
rhr_daily <- clean_data %>%
  filter(type == "HKQuantityTypeIdentifierRestingHeartRate") %>%
  mutate(date = as.Date(startDate)) %>%
  group_by(date) %>%
  summarise(
    avg_rhr = mean(value, na.rm = TRUE)
  )

rhr_monthly <- rhr_daily %>%
  mutate(month = floor_date(date, "month")) %>%
  group_by(month) %>%
  summarise(
    avg_rhr_month = mean(avg_rhr, na.rm = TRUE)
  )

ggplot(rhr_monthly, aes(x = month, y = avg_rhr_month)) +
  geom_line(alpha = 0.6) +
  geom_point(size = 2) +
  geom_smooth(method = "lm", se = FALSE, linetype = "dashed") +
  labs(
    title = "Xu hướng sức khoẻ tim mạch qua Resting Heart Rate",
    x = "Tháng",
    y = "Resting Heart Rate (bpm)"
  ) +
  theme_minimal()
# Nhịp tim RHR tăng từ August đến September : Có dấu hiệu đang không cải thiện sức khoẻ, bỏ tập




