/*******************************************************************************
PROJECT: FILAAP
AIM:     Definition of final database + Translation to English
AUTHOR: Marti Rovira
Date: 25/05/2019			
*******************************************************************************/

use "`c(pwd)'/database_0.dta", clear

********************************************************************************
					* Translation of main variables *
********************************************************************************


lab var ID "Main identifier"

**

rename Ola Wave
lab var Wave "Wave"

**

rename Dia Date
lab var Date "Date of the interview"

**

rename Encuestador Surveyor
lab var Surveyor "Interviewer ID"

**

rename Participacion Participation
lab var Participation "The interviewee accepts to take part on the survey"

**

rename Certificado Request_Certificate
lab var Request_Certificate "The subject has come the office to request a certificate"

**

rename muestra Sample
lab var Sample "The request is part of the sample of analysis"

**

rename Certificado_Tipo Request_Type
lab var Request_Type "Type of certificate requested"

**

rename CAP Request_CAP
lab var Request_CAP "CAP is requested"

**

rename CDNS Request_CDNS
lab var Request_CDNS "CDNS is requested"

**

gen Request_Motivation=Motivo_Peticion

label define RM_lbl ///
	1 "Employment in Spain" ///
	2 "Employment in other countries" ///
	3 "VISA in Spain" ///
	4 "VISA in other countries" ///
	5 "Licences" ///
	6 "Expungement" ///
	7 "Other" ///
	9 "Don't Know / No respose"
	
drop Motivo_Peticion

lab var Request_Motivation "Motivation to request the certificate"
	
label values Request_Motivation RM_lbl

**

rename Tipo_Trabajo Job_Type
lab var Job_Type "Type of job (original)"

**

rename Tipo_Trabajo_Tecnologico Job_New_Tech
lab var Job_New_Tech "Job related with new technological companies"


**

rename Tipo_Trabajo_Menores Job_Children
lab var Job_Children "Job involving some type of contact with children"

**

rename Tipo_Trabajo_Menores1 Job_Children1
lab var Job_Children1 "Job involving regular contact with children"

**

rename Tipo_Trabajo_Menores2 Job_Children2
lab var Job_Children2 "Job involving unfrequent contact with children"

**

rename Tipo_Trabajo_Pais Job_country 
lab var Job_country "Country for which the request of certificate came from"

**

rename Tipo_Trabajo_Pais_REC1 Job_Spain 
lab var Job_Spain "The job is in Spain"

**

rename marcolegalCAP Request_Mand_CAP
lab var Request_Mand_CAP "The request is mandatory for CAP"

**

rename marcolegalCDNS Request_Mand_CDNS
lab var Request_Mand_CDNS "The request is mandatory for CDNS"

**

rename marcolegalTOT Request_Mand
lab var Request_Mand "The request is mandatory (Both Certificates)"

**

rename Genero Gender
lab var Gender "Gender of the interviewee"

**

rename Edad Age
lab var Age "Age of the interviewee"

**

rename Origen Origin
label var Origin "Place of birth of the interviewee"

**

rename Origen_REC Origin_REC
label var Origin_REC "Place of birth (RECODE)"

**

rename NivelEstudios Education
label var Education "Level of education (Original)"

**

rename NivelEstudios_REC Education_REC
label var Education_REC "Level of education (Recode)"

**

rename doubtful Outlier
lab var Outlier "Outlier"

********************************************************************************
* Labels

label define dicolbl 1 "Yes", modify
label define dicolbl 9 "DK", modify

lab val Request_CAP dicolbl
lab val Request_CDNS dicolbl
lab val Request_Mand dicolbl
lab val Job_New_Tech dicolbl
lab val Job_Children1 dicolbl
lab val Job_Children2 dicolbl
lab val Job_Spain Outlier dicolbl

label define Genero 1 "Man", modify
label define Genero 2 "Woman", modify
label define Origenlbl 1 "Catalonia" 2 "Rest of Spain" 3 "Other EU country" ///
	4 "Third country", replace
label define NivelEstudios 1 "Primary", modify
label define NivelEstudios 2 "Secondary", modify
label define NivelEstudios 3 "University", modify

label define Enquestador 1 "Student 1", modify
label define Enquestador 2 "Author", modify
label define Enquestador 3 "Student 2", modify
label define Enquestador 4 "Student 3", modify



********************************************************************************
						* JOBS X CATEGORY *
********************************************************************************

