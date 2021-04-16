## 1. Introduction

### Notation

i

$T_i$

$Y_i$

$Y_{1i}$: potential outcome for the same unit i with the treatment

$Y_{0i}$ : potential outcome for unit i without the treatment

$Y_{1i}-Y_{0i}$: individual treatment effect

$ATE = E[Y_1-Y_0]$

Average Treatment Effect on the Treated: $ATET = E[Y_1-Y_0|T=1]$

### Bias

$Y_{0i}$ is counterfactual
$$
E[Y|T=1] - E[Y|T=0] = E[Y_1|T=1] - E[Y_0|T=0] \\
E[Y|T=1] - E[Y|T=0] = E[Y_1|T=1]-E[Y_0|T=0]+E[Y_0|T=1]-E[Y_0|T=1] \\
E[Y|T=1] - E[Y|T=0] = \underbrace{E[Y_1-Y_0|T=1]}_{ATET} -\underbrace{E[Y_0|T=1]-E[Y_0|T=0]}_{BIAS}
$$
If $E[Y_0|T=1] = E[Y_0|T=0]$, then, association is causation.

## 2. Randomise Experiments
### Randomise Experiments
$$
(Y_0, Y_1) \perp\!\!\!\perp T
$$

$$
E[Y_0|T=0] - E[Y_0|Y=1] = E[Y_0] \\
E[Y|T=1] - E[Y|T=0] = E[Y_1-Y_0] = ATE
$$

### The Assignment Mechanism

## 3. Stats Review

### Standard Error

$$
\hat{\sigma}=\frac{1}{N-1}\sum_{i=0}^N (x-\bar{x})^2
$$

### Confidence Intervals

### Hypothesis Testing

### P-Values

## 4. Graphical Casual Models

[ExecutableNotFound: failed to execute ['dot', '-Kdot', '-Tsvg'], make sure the Graphviz executables are on your systems' PATH](https://stackoverflow.com/questions/35064304/runtimeerror-make-sure-the-graphviz-executables-are-on-your-systems-path-aft)



---

虚拟事实框架

个体-群体

随机分配

直观上，我们说随机分组保证了控制组和干预组在任何其他 变量上都没有系统差异，所以其潜在结果是“可比的”。

- 稳定性假设：单位层面因果作用是稳定的
- 无混淆假设：个体被分配到干预组还是控制组与个体的潜在结果是完全独立的

控制：

准自然实验

实验

三种平均因果效应：

- ATE: Average Treatment Effect
- ATT: Average Treatment Effect for the Treated
- ATC: Average Treatment for the Control

因果关系图：判断哪些变量需要控制

中介路径、叉型路径、倒叉型路径

后门路径

撞子变量

因果关系图中控制的基本原则：

- 不要控制中介变量，即不要关闭因果路径
- 需要控制混淆变量，即必须关闭后门路径
- 不要控制撞子变量，即不要打开（新的）后门路径
- 推广到N个变量的情景，其核心思想不变——关闭后门路径

