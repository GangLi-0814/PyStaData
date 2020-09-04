## 2020: 19-20 August, Online

|Theme|Intro|Description|
|:---:|:---:|:---:|
|使用 Stata 获取与处理COVID-19数据|Hua Peng StataCorp LLC|快速数据获取和分析是公共卫生决定的基础。我们将展示Stata中各种获取数据的工具包， 及其在获取与处理 COVID-19 数据中的应用。|
|混频回归方法与Stata应用|王群勇 南开大学|常见变量的抽样频率并不统一，比如GDP经常是季度的，而通胀率是月度的，金融市场数据往往是日度的。混频数据回归是用低频变量对高频变量回归，通过数据驱动的方法对高频变量的不同期赋权以提高精确预测的一种方法，在宏观经济预测中得到越来越广泛的应用。本文介绍混频回归模型及 Stata 的新指令：`midasreg`。这一指令允许对多种不同频率的数据进行回归，包含了 STEP、PDL、Beta 等多种加权函数，兼容 `estat`、`predict` 等Stata的标准指令。|
|跨度回归、偏度回归与峰度回归及Stata应用（Spread Regression, Skewness Regression and Kurtosis Regression Using Stata）|陈强 山东大学|Quantile regression provides a powerful tool to study the effects of covariates on key quantiles of conditional distribution. Yet we often still lack a general picture about how covariates affect the overall shape of conditional distribution. Using quantile-based measures of spread, skewness and kurtosis, we propose spread regression, skewness regression and kurtosis regression as empirical tools to quantify the effects of covariates on the spread, skewness and kurtosis of conditional distribution. While spread regression can be implemented by official Stata command "iqreg", we provide new Stata commands "skewreg" and "kurtosisreg" for skewness regression and kurtosis regression respectively, and illustrate them with an example of the U.S. wage data with substantive findings.|
|基于Stata模拟的内生性来源及其应对|陈传波 中国人民大学|内生性虽然是一个老生常谈的话题，但仍然很容易在建模的过程中被忽略。通过统一的框架和简单的 Stata 程序模拟，我们展示了自选择偏误、联立因果、遗漏变量、测量误差等如何导致内生性。并结合通俗易懂的案例展示控制变量、差分估计、工具变量、断点回归、匹配等方法在什么条件下，以及如何克服内生性，并获得一致估计。|
|Measuring technical efficiency and total factor productivity change with undesirable outputs in Stata|王道平 上海财经大学|近年来，在效率和生产率分析中考虑非合意产出已成为一个重要的研究方向。与此相对应，在效率与生产率分析领域也逐渐发展出很多可以同时考虑合意和非合意产出的新模型。本文与大家分享效率与生产率的非参数前沿估计方法和应用，及与厦门大学杜克锐老师共同撰写的Stata新指令：`teddf` 和 `gtfpch` 。这两个指令适用于估计含有非合意产出的决策单元的效率和生产率，涵盖了多种基于方向距离函数的非参数前沿模型。|
|Call Stata from Python|Zhao Xu StatCorp LLC|Stata 16 introduces tight integration with Python, allowing users to embed and execute Python code from within Stata. In this talk, I will demonstrate new functionality we have been working on -- calling Stata from within Python. We are working on providing two ways to let users interact with Stata from within Python: the IPython magic commands and a suite of API functions. With those utilities, you will be able to run Stata conveniently from Python environments, such as Jupyter Notebook/console, Jupyter Lab/console, Spyder IDE, or Python launched from a Windows Command Prompt, Unix terminal, etc.|
|平滑转换模型与Stata应用|王群勇 南开大学|平滑转移模型描述了变量之间在两种或多种状态之间的转换关系，状态之间通过平滑转移函数来实现。这一模型在宏观经济和金融市场中得到广泛应用。比如，石油价格与经济波动、银行业与经济发展等。本文介绍平滑转换模型的设定和相关检验，以及 Stata 的新程序：`stregress` 。这一指令适用于时间序列、截面数据和面板数据，包含了 LSTR、ESTR、NSTR、L2STR 等多种转换函数，以及模型的线性性、残差的序列相关、参数常数特征等多种检验。|
|Causal Mediation|金承刚 北京师范大学|干预或暴露的效应估计的是一个常见的效果评价，是一个重要的因果推断统计分析内容。为了进一步理解作用机理或作用路径改进干预策略，中介效应成为社会发展学科和流行病学的研究的重要研究内容之一，并形成不同的流派。Causal Mediation 则是从counterfactual 的框架出发，处理 exposure-mediating confounding, exposure-outcome confounding 和对 mediating-outcome confounding 进行敏感度检验。|
|合成控制法安慰剂检验改进研究——基于标准化处理效应和非拒绝域的统计推断|连玉君 中山大学|合成控制法的统计推断主要依赖于以置换检验 (Permutation test) 为基本思想的「安慰剂检验」，但该方法存在严重的过度拒绝和显著性追逐问题。本文通过「准标准化」转换来惩罚安慰剂检验过程中的噪音成分，以避免干预后政策效果分布的非一致性问题，从而保证我们可以在不删除观察值的情况下实施安慰剂检验。上述改进可以克服传统统计量面临的过度拒绝和显著性追逐问题。研究发现：(1) 通过进行安慰剂检验标准化处理，能够有效地降低随机冲击的异方差性以及估计偏误造成的过度拒绝问题；(2) 安慰剂检验标准化处理能够使得干预后时期处理组与潜在控制组的政策效果分布满足一致性，避免对于显著性结果的追逐问题；(3) 基于标准化处理结果，我们能够在相对干净的数据条件下，通过使用bootstrap法构造政策效果的「非拒绝域」，从而保证了合成控制法的统计推断框架能与传统统计推断保持一致。|

## 2020: 16 August in Wuhan
|Theme|Intor|Description|
|:---:|:---:|:---:|
|Stata与Python的融合应用|StataCorp  LLC   Hua  Peng|与Python的融合应用是Stata16的一个新功能。它使得Stata可以自由地运行Python程序。我们将通过一系列实例来演示这一功能带来的各种拓展Stata以及Python的可能性。|
|中文地图与Stata|中南财经政法大学   李春涛|我们将介绍Stata读取Baidu地图和高德地图信息体统的基本原理，以及我们开发的系列地图命令，他们是：cngcode，把中文地址转换为经纬度；cnaddress，将经纬度转化为中文标志性地理位置；cntraveltime，计算两个地理位置之间的交通距离（可以选择不同的交通模式）；cnmapsearch，搜索给定位置附近几公里范围内的地铁站、医院、咖啡厅、烧烤摊等各种地理关键词。这些命令为实证研究的地理和交通问题提供极大的便利，在金融学、经济学、社会学中有广泛的应用前景。|
|Using Stata 16's lasso features for prediction and inference|StataCorp  LLC   Di  Liu|Lasso and elastic net are two popular machine-learning methods. In this presentation, I discuss Stata 16's new lasso features for prediction and inference. I will demonstrate how lasso-type techniques can be used for prediction with linear, binary, and count outcomes. I will then show why these methods are effective and how they work. The increasing availability of high-dimensional data and increasing interest in more realistic functional forms have sparked a renewed interest in automated methods for selecting the covariates to include in a model. I discuss the promises and perils of model selection and pay special attention to some new estimators that provide reliable inference after model selection.|
|新冠疫情数据的可视化与建模方法|武汉大学   肖光恩|自2019年新冠病毒感染病例被发现以来，新冠疫情的全球传播就受到广泛的关注。本次讲座首先梳理了新冠疫情数据的可视化的基本方法，从而探寻了新冠疫情在全球传播的时间特征和空间特征；然后介绍一种新冠疫情流行趋势预测的建模方法，以更好地调整新冠疫情防控的政策，最后总结了新冠疫情数据分析应该注意的事项。|



