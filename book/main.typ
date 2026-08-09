#import "template.typ": project

#show: doc => project(
  title: [Геоинформатика],
  subtitle: [Курс лекций],
  authors: (
    (name: "", affiliation: ""),
  ),
  abstract: [],
  doc,
)

#include "01_Geoinformation.typ"
#pagebreak()
#include "02_Models.typ"
#pagebreak()
#include "03_Georeferencing.typ"
#pagebreak()
#include "04_Databases.typ"
#pagebreak()
#include "05_Vector.typ"
#pagebreak()
#include "06_Raster.typ"
#pagebreak()
#include "07_Networks.typ"
#pagebreak()
#include "08_Dem.typ"
#pagebreak()
#include "09_Interpolation.typ"
#pagebreak()
#include "10_Regression.typ"
#pagebreak()
#include "11_PointPatterns.typ"
#pagebreak()
#include "12_Technologies.typ"
#pagebreak()

#bibliography("carto-msu.bib")
