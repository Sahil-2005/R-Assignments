# 🌬️ Air Quality Data Cleaning

> **R Programming - Assignment 1**
> 
> **Dataset:** Beijing Multi-Site Air Quality Data (UCI ML Repository) — Aotizhongxin station

## 📌 Project Overview
This project focuses on identifying and handling missing values within the Aotizhongxin station dataset. Using R, robust data cleaning techniques were applied to various variables:
- **Numeric Variables** (`PM2.5`, `PM10`, `SO2`, `NO2`, `TEMP`, `WSPM`): Imputed using the **median**.
- **Categorical Variables** (`wd` - wind direction): Imputed using the **mode**.

The data processing pipeline utilized core R constructs such as loops, custom user-defined functions, and `tryCatch()` blocks for effective error handling. Following this procedure, all targeted variables successfully reached 0 missing values.

## 📂 Deliverables
| File | Description |
|---|---|
| 📄 `air_quality_cleaning.R` | The main R script containing the implementation for all 10 tasks. |
| 📊 `cleaned_air_quality_data.csv` | The final dataset exported after successful imputation of missing values. |
| 📈 `missing_values_chart.png` | A visual comparison (bar chart) illustrating missing data before and after the cleaning operations. |

---

## 👨‍💻 Connect with the Author

**Sahil Sanjay Gawade**

[![Portfolio](https://img.shields.io/badge/Portfolio-2563EB?style=for-the-badge&logo=vercel&logoColor=white)](https://sahil-gawade.vercel.app/)
[![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/Sahil-2005)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/sahil-gawade-920a0a242/)
[![LeetCode](https://img.shields.io/badge/LeetCode-FFA116?style=for-the-badge&logo=leetcode&logoColor=white)](https://leetcode.com/u/sahilgawade4321/)
[![Gmail](https://img.shields.io/badge/Gmail-EA4335?style=for-the-badge&logo=gmail&logoColor=white)](mailto:gawadesahil.dev@gmail.com)