## 2019: 20–21 August in Shanghai
|Theme|Intro|Description|
|:---:|:---:|:---:|
|Using Python within Stata|Hua Peng   Director  StataCorp LLC|Users may extend Stata's features using other programming languages such as Java and C. New in Stata 16, Stata has tight integration with Python, which allows users to embed and execute Python code from within Stata. I will discuss how users can easily call Python from Stata, output Python results within Stata, and exchange data and results between Python and Stata, both interactively and as sub-routines within do-files and ado-files. I will also show examples of the Stata Function Interface (sfi); a Python module provided with Stata which provides extensive facilities for accessing Stata objects from within Python.|
|Stata在公司投融资研究中的应用|覃家琦 南开大学教授|投融资行为对于公司而言至关重要，至今公司投融资研究主题有哪些？主流的投融资研究主题涉及哪些实证技术或难题？Stata是如何解决这些技术或难题的？未来趋势有哪些？|
|分位数回归：横截面、面板与工具变量法|陈强  山东大学教授|分位数回归在经济、金融与社会科学中有着日益广泛的用途。本演讲从总体分位数、样本分位数开始，介绍基本的横截面分位数回归，乃至最前沿的面板分位数与分位数工具变量法，以及相应的 Stata 操作与案例。|
|Using lasso and related estimators for prediction|Di Liu Senior Econometrician StataCorp LLC|Lasso and elastic net are two popular machine-learning methods. In this presentation, I will discuss Stata 16's new features for lasso and elastic net, and I will demonstrate how they can be used for prediction with linear, binary, and count outcomes. We will discover why these methods are effective and how they work.|
|Inference after lasso model selection|Di Liu Senior Econometrician StataCorp LLC|The increasing availability of high-dimensional data and increasing interest in more realistic functional forms have sparked a renewed interest in automated methods for selecting the covariates to include in a model. I discuss the promises and perils of model selection and pay special attention to some new estimators that provide reliable inference after model selection.|
|非参数计量经济方法（核回归，局部线性回归）|王群勇 南开大学教授|模型错误设定是计量经济分析的常见问题，非参数和半参数方法估计具有稳健、弹性的优良特征。本文介绍了核回归和局部线性回归等非参数、半参数计量经济模型的估计和设定检验，包括局部估计（local estimation）和整体估计（global estimation），以及这些方法在 Stata 中的应用|
|Fixed effect panel threshold model for unbalanced panel|王群勇 南开大学教授|目前的**固定效应面板数据门限模型**只适用于平衡面板，在将非平衡面板转为平衡面板时可能造成较大样本选择偏差。我们基于目前的 `xthreg` 指令提出改进的指令 `xthreg2`，该指令利用聚类野蛮自举（cluster wild bootstrap）估计非平衡面板数据的固定效应门限模型。本文利用蒙特卡洛模拟的方法考察不同情形下聚类野蛮自举的有效样本特征。|
|Stata 在外汇市场实证中的应用|丁剑平 上海财经大学教授|Stata 的几个关键命令在外汇市场**时间序列数据的频率切换**比较运用。在各国汇率制度比较的面板数据中，Stata 的几个关键命令是如何获得“物以类聚”实际制度归类的。以最好的Stata的“拼图”获得审稿人好印象。|
|人工智能+ Stata|陈堰平 微软 人工智能解决方案架构师|大数据时代，数据量越来越大，数据的类型也越来越丰富，如何处理图像、声音、文本等非结构化数据，是计量经济学科研工作者面临的的一大挑战。借助于微软云端的人工智能平台，Stata 的用户仅用几行代码就可以调用强大的算法完成上述任务，**将非结构化数据转化为结构化数据**，并引入到计量经济学模型中，帮助用户做出让人眼前一亮的科研成果。|
|A quick tour of new reporting features in Stata 16|Hua Peng   Director  StataCorp LLC|Stata's commands for report generation allow you to create complete Word, Excel, PDF, and HTML documents that include formatted text, as well as summary statistics, regression results, and graphs produced by Stata. In this talk, we will go over the new features in Stata 16 for generating reproducible reports.|

## 2018: 19–20 August in Foshan City
|Theme|Intro|
|:---:|:---:|
|大数据、高维回归与 Stata|陈强 山东大学教授|
|Spatial autoregressive models using Stata|刘迪 StataCorp LP 经济学专家|
|政策评估与因果推断：Stata 应用概述|王群勇 南开大学教授|
|断点回归|连玉君 中山大学副教授|
|Report generation with `putdocx`, `putexcel`, `putpdf`, and `dyndoc`|彭华 StataCorp LP 软件工程总监|
|回归分析集成输出解决方案|李春涛 华中科技大学教授|
|内含资本成本的计算|顾俊 深圳大学会计与金融博士|
|样本选择问题与处理|王群勇 南开大学教授|
|DSGE 在 Stata 中的应用|许文立 安徽大学经济学博士|


## 2017: 19–20 August in Wenzhou

|Theme|Intro|
|:---:|:---:|
|Stata 15 新版本发布及新功能研讨|彭华 StataCorp LP 软件工程总监|
|内生性问题：方法及进展|连玉君 中山大学副教授|
|进阶回归分析中的Stata应用|王存同 中央财经大学|
|`putdocx`与格式化输出|李春涛 中南财经政法大学|
|unicode与中文编码|彭华 StataCorp LP 软件工程总监|
|Stata函数|彭华 StataCorp LP 软件工程总监|
|`subinfile`网页源代码分析的神器|薛原 爬虫俱乐部|
|Stata自动化报告与可重复研究|陈堰平 雪晴数据网|
|分词与情感分析|薛原 爬虫俱乐部|
|文本分析在量化文史学研究中的应用—以《唐书》与《红楼梦》为例|俞俊利 上海交通大学|
|Stata、cURL交互与网络爬虫|彭文威 香港科技大学|
|Stata数据清洗常用技巧|彭文威 香港科技大学|
|Econometric convergence test and club clustering using Stata|杜锐 山东大学|


