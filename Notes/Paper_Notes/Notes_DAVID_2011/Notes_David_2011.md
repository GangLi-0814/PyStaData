> Function: Notes of S. Fountas et al.(2015)
>
> Name: Li Gang
>
> E-Mail: gang.li.0814@gmail.com
>
> Create Date: 2020/05/30
>
> Last Modify: 2020/06/01 09:50

_You can see the latest version of this notes at my [Github Page](https://github.com/GangLi-0814/PyStaData/blob/master/Notes/Paper_Notes/Notes_David_2011/Notes_David_2011.md)_.

## 1. Background and Goal

**Background**: milk-related food safety $\Rightarrow$ trade flows from China.

**Goal**: provide an economic assessment of Chinese consumer preferences for food safety verification attributes in UTH milk(Ultra-high temperature, or UHT, milk is ultra-pasteurized milk that comes in sterilized containers).

## 2. Methodology and Data

### 2.1 Methodology

Choice experiment approach to evaluate Chinese consumer's willingness to pay(WTP)

- **Five two-level attributes**: price, shelf-life, government certification, third-party (private) certification, and brand.
- **Experiment Area**: Beijing, Chengdu, Hohhot, Nanjing, Shanghai, Wuhan, and Xi'an.
- **Interviewee**: random in supermarkets and convenience stores, where actual milk purchasing decisions take place.

### 2.2 Data

7 cities $\times$ 60 observations $\times$ 16 choice sets = 6720 observations.

### 2.3 Econometric Methods

#### 2.3.1 The random utility model(RUM)

$$
P_{nit} = \frac{exp(V_{nit})}{\sum_{j}{exp(V_njt)}}
$$

#### 2.3.2 RPL model (Recognition of Prior Learning)

RPL model relaxes the limitations of the traditional logit by allowing random taste variation within a sample according to a specified distribution.

$$
P_{nit}=\int \frac{exp(V_{nit})}{\sum_{j}{exp(V_{njt})}}f(\beta)d\beta
$$

#### 2.3.3 WTP

$$
WTP=-2 \frac{\beta_{k}}{\beta_{p}}
$$

$\beta_{k}$ is the estimated parameter of the $k$th attribute, $\beta_{p}$ is the estimated price coefficient.

#### 2.3.4 Welfare Evaluation

$$
CV = ln(\sum_{j}{e^{V_{i}}})+ \gamma
$$

where $\gamma$ is Euler's constant. Therefore, the change in welfare that from moving from situation A tp B is given by

$$
\frac{1}{Marginal\,Utility\,of\,Income}(CV^B-CV^A)
$$

## 4. Results

### 4.1 Willingness to Pay

![](./images/1.png)

Table 1 indicates that consumers are willing to pay the most for government certification, followed by the product's brand and private certification;then there is negative WTP for UTH milk with the shelf-life longer than three months.

### 4.2 Welfare Evaluation and Market Impacts

![](./images/2.png)

## 5. Conclusions

This study finds that:

- consumers prefer the shorter shelf-life UHT milk relative to the longer shelf-life product;
- consumers have highest value for government certification, followed by a national brand;
-  third-party nongovernment certification program is positively valued by consumers.