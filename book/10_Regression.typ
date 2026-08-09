#bibliography("carto-msu.bib")

= Пространственная зависимость

**Пространственная зависимость** проявляется в том, что значения величины в соседних единицах измерений оказываются связаны.

Учет этого фактора позволяет значительно усилить качество регрессионных моделей.

*Примечание:* *Как это работает?:*
Например, уровень преступности можно прогнозировать не только по доходам населения в районе, но и по уровню преступности *в соседних районах*.

#figure(image("../images/dependency.svg", width: 100%))

== Исходные данные

#figure(
  image("../docs/10_Regression_files/figure-revealjs/unnamed-chunk-1-1.png", width: 80%),
  caption: [график],
)

#figure(
  image("../docs/10_Regression_files/figure-revealjs/unnamed-chunk-2-1.png", width: 80%),
  caption: [график],
)

#figure(
  image("../docs/10_Regression_files/figure-revealjs/unnamed-chunk-3-1.png", width: 80%),
  caption: [график],
)

== Диаграмма рассеяния

Диаграмма рассеяния показывает соотношение переменных

#figure(
  image("../docs/10_Regression_files/figure-revealjs/unnamed-chunk-4-1.png", width: 80%),
  caption: [график],
)

== Линейная регрессия

Линейная регрессия дает аппроксимацию зависимости

#figure(
  image("../docs/10_Regression_files/figure-revealjs/unnamed-chunk-5-1.png", width: 80%),
  caption: [график],
)

Коэффициент корреляции равен $-0.696$.

Линейная регрессия дает аппроксимацию зависимости

#figure(
  image("../docs/10_Regression_files/figure-revealjs/unnamed-chunk-6-1.png", width: 80%),
  caption: [график],
)

Коэффициент корреляции равен $-0.574$.

Линейная регрессия позволяет найти зависимость вида

$
y = sum_{j=0}^k beta_j x_j
$

где $x_0 = 1$, а остальные $x_j$ --- независимые переменные.

Например, для двух переменных:

$
y = beta_0 + beta_1 x_1 + beta_2 x_2
$

В этом уравнении 3 неизвестных коэффициента. Для их нахождения требуется как минимум 3 измерения. Но обычно их больше, поэтому получится аппроксимация зависимости.

Пусть исследуемый показатель, а также независимые переменные измерены в $n$ географических местоположениях.

Для нахождения $\beta$ составляют систему из $i=1...n$ уравнений вида

$
y_i = sum_{j=0}^k beta_j x_{i j}
$

Например, для четырех измерений:

$
y_1 &= beta_0 + beta_1 x_(1 1) + beta_2 x_(1 2) \
y_2 &= beta_0 + beta_1 x_(2 1) + beta_2 x_(2 2) \
y_3 &= beta_0 + beta_1 x_(3 1) + beta_2 x_(3 2) \
y_4 &= beta_0 + beta_1 x_(4 1) + beta_2 x_(4 2)
$


Для решения систему уравнений их записывают в матричном виде:

$
underbrace(mat(delim: "[", y_1; y_2; y_3; y_4), bold(y)) =
underbrace(mat(delim: "[", 
  1, x_(1 1), x_(1 2); 
  1, x_(2 1), x_(2 2); 
  1, x_(3 1), x_(3 2); 
  1, x_(4 1), x_(4 2)
), bold(X))
underbrace(mat(delim: "[", beta_0; beta_1; beta_2), bold(beta))
$


Или более компактно:

$
bold(y) = bold(X) bold(\beta)
$

Если предположить, что система решена и коэффициенты $\beta$ найдены, то в каждом измерении получается ошибка (остаток) :

$
epsilon_i = y_i - sum_{j=0}^k \beta_j x_{i j}
$

**Метод наименьших квадратов** позволяет минимизировать сумму:

$
sum_{i=1}^n epsilon_i^2 arrow \min
$

Гауссом доказано, что минимум достигается решением:

$
bold(beta) = (bold(X)^T bold(X))^{-1} bold(X)^T bold(y)
$

Модель линейной регрессии записывается как:

$
bold(y) = bold(X) bold(beta) + bold(epsilon),
$