## USA 2020

### Session 1: Methods and implementations

#### Better predicted probabilities from linear probability models with applications to multiple imputation

Abstract: Although logistic regression is the most popular method for regression analysis of binary outcomes, there are still many attractions to using least-squares regression to estimate a linear probability model. A major downside, however, is that predicted “probabilities” from a linear model are often greater than 1 or less than 0. That can be problematic for many real-world applications. As a solution, we propose to generate predicted probabilities based on a linear discriminant model, which Haggstrom (1983) showed could be obtained by rescaling coefficients from OLS regression. ...(Read more)
Additional information:
us20_Allison.pdf

Paul Allison
Statistical Horizons LLC

#### Implementing quantile selection models in Stata

Abstract: This presentation describes qregsel, a community-contributed command to implement a copula-based sample-selection correction for quantile regression recently proposed by Arellano and Bonhomme (2017). We illustrate the use of qregsel with an empirical example using the data employed in the Stata base reference manual for the heckman command.
Additional information:
us20_Siravegna.pdf

Mariel Siravegna
Georgetown University

#### Expanding Stata's capabilities for sensitivity analysis

Abstract: Nonexperimental approaches to estimating treatment effects often balance observable characteristics to minimize potential for bias. Rosenbaum (2002) recommends a sensitivity analysis to test the assumption that a study is free from hidden bias once such balance is achieved. There are currently two Stata commands that can implement this sensitivity test: mhbounds and rbounds. ...(Read more)
Additional information:
us20_Litwok.pptx

Daniel Litwok
Abt Associates

#### StataCorp presentation: Meta-analysis using Stata

Abstract: Meta-analysis combines results of multiple similar studies to provide an estimate of the overall effect. This overall estimate may not always be representative of a true effect. Often, studies report results that vary in magnitude and even direction of the effect, which leads to between-study heterogeneity. And sometimes the actual studies selected in a meta-analysis are not representative of the population of interest, which happens, for instance, in the presence of publication bias. Meta-analysis provides the tools to investigate and address these complications. Stata has a long history of meta-analysis methods contributed by Stata researchers. In my presentation, I will introduce Stata's new suite of commands, meta, and demonstrate it using real-world examples.
Additional information:
us20_Assaad (https:)

Houssein Assaad
StataCorp

### Session 2: Financial data

#### Economic forecasting with multiequation simulation models
Abstract: Capturing interdependencies among many variables is a crucial part of economic forecasting. We show how multiple estimated equations can be solved simultaneously with the Stata forecast command and how to simulate the system through time to produce forecasts. This can be combined with user-defined exogenous variables, so that different assumptions can be used to create forecasts under different scenarios. Techniques for assessing the quality of both ex post and ex ante forecasts are shown, along with a simple example model of the U.S. economy.
Additional information:
us20_Price.pptx

Calvin Price
MUFG Bank

#### Applications of generalized structural equation modeling for enhanced credit risk management
Abstract: The integration of the generalized structural equation modeling (GSEM) framework to widely used statistical packages like Stata offers significant opportunities for credit risk management. GSEM techniques bring to bear a modular and all-inclusive approach to statistical model building. We illustrate the “game changing” potential of the GSEM framework with an application to credit risk stress testing and loss forecasting for a representative portfolio of mortgages originated over the past 20 years. ...(Read more)
Additional information:
us20_Canals-Cerdá.pdf

José Canals-Cerdá
Federal Reserve Bank of Philadelphia

#### Event studies with daily stock returns in Stata: Which command to use?
Abstract: This presentation provides an overview on existing user-written commands for executing event studies. By conducting a review of articles that appeared in the past 10 years in 3 leading accounting, finance, and management journals and by assessing which commands could have been used to conduct these studies, I argue that currently only my command eventstudy2 provides sufficient flexibility to conduct a broad range of state-of-the-art event studies. ...(Read more)
Additional information:
us20_Kaspereit.pdf

Thomas Kaspereit
Universite du Luxembourg

#### StataCorp presentation: Call Stata from Python

Abstract: Stata 16 introduced tight integration with Python, allowing users to embed and execute Python code from within Stata. In this talk, I will demonstrate new functionality we have been working on—calling Stata from within Python. We are working on providing two ways to let users interact with Stata from within Python: the IPython magic commands and a suite of API functions. With those utilities, you will be able to run Stata conveniently from Python environments, such as Jupyter Notebook/console, Jupyter Lab/console, Spyder IDE, or Python launched from a Windows Command Prompt, Unix terminal, etc.
Additional information:
us20_Zhao_Xu (https:)

Zhao Xu
StataCorp

#### Special Stata musical interlude by Dorry Segev and Allan Massie
Additional information:
(Teach Me More) Stata Code (https:)

### Session 3: Programming
#### Implementing programming patterns in Mata to optimize your code
Abstract: Have you ever created a program that requires a nontrivial amount of data to be present or available (for example, look-up/value tables, data used for the program interface, etc…)? If you have, you’ll likely have experienced the performance penalty that multiple I/O operations can cause. ...(Read more)
Additional information:
us20_Buchanan1 (https:)

Billy Buchanan
Fayette County Public Schools

#### Text mining with n-gram variables
Abstract: Text data, such as answers to open-ended questions, are sometimes ignored because they are hard to analyze. Our Stata command ngram turns text into hundreds of variables using the "bag of words" approach. Broadly speaking, each variable records how often the corresponding word or word sequence occurs in a given text. This is more useful than it sounds. The program supports text in 12 European languages. (Schonlau, M, Guenther, and N Sucholutsky 2017)
Additional information:
us20_Schonlau.pdf

Matthias Schonlau
University of Waterloo

#### f_able estimation of marginal with transformed data
Abstract: The command margins is a very powerful command that can be used for the estimation of marginal effects for linear and non-linear models (using official or community-contributed commands), as long as the variables of interest are introduced linearly or as polynomials (using factor notation). When other types of transformations are used, Stata is usually unable to estimate marginal effecs correctly because it may not understand that, for example, log_x is actually log(x), considering it as an unrelated independent variable in the model. In this presentation, I provide a simple command, f_able, that enables margins to correctly estimate marginal effects when transformations other than polynomials are used in the model specification.
Additional information:
us20_Rios-Avila1.pdf

Fernando Rios-Avila
Levy Economics Institute

#### Two-dimensional Gauss–Legendre quadrature: Seemingly unrelated dispersion-flexible count regressions
Abstract: Many contexts in empirical econometrics require nonclosed form two-dimensional (2D) integration for appropriate modeling and estimation design. Applied researchers often avoid such correct but computationally demanding specifications and opt for simpler biased or less efficient modeling designs. The presentation will detail a new Mata implementation of the 2D version of a relatively simple numerical integration technique—Gauss–Legendre quadrature. ...(Read more)
Additional information:
us20_Terza.pdf

