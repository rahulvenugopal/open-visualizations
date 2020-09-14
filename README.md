

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3715576.svg)](https://doi.org/10.5281/zenodo.3715576)
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/jorvlan/open-visualizations/master)
# open-visualizations
```
van Langen, J. (2020). Open-visualizations in R and Python. 
https://github.com/jorvlan/open-visualizations
```

### Added rain_rain_come_again.R which is a script version of notebook [14.09.2020]
# Made in R
## Plots from rain_rain_come_again.R
![Repeated measures individual datapoints](https://github.com/rahulvenugopal/open-visualizations/blob/master/R/f1.png)
![Repeated measures with connecting lines](https://github.com/rahulvenugopal/open-visualizations/blob/master/R/f2.png)
![Repeated measures with jitter and connections](https://github.com/rahulvenugopal/open-visualizations/blob/master/R/f3.png)
![Repeated measures with jittered datapoints and connections](https://github.com/rahulvenugopal/open-visualizations/blob/master/R/f4.png)

![Repeated measures with box- and violin plots](https://github.com/rahulvenugopal/open-visualizations/blob/master/R/f5.png)

![Repeated measures with box- and violin plots](https://github.com/rahulvenugopal/open-visualizations/blob/master/R/f5b.png)

![Repeated measures with box- and violin plots](https://github.com/rahulvenugopal/open-visualizations/blob/master/R/f5c.png)

![ Repeated measures with box- and violin plots](https://github.com/rahulvenugopal/open-visualizations/blob/master/R/f6.png)
![Repeated measures with box- and violin plots and means + ci](https://github.com/rahulvenugopal/open-visualizations/blob/master/R/f7.png)
![2 x 2 Repeated measures with box- and violin plots](https://github.com/rahulvenugopal/open-visualizations/blob/master/R/f8.png)

![2 x 2 Repeated measures with box- and violin plots](https://github.com/rahulvenugopal/open-visualizations/blob/master/R/f9.png)
![Repeated measures with jittered datapoints and connections](https://github.com/rahulvenugopal/open-visualizations/blob/master/R/f10.png)
![Repeated measures with jittered datapoints and connections](https://github.com/rahulvenugopal/open-visualizations/blob/master/R/f11.png)
![Repeated measures with jittered datapoints and connections](https://github.com/rahulvenugopal/open-visualizations/blob/master/R/f12.png)

![Repeated measures with jittered datapoints and connections](https://github.com/rahulvenugopal/open-visualizations/blob/master/R/f13.png)
![Repeated measures with jittered datapoints and connections](https://github.com/rahulvenugopal/open-visualizations/blob/master/R/f14.png)

# Made in Python
![Example3](Python/tutorial_1/figure10.png)

This repository currently includes visualizations made with:
- Python (.ipynb)
- R (.rmd)

## Update 10 Augustus 2020:
Development of a R package has started and a first version is expected to be completed by September 2020.

## Update 30 April - 2020: 
Thanks to the overwhelming feedback on Twitter, and thanks to Micah Allen, I will try to implement some comments and upload an updated version somewhere in the next two months. It might be that, due to the recent Rstudio update, some package versions don't work anymore e.g., gghalves. If you encounter this problem, please try to install those packages from CRAN and if that doesn't work, try to install it from the respective GitHub package page. 


# Interactive tutorials
Both Python tutorials and the R tutorial are directly available through Binder. Click on the Binder launcher to open them! 

NOTE: if you want to open the R tutorial with Binder and use RStudio, you'll have to select RStudio within the Jupyter environment by - inside the R folder - clicking: 'new' -> 'RStudio'. This will open RStudio in Binder. If you perform the R tutorial in Binder, the error:`Error in grid.newpage() : could not open file ...` occurs when using ggsave. At this stage, I don't know how to fix this issue, but the figure will be presented, so please ignore this error.

# Background
The idea behind the ‘open-visualizations’ repository stems from the fact that (open) science - in general - lacks ‘fully’ transparent and robust visualizations, i.e., figures have always some form of ‘hidden-data’. To overcome this issue, I created this repository. Some of the work in R is inspired by work from Allen et al. (2019)(https://github.com/RainCloudPlots/RainCloudPlots)

There is a zenodo (https://doi.org/10.5281/zenodo.3715576) archive of the code and this repository is made available under the MIT license i.e., you can do with it what you want, but if you use it, reference needs to be given to the author of this repository.
```
van Langen, J. (2020). Open-visualizations in R and Python. 
https://github.com/jorvlan/open-visualizations
```

I hope that these tutorials are helpful for your research and if you have any questions, suggestions for improvement - I'm nor R nor Python Pro - or identify bugs, please open an issue in this repository. 
