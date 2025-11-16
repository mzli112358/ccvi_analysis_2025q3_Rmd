++ CCVI 指标目录（中文译本）

CCVI 由 35 个不同的开放数据源中的 43 个指标组成。所有指标均映射到相同的空间与时间网格，并使用标准化评分方法进行转换。

- 说明：以下按“领域 » 分组 → 指标名称（英）”组织；每项包含描述、原始单位、数据时效、来源。

---

- Climate（气候） » Current extreme events（当前极端事件） → Droughts（干旱）
  - 描述：干旱是异常干燥条件持续较长时间的现象。通过影响种植系统、畜牧业和水资源可用性，干旱尤其推动粮食安全与水安全等方面的风险。该指标以过去 12 个月的 SPEI 衡量网格单元的干旱状态。
  - 原始单位：季度最后一个月的 SPEI‑12。
  - 数据时效：2025‑Q3
  - 来源：
    - ERA5‑Drought‑ECMWF Climate Reanalysis
    - MODIS/Terra+Aqua Land Cover Type Yearly L3 Global 0.05 Deg CMG

- Climate（气候） » Current extreme events（当前极端事件） → Heatwaves（热浪）
  - 描述：热浪为至少持续三天的异常高温天气。通过影响死亡率与发病率、劳动生产率、农作物产量等，热浪主要推动与人类健康和粮食安全相关的风险。该指标度量过去 12 个月内网格单元的热浪天数总计。
  - 原始单位：过去 12 个月的热浪天数。
  - 数据时效：2025‑Q3
  - 来源：
    - ERA5‑Land Daily Aggregated ‑ ECMWF Climate Reanalysis

- Climate（气候） » Current extreme events（当前极端事件） → Heavy precipitation（强降水）
  - 描述：强降水事件是在短时间内出现的异常大量降雨。其可危害作物并引发滑坡与暴雨内涝等。该指标显示过去 12 个月内网格单元的强降水天数。
  - 原始单位：过去 12 个月的强降水天数。
  - 数据时效：2025‑Q3
  - 来源：
    - ERA5‑Land Daily Aggregated ‑ ECMWF Climate Reanalysis

- Climate（气候） » Current extreme events（当前极端事件） → Wildfires（野火）
  - 描述：野火为非计划或失控的火灾。其可造成文化损失、破坏作物并产生危害健康的污染。该指标显示过去 12 个月内，至少一次遭受野火影响的网格单元面积（km²）。
  - 原始单位：过去 12 个月内暴露于野火的面积（km²）。
  - 数据时效：2025‑Q3
  - 来源：
    - MOD14A1‑Daily Fires
    - MCD14DL‑Active Fires
    - Land Cover Classification C3S

- Climate（气候） » Current extreme events（当前极端事件） → Floods（洪水）
  - 描述：洪水可推动人口流离失所并破坏作物。该指标统计过去 12 个月内网格单元（或其部分）暴露于洪水的天数。
  - 原始单位：过去 12 个月暴露于洪水的天数。
  - 数据时效：2025‑Q3
  - 来源：
    - GloFAS Historical Streamflow Data

- Climate（气候） » Current extreme events（当前极端事件） → Tropical cyclones（热带气旋）
  - 描述：热带气旋是伴有强风和强降水的旋转风暴。按地区不同也称飓风、台风或气旋。其会破坏作物与建筑环境、推动人口迁移并导致死亡。该指标统计过去 12 个月内网格单元发生的热带气旋次数。
  - 原始单位：过去 12 个月内热带气旋的次数。
  - 数据时效：2025‑Q3
  - 来源：
    - IBTrACS_v4‑Cyclones

- Climate（气候） » Accumulated extreme events（累积极端事件） → Droughts (accumulated)（干旱·累积）
  - 描述：同为干旱，但基于过去 7 年的季度 SPEI‑12 均值，仅计入为负的 SPEI 值，反映近年累积干旱状况。
  - 原始单位：过去 7 年内各季度末负值 SPEI‑12 的均值。
  - 数据时效：2025‑Q3
  - 来源：
    - ERA5‑Drought‑ECMWF Climate Reanalysis