Joseph Terza
IUPUI


#### Investigating factors that influence bicyclist injury severity in bicycle-motor vehicle crashes at unsignalized intersections in North Carolina
Abstract: In 2014, North Carolina implemented a strategic highway safety plan to reduce fatalities and serious injuries. The plan defined nine areas of focus to address safety issues; two main areas were investigated, unsignalized intersections and bicyclist safety. The purpose of this study was to evaluate (1) potential factors associated with bicyclist injury severity in bicycle-motor vehicle crashes at unsignalized intersections and (2) the impact of these factors on bicyclist safety. ...(Read more)
Additional information:
us20_Covert.pdf

Shatoya Covert
Elizabeth City State University

### Session 4: Panel data
#### Generalized method of moments estimation of linear dynamic panel-data models
Abstract: In dynamic models with unobserved group-specific effects, the lagged dependent variable is an endogenous regressor by construction. The conventional fixed-effects estimator is biased and inconsistent under fixed-T asymptotics. To deal with this problem, "difference GMM" and "system GMM" estimators in the spirit of Arellano and Bond (1991), Arellano and Bover (1995), and Blundell and Bond (1998) are predominantly applied in practice. The Stata community widely associates these methods with the xtabond2 command provided by Roodman (2009). ...(Read more)
Additional information:
us20_Kripfganz.pdf

Sebastian Kripfganz
University of Exeter Business School

#### Pretesting for unobserved cluster effects and inference in panel-data sets
Abstract: This presentation addresses the question of how to estimate the standard errors in panel data when there are potentially unobserved cluster effects. We analyze the performance of statistical inference regarding the parameters of a panel-data model when it is first subjected to a pretest for the presence of individual and time unobserved cluster effects. ...(Read more)
Ercio Munoz
CUNY Graduate Center

#### XTSEL: Selection of variables and specification in a panel-data framework
Abstract: We have developed two new commands that allow selecting the best predictor between a number of alternative explanatory variables (xtselvar) and the best specification between all possible combinations of a defined set of explanatory variables (xtselmod) in a panel-data framework. xtselvar helps us to select the best predictor between a number of alternative explanatory variables (candidates). ...(Read more)
Additional information:
us20_Ugarte-Ruiz.pdf

Alfonso Ugarte-Ruiz
BBVA Research

### Session 5: Flexible and SEM estimation

#### Smooth varying coefficient models in Stata
Abstract: Nonparametric regressions are a powerful statistical tool to model relationships between dependent and independent variables with minimal assumptions on the underlying functional forms. Despite its potential benefits, these types of models have two weaknesses: The added flexibility creates a curse of dimensionality, and procedures available for model selection, like cross-validation, have a high computationally cost in samples with even moderate sizes. ...(Read more)
Additional information:
us20_Rios-Avila2.pdf

Fernando Rios-Avila
Levy Economics Institute

#### Invited talk: Using Stata to simulate the impact of COVID-19 on organ transplantation
Abstract: We present a case study demonstrating how the Epidemiologic Research Group in Organ Transplantation (ERGOT) at Johns Hopkins uses Stata to further the group's research goals. Recent applications include simulation to estimate the benefit or harm of delaying organ transplantation in the context of the COVID-19 pandemic and modular code design to facilitate rapid analysis of changes in the landscape of organ transplantation under COVID-19 across different organ types. We will discuss techniques for simulation and integration of putdocx and frames to rapidly produce manuscript-ready output. Additionally we will provide an overview of the Stata class we teach at the Johns Hopkins School of Public Health and discuss the songs about Stata we have written to promote the class.
Additional information:
us20_Segev.pptx
Dorry Segev and Allan Massie
Johns Hopkins University

### Session 6: Integration with other software

#### Reading an arbitrary number of files into Stata made easy
Abstract: The Statalist is filled with threads from users who all want to do the same thing. You probably have run into the issue yourself. You have dozens, hundreds, or thousands of files that you need to combine into a single dataset for analysis and want to figure out the most efficient way to do it. In this talk, I’ll describe readit, a new command that solves this problem and can solve the same problem when used across multiple file types using the Python API introduced in Stata 16. The readit command can operate in a few different ways that provide significant flexibility built on the I/O capabilities of the pandas package in Python.

Additional information:
us20_Buchanan2 (https:)

Billy Buchanan
Fayette County Public Schools

#### Using Microsoft Excel to improve efficiency in working with large datasets in Stata
Abstract: Introduction: There is an ongoing growth in the availability of data and increased number of variables in large datasets such as medical claim files or national surveys. Stata supports various descriptive, exploratory, and analytical approaches to work with these data to identify and study various topics such as public and clinical health outcomes and issues. Given the high volume of various data generated daily, implementing cross-platform approaches to manage and manipulate data can improve efficiency of data-science professionals and academic researchers. ...(Read more)

Additional information:
us20_Khanijahani.pdf
us20_Khanijahani.xlsx

Ahmad Khanijahani
Duquesne University

#### Applying symbolic mathematics in Stata using Python
Abstract: I present an applied example of blending theory and data using Stata 16's new Python integration. The SymPy library in Python makes a wide range of symbolic mathematical tools available to Stata programmers. For a recent project, I used theory and SymPy to derive a relationship between two labor supply elasticities in a structural model and separately used Stata to generate reduced-form estimates of these elasticities. I then used the Stata Function Interface to directly plug the empirical Stata estimates into my SymPy model, allowing easy and reproducible estimation of the theoretical relationship of interest. I discuss these methods and provide code for use by other researchers.

Additional information:
us20_Lippold.pdf

Kye Lippold
UC San Diego

#### Rosetta Stone: Stata To Python Pandas crosswalk
Abstract: Given Stata’s recent updates that promote Python integration and the growing popularity of Python and Pandas as a data wrangling and analysis platform, this session will provide a Rosetta Stone-like crosswalk between Stata and Python. The content will demonstrate Python code that replicates common techniques often executed in Stata. This session will be best for Stata users who desire to leverage recently available Python integrations but who have yet to attain beginner-to-intermediate proficiency in Python.

Additional information:
us20_Nelson.pptx
us20_Stata_Pandas_crosswalk.do

Adam Ross Nelson
American University

#### Downloading and preparing survey data using the Qualtrics API in the Stata ecosystem
Abstract: Downloading and preparing survey data for analysis from online platforms such as Qualtrics is a time-consuming and error-prone task. The qualtrics.ado command interacts with the Qualtrics API to download, and clean, data quickly with less error. The program requires users to enter their Qualtrics credentials. ...(Read more)

Additional information:
us20_Hoepfner.pdf
us20_qualtrics.ado
us20_qualtrics.sthlp
us20_qualtrics_example.do

Danial Hoepfner
Gibson Consulting Group Inc.

