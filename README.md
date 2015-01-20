This is a simplified implementation of handsontable.

It is a fork from https://github.com/AnalytixWare/ShinySky
I found it prefereable to Jeff's implementation at https://github.com/trestletech/shinyTable purely because it handles working with partials / containers

The main changes from ShinySky are:

* Code simplified (i.e. just handsontable)
* First column can be anything 
* RAG status implementation (it works but it requires more testing)
* Using data.table instead of plyr for speed

# TODO:
Comment management? Latest versions of handsontable handle cell comments like Excel...

# Install
To istall a github package you need the `devtools` package installed.  If you do not have the `devtools` package installed, run this first
```s
install.packages(devtools)
```

If you already have the `devtools` package installed, simply run

```s
devtools::install_github("smartinsightsfromdata/shinyhdtable”)
```