- Climate（气候） » Accumulated extreme events（累积极端事件） → Heatwaves (accumulated)（热浪·累积）
  - 描述：以过去 7 年年内热浪天数的平均计数衡量，反映近年累积热浪暴露。
  - 原始单位：过去 7 年的 12 个月平均热浪天数。
  - 数据时效：2025‑Q3
  - 来源：
    - ERA5‑Land Daily Aggregated ‑ ECMWF Climate Reanalysis

- Climate（气候） » Accumulated extreme events（累积极端事件） → Heavy precipitation (accumulated)（强降水·累积）
  - 描述：以过去 7 年年内强降水天数的平均计数衡量，反映近年累积强降水暴露。
  - 原始单位：过去 7 年的 12 个月平均强降水天数。
  - 数据时效：2025‑Q3
  - 来源：
    - ERA5‑Land Daily Aggregated ‑ ECMWF Climate Reanalysis

- Climate（气候） » Accumulated extreme events（累积极端事件） → Wildfires (accumulated)（野火·累积）
  - 描述：以过去 7 年内，网格单元至少一次遭受野火影响的面积（km²）的年均值衡量。
  - 原始单位：过去 7 年内 12 个月平均暴露于野火的面积（km²）。
  - 数据时效：2025‑Q3
  - 来源：
    - MOD14A1‑Daily Fires
    - MCD14DL‑Active Fires
    - Land Cover Classification C3S

- Climate（气候） » Accumulated extreme events（累积极端事件） → Floods (accumulated)（洪水·累积）
  - 描述：以过去 7 年内网格单元（或其部分）暴露于洪水的年均天数衡量。
  - 原始单位：过去 7 年的 12 个月平均洪水暴露天数。
  - 数据时效：2025‑Q3
  - 来源：
    - GloFAS Historical Streamflow Data

- Climate（气候） » Accumulated extreme events（累积极端事件） → Tropical cyclones (accumulated)（热带气旋·累积）
  - 描述：以过去 7 年内网格单元发生的热带气旋年均次数衡量。
  - 原始单位：过去 7 年的 12 个月平均热带气旋次数。
  - 数据时效：2025‑Q3
  - 来源：
    - IBTrACS_v4‑Cyclones

- Climate（气候） » Shifts in long‑term conditions（长期条件变化） → Mean temperature change（平均气温变化）
  - 描述：描述相对前工业时期（1850‑1900）的温度变化。气温上升与健康、粮食安全等风险相关。该指标比较过去 30 年年均地表气温与 1850‑1900 年的年均地表气温。
  - 原始单位：过去 30 年相对 1850‑1900 的地表气温变化（°C）。
  - 数据时效：2025‑Q2
  - 来源：
    - Berkeley Earth Global Monthly Land + Ocean Temperature Data

- Climate（气候） » Shifts in long‑term conditions（长期条件变化） → Relative sea level rise（相对海平面上升）
  - 描述：相对海平面上升推动海岸侵蚀、极端海水位、淡水盐化等海岸风险，影响生活水平、粮食安全与人口流动。该指标为 1993‑2015 年的年均相对海平面上升速率（mm/年）。
  - 原始单位：1993‑2015 年的平均相对海平面上升（mm/年）。
  - 数据时效：2025‑Q3
  - 来源：
    - Nicholls et al. 2021

- Climate（气候） » Shifts in long‑term conditions（长期条件变化） → Mean precipitation anomaly（平均降水距平）
  - 描述：长期降水异常会对健康、粮食与水安全构成风险。该指标度量过去 30 年相对 1951‑1980 的年均降水异常。
  - 原始单位：过去 30 年相对 1951‑1980 的年均降水异常（%）。
  - 数据时效：2025‑Q3
  - 来源：
    - ERA5‑Land Monthly Aggregated ‑ ECMWF Climate Reanalysis

- Conflict（冲突） » Level of armed violence（武装暴力程度） → Intensity of violence（暴力强度）
  - 描述：衡量武装暴力对人类生命的直接本地效应。暴力致死越多，冲突强度越高。该指标将季度内网格单元的各类武装暴力事件综合而成。
  - 原始单位：过去一季度的死亡人数。
  - 数据时效：2025‑Q3
  - 来源：
    - ACLED（Armed Conflict Location & Event Data Project）

