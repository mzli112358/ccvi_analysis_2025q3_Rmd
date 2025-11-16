# CCVI 2025Q3 气候冲突脆弱性指数分析报告

## 项目概述

本项目是一个综合性的R Markdown分析报告，基于2025年第三季度CCVI（Climate-Conflict-Vulnerability Index，气候冲突脆弱性指数）完整数据，提供全面的风险评估和可视化分析。

## 什么是CCVI？

CCVI是一个综合评估框架，通过三个核心维度衡量全球各地的风险水平：
- **气候维度 (CLI)**：评估气候变化影响和脆弱性
- **冲突维度 (CON)**：评估武装冲突和暴力风险
- **脆弱性维度 (VUL)**：评估社会经济和制度脆弱性

## 数据特征

- **空间分辨率**：0.5°×0.5°网格（赤道处约55km×55km）
- **时间分辨率**：季度数据（2015年至2025年第三季度）
- **地理覆盖**：全球范围
- **风险等级**：五个等级（很低、低、中等、高、很高）

## 文件结构

```
proj/
├── ccvi_analysis_2025q3.Rmd          # 主分析报告
├── ccvi_analysis_functions.R          # 分析函数库
├── README_CN.md                       # 项目说明（本文件）
├── ccvi-data-main/                    # 数据处理管道
├── ccvi-full-2025-3/                  # 完整数据集
└── ccvi-latest-2025-3/                # 最新数据
```

## 主要功能

### 📊 综合分析报告
- **执行摘要**：全球风险状况概览
- **全球风险评估**：交互式全球风险地图
- **维度分析**：气候、冲突、脆弱性单独分析
- **国别深度分析**：重点国家详细评估
- **统计分析**：相关性分析、主成分分析、聚类分析
- **时间趋势分析**：季度变化趋势
- **风险热点识别**：高风险区域识别
- **政策建议**：基于分析结果的建议

### 🗺️ 可视化功能
- **交互式地图**：使用Leaflet创建可缩放的全球风险地图
- **动态图表**：Plotly和Highcharter交互式图表
- **统计图形**：ggplot2专业统计图表
- **相关性矩阵**：可视化各维度间关系
- **聚类分析图**：风险群体识别

### 📈 输出格式
支持多种输出格式：
- HTML（交互式网页）
- PDF（高质量打印版）
- Word（可编辑文档）
- PowerPoint（演示文稿）

## 快速开始

### 环境要求
```r
# 安装必要的R包
install.packages(c(
  "tidyverse", "data.table", "arrow", "sf", "rnaturalearth", 
  "rnaturalearthdata", "leaflet", "plotly", "highcharter", 
  "DT", "kableExtra", "ggplot2", "ggthemes", "viridis", 
  "RColorBrewer", "corrplot", "psych", "factoextra", "cluster",
  "rmarkdown", "knitr"
))
```

## 数据准备

- **CCVI 完整数据（2025-3）**：下载并解压到项目数据目录（如 `ccvi-full-2025-3/`）。
  - 下载地址：[ccvi-full-2025-3.zip](https://climate-conflict.org/data/download/2025-3/ccvi-full-2025-3.zip)
- **灾害与危险源数据页**：查看各类气候灾害与危险源数据的说明与获取入口。
  - 访问页面：[Hazards 数据页](https://climate-conflict.org/www/data-pages/hazards)

> 提示：下载完成后，请根据你的本地路径在 `ccvi_analysis_2025q3.Rmd` 或相关数据加载脚本中更新数据根路径，确保 `parquet` 与其他输入文件能够被正确读取。

## 核心函数

### 数据加载函数
- `load_parquet()`：高效加载parquet格式数据
- `load_ccvi_data()`：加载CCVI完整数据集
- `clean_ccvi_data()`：数据清洗和预处理

### 分析函数
- `categorize_risk()`：风险等级分类
- `get_regional_classification()`：区域分类
- `identify_hotspots()`：热点区域识别
- `calculate_temporal_trends()`：时间趋势计算
- `perform_clustering()`：聚类分析
- `run_pca_analysis()`：主成分分析

### 可视化函数
- `create_interactive_map()`：交互式地图
- `create_risk_scatter()`：风险散点图
- `plot_correlation_matrix()`：相关性矩阵图
- `plot_temporal_trends()`：时间趋势图

## 分析亮点

### 🔍 全球风险格局
- 识别全球高风险区域分布
- 分析各大洲风险特征差异
- 评估风险聚集效应

### 📊 维度关联分析
- 气候-冲突关联性评估
- 脆弱性因子影响力分析
- 多维度风险交互效应

### 🌍 区域深度分析
- 重点国家风险档案
- 区域风险比较分析
- 次国家级风险评估

### 📈 趋势预测
- 季度风险变化追踪
- 长期趋势识别
- 新兴风险预警


## 输出结果

运行报告后将生成：
- **HTML报告**：完整的交互式分析报告
- **数据文件**：分析结果和中间数据
- **图表文件**：高分辨率图表和地图
- **统计摘要**：关键统计指标

## 注意事项

1. **数据文件路径**：确保parquet数据文件路径正确
2. **内存需求**：处理大型数据集可能需要较多内存
3. **依赖包**：首次运行需要安装所有依赖包
4. **输出格式**：PDF输出需要LaTeX环境支持

## 扩展功能

### 自定义分析
可以通过修改函数参数进行自定义分析：
- 调整风险分类阈值
- 选择特定区域或时间段
- 修改聚类算法参数
- 自定义可视化样式

### 批量处理
支持批量处理多个时间段或区域：
```r
# 批量分析多个季度
quarters <- c("2025Q1", "2025Q2", "2025Q3")
results <- lapply(quarters, analyze_quarterly_data)
```
