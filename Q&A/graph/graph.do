cd /Users/gangli/Desktop/graph

import excel using "data.xlsx", firstrow clear

gen import_share_percent = Import_Market_Share*100
gen emission_sahre_percent = Emissions_Share*100
encode country,gen(Countries)

* Grpah1
tw (bar import_share_percent year) ///
(line emission_sahre_percent year),by(Countries, note("")) ///
scheme(s2mono) ///
ytitle("share (%)") xtitle("") ///
legend(row(1) lab(1 "Import Market") lab(2 "Emissions"))

// File created by Graph Editor Recorder.
gr_edit .l1title.DragBy 28.41946848417304 .2870653382239695