где:

-   $bold(y) = \{y_1, y_2, ... y_n\}$ --- вектор измерений зависимой переменной по $n$ объектам,

-   $bold(X) = \{x_{i j}\}$ --- матрица размером $n times (k+1)$, состоящая из значений $k$ независимых переменных для $n$ объектов (плюс константа $1$).

-   $bold(beta)$ --- вектор коэффициентов регрессии;

-   $bold(epsilon)$ --- вектор случайных ошибок (остатков).

Для модели

$
"CRIME" = beta_0 + beta_1 "INC" + beta_2 "HOVAL"
$

получается следующая диагностика:

```r
model = lm(CRIME ~ INC + HOVAL, data = reg)
reg = reg |>
  mutate(
    FIT = fitted(model),
    RES = residuals(model)
  )
s = summary(model)
s\$coefficients[,-3]
```

Т.е. модель принимает следующий вид:

$
"CRIME" = 68.619 -1.597~"INC" - 0.274~"HOVAL"
$

#figure(
  image("../docs/10_Regression_files/figure-revealjs/unnamed-chunk-8-1.png", width: 80%),
  caption: [график],
)

#figure(
  image("../docs/10_Regression_files/figure-revealjs/unnamed-chunk-9-1.png", width: 80%),
  caption: [график],
)

#figure(
  image("../docs/10_Regression_files/figure-revealjs/unnamed-chunk-10-1.png", width: 80%),
  caption: [график],
)

== Остатки регрессии

*Важно:* *Важно:*
Если остатки от регрессии образуют пространственный рисунок, это значит, что независимых переменных недостаточно для предсказания исследуемой величины. Необходимо учитывать пространственную зависимость.

#figure(
  image("../docs/10_Regression_files/figure-revealjs/unnamed-chunk-11-1.png", width: 80%),
  caption: [график],
)

При анализе карт остатков регрессии обращают внимание на то, меняются ли они плавно по пространству, есть ли выраженный пространственный тренд и зависимость значений соседних единиц.

== Пространственная автокорреляция

Пространственная автокорреляция [@hubert:1981]

:   Для множества $S$, состоящего из $n$ географических единиц, пространственная автокорреляция есть соотношение между переменной, наблюдаемой в каждой из $n$ единиц и мерой географической близости, определенной для всех $n(n − 1)$ пар единиц из $S$.

-   Пространственная автокорреляция является количественной мерой пространственной зависимости.

-   Для ее вычисления необходимо формализовать понятие географического соседства: какие объекты будем считать соседними и что будет мерой их близости?

== Географическое соседство

Для площадных территориальных единиц часто используется **соседство по смежности**, которое использует касание границ:

#figure(image("../images/QueenRook.png", width: 100%))

**Правило ферзя**: хотя бы одна общая точка на границе.\
**Правило ладьи**: общий участок линии на границе.

#figure(
  image("../docs/10_Regression_files/figure-revealjs/unnamed-chunk-12-1.png", width: 80%),
  caption: [график],
)

#figure(
  image("../docs/10_Regression_files/figure-revealjs/unnamed-chunk-13-1.png", width: 80%),
  caption: [график],
)

== Пространственные веса

**Пространственные веса** характеризуют силу связи между объектами

-   Если единицы не являются соседними (по выбранному правилу), то пространственный вес их связи будет равен нулю. Во всех остальных случаях веса будут ненулевыми.

-   Бинарные веса: если связь есть, то ее вес равен единице ($1$), если нет --- нулю ($0$).

-   Нормированные веса: вес $j$-й единицы по отношению к $i$-й равен $1/n_i$, где $n_i$ --- количество соседей у $i$.

**Бинарные веса**

#figure(image("../images/binary.svg", width: 100%))

**Матрица весов** $bold(W)$

