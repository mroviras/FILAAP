/*******************************************************************************
PROJECT: FILAAP
AIM:     Analysis
AUTHOR:  Marti Rovira
Date:    25/05/2019			
*******************************************************************************/

*********************************************************************************
						* Preparations *
*********************************************************************************

** Required packages

* ssc inst tab_chi, replace  /// Consider installing it.

** Importing data

use "`c(pwd)'/database_final.dta", clear

*********************************************************************************
						* Descriptives *
*********************************************************************************
tab Wave if Outlier==0

* 
tab Wave Participation if Outlier==0
tab Wave Participation if Outlier==0, row

*
tab Wave Sample if Outlier==0 & Participation==1
tab Wave Sample if Outlier==0 & Participation==1, row

********************************************************************************
				* Request motivation *
********************************************************************************

tab Request_Motivation Wave if Outlier==0 & Participation==1, col chi

********************************************************************************
				* Creation of the main table *
********************************************************************************

** Step1: Other/Employment

gen Step1=1 if Request_Motivation==1
replace Step1=2 if Request_Motivation!=1 & Request_Motivation!=.

label define Step1lbl ///
	1 "Employment in Spain" ///
	2 "Non-Prof."
	
label values Step1 Step1lbl

tab Step1 Wave if Outlier==0 & Sample==1, col chi

** Step2: Other/Mandatory/Non-Mandatory

quietly {
	gen Step2=.
	replace Step2=1 if Request_Motivation!=1 & Request_Motivation!=.
	replace Step2=2 if Request_Motivation==1 & Request_Mand==1
	replace Step2=3 if Request_Motivation==1 & Request_Mand==0

	label define Step2lbl 1"Non-Prof." 2"Mand." 3"Non-Mand."
	label value Step2 Step2lbl
}

tab Step2 Wave if Outlier==0 & Sample==1, col chi

** Step3: Other/Mandatory/Non-Mandatory by minors

quietly {
	gen Step3=.
	replace Step3=1 if Request_Motivation!=1 & Request_Motivation!=.
	replace Step3=2 if Request_Motivation==1 & Request_Mand==1
	replace Step3=3 if Request_Motivation==1 & Request_CAP==1 & Request_Mand_CAP==0 
	replace Step3=5 if Request_Motivation==1 & Request_CAP==1 & Request_Mand_CAP==0 & Job_Children==1
	replace Step3=4 if Request_Motivation==1 & Request_CDNS==1 & Request_Mand_CDNS==0

	label define Step3lbl 1"Non-Prof." 2"Mand." 3"Function Creep" 4"Legal Ambiguity Effect" 5"Not classified"
	label value Step3 Step3lbl
}

tab Step3 Wave if Outlier==0 & Sample==1, col chi

** Step 4 (Refinement1 - Wrong certificate)

quietly {
	gen Step4=.
	replace Step4=1 if Request_Motivation!=1 & Request_Motivation!=.
	replace Step4=2 if Request_Motivation==1 & Request_Mand==1
	replace Step4=3 if Request_Motivation==1 & Request_CAP==1 & Request_Mand_CAP==0 
	replace Step4=4 if Request_Motivation==1 & Request_CDNS==1 & Request_Mand_CDNS==0
	replace Step4=6 if Request_Motivation==1 & Request_CAP==1 & Request_Mand_CAP==0 & Job_Children1==1
	replace Step4=5 if Request_Motivation==1 & Request_CAP==1 & Request_Mand_CAP==0 & Job_Children2==1

	label define Step4lbl 1"Non-Prof." 2"Mand." 3"Function Creep" 4"Legal Ambiguity effect" ///
							6"Wrong Certificate" 5"Not classified"
	label value Step4 Step4lbl
}

tab Step4 Wave if Outlier==0 & Sample==1, col chi