- Conflict（冲突） » Level of armed violence（武装暴力程度） → Surrounding violence（周边暴力）
  - 描述：考虑暴力影响并不限于发生地本身，存在地理扩散与后果外溢（如迁移、经济影响）。该指标基于死亡人数衡量网格单元近邻的平均暴力水平。
  - 原始单位：过去一季度的死亡人数。
  - 数据时效：2025‑Q3
  - 来源：
    - ACLED（Armed Conflict Location & Event Data Project）

- Conflict（冲突） » Level of armed violence（武装暴力程度） → Persistence of violence（暴力持续性）
  - 描述：估计武装暴力的持久程度，反映暴力重复发生的高概率随时间仅逐步下降，且经济与发展影响也仅逐步消退。该指标基于近期历史的暴力活动估计每个网格单元季度的持续性强度。
  - 数据时效：2025‑Q3
  - 来源：
    - ACLED（Armed Conflict Location & Event Data Project）

- Conflict（冲突） » Societal tensions（社会紧张） → Intensity of popular unrest（群体性骚乱强度）
  - 描述：以抗议、骚乱等公众不满表达为代表的骚乱可指示潜在社会紧张，并可能升级为未来的暴力冲突。该指标基于观察到的骚乱事件数量，并考虑国家层面的示威自由度。
  - 原始单位：过去一季度的骚乱事件数。
  - 数据时效：2025‑Q3
  - 来源：
    - ACLED
    - V‑Dem（Varieties of Democracy）

- Conflict（冲突） » Societal tensions（社会紧张） → Surrounding popular unrest（周边群体性骚乱）
  - 描述：与武装暴力类似，骚乱可在其他地区引发进一步骚乱并影响周边区域。该指标基于事件数量与抗议便利度，衡量地理近邻的平均骚乱水平。
  - 原始单位：过去一季度的骚乱事件数。
  - 数据时效：2025‑Q3
  - 来源：
    - ACLED
    - V‑Dem

- Conflict（冲突） » Societal tensions（社会紧张） → Persistence of popular unrest（骚乱持续性）
  - 描述：估计骚乱的持久水平。若潜在问题未解决，骚乱可在较长时期持续或在短暂平静后再现。该指标基于地理近邻的近期骚乱历史估计各网格单元季度的持续性水平。
  - 数据时效：2025‑Q3
  - 来源：
    - ACLED
    - V‑Dem

- Conflict（冲突） » Conflict context（冲突背景） → Conflict actors（冲突行为体）
  - 描述：反映一国冲突格局的复杂性。行为体越多且越活跃，越难解决，长期风险越高。该指标结合一国有组织行为体数量与相对于人口规模的全国冲突严重度。
  - 原始单位：过去一季度在一国活动的有组织行为体数量。
  - 数据时效：2025‑Q3
  - 来源：
    - UCDP GED（Georeferenced Event Dataset）
    - UN WPP（United Nations World Population Prospects）

- Conflict（冲突） » Conflict context（冲突背景） → Country affectedness（国家受影响程度）
  - 描述：衡量一国整体冲突情势的严重程度。暴力越广泛、越强烈，国内的间接风险（如经济或卫生系统恶化）越高。该指标结合受影响国土比例与相对人口的总体致死性。
  - 数据时效：2025‑Q3
  - 来源：
    - ACLED
    - UN WPP

- Vulnerability（脆弱性） » Socio‑economic vulnerability（社会经济脆弱性） → Economic dependence on agriculture（农业经济依赖）
  - 描述：衡量农业对一国经济与居民收入的重要性。依赖度越高，因农业对气候与冲击敏感而脆弱性越高。该指标结合农业就业与农业对 GDP 的贡献。
  - 数据时效：2024‑Q4
  - 来源：
    - 世界银行 WDI（World Development Indicators）
    - ILO 劳动统计（Labor Force Statistics）

- Vulnerability（脆弱性） » Socio‑economic vulnerability（社会经济脆弱性） → Economic deprivation（经济匮乏）
  - 描述：以反向刻度反映本地经济能力。经济能力越低，越难以投资适应、提供救助并吸收冲击。指标基于每个网格单元的（反向）人均 GDP（PPP）。
  - 原始单位：人均 GDP（PPP）。
  - 数据时效：2024‑Q4
  - 来源：
    - VIIRS 夜间灯光（EOG）
    - 世界银行 WDI
    - IMF 国际金融统计
    - WorldPop 人口密度（无约束，联合国校准）

- Vulnerability（脆弱性） » Socio‑economic vulnerability（社会经济脆弱性） → Educational vulnerability（教育脆弱性）
  - 描述：反映教育不足如何增加不良结果的易感性。教育水平越高越能更好准备和应对灾害；越低则脆弱性越高。指标为平均受教育年限（反向刻度）。
  - 数据时效：2023‑Q4
  - 来源：
    - Global Data Lab ‑ 次国家人类/性别发展
    - UNDP 人类发展指数（HDI）

- Vulnerability（脆弱性） » Socio‑economic vulnerability（社会经济脆弱性） → Health vulnerability（健康脆弱性）
  - 描述：反映来自健康与医疗体系不足的不良结果易感性。健康状况影响应对与适应能力；健康状况不佳是脆弱性的重要驱动。指标基于出生时预期寿命（反向刻度）。
  - 原始单位：预期寿命（年）。
  - 数据时效：2023‑Q4
  - 来源：
    - Global Data Lab ‑ 次国家人类/性别发展
    - UNDP 人类发展指数（HDI）

- Vulnerability（脆弱性） » Socio‑economic vulnerability（社会经济脆弱性） → Economic inequality（经济不平等）
  - 描述：反映社会资源分配的不均衡程度。不平等程度高通常意味着弱势群体在适应气候变化、应对气候风险与冲突中的自我保护能力更弱。该指标基于各国收入分配。
  - 数据时效：2024‑Q4
  - 来源：
    - VIIRS 夜间灯光（EOG）
    - WorldPop 人口密度（无约束，联合国校准）
    - SWIID 标准化世界收入不平等数据库
    - geoBoundaries 行政边界数据库

- Vulnerability（脆弱性） » Socio‑economic vulnerability（社会经济脆弱性） → Hunger（饥饿）
  - 描述：反映营养不良的流行程度，即摄入不足以维持正常、积极、健康生活。饥饿削弱人群承受和恢复冲击的能力。该指标基于各国营养不良数据。
  - 原始单位：营养不良人口占比（%）。
  - 数据时效：2023‑Q4
  - 来源：
    - 联合国可持续发展目标指标数据库（UN SDG Indicators）

- Vulnerability（脆弱性） » Political vulnerability（政治脆弱性） → Gender inequality（性别不平等）
  - 描述：指基于性别的不平等对待。歧视性的正式与非正式规范、规则与价值观可能限制女性流动与资源获取，使其更易受灾害影响。该指标综合多项性别不平等指标，考虑政治与社会经济层面的不平等。
  - 数据时效：2023‑Q4
  - 来源：
    - UNDP 性别不平等指数（GII）
    - V‑Dem
    - Global Data Lab ‑ 次国家人类/性别发展

- Vulnerability（脆弱性） » Political vulnerability（政治脆弱性） → Institutional vulnerability（制度脆弱性）
  - 描述：以反向刻度衡量制度可靠性与法治等良政标志。制度薄弱会导致资源分配低效、降低应对与适应能力，并可能激化不满与冲突。该指标基于腐败与法治的外部指数。
  - 数据时效：2024‑Q4
  - 来源：
    - 透明国际 ‑ 腐败感知指数（CPI）
    - 世界银行 WDI
    - V‑Dem

- Vulnerability（脆弱性） » Political vulnerability（政治脆弱性） → Political system vulnerability（政治体制脆弱性）
  - 描述：以反向刻度衡量政治体制中的个人权利与自由，以及其公平性与包容性。自由越少、包容性越弱，政策越不可能覆盖所有群体的诉求与需求，从而增加脆弱性。该指标综合国家层面的选举民主、政治权利与公民自由。
  - 数据时效：2024‑Q4
  - 来源：
    - V‑Dem
    - Freedom House（世界自由度报告）

- Vulnerability（脆弱性） » Political vulnerability（政治脆弱性） → Ethnic marginalization（族群边缘化）
  - 描述：衡量特定族群被排除在政治权力之外的程度。此类排斥会导致资源、服务与机会的不平等，从而提高被排斥群体的脆弱性。该指标结合在地具有相关性的被排斥族群数量与一国少数群体权利保护水平。
  - 数据时效：2021‑Q4
  - 来源：
    - V‑Dem
    - EPR（Ethnic Power Relations）