$
mat(delim: "[", 0, 0, #text(fill: green)[bold(1)], 0, #text(fill: green)[bold(1)], #text(fill: green)[bold(1)], 0; 0, 0, #text(fill: blue)[bold(1)], 0, 0, 0, #text(fill: blue)[bold(1)]; 0, #text(fill: blue)[bold(1)], #text(fill: blue)[bold(1)], #text(fill: blue)[bold(1)], 0, 0, #text(fill: blue)[bold(1)]; #text(fill: red)[bold(1)], #text(fill: red)[bold(1)], #text(fill: red)[bold(1)], 0, #text(fill: red)[bold(1)], 0, 0; #text(fill: blue)[bold(1)], 0, 0, #text(fill: blue)[bold(1)], #text(fill: blue)[bold(1)], #text(fill: blue)[bold(1)], #text(fill: blue)[bold(1)]; #text(fill: blue)[bold(1)], 0, 0, #text(fill: blue)[bold(1)], #text(fill: blue)[bold(1)], 0, 0; 0, #text(fill: blue)[bold(1)], #text(fill: blue)[bold(1)], #text(fill: blue)[bold(1)], 0, 0, 0)
$

**Нормированные веса**

#figure(image("../images/weighted.svg", width: 100%))

Матрица весов $bold(W)$

$

mat(delim: "[", 0, 0, #text(fill: green)[bold(0.33)], 0, #text(fill: green)[bold(0.33)], #text(fill: green)[bold(0.33)], 0; 0, 0, #text(fill: blue)[bold(0.5)], 0, 0, 0, #text(fill: blue)[bold(0.5)]; 0, #text(fill: blue)[bold(0.25)], #text(fill: blue)[bold(0.25)], #text(fill: blue)[bold(0.25)], 0, 0, #text(fill: blue)[bold(0.25)]; #text(fill: red)[bold(0.25)], #text(fill: red)[bold(0.25)], #text(fill: red)[bold(0.25)], 0, #text(fill: red)[bold(0.25)], 0, 0; #text(fill: blue)[bold(0.2)], 0, 0, #text(fill: blue)[bold(0.2)], #text(fill: blue)[bold(0.2)], #text(fill: blue)[bold(0.2)], #text(fill: blue)[bold(0.2)]; #text(fill: blue)[bold(0.33)], 0, 0, #text(fill: blue)[bold(0.33)], #text(fill: blue)[bold(0.33)], 0, 0; 0, #text(fill: blue)[bold(0.33)], #text(fill: blue)[bold(0.33)], #text(fill: blue)[bold(0.33)], 0, 0, 0)

$

#figure(
  image("../docs/10_Regression_files/figure-revealjs/unnamed-chunk-14-1.png", width: 80%),
  caption: [график],
)

#figure(
  image("../docs/10_Regression_files/figure-revealjs/unnamed-chunk-15-1.png", width: 80%),
  caption: [график],
)

== Коэффициент корреляции Пирсона

Коэффициент корреляции Пирсона вычисляется как:

$
r_(x y) = ( sum_(i=1)^n (x_i - overline(x)) (y_i - overline(y)) ) / 
( sqrt(sum_(i=1)^n (x_i - overline(x))^2) sqrt(sum_(i=1)^n (y_i - overline(y))^2) )
$ где:

- $X = {x_i}$ и $Y = {y_i}$ -- две выборки значений;
- $overline(x)$ и $overline(y)$ -- средние арифметические.

*Примечание:* *Линейная зависимость:*
Коэффициент корреляции Пирсона показывает зависимость только для переменных, имеющих связь линейного характера

== Индекс Морана

Пространственную автокорреляцию можно оценить путем вычисления индекса Морана (Moran's I) [@moran:1950]:

$
I = ( n sum_(i=1)^n sum_(j=1)^n w_(i j) (y_i - overline(y)) (y_j - overline(y)) ) / 
( [sum_(i=1)^n sum_(j=1)^n w_(i j)] [sum_(i=1)^n (y_i - overline(y))^2] )
$

где:

- $n$ -- количество единиц,
- $w_(i j)$ -- вес пространственной связи между $i$-й и $j$-й единицей,
- $y_i$ -- значение в $i$-й единице,
- $overline(y)$ -- выборочное среднее по всем единицам


== Индекс Морана (Moran's I)

Индекс Морана для нормально распределенных данных лежит в диапазоне от $-1$ до $1$:

-   $+1$ означает детерминированную прямую зависимость --- группировку схожих (низких или высоких) значений;

-   $0$ означает абсолютно случайное распределение;

-   $-1$ означает детерминированную обратную зависимость --- идеальное перемешивание низких и высоких значений, напоминающее шахматную доску.

**Математическое ожидание** индекса Морана для случайных данных равно $E[I] = -1/(n-1)$

== Индекс Морана

#figure(
  image("../docs/10_Regression_files/figure-revealjs/unnamed-chunk-16-1.png", width: 80%),
  caption: [график],
)

Индекс Морана равен $0.500$

#figure(
  image("../docs/10_Regression_files/figure-revealjs/unnamed-chunk-17-1.png", width: 80%),
  caption: [график],
)