gen job_sector=.
	replace job_sector=1 if Tipo_Trabajo_REC==7
	replace job_sector=1 if Tipo_Trabajo_REC==48
	replace job_sector=1 if Tipo_Trabajo_REC==78
	replace job_sector=1 if Tipo_Trabajo_REC==94
	replace job_sector=1 if Tipo_Trabajo_REC==90
	replace job_sector=2 if Tipo_Trabajo_REC==46
	replace job_sector=2 if Tipo_Trabajo_REC==54
	replace job_sector=2 if Tipo_Trabajo_REC==86
	replace job_sector=3 if Tipo_Trabajo_REC==11
	replace job_sector=3 if Tipo_Trabajo_REC==12
	replace job_sector=3 if Tipo_Trabajo_REC==91
	replace job_sector=4 if Tipo_Trabajo_REC==13
	replace job_sector=4 if Tipo_Trabajo_REC==18
	replace job_sector=4 if Tipo_Trabajo_REC==44
	replace job_sector=5 if Tipo_Trabajo_REC==17
	replace job_sector=5 if Tipo_Trabajo_REC==97
	replace job_sector=5 if Tipo_Trabajo_REC==69
	replace job_sector=5 if Tipo_Trabajo_REC==83
	replace job_sector=5 if Tipo_Trabajo_REC==40
	replace job_sector=5 if Tipo_Trabajo_REC==96
	replace job_sector=5 if Tipo_Trabajo_REC==95
	replace job_sector=5 if Tipo_Trabajo_REC==60
	replace job_sector=5 if Tipo_Trabajo_REC==3
	replace job_sector=6 if Tipo_Trabajo_REC==20
	replace job_sector=6 if Tipo_Trabajo_REC==29
	replace job_sector=6 if Tipo_Trabajo_REC==39
	replace job_sector=7 if Tipo_Trabajo_REC==53
	replace job_sector=7 if Tipo_Trabajo_REC==36
	replace job_sector=7 if Tipo_Trabajo_REC==85
	replace job_sector=8 if Tipo_Trabajo_REC==61
	replace job_sector=8 if Tipo_Trabajo_REC==62
	replace job_sector=8 if Tipo_Trabajo_REC==67
	replace job_sector=9 if Tipo_Trabajo_REC==22
	replace job_sector=9 if Tipo_Trabajo_REC==2
	replace job_sector=9 if Tipo_Trabajo_REC==8
	replace job_sector=9 if Tipo_Trabajo_REC==33
	replace job_sector=9 if Tipo_Trabajo_REC==52
	replace job_sector=10 if Tipo_Trabajo_REC==16
	replace job_sector=10 if Tipo_Trabajo_REC==1
	replace job_sector=10 if Tipo_Trabajo_REC==77
	replace job_sector=11 if Tipo_Trabajo_REC==31
	replace job_sector=12 if Tipo_Trabajo_REC==15
	replace job_sector=12 if Tipo_Trabajo_REC==28
	replace job_sector=12 if Tipo_Trabajo_REC==47
	replace job_sector=12 if Tipo_Trabajo_REC==76
	replace job_sector=12 if Tipo_Trabajo_REC==15
	replace job_sector=12 if Tipo_Trabajo_REC==38
	replace job_sector=12 if Tipo_Trabajo_REC==41
	replace job_sector=13 if Tipo_Trabajo_REC==9
	replace job_sector=13 if Tipo_Trabajo_REC==24
	replace job_sector=13 if Tipo_Trabajo_REC==34
	replace job_sector=13 if Tipo_Trabajo_REC==23
	replace job_sector=13 if Tipo_Trabajo_REC==35
	replace job_sector=13 if Tipo_Trabajo_REC==37
	replace job_sector=14 if Tipo_Trabajo_REC==21
	replace job_sector=14 if Tipo_Trabajo_REC==49
	replace job_sector=14 if Tipo_Trabajo_REC==73
	replace job_sector=15 if Tipo_Trabajo_REC==19
	replace job_sector=15 if Tipo_Trabajo_REC==50
	replace job_sector=15 if Tipo_Trabajo_REC==26
	replace job_sector=16 if Tipo_Trabajo_REC==79
	replace job_sector=16 if Tipo_Trabajo_REC==93
	replace job_sector=17 if Tipo_Trabajo_REC==10
	replace job_sector=17 if Tipo_Trabajo_REC==42
	replace job_sector=17 if Tipo_Trabajo_REC==43
	replace job_sector=18 if Tipo_Trabajo_REC==80
	replace job_sector=18 if Tipo_Trabajo_REC==63
	replace job_sector=18 if Tipo_Trabajo_REC==45
	replace job_sector=18 if Tipo_Trabajo_REC==65
	replace job_sector=18 if Tipo_Trabajo_REC==74
	replace job_sector=18 if Tipo_Trabajo_REC==66
	replace job_sector=18 if Tipo_Trabajo_REC==75
	replace job_sector=18 if Tipo_Trabajo_REC==82
	replace job_sector=98 if Tipo_Trabajo_REC==98
	replace job_sector=99 if Tipo_Trabajo_REC==99
	replace job_sector=. if Request_Motivation!=1