#### StataCorp presentation: Nonlinear dynamic stochastic general equilibrium models in Stata
Abstract: Dynamic stochastic general equilibrium (DSGE) models are used in macroeconomics for policy analysis and forecasting. A DSGE model consists of a system of equations—usually a nonlinear system of equations—that is derived from economic theory. I will show you how to easily solve, estimate, and analyze nonlinear DSGEs. We will explore how to obtain policy matrices, transition matrices, and impulse–response functions for nonlinear models.

Additional information:
us20_Schenck.pdf

David Schenck
StataCorp

### Session 7: Empirical applications
#### The causal effects of parents' marital status on children's earnings
Abstract: this research, I examine how the marital relationship affects children's future economic status. I introduce the parental marital status hypothesis of children's earnings: ...(Read more)
Additional information:
us20_Wen.pdf

Bob Wen
Clemson University

#### The social costs of crime over trust: An approach with machine learning
Abstract: In Peru, 55% of the population considers insecurity as the country's main problem. The present study seeks to contribute to the understanding of the social costs of crime in Peru by measuring the impact of patrimonial crime on trust in public institutions, ...(Read more)
Additional information:
us20_Cozzubo.pdf

Angelo Cozzubo
University of Chicago

## 2019 USA, Chicago

### Using Stata for data collection and management

#### `ietoolkit`: How DIME Analytics develops Stata code from primary data work

**Abstract**: Over the years, the complexity of data work in development research has grown exponentially, and standardizations for workflows are needed for researchers and data analysts to work simultaneously on multiple projects. **ietoolkit** was developed to standardize and simplify best practices for data management and analysis across the 100-plus members of the World Bank's Development Research Group, Impact Evaluations team (DIME). It includes a standardized project folder structure; standardized Stata "boilerplate" code; standardized balance tables, graphs, and matching procedures; and modified dropping and saving commands with built-in safety checks. The presentation will outline how the **ietoolkit** structure is meant to serve as a guide for projects to move their data through the analysis process in a standardized way, as well as offer a brief introduction to the other commands. The intent is for many projects within one organization to have a predictable workflow, such that researchers and data analysts can move between multiple projects and support other teams easily and rapidly without expending time relearning idiosyncratic project organization structures and standards. These tools are developed open-source on GitHub and available publicly.