Индекс Морана равен $0.222$

Поскольку остатки регрессии по-прежнему автокоррелированы, можно сделать вывод о том, что независимые переменные не объясняют полностью величину преступности.

== Пространственная регрессия

Чтобы учесть пространственную автокорреляцию зависимой переменной, в модель линейной регрессии добавляется компонента **авторегрессии** $rho bold(W y)$ [@Anselin:1988]:

$
bold(y) = underbrace(bold(X) bold(beta), "тренд") + underbrace(#text(red)[$rho bold(W) bold(y)$], "сигнал") + underbrace(bold(epsilon), "шум"),
$

- $rho$ -- коэффициент авторегрессии, отражающий вклад пространственной автокорреляции;
- $bold(W)$ -- матрица пространственных весов.

Полученная модель называется **пространственной регрессией**.\
Тренд, сигнал и шум называются **предикторами**.

Пространственную регрессию можно представить как обычную регрессию. Выполним преобразования:

$
bold(y) &= bold(X) bold(beta) + rho bold(W) bold(y) + bold(epsilon) \
bold(y) - rho bold(W) bold(y) &= bold(X) bold(beta) + bold(epsilon) \
(bold(I) - rho bold(W)) bold(y) &= bold(X) bold(beta) + bold(epsilon) \
#rect(stroke: 1pt + red, inset: 8pt)[
  #text(blue)[$bold(y) = (bold(I) - rho bold(W))^(-1) bold(X) bold(beta) + (bold(I) - rho bold(W))^(-1) bold(epsilon)$]
]
$

Коэффициенты $beta$ и $rho$ находятся по методу наименьших квадратов.

Для нашего случая модель будет иметь вид:

$
"CRIME" = 45.603 - 1.049 "INC" - 0.266 "HOVAL" + 0.423 bold(W) "CRIME"
$

#figure(
  image("../docs/10_Regression_files/figure-revealjs/unnamed-chunk-18-1.png", width: 80%),
  caption: [график],
)

#figure(
  image("../docs/10_Regression_files/figure-revealjs/unnamed-chunk-19-1.png", width: 80%),
  caption: [график],
)

#figure(
  image("../docs/10_Regression_files/figure-revealjs/unnamed-chunk-20-1.png", width: 80%),
  caption: [график],
)

#figure(
  image("../docs/10_Regression_files/figure-revealjs/unnamed-chunk-21-1.png", width: 80%),
  caption: [график],
)

#figure(
  image("../docs/10_Regression_files/figure-revealjs/unnamed-chunk-22-1.png", width: 80%),
  caption: [график],
)

== Остатки пространств. регрессии

**Индекс Морана** для остатков пространств. регрессии равен $0.033$.

Автокорреляционная составляющая практически полностью учтена в модели пространственной регрессии. Предсказательная сила модели улучшена.

#figure(
  image("../docs/10_Regression_files/figure-revealjs/unnamed-chunk-23-1.png", width: 80%),
  caption: [график],
)

== Пространственная гетерогенность

**Пространственная гетерогенность** проявляется в том, что зависимости между переменными меняются по пространству.

Учет этого фактора позволяет значительно усилить качество регрессионных моделей.

*Примечание:* *Как это работает?:*
Например, стоимость недвижимости может по-разному реагировать на увеличение жилплощади и количества комнат в разных городских районах.

#figure(image("../images/heterogeneity.svg", width: 100%))

== Исходные данные