** Step 5 (Refinement 2 - New Technological Companies=

quietly {
	gen Step5=.
	replace Step5=1 if Request_Motivation!=1 & Request_Motivation!=.
	replace Step5=2 if Request_Motivation==1 & Request_Mand==1
	replace Step5=3 if Request_Motivation==1 & Request_CAP==1 & Request_Mand_CAP==0 
	replace Step5=6 if Request_Motivation==1 & Request_CAP==1 & Request_Mand_CAP==0 & Job_Children1==1
	replace Step5=5 if Request_Motivation==1 & Request_CAP==1 & Request_Mand_CAP==0 & Job_Children2==1
	replace Step5=7 if Request_Motivation==1 & Request_CAP==1 & Request_Mand_CAP==0 & Job_New_Tech==1
	replace Step5=4 if Request_Motivation==1 & Request_CDNS==1 & Request_Mand_CDNS==0


	label define Step5lbl 1"Non-Prof." 2"Mand." 3"Function Creep" 4 "Legal Ambiguity Effect" ///
						6"Wrong Certificate" 5"Not classified" 7"New Tech."
	label value Step5 Step5lbl
}
tab Step5 Wave if Outlier==0 & Sample==1, col chi


********* Labelling tables

lab var Step1 "Table Step 1: Non-Professional vs. Professional requests "
lab var Step2 "Table Step 2: Mandatory vs. Non-Mandatory"
lab var Step3 "Table Step 3: First indicators"
lab var Step4 "Table Step 4: First refinement: Wrong certificate"
lab var Step5 "Table Step 5: Second refinement: New tech. companies"


********* Creating maing table ********* 

tabout Step1 Step2 Step3 Step4 Step5 Wave using table1.xls ///
if Outlier==0 & Sample==1, c(freq col) replace ptotal(single) stats(chi2)


********************************************************************************
                *** Creation figure 1 ****
********************************************************************************

tab Step5 Wave if Outlier==0 & Sample==1, col nof

********************************************************************************
				** Final table with adjusted residuals **
********************************************************************************


tab Step5 Wave if Outlier==0 & Sample==1, col 

tabchi Step5 Wave if Outlier==0 & Sample==1, adjust noo

tabchi Step5 Wave if Outlier==0 & Sample==1 & Wave!=3, adjust noo

tabchi Step5 Wave if Outlier==0 & Sample==1 & Wave!=2, adjust noo

tabchi Step5 Wave if Outlier==0 & Sample==1 & Wave!=1, adjust noo

********************************************************************************
					** Table for each variable **
********************************************************************************

preserve

	lab var Job_Type_REC "Type of Job"

	tabout Job_Type_REC Wave if Step5==2 & Outlier==0 & Sample==1 using table_2.xls, c(freq col) replace 
	tabout Job_Type_REC Wave if Step5==3 & Outlier==0 & Sample==1 using table_2.xls, c(freq col) append
	tabout Job_Type_REC Wave if Step5==4 & Outlier==0 & Sample==1 using table_2.xls, c(freq col) append
	tabout Job_Type_REC Wave if Step5==5 & Outlier==0 & Sample==1 using table_2.xls, c(freq col) append
	tabout Job_Type_REC Wave if Step5==6 & Outlier==0 & Sample==1 using table_2.xls, c(freq col) append 
	tabout Job_Type_REC Wave if Step5==7 & Outlier==0 & Sample==1 using table_2.xls, c(freq col) append 

restore 
********************************************************************************
						** Demographics **
********************************************************************************

*** Creation of variables for the table format

* Woman

gen Woman=.
replace Woman=1 if Gender==2
replace Woman=2 if Gender==1

gen Man=.
replace Man=2 if Gender==2
replace Man=1 if Gender==1

* Non_National
gen National=.
replace National=1 if Origin_REC==1
replace National=1 if Origin_REC==2
replace National=2 if Origin_REC==3
replace National=2 if Origin_REC==4

gen Non_National=.
replace Non_National=2 if Origin_REC==1
replace Non_National=2 if Origin_REC==2
replace Non_National=1 if Origin_REC==3
replace Non_National=1 if Origin_REC==4

* Primary

gen Primary=.
replace Primary=1 if Education_REC==1
replace Primary=2 if Education_REC==2
replace Primary=2 if Education_REC==3

gen Secondary=.
replace Secondary=2 if Education_REC==1
replace Secondary=1 if Education_REC==2
replace Secondary=2 if Education_REC==3

* University

gen University=.
replace University=2 if Education_REC==1
replace University=2 if Education_REC==2
replace University=1 if Education_REC==3

** Labelling variables

lab val Woman Man National Non_National Primary Secondary University dicolbl

** Some extra values needed

global zero="."
global cent = "100"

** Creation of the matrix of variables for categorical variables


foreach v of var Man Woman National Non_National Primary Secondary University {
	foreach i in 1 2 3 4 5 6 7 {
	tab Wave `v' if Outlier==0 & Sample==1 & Step5==`i' , row matcell(freq) chi
	global g_pvalue_`i' = r(p)

	mata: st_matrix("freq", (st_matrix("freq")  :/ rowsum(st_matrix("freq"))))

	mat li freq , format("%3.2f")

	global g_2014_`i'=(freq[1,1]*100)
	global g_2016_`i'=(freq[2,1]*100)
	global g_2018_`i'=(freq[3,1]*100)
	
	tab `v' if Outlier==0 & Sample==1 & Step5==`i', matcell(freq)
	global g_total_`i'=(freq[1,1]/(freq[1,1]+freq[2,1]))*100

	}
	tab Wave `v' if Outlier==0 & Sample==1, row matcell(freq) chi
	global g_pvalue_total = r(p)
	mata: st_matrix("freq", (st_matrix("freq")  :/ rowsum(st_matrix("freq"))))
	
	global g_2014_total=(freq[1,1]*100)
	global g_2016_total=(freq[2,1]*100)
	global g_2018_total=(freq[3,1]*100)
	
	matrix `v' = ($g_2014_1 \ $g_2016_1 \ $g_2018_1 \ $g_total_1 \ $g_pvalue_1   ///
					\ $g_2014_2 \ $g_2016_2 \ $g_2018_2 \ $g_total_2 \ $g_pvalue_2 ///
					\ $g_2014_3 \ $g_2016_3 \ $g_2018_3 \ $g_total_3 \ $g_pvalue_3 ///
					\ $zero \ $g_2014_4 \ $g_2016_4 \ $g_total_4 \ $g_pvalue_4 ///
					\ $g_2014_5 \ $g_2016_5 \ $g_2018_5 \ $g_total_5 \ $g_pvalue_5 ///
					\ $g_2014_6 \ $g_2016_6 \ $g_2018_6 \ $g_total_6 \ $g_pvalue_6 ///
					\ $zero \ $zero \ $g_2014_7 \ $g_total_7 \ $g_pvalue_7 ///
					\ $g_2014_total \ $g_2016_total \ $g_2018_total \ $cent ///
					\ $g_pvalue_total ///
					)
					
	matrix list `v'

}

** Creation of the matrix of variables for the quantitative variables

foreach i in 1 2 3 4 5 6 7 {
	mean Age if Outlier==0 & Sample==1 & Step5==`i', over(Wave)
	ereturn list
	
	matrix mean_`i'=e(b)
	
	**
	mata st_matrix("dev",sqrt(diagonal(st_matrix("e(V)"))))
	
	global g_2014_dev_`i'=(dev[1,1])
	global g_2016_dev_`i'=(dev[2,1])
	global g_2018_dev_`i'=(dev[3,1])
	
	******
	
	
	mean Age if Outlier==0 & Sample==1 & Step5==`i'
	ereturn list
	matrix mean_total_`i'=e(b)
	
	**
	
	mata st_matrix("dev",sqrt(diagonal(st_matrix("e(V)"))))
	
	global g_2014_dev_total_`i'=(dev[1,1])
	
	
}
	mean Age if Outlier==0 & Sample==1, over(Wave)
	ereturn list
	matrix mean_total=e(b)
	
	**
	
	mata st_matrix("dev",sqrt(diagonal(st_matrix("e(V)"))))

	global g_2014_dev_total=(dev[1,1])
	global g_2016_dev_total=(dev[2,1])
	global g_2018_dev_total=(dev[3,1])
	
	mean Age if Outlier==0 & Sample==1
	ereturn list
	matrix mean_total_total=e(b)
	
	global g_Age_dev_total_total=(dev[1,1])

	**
	
	matrix Age_dev = ($g_2014_dev_1 \ $g_2016_dev_1 \ $g_2018_dev_1 \ $g_2014_dev_total_1 \ $zero   ///
					\ $g_2014_dev_2 \ $g_2016_dev_2 \ $g_2018_dev_2 \ $g_2014_dev_total_2 \ $zero   ///
					\ $g_2014_dev_3 \ $g_2016_dev_3 \ $g_2018_dev_3 \ $g_2014_dev_total_3 \ $zero   ///
					\ $zero \ $g_2014_dev_4 \ $g_2016_dev_4 \ $g_2014_dev_total_4 \ $zero   ///
					\ $g_2014_dev_5 \ $g_2016_dev_5 \ $g_2018_dev_5 \ $g_2014_dev_total_5 \ $zero   ///
					\ $g_2014_dev_6 \ $g_2016_dev_6 \ $g_2018_dev_6 \ $g_2014_dev_total_6 \ $zero  ///
					\ $zero \ $zero \ $g_2014_dev_7 \ $g_2014_dev_7 \ $zero //////
					\ $g_2014_dev_total \ $g_2016_dev_total \ $g_2018_dev_total \ $g_Age_dev_total_total \ $zero ///
					)	
	

matrix Age = (mean_1, mean_total_1, $zero, mean_2, mean_total_2, $zero, mean_3, ///
mean_total_3, $zero, $zero, mean_4, mean_total_4, $zero, mean_5, mean_total_5, ///
$zero, mean_6, mean_total_6, $zero, $zero, $zero, mean_7, mean_total_7, $zero, ///
mean_total, mean_total_total, $zero)

matrix Age_b = (Age)'


** Calculation of variables following distribution

foreach i in 1 2 3 4 5 6 7 {
	tab Wave if Outlier==0 & Sample==1 & Step5==`i', matcell(freq)
	
	mata: st_matrix("freq", (st_matrix("freq")  :/ colsum(st_matrix("freq"))))
	matrix list freq
	
	global g_2014_`i'=(freq[1,1]*100)
	global g_2016_`i'=(freq[2,1]*100)
	global g_2018_`i'=(freq[3,1]*100)

	matrix CatxWave = ($g_2014_1 \ $g_2016_1 \ $g_2018_1 \ $cent \ $zero   ///
					\ $g_2014_2 \ $g_2016_2 \ $g_2018_2 \ $cent \ $zero ///
					\ $g_2014_3 \ $g_2016_3 \ $g_2018_3 \ $cent \ $zero ///
					\ $zero \ $g_2014_4 \ $g_2016_4 \ $cent\ $zero ///
					\ $g_2014_5 \ $g_2016_5 \ $g_2018_5 \ $cent \ $zero ///
					\ $g_2014_6 \ $g_2016_6 \ $g_2018_6 \ $cent \ $zero ///
					\ $zero \ $zero \ $g_2014_7 \ $cent \ $zero ///
					\ $g_2014_total \ $g_2016_total \ $g_2018_total \ $cent \ $zero ///
					)
					
	matrix list CatxWave
}


* Cat x Wave Pending???

matrix dmat = (Woman, Man, Age_b, Age_dev, National, Non_National, Primary, Secondary, University, CatxWave)

matrix rownames dmat= "Non Prof 2014" "Non Prof 2016" "Non Prof 2018" "Non Prof total" "p-value chi2" ///
"Mand 2014" "Mand 2016" "Mand 2018" "Mand total" "p-value chi2" ///
"Func Creep 2014" "Func Creep 2016" "Func Creep 2018" "Func Creep total" "p-value chi2"  ///
"Legal Amb 2014" "Legal Amb 2016" "Legal Amb 2018" "Legal Amb total" "p-value chi2" ///
"Not class 2014" "Not class 2016" "Not class 2018" "Not class total" "p-value chi2" ///
"Wrong Cert 2014" "Wrong Cert 2016" "Wrong Cert 2018" "Wrong Cert total" "p-value chi2" ///
"New Tech 2014" "New Tech 2016" "New Tech 2018" "New Tech total" "p-value chi2" ///
"Total 2014" "Total 2016" "Total 2018" "Total (all waves)" "p-value chi2"
					
matrix colnames dmat= "Woman (%)" "Man (%)" "Age(mean)" "Age(dev)" "National (%)" ///
"Non-National (%)" "Primary (%)" "Secondary (%)" "Tertiary (%)" "Wave (%)"

matrix list dmat, format ("%3.2f")


*********************************************************************************
*********************************************************************************

exit, clear
