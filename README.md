
<!-- README.md is generated from README.Rmd. Please edit that file -->

# shiny for accessing to clean fuels for cooking vs gdp per capita

## Siyi Li (29018102)

In this shinyapp, the package is used including: **shiny**, **plotly**,
**tidyverse**, **crosstalk**, **DT**, **ggplot2**

Please install all this package before you visit the shinyapp.

``` r
install.packages(c("shiny", "crosstalk", "plotly", "DT", "tidyverse", "here","ggplot2"))
```

## How to run the app

-   About the **chart** session, which shows the access to the fuels for
    cooking and GDP per capita.

On the upper left of the chart, you can click the **Linearize x-axis**
to get the different chart which has the linear x-axis (the value on the
x-axis without the log10 transformation).

On the upper right of the chart, you could click **Hide countries &lt; 1
million** to filter out the countries which has population size less
than 1 million.

On the middle, you could find a box which has the lable **Which country
do you want to analyze**, you can select one or more countries and get
their information.

On the bottom of the chart, you also can find a time bar, you can move
the circle button to see the points in different years.

Finally, you can click each point to get more details.

-   About the **table** session, you can click the top of the table
    button to get the whole dataset.

The table contains the variables like continent, country, code, year,
new\_cooking, new\_gdp\_per\_capita and population. in each variable
column, you could sort the variable with decreasing or incresing order.

You also can search something that you are interested in.

-   About the **about** session, you can find more information from the
    source link, and you can find my Github from the Github link.

## Session Information

The session info is:

``` r
 sessioninfo::session_info()
#> ─ Session info ───────────────────────────────────────────────────────────────
#>  setting  value                       
#>  version  R version 4.1.1 (2021-08-10)
#>  os       macOS Catalina 10.15.7      
#>  system   x86_64, darwin17.0          
#>  ui       X11                         
#>  language (EN)                        
#>  collate  en_AU.UTF-8                 
#>  ctype    en_AU.UTF-8                 
#>  tz       Australia/Melbourne         
#>  date     2021-09-24                  
#> 
#> ─ Packages ───────────────────────────────────────────────────────────────────
#>  package     * version date       lib source        
#>  cli           3.0.1   2021-07-17 [1] CRAN (R 4.1.0)
#>  digest        0.6.27  2020-10-24 [1] CRAN (R 4.1.0)
#>  evaluate      0.14    2019-05-28 [1] CRAN (R 4.1.0)
#>  fastmap       1.1.0   2021-01-25 [1] CRAN (R 4.1.0)
#>  htmltools     0.5.2   2021-08-25 [1] CRAN (R 4.1.0)
#>  knitr         1.33    2021-04-24 [1] CRAN (R 4.1.0)
#>  magrittr      2.0.1   2020-11-17 [1] CRAN (R 4.1.0)
#>  rlang         0.4.11  2021-04-30 [1] CRAN (R 4.1.0)
#>  rmarkdown     2.10    2021-08-06 [1] CRAN (R 4.1.0)
#>  rstudioapi    0.13    2020-11-12 [1] CRAN (R 4.1.0)
#>  sessioninfo   1.1.1   2018-11-05 [1] CRAN (R 4.1.0)
#>  stringi       1.7.4   2021-08-25 [1] CRAN (R 4.1.0)
#>  stringr       1.4.0   2019-02-10 [1] CRAN (R 4.1.0)
#>  withr         2.4.2   2021-04-18 [1] CRAN (R 4.1.0)
#>  xfun          0.25    2021-08-06 [1] CRAN (R 4.1.0)
#>  yaml          2.2.1   2020-02-01 [1] CRAN (R 4.1.0)
#> 
#> [1] /Library/Frameworks/R.framework/Versions/4.1/Resources/library
```