```r
realest = read_delim(url('https://www.jefftk.com/apartment_prices/apts-1542637382.txt'),
                 delim = ' ',
                 col_names = c('price', 'rooms', 'id', 'lon', 'lat')) %>%
  st_as_sf(coords = c('lon', 'lat'), crs = 4326) %>%
  st_transform(3395) |>
  arrange(price)
```

#figure(
  image("../docs/10_Regression_files/figure-revealjs/unnamed-chunk-25-1.png", width: 80%),
  caption: [график],
)

== Обычная регрессия

#figure(
  image("../docs/10_Regression_files/figure-revealjs/unnamed-chunk-26-1.png", width: 80%),
  caption: [график],
)

Коэффициент детерминации $R^2 = 0.1483$. Регрессионная модель:

$
"price" = 2319.2 +421.8~"rooms"
$

== Географич. взвешенная регрессия

В стандартной модели линейной регрессии параметры $beta$ предполагаются постоянными. Для $i$-й локации решение выглядит следующим образом:

$
y_i = beta_0 + beta_1 x_(1 i) + beta_2 x_(2 i) + dots.h + beta_k x_(k i) + epsilon_i
$

В географически взвешенной регрессии (ГВР) параметры $beta$ определяются для каждой локации @Fotheringham2002:

$
y_i = beta_(0 i) + beta_(1 i) x_(1 i) + beta_(2 i) x_(2 i) + dots.h + beta_(k i) x_(k i) + epsilon_i
$

В этом случае область оценки параметров $bold(beta)$ ограничивается некой окрестностью точки $i$.


== Весовая функция

Далёкие точки должны иметь меньший вес при вычислении коэффициентов. Например, для *гауссовой* весовой функции:

$
w_(i j) = exp( -1/2 (d_(i j) / h)^2 )
$

- $w_(i j)$ -- вес, который будет иметь $j$-я точка при вычислении коэффициентов регрессии в $i$-й точке;
- $d_(i j)$ -- расстояние между ними;
- $h$ -- полоса пропускания


#figure(image("../images/gwr_weights.svg", width: 100%))

== Весовые функции

В случае фиксированной весовой функции окрестность всегда имеет фиксированную полосу пропускания:

#figure(image("../images/nbfixed.svg", width: 100%))

В случае адаптивной весовой функции полоса пропускания определяется $N$ ближайшими точками. Например для $N = 5$:

#figure(image("../images/nbvariable.svg", width: 100%))

== Модель ГВР

В случае модели ГВР получается множество коэффициентов регрессии. По ним можно узнать статистику

```r
library(GWmodel)
samples = realest |> as('Spatial')
gwr_res = gwr.basic(price ~ rooms, data = samples, bw = 1000, kernel = 'gaussian')
```

```
              Min.   1st Qu. Median  3rd Qu. Max.
   Intercept  198.56 1785.17 2054.43 2361.79 3485.2
   rooms     -409.97  471.77  524.01  650.52 1299.1

   Kernel function: gaussian
   Fixed bandwidth: 1000
   Regression points: the same locations as observations are used.
   Distance metric: Euclidean distance metric is used
```

Коэффициент детерминации $R^2 = 0.367$.

== Коэффициенты ГВР

#figure(
  image("../docs/10_Regression_files/figure-revealjs/unnamed-chunk-28-1.png", width: 80%),
  caption: [график],
)

#figure(
  image("../docs/10_Regression_files/figure-revealjs/unnamed-chunk-29-1.png", width: 80%),
  caption: [график],
)

Пространственная картина распределения коэффициентов регрессии подтверждает гипотезу о гетерогенности.

== Словарик

Линейная регрессия

Метод наименьших квадратов

Диаграмма рассеяния

Остатки регрессии

Простр. автокорреляция

Пространственные соседи

Пространственные веса

Пространственная регрессия

Географически взвешенная регрессия (ГВР)

Полоса пропускания

Linear regression

Least squares method

Scatterplot

Regression residuals

Spatial autocorrelation

Spatial neighbours

Spatial weights

Spatial regression

Geographically weighted regression (GWR)

Bandwidth

== Библиография