label var job_sector "Job by sector"
label define job_sectorlbl ///
	1 "Road Transport (1)" ///
	2 "Port / Airport (2)" ///
	3 "Private Security (3)" ///
	4 "Public Secutiry (4)" ///
	5 "Minors (5)" ///
	6 "Health (6)" ///
	7 "Social Services (7)" ///
	8 "Personal services (8)" ///
	9 "Financial sector (9)" ///
	10 "Licensed Jobs (10)" ///
	11 "Primary sector (11)" ///
	12 "Industry (12)" ///
	13 "Building / Installation services (13)" ///
	14 "Clerical Jobs (14)" ///
	15 "Contact with public (15)" ///
	16 "Managerial Positions (16)" ///
	17 "International Organisations (17)" ///
	18 "Other (18)" ///
	98 "DK / NA (98)"

label val job_sector job_sectorlbl

rename job_sector Job_Sector

lab var Job_Sector "Sector of the company"

******

gen job_type=.
	replace job_type=1 if Tipo_Trabajo_REC==7
	replace job_type=2 if Tipo_Trabajo_REC==48
	replace job_type=3 if Tipo_Trabajo_REC==78
	replace job_type=4 if Tipo_Trabajo_REC==94
	replace job_type=5 if Tipo_Trabajo_REC==90
	replace job_type=10 if Tipo_Trabajo_REC==46
	replace job_type=11 if Tipo_Trabajo_REC==54
	replace job_type=12 if Tipo_Trabajo_REC==86
	replace job_type=21 if Tipo_Trabajo_REC==11
	replace job_type=22 if Tipo_Trabajo_REC==12
	replace job_type=23 if Tipo_Trabajo_REC==91
	replace job_type=31 if Tipo_Trabajo_REC==13
	replace job_type=32 if Tipo_Trabajo_REC==18
	replace job_type=33 if Tipo_Trabajo_REC==44
	replace job_type=44 if Tipo_Trabajo_REC==17
	replace job_type=45 if Tipo_Trabajo_REC==97
	replace job_type=46 if Tipo_Trabajo_REC==69
	replace job_type=47 if Tipo_Trabajo_REC==83
	replace job_type=48 if Tipo_Trabajo_REC==40
	replace job_type=48 if Tipo_Trabajo_REC==96
	replace job_type=50 if Tipo_Trabajo_REC==95
	replace job_type=51 if Tipo_Trabajo_REC==60
	replace job_type=53 if Tipo_Trabajo_REC==3
	replace job_type=61 if Tipo_Trabajo_REC==20
	replace job_type=62 if Tipo_Trabajo_REC==29
	replace job_type=63 if Tipo_Trabajo_REC==39
	replace job_type=71 if Tipo_Trabajo_REC==53
	replace job_type=72 if Tipo_Trabajo_REC==36
	replace job_type=73 if Tipo_Trabajo_REC==85
	replace job_type=81 if Tipo_Trabajo_REC==61
	replace job_type=82 if Tipo_Trabajo_REC==62
	replace job_type=83 if Tipo_Trabajo_REC==67
	replace job_type=91 if Tipo_Trabajo_REC==22
	replace job_type=91 if Tipo_Trabajo_REC==2
	replace job_type=93 if Tipo_Trabajo_REC==8
	replace job_type=95 if Tipo_Trabajo_REC==33
	replace job_type=96 if Tipo_Trabajo_REC==52
	replace job_type=101 if Tipo_Trabajo_REC==16
	replace job_type=102 if Tipo_Trabajo_REC==1
	replace job_type=103 if Tipo_Trabajo_REC==77
	replace job_type=110 if Tipo_Trabajo_REC==31
	replace job_type=121 if Tipo_Trabajo_REC==15
	replace job_type=121 if Tipo_Trabajo_REC==28
	replace job_type=121 if Tipo_Trabajo_REC==47
	replace job_type=121 if Tipo_Trabajo_REC==76
	replace job_type=121 if Tipo_Trabajo_REC==15
	replace job_type=126 if Tipo_Trabajo_REC==38
	replace job_type=127 if Tipo_Trabajo_REC==41
	replace job_type=131 if Tipo_Trabajo_REC==9
	replace job_type=132 if Tipo_Trabajo_REC==24
	replace job_type=133 if Tipo_Trabajo_REC==34
	replace job_type=134 if Tipo_Trabajo_REC==23
	replace job_type=135 if Tipo_Trabajo_REC==35
	replace job_type=136 if Tipo_Trabajo_REC==37
	replace job_type=137 if Tipo_Trabajo_REC==21
	replace job_type=138 if Tipo_Trabajo_REC==49
	replace job_type=139 if Tipo_Trabajo_REC==73
	replace job_type=140 if Tipo_Trabajo_REC==19
	replace job_type=140 if Tipo_Trabajo_REC==50
	replace job_type=142 if Tipo_Trabajo_REC==26
	replace job_type=151 if Tipo_Trabajo_REC==79
	replace job_type=151 if Tipo_Trabajo_REC==93
	replace job_type=161 if Tipo_Trabajo_REC==10
	replace job_type=162 if Tipo_Trabajo_REC==42
	replace job_type=163 if Tipo_Trabajo_REC==43
	replace job_type=164 if Tipo_Trabajo_REC==80
	replace job_type=171 if Tipo_Trabajo_REC==63
	replace job_type=172 if Tipo_Trabajo_REC==45
	replace job_type=173 if Tipo_Trabajo_REC==65
	replace job_type=174 if Tipo_Trabajo_REC==74
	replace job_type=175 if Tipo_Trabajo_REC==66
	replace job_type=176 if Tipo_Trabajo_REC==75
	replace job_type=177 if Tipo_Trabajo_REC==82
	replace job_type=181 if Tipo_Trabajo_REC==98
	replace job_type=182 if Tipo_Trabajo_REC==99
	replace job_type=. if Request_Motivation!=1

	
**

label define job_typelbl ///
	1 "Private car driver" ///
	2 "Taxi driver" ///
	3 "Truck driver" ///
	4 "Delivery worker" ///
	5 "Bus driver" ///
	10 "Port workers" ///
	11 "Airport Workers" ///
	12 "Plane pilot / stewardess" ///
	21 "Bouncers" ///
	22 "Private sec. officers" ///
	23 "Private sec. (other)" ///
	31 "Soldiers" ///
	32 "Police officers" ///
	33 "Parking meter supervisor" ///
	44 "Teachers / ass. teachers" ///
	45 "Exam Invigilator" ///
	46 "Librarian" ///
	47 "Manager (jobs inv. children)" ///
	48 "Children activities instructor" ///
	50 "Sports trainer" ///
	51 "Lifeguard" ///
	53 "Au Pair" ///
	61 "Nurse" ///
	62 "Fisiotherapists" ///
	63 "Doctors" ///
	71 "Social Worker" ///
	72 "Researcher" ///
	73 "Psychologists" ///
	81 "Cleaner" ///
	82 "Cooker" ///
	83 "Care taker" ///
	91 "Financial Analysts" ///
	93 "Property Managers" ///
	95 "IT Technician (financial sec.)" ///
	96 "Comercial lic. (offshore)" ///
	101 "Money Transfer Agent" ///
	102 "Lawyer" ///
	103 "Casino Workers" ///
	110 "Farm workers" ///
	121 "Industry Workers" ///
	126 "Slaughterhouse Worker" ///
	127 "Warehouse Worker" ///
	131 "Builders / Construction sector" ///
	132 "Carpenters" ///
	133 "Engineers" ///
	134 "Arquitects" ///
	135 "Installations / Machinery" ///
	136 "Plumber" ///
	137 "Clerical jobs" ///
	138 "Telephone operator / Telemarketer" ///
	139 "Human Resources" ///
	140 "Hotel / restaurant workers" ///
	142 "Store Assistant" ///
	151 "Manager position" ///
	161 "Workers in Consulates/Embassy" ///
	162 "NGO workers" ///
	163 "Workers European Parliament" ///
	164 "Graphic Designer" ///
	171 "Environmental tecnician" ///
	172 "Journalist" ///
	173 "Machine operator at amusement parks" ///
	174 "Locksmith" ///
	175 "Artists " ///
	176 "Community Managers" ///
	177 "Pastor" ///
	181 "Don't Know" ///
	182 "No Answer" 
	
lab val job_type job_typelbl

rename job_type Job_Type_REC

lab var Job_Type_REC "Type of job (Recode and translated)"


********************************************************************************
							   * Deletion *
********************************************************************************
drop Tipo_Trabajo_REC Cuest NumCuest Tipo_empresa ///
Tipo_Trabajo_Pais_REC outjobs Edad_REC Motivo_Peticion_REC

drop Job_Type Job_country


********************************************************************************
							   * Order *
********************************************************************************

order ID Wave Date Surveyor Participation Sample Request_Certificate ///
Request_Motivation Request_Type Request_CAP Request_CDNS Request_Mand ///
Request_Mand_CAP Request_Mand_CDNS Job_Type_REC Job_Sector Job_New_Tech ///
Job_Children Job_Children1 Job_Children2 Job_Spain Gender Age Origin ///
Origin_REC Education Education_REC Outlier

********************************************************************************
							* Final clasification *
********************************************************************************

replace Request_CDNS=1 if Job_Type_REC==173 & Wave==2
replace Request_CAP=0 if Job_Type_REC==173 & Wave==2
replace Request_Mand_CDNS=0 if Job_Type_REC==173 & Wave==2

********************************************************************************
							  * Saving *
********************************************************************************

save "`c(pwd)'/database_final.dta", replace