- Vulnerability（脆弱性） » Demographic vulnerability（人口脆弱性） → Uprooted people（被迫迁徙人口）
  - 描述：反映社会中被迫背井离乡且需要援助的人群。由于融入社会有限且公共支持不足，被迫迁徙人口往往处于脆弱状态，服务可及性有限。该指标为一国内被迫迁徙人口占比。
  - 原始单位：被迫迁徙人口占总人口的比例。
  - 数据时效：2024‑Q4
  - 来源：
    - UN WPP
    - UNHCR 难民人口统计数据库

- Vulnerability（脆弱性） » Demographic vulnerability（人口脆弱性） → Population growth（人口增长）
  - 描述：反映人口对公共与自然资源的压力。快速增长加剧公共资源紧张、就业与资源竞争以及环境压力。指标为人口相对变化，包含全部居民（不论法律地位或国籍）。
  - 原始单位：相对上一季度的变化。
  - 数据时效：2025‑Q3
  - 来源：
    - UN WPP

- Vulnerability（脆弱性） » Demographic vulnerability（人口脆弱性） → Dependent population（抚养人口）
  - 描述：反映非劳动年龄人口（儿童与老年人）对公共资源的压力。其本身更易受灾害影响，且较高的总抚养比会增加劳动力与公共资源的经济压力。指标为抚养人口占劳动年龄人口的比例。
  - 原始单位：15 岁以下与 65 岁以上人口相对 15‑64 岁劳动年龄人口的比例。
  - 数据时效：2025‑Q2
  - 来源：
    - UN WPP

- Vulnerability（脆弱性） » Environmental vulnerability（环境脆弱性） → Soil degradation（土壤退化）
  - 描述：反映土壤生态系统及其服务功能的退化。其会降低水质与土壤生产力并减少植被覆盖，使灾害影响加剧，并使直接依赖生态系统的人群尤为脆弱。指标衡量给定网格单元的土壤退化程度。
  - 数据时效：2020‑Q4
  - 来源：
    - MagPie（农业生产及环境影响模型）
    - Land degradation debt

- Vulnerability（脆弱性） » Environmental vulnerability（环境脆弱性） → Deforestation（森林砍伐/退化）
  - 描述：以森林生态系统退化与服务丧失的近似量度。树木覆盖作为天然缓冲被移除会使地区更易受灾，并减少依赖森林群体的资源可得性。该指标跟踪 2000‑2022 年间的树木覆盖损失。
  - 原始单位：相对 2000 年，网格单元内发生树木覆盖损失的面积占比（%）。
  - 数据时效：2024‑Q4
  - 来源：
    - Global Forest Change

- Vulnerability（脆弱性） » Environmental vulnerability（环境脆弱性） → Biodiversity loss（生物多样性丧失）
  - 描述：反映人类压力导致的生物多样性及相关服务退化。健康且多样的生态系统能降低脆弱性、增强对灾害的韧性，包括提升适应能力、清洁供水与可持续粮食生产。该指标衡量相对自然条件的生物多样性丧失。
  - 原始单位：相对自然状态仍然完好的生物多样性比例（%）。
  - 数据时效：2025‑Q3
  - 来源：
    - MagPie（农业生产及环境影响模型）

- Vulnerability（脆弱性） » Environmental vulnerability（环境脆弱性） → Water stress（水资源紧张）
  - 描述：当可更新淡水几乎或全部被使用时会出现水资源紧张，导致缺水。其常由可用性不足、不可持续利用与基础设施不足共同驱动，并在缺水地区放大气候灾害影响、加剧脆弱性。该指标衡量网格单元的水资源紧张程度。
  - 数据时效：2025‑Q3
  - 来源：
    - Aqueduct 4.0

- Vulnerability（脆弱性） » Environmental vulnerability（环境脆弱性） → Agricultural dependence on rainfall（农业对降雨依赖）
  - 描述：反映农业部门对降雨的直接依赖。灌溉是一种重要的适应方式，可降低对干旱和降雨变化等灾害的脆弱性。该指标为网格单元内雨养耕地占比。
  - 原始单位：网格单元内被分类为雨养的耕地比例（%）。
  - 数据时效：2015‑Q4
  - 来源：
    - Landsat‑Derived Global Rainfed and Irrigated‑Cropland Product 30 m V001


