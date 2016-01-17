# ggmap-presentation  

This repository contains all the files used for the presentation on ggmap given at the Statistical Programming DC Meet Up in March 2015.

**Update January 2016**  
Updates to **ggmap** have changed the default service for geocoding locations.  The default service is the Data Science Toolkit.  [Unfortunately Data Science Toolkit does not appear to be up and running any longer](https://github.com/dkahle/ggmap/issues/73).  The presentation code has been updated to specify Google as the source for geocodeing.  


## To Follow Along During the Presentation  

**There will not be internet access for the auidence at the presentation and therefore will not be able to get the maps or install packages without doing so before arriving.**

1. Download the zip file or clone the repository.  
2. Open the R Studio Project.  
3. Install the *ggplot2*, *ggmap* and *data.table* packages.  
4. Before the presentation while you have an internet connection open Presentation_Code.R and run lines 40, 61 and 67.  This will provide the background maps used during the presentation.  
5. *Do Not Close your R Session.*  R will continue to hold the maps in memory which you can use in the presentation.  

## Files Included  
1. **ggmap-presentation.Rproj:** R Studio Project  
2. **Presentation_Code.R:** A copy of the code run demonstrated during the talk.  
3. **slides.Rpres:** A copy of the R Markdown code used to create the HTML slides used during the presentation.    
4. **presentation_data.csv:** Data used during the presentation.  Contains the daily average of trips from bike share stations in Washington, DC.  
5. **zipcode_shapefile:** Contains Shape Files for Washington DC.  Used in the presentation slides.