**Additional information:** [chicago19_Bjarkefur.pdf](https://www.stata.com/meeting/chicago19/slides/chicago19_Bjarkefur.pdf)

Kristoffer Bjarkefur
World Bank Group (DIME) 

#### iefieldkit: Stata commands for primary data collection and cleaning
**Abstract**: Data collection and cleaning workflows use highly repetitive but extremely important processes. **iefieldkit** was developed to standardize and simplify best practices for high-quality primary data collection across the 100-plus members of the World Bank's Development Research Group, Impact Evaluations team (DIME). It automates error-checking for electronic ODK-based survey modules such as those implemented in SurveyCTO; duplicate checking and resolution; data cleaning, including renaming, labeling, recoding, and survey harmonization; and codebook creation. The presentation will outline how the **iefieldkit** package is intended to provide a data-collection workflow skeleton for nearly any type of primary data collection, from questionnaire design to data import. One feature of many **iefieldkit** commands is their utilization of spreadsheet-based workflows, which reduce repetitive coding in Stata and document corrections and cleaning in a human-readable format. This enables rapid review of data quality in a standardized process, with the goal of producing maximally clean primary data for the downstream data construction and analysis phases in a transparent and accessible manner. These tools are developed open-source on GitHub and available publicly.

**Additional information: **[chicago19_Daniels.pdf](https://www.stata.com/meeting/chicago19/slides/chicago19_Daniels.pdf)

Benjamin Daniels
World Bank Group (DIME) 


## Graphics development

### Barrel-aged software development: brewscheme as a four-year-old

**Abstract**: The term "software development" implies some type of change over time. While Stata goes through extraordinary steps to support backward compatibility, user-contributors may not always see a need to continue developing programs shared with the community. How do you know if or when you should add additional programs or functionality to an existing package? Is it easy and practical to extend existing Stata code, or is it easier to refactor everything from the ground up? What can you do to make it easier to extend existing code? While **brewscheme** may have started as a relatively simple package with a couple of commands and limited functionality, in the four years since it was introduced, it has grown into a multifunctional library of tools to make it easier to create customized visualizations in Stata while being mindful of color sight impairments. I will share my experience, what I have learned, and strategies related to how I dealt with these questions in the context of the development of the **brewscheme** package. I will also show what the additional features do that the original **brewscheme** did not do.

**Additional information:** [chicago19_Buchanan (https:)](https://wbuchanan.github.io/stataConference2019/#/)

Billy Buchanan

Fayette County Public Schools 

## Substantive applications 
### Simulating baboon behavior using Stata

**Abstract**: This presentation originated from a field study of the behavior of feral baboons in Tanzania. The field study used behavior sampling methods, including on-the-moment (instantaneous) and thru-the-moment (one-zero). Some primatologists critiqued behavioral sampling as not reflecting true frequency or duration. A Monte Carlo simulation study was performed to compare behavior sampling with actual frequency and duration.

**Additional information:** [chicago19_Ender.pdf](https://www.stata.com/meeting/chicago19/slides/chicago19_Ender.pdf)

Phil Ender
UCLA Retired 

### Using cluster analysis to understand complex datasets: Experience from a national nursing consortium
**Abstract**: Cluster analysis is a type of exploratory data analysis for classifying observations and identifying distinct groups. It may be useful for complex datasets where commonly used regression modeling approaches may be inadequate because of outliers, complex interactions, or violation of assumptions. In health care, the complex effect of nursing factors (including staffing levels, experience, and contract status), hospital size, and patient characteristics on patient safety (including pressure ulcers and falls) has not been well understood. In this presentation, I will explore the use of Stata cluster analysis (cluster) to describe five groups of hospital units that have distinct characteristics to predict patient pressure ulcers and hospital falls in relationship to employment of supplemental registered nurses (SRNs) in a national nursing database. The use of SRNs is a common practice among hospitals to fill gaps in nurse staffing. But the relationship between the use of SRNs and patient outcomes varies widely, with some groups reporting a positive relationship, while other groups report an adverse relationship. The purpose of this presentation is to identify the advantages and disadvantages of cluster analysis and other methods when analyzing nonnormally distributed, nonlinear data that have unpredictable interactions.

**Additional information:** [chicago19_Williams.pptx](https://www.stata.com/meeting/chicago19/slides/chicago19_Williams.pptx)

Barbara Williams
Virginia Mason Medical Center 

### The individual process of neighborhood change and residential segregation in 1940: An implication of a discrete choice model
**Abstract**: Using the 1940 restricted census microdata, this study develops discrete choice models to investigate how individual and household characteristics, along with the features of neighborhoods of residence, affect individual choices of residential outcomes in US cities. This study will make several innovations: (1) We will take advantage of 100% census microdata on the whole population of the cities to establish discrete choice models estimating the attributes of alternatives (for example, neighborhoods) and personal characteristics simultaneously. (2) This study will set a routine of reconstructing personal records to the data structure eligible for discrete choice models and then test whether the assumptions are violated. (3) This study will assess the extent and importance of discrimination and residential preferences, respectively, through the model specification. The results suggest that both in-group racial and class preferences can explain the individual process of neighborhood changes. All groups somehow practice out-group avoidance based on race and social class. Such phenomena are more pronounced in multiracial cities.

**Additional information:** [chicago19_Zou.pptx](https://www.stata.com/meeting/chicago19/slides/chicago19_Zou.pptx)

Karl X.Y. Zou
Texas A&M University 

### Featured presentation from StataCorpUsing Python within Stata

**Abstract**: Users may extend Stata's features using other programming languages such as Java and C. New in Stata 16, Stata has tight integration with Python, which allows users to embed and execute Python code from within Stata. I will discuss how users can easily call Python from Stata, output Python results within Stata, and exchange data and results between Python and Stata, both interactively and as sub-routines within do-files and ado-files. I will also show examples of the Stata Function Interface (sfi); a Python module provided with Stata which provides extensive facilities for accessing Stata objects from within Python.

**Additional information:** [chicago19_Peng (https:)](https://huapeng01016.github.io/chicago19/#/hua-pengstatacorphpeng)

Hua Peng
StataCorp 

## Difference-in-differences

### Extending the difference-in-differences (DID) to settings with many treated units and same intervention time: Model and Stata implementation

**Abstract**: The difference-in-differences (DID) estimator is popular to estimate average treatment effects in causal inference studies. Under the common support assumption, DID overcomes the problem of unobservable selection using panel, time, or location fixed effects and the knowledge of the pre- or postintervention times. New developments of DID have been recently proposed: (i) the synthetic control method (SCM) applies when a long pre- and postintervention time series is available, only one unit is treated, and intervention occurs in a specific time (implemented in Stata via SYNTH by Hainmueller, Abadie, Dimond [2014]); (ii) an extension to binary time-varying treatment with many treated units has also been proposed and implemented in Stata via TVDIFF (Cerulli and Ventura, 2018). However, a command to accommodate a setting with many treated units and the same intervention time is still lacking. In this presentation, I propose a potential-outcome model to accommodate this latter setting and provide a Stata implementation via the new Stata routine FTMTDIFF (standing for fixed-time multiple treated DID). I will finally set some guidelines for future DID developments.

**Additional information:** [chicago19_Cerulli.pdf](https://www.stata.com/meeting/chicago19/slides/chicago19_Cerulli.pdf)

Giovanni CerulliIRCrES-CNR
National Research Council of Italy 

### Bacon decomposition for understanding differences-in-differences with variation in treatment timing
**Abstract**: In applications of a difference-in-differences (DD) model, researchers often exploit natural experiments with variation in onset, comparing outcomes across groups of units that receive treatment starting at different times. Goodman-Bacon (2019) shows that this DD estimator is a weighted average of all possible two-group or two-period DD estimators in the data. The **bacon** command performs this decomposition and graphs all two-by-two DD estimates against their weight, which displays all identifying variation for the overall DD estimate. Given the widespread use of the two-way fixed effects DD model, **bacon** has broad applicability across domains and will help researchers understand how much of a given DD estimate comes from different sources of variation.

**Additional information:** [chicago19_Goodman-Bacon.pdf](https://www.stata.com/meeting/chicago19/slides/chicago19_Goodman-Bacon.pdf)

Andrew Goodman-Bacon
Vanderbilt University

## Stata programming
### The matching problem using Stata
**Abstract**: A main purpose of this presentation is to discuss an algorithm for the matching problem. As an example, K-cycle Kidney exchange problem is defined and solved using user-written Stata program.

**Additional information:** [chicago19_Lee.pdf](https://www.stata.com/meeting/chicago19/slides/chicago19_Lee.pdf)

Choonjoo LeeKorea 
National Defense University 

### Mata implementation of Gauss-Legendre quadrature in the M-estimation context: Correcting for sample-selection bias in a generic nonlinear setting
**Abstract**: Many contexts in empirical econometrics require nonclosed form integration for appropriate modeling and estimation design. Applied researchers often avoid such correct but computationally demanding specifications and opt for simpler misspecified modeling designs. The presentation will detail a newly developed Mata implementation of a relatively simple numerical integration technique – Gauss-Legendre quadrature. Although this Mata code is applicable in a variety of circumstances, it was mainly written for use in M-estimation when the relevant objective function (for example, the likelihood function) involves integration at the observation level. As inputs, the user supplies a vector-valued integrand function (for example, a vector of sample log-likelihood integrands) and a matrix of upper and lower integration limits. The code outputs the corresponding vector of integrals (for example, the vector of observation-specific log-likelihood values). To illustrate the use of this Mata implementation, we conduct an empirical analysis of classical sample-selection bias in the estimation of wage offer regressions. We estimate a nonlinear version of the model based on the modeling approach suggested by Terza (*Econometric Reviews* 2009) which requires numerical integration. This model is juxtaposed with the classical linear sample-selection specification of Heckman (*Annals of Economic and Social Measurement* 1976), for which numerical integration is not required.

**Additional information:** [chicago19_Terza.pdf](https://www.stata.com/meeting/chicago19/slides/chicago19_Terza.pdf)

Joseph Terza
Indiana University Purdue University Indianapolis

## Economic applications
### A practical application of the mvport package: CAPM-based optimal portfolios
**Abstract**: The mvport package has commands for financial portfolio optimization and portfolio backtesting. I present a practical implementation of a CAPM-based strategy to select stocks, and then apply different optimization settings, and evaluate the resulting portfolios. The presentation illustrates how to automate the process through a simple do-file that allows to easily change parameters (for example, stock list, market index, risk-free rate) using an Excel interface. The program automates the following: a) data collection, b) CAPM model estimation for all stocks, c) selection of stocks based on CAPM parameters, d) portfolio optimization with different configurations, and e) portfolio backtesting. For data collection, the **getsymbols** and the **freduse** command is used to get online price data for all the S&P500 stocks and the risk-free rate. For each stock, two competing CAPM models are estimated: using a simple regression and using an autoregressive conditional heteroskedasticity (ARCH) model. The CAPM parameters are used to select stocks. Then the mvport package is used to optimize different configurations of the portfolio. Finally, the performance of each portfolio configuration is calculated and compared with the market portfolio.

**Additional information:** [chicago19_Dorantes.pdf](https://www.stata.com/meeting/chicago19/slides/chicago19_Dorantes.pdf),  [chicago19_Dorantes.xlsx](https://www.stata.com/meeting/chicago19/slides/chicago19_Dorantes.xlsx)

Carlos Dorantes
Tec de Monterrey 

### Tools to analyze interest rates and value bonds
**Abstract**: Bond markets contain a wealth of information about investor preferences and expectations. However, extracting such information from market interest rates can be computationally burdensome. I introduce a suite of new Stata commands to aid finance professionals and researchers in using Stata to analyze the term structure of interest rates and value bonds. The **genspot** command uses a bootstrap methodology to construct a spot rate curve from a yield curve of market interest rates under a no-arbitrage assumption. The **genfwd** command generates a forward rate curve from a spot rate curve, allowing researchers to infer market participants’ expectations of future interest rates. Finally, the **pricebond** command uses forward rates to value a bond with user-specified terms.

**Additional information:** [chicago19_Schmidt.pdf](https://www.stata.com/meeting/chicago19/slides/chicago19_Schmidt.pdf)

Tim Schmidt
Discover Financial Services 

### Panel stochastic frontier models with endogeneity in Stata
**Abstract**: I introduce **xtsfkk**, a new Stata command for fitting panel stochastic frontier models with endogeneity. The advantage of **xtsfkk** is that it can control for the endogenous variables in the frontier or the inefficiency term in a longitudinal setting. Hence, **xtsfkk** performs better than standard panel frontier methodologies such as **xtfrontier** that overlook endogeneity by design.

**Additional information:** [chicago19_Karakaplan.pptx](https://www.stata.com/meeting/chicago19/slides/chicago19_Karakaplan.pptx)

Mustafa Karakaplan

## Statistical topics
### Recentered influence functions (RIF) in Stata: RIF-regression and RIF-decomposition
**Abstract**: Recentered influence functions (RIF) are statistical tools that have been popularized by Firpo, Fortin, and Lemieux (2009) for analyzing unconditional partial effects (UPE) on quantiles in a regression analysis framework (unconditional quantile regressions). The flexibility and simplicity of this tool, however, has opened the possibility to extend the analysis to other distributional statistics, using linear regressions or decomposition approaches. In this presentation, I introduce three Stata commands to facilitate the use of RIFs in the analysis of outcome distributions: **rifvar()** is an egen extension used to create RIFs for a large set of distributional statistics; **rifhdreg** facilitates the estimation of RIF regressions enabling the use of high-dimensional fixed effects; and **oaxaca_rif** implements Oaxaca-Blinder-type decomposition analysis.

**Additional information:** [chicago19_Rios-Avila.pdf](https://www.stata.com/meeting/chicago19/slides/chicago19_Rios-Avila.pdf)

Fernando Rios-Avila 

### Verifying the existence of maximum likelihood estimates in generalized linear models
**Abstract**: There has been considerable ambiguity over how to verify whether estimates from nonlinear models "exist" and what can be done if they do not. This is the so-called separation problem. We characterize the problem in detail across a wide range of generalized linear models and introduce a novel method for dealing with it in the presence of high-dimensional fixed effects, as are often recommended for gravity models of international trade and in other common panel-data settings. We have included these methods in a new Stata command for HDFE-Poisson estimation called **PPMLHDFE**. We have also created a suite of test cases developers may use in the future for testing whether their estimation packages are correctly identifying instances of separation. These projects are joint with Sergio Correia and Paulo Guimaraes. We have written two papers related to these topics and also created a website with example code and data illustrating the separation issue and how we solve it. Please see our github for more details: https://github.com/sergiocorreia/ppmlhdfe/.
**Additional information:** [chicago19_Zylkin.pdf](https://www.stata.com/meeting/chicago19/slides/chicago19_Zylkin.pdf)

Thomas Zylkin
University of Richmond 

### Unbiased IV in Stata
**Abstract**: A well-known result is that exactly identified IV has no moments, including in the ideal case of an experimental design (that is, a randomized control trial with imperfect compliance). This result no longer holds when the sign of the first stage is known, however. I describe a Stata implementation of an unbiased estimator for instrumental-variable models with a single endogenous regressor where the sign of one or more first‐stage coefficients is known (due to Andrews and Armstrong 2017) and its finite sample properties under alternative error structures.
**Additional information:** [chicago19_Nichols.pdf](https://www.stata.com/meeting/chicago19/slides/chicago19_Nichols.pdf)

Austin Nichols
Abt Associates

## Using Stata for reproducible research
### Connecting Stata and Microsoft Word using StatTag for collaborative reproducibility
**Abstract**: Although Stata can render output and reports to Microsoft Word, pdf and html files, Stata users must sometimes transcribe statistical content in to separate Microsoft Word documents (for example, documents drafted by colleagues in Word or documents that must be prepared in Word), a process that is error prone, irreproducible, and inefficient. This talk will illustrate how StatTag (www.stattag.org), an open source, free, and user-friendly program that we developed, addresses this problem. Since its introduction in 2016, StatTag has undergone substantial improvements and refinements. StatTag establishes a bidirectional link between Stata files and a Word document and supports a reproducible pipeline even when (1) statistical results must be included and updated in Word documents that were never generated from Stata; and (2) text in Word files generated from Stata has departed substantially from original content, for example, through tracked changes or comments. We will demonstrate how to use StatTag to connect Stata and Word files so that all files can be edited separately, but statistical content—values, tables, figures, and verbatim output—can be updated automatically in Word. Using practical examples, we will also illustrate how to use StatTag to view, edit, and rerun Stata code directly from Word.

**Additional information:** [chicago19_Baldridge.pptx](https://www.stata.com/meeting/chicago19/slides/chicago19_Baldridge.pptx)

Abigail S. Baldridge
Northwestern University

## Featured presentations from StataCorp
### Using lasso and related estimators for prediction
**Abstract**: Lasso and elastic net are two popular machine-learning methods. In this presentation, I will discuss Stata 16's new features for lasso and elastic net, and I will demonstrate how they can be used for prediction with linear, binary, and count outcomes. We will discover why these methods are effective and how they work.

**Additional information:** [chicago19_Liu.pdf](https://www.stata.com/meeting/chicago19/slides/chicago19_Liu.pdf)

Di Liu 
StataCorp 

### Inference after lasso model selection
**Abstract**: The increasing availability of high-dimensional data and increasing interest in more realistic functional forms have sparked a renewed interest in automated methods for selecting the covariates to include in a model. I discuss the promises and perils of model selection and pay special attention to estimators that provide reliable inference after model selection. I will demonstrate how to use Stata 16's new features for double selection, partialing out, and cross-fit partialing out to estimate the effects of variables of interest while using lasso methods to select control variables.

**Additional information:** [chicago19_Drukker.pdf](https://www.stata.com/meeting/chicago19/slides/chicago19_Drukker.pdf)

David Drukker
StataCorp

## Topics in biostatistics
### Uncovering the true variability in meta-analysis results using resampling methods
**Abstract**: Traditionally, meta-analyses are performed using a single effect estimate from each included study, resulting in a single combined effect estimate and confidence interval. However, there are a number of processes that could give rise to multiple effect estimates from each study, such as multiple individuals extracting study data, the use of different analysis methods for dealing with missing data or dropouts, and the use of different types of endpoints for measuring the same outcome. Depending on the number of studies and the number of possible estimates per study, the number of combinations of studies for which a meta-analysis could be performed could be in the thousands. Accordingly, meta-analysts need a tool that can iterate through all of these possible combinations (or a reasonably sized sample thereof), compute an effect estimate for each, and summarize the distribution of the effect estimates and standard errors for all combinations. We have developed a Stata command, **resmeta**, for this purpose that can generate results for 10,000 combinations in a few seconds. This command can handle both continuous and categorical data, can handle a variable number of estimates per study, and has options to compute a variety of different estimates and standard errors. In the presentation, we will cover case studies where this approach was applied, considerations for more general application of the approach, command syntax and options, and different ways of summarizing the results and evaluating different sources of variability in the results.

**Additional information:** [chicago19_Canner.pptx](https://www.stata.com/meeting/chicago19/slides/chicago19_Canner.pptx)

Joseph Canner
Johns Hopkins University School of Medicine 

### Comparing treatments in the presence of competing risks based on life years lost
**Abstract**: Competing risks are frequently encountered in medical research. Examples are clinical trials in head-and-neck and prostate cancer where deaths from cancer and deaths from other causes are competing risks. Andersen (*Stat in Med* 2013) showed that the area under the cause j cumulative incidence curve from 0 to t* can be interpreted as the number of life years lost (LYL) due to cause j before time t*. LYL can be estimated and compared in Stata using either the pseudo-observations approach described in Overgaard, Andersen, and Parner (*Stata Journal* 2015) or by modification of a routine by Pepe and Mori (*Stat in Med* 1993) for testing the equality of cumulative incidence curves. We describe an application of the method to the DeCIDE trial, a phase III randomized clinical trial of induction chemotherapy plus chemoradiotherapy versus chemoradiotherapy alone in patients with locally advanced head-and-neck cancer. We present simulation results demonstrating that the pseudo-observations and Pepe-Mori approaches yield similar results. We also evaluate the power obtained from comparing life years lost relative to standard procedures for analyzing competing risks data, including cause-specific logrank tests (Freidlin and Korn; *Stat in Med* 2005) and the Fine-Gray model (Fine and Gray; *JASA* 1999).

**Additional information:** [chicago19_Karrison.pptx](https://www.stata.com/meeting/chicago19/slides/chicago19_Karrison.pptx)

Theodore Karrison
University of Chicago and NRG Oncology 

### Hierarchical summary ROC analysis: A frequentist-Bayesian colloquy in Stata

**Abstract**: Meta-analysis of diagnostic accuracy studies requires the use of more advanced methods than meta-analysis of intervention studies. Hierarchical or multilevel modeling accounts for the bivariate nature of the data, both within- and between-study heterogeneity and threshold variability. The hierarchical summary receiver operating characteristic (HSROC) and the bivariate random-effects models are currently recommended by the Cochrane Collaboration. The bivariate model is focused on estimating summary sensitivity and specificity and as a generalized linear mixed model is estimable in most statistical software, including Stata. The HSROC approach models the implicit threshold and diagnostic accuracy for each study as random effects and includes a shape or scale parameter that enables asymmetry in the SROC by allowing accuracy to vary with implicit threshold. As a generalized nonlinear mixed model, it has not been previously or directly estimable in Stata, though possible with WinBUGS and SAS Proc NLMIXED or indirectly extrapolating its parameters from the bivariate model in Stata. This talk will demonstrate for the first time how the HSROC model can be fit in Stata using ML programming and the recently introduced **bayesmh** command. Using a publicly available dataset, I will show the comparability of Stata results with those obtained with WinBUGS and SAS Proc NLMIXED.

**Additional information:** [chicago19_Dwamena.pdf](https://www.stata.com/meeting/chicago19/slides/chicago19_Dwamena.pdf)

Ben Adarkwa Dwamena
University of Michigan Medical School

## Using Stata to solve problems in applied work
### kmr: A command to correct survey weights for unit nonresponse using a group's response rates
**Abstract**: This article describes **kmr**, a Stata command to estimate a micro compliance function using group level nonresponse rates (2007, *Journal of Econometrics* 136: 213-235), which can be used to correct survey weights for unit nonresponse. We illustrate the use of kmr with an empirical example using the Current Population Survey and state-level nonresponse rates.

**Additional information:** [chicago19_Munoz.pdf](https://www.stata.com/meeting/chicago19/slides/chicago19_Munoz.pdf)

Ercio Munoz
CUNY Graduate Center and Stone Center on Socio-economic Inequality 

### tesensitivity: A Stata package for assessing the unconfoundedness assumption
**Abstract**: This talk will discuss a new set of methods for quantifying the robustness of treatment effects estimated under the unconfoundedness assumption (also known as selection on observables or conditional ignorability). Specifically, we estimate bounds on the ATE, the ATT, and the QTE under nonparametric relaxations of unconfoundedness indexed by a scalar sensitivity parameter c. These deviations allow for limited selection on unobservables, depending on the value of c. For large enough c, these bounds equal the no assumptions bounds. Our methods allow for both continuous and discrete outcomes but require discrete treatments. We implement these methods in a new Stata package, tesensitivity, for easy use in practice. We illustrate how to use this package and these methods with an empirical application to the National Supported Work Demonstration program.

**Additional information:** [chicago19_Masten.pdf](https://www.stata.com/meeting/chicago19/slides/chicago19_Masten.pdf)

Matthew Masten 
Duke University

## Poster session 
### Post-estimation analysis with Stata by SPost13 commands of survey data analyzed by MNLM
**Additional information:** [chicago19_Giovannelli.pdf](https://www.stata.com/meeting/chicago19/slides/chicago19_Giovannelli.pdf)

Debora Giovannelli

### The causal effects of wages on labor supply for married women: Evidence from American couples

**Additional information:** [chicago19_Wen.pdf](https://www.stata.com/meeting/chicago19/slides/chicago19_Wen.pdf)

Bob Wen
Clemson University 

### Fitting generalized linear models when the data exceeds available memory
**Additional information:** [chicago19_Canner.pdf](https://www.stata.com/meeting/chicago19/slides/chicago19_Canner_poster.pdf)

Joseph Canner
Johns Hopkins University School of Medicine 

### Estimation of varying coefficient models in Stata
**Additional information:** [chicago19_Rios-Avila.pdf](https://www.stata.com/meeting/chicago19/slides/chicago19_Rios-Avila_poster.pdf)

Fernando Rios-Avila
Levy Economics Institute

### Psychiatric morbidity in physically injured children and adolescents: A national evaluation
**Additional information:** [chicago19_Tennakoon.pdf](https://www.stata.com/meeting/chicago19/slides/chicago19_Tennakoon.pdf)

Lakshika Tennakoon
Stanford University