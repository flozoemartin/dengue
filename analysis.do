
/*	

Information from the original dataset

label tranfusion* "Transfusion 1-whole blood 2-prbc,3-ffp,4-sdp,5-cryo,6-rdp,7-Not done"
	label crp* "CRP normal <6"
	label variable fluidreq* "(ml/kg/day)"
	label variable urineout* "(ml/kg/hr)"
	label variable fluidbalance* "(ml/kg)"
	label akinra_day* "(mg/kg/day)"
	label ivig* "(mg/kg)"
	label cortico_day* "(mg/kg)"
	label supptherapy* "1-MV(mechanical ventilation),2-NIV(non invasive ventilation),3-HFNC(high frequency nasal cannula),4-low frequency nasal cannula" 
	label renalreptherapy* "(1-IHD,2-SLED,3-SCUF,4-CRRT,5-pd)"
	label outcome "1-discharge,2-death,3-discharge against medical advice"
	RRT(1-IHD,2-SLED,3-SCUF,4-CRRT,5-pd)
	outcome1-discharge,2-death,3-dama
	grade 1-Severe leak,2-severe bleeding,3-Severe organ dysfunction
	
*/

* Load in the data

	import excel using "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/Dengue immunomodulation data v6.xlsx", firstrow clear
	
	* Create labels to use for different variables
	
	label define pos_lb 1"Positive" 2"Negative"
	label define sex_lb 1"Male" 2"Female"
	label define bin_lb 1"Yes" 2"No"
	label define shock_lb 0"No hypotension" 1"Compensated" 2"Decompensated"
	label define outcome_lb 1"Discharged" 2"Died"
	label define liverdys_lb 1"INR > 2" 2"INR < 2 with transaminitis"
	
* Data management

	drop IPNUMBER
	drop A D
	
	* Patient identifier
	rename Slno patid
	drop if patid==.
	count // 45 patients
	
	* Phenotype
	rename liverinvolvementgrades123 liverinvolv
	tab liverinvolv
	
	* Duration of hospital/ICU stay
	rename HOSPITALSTAY hospstay_duration
	tab hospstay_duration, m // n=1 missing
	
	rename icustay icustay_duration
	tab icustay_duration
	
	* Patient age in months
	rename AGEMONTHS age_m
	tab age_m
	
	* Patient sex
	rename SEXM1F2 sex
	label values sex sex_lb
	tab sex, m
	
	* Blood pressure 
	rename Systolicbloodpressure SBP
	rename diastolicbp DBP
	
	* Phenotypes
	rename leakatanytime leak
	label values leak bin_lb
	tab leak, m
	
	rename liverdysfunction1inr22INR liverdys
	label values liverdys liverdys_lb
	tab liverdys
	
	label values severebleeding bin_lb
	tab severebleeding
	
	rename mixedphenotype1yes2outof mixedpheno
	label values mixedpheno bin_lb
	tab mixedpheno
	
	* Influenza infection
	rename influenza1positive2negative influenza
	label values influenza pos_lb
	tab influenza, m // n=1 missing
	
	* Co-infection
	rename coinfection1YES2NO coinfection
	label values coinfection bin_lb
	tab coinfection, m 
	
	* Fever at admission
	rename feveratadmission1yes2no fever_admission
	label values fever_admission bin_lb
	tab fever_admission
	
	* Fever at immunomodulation
	rename FEVERATIMMUNOMODULATION1YES fever_immunomod
	label values fever_immunomod bin_lb
	tab fever_immunomod, m
	
	* Fever of more than 5 days
	rename FEVERE5DAYS1YES2NO fever_5days
	label values fever_5days bin_lb
	tab fever_5days, m
	
	* Secondary fever
	rename SECONDARYFEVER1YES2NO secondary_fever
	label values secondary_fever bin_lb
	tab secondary_fever, m // n=2 coded as zero
	
	* Shock
	rename Shock0nohypotension1compen shock
	label values shock shock_lb
	tab shock, m // n=1 missing
	
	* Bleeding
	rename bleeding1yes2no bleeding
	label values bleeding bin_lb
	tab bleeding, m
	
	* NS1 infection
	rename NS1positive1negative2 ns1
	label values ns1 pos_lb
	tab ns1, m
	
	* IgG  
	rename iggpositive1negative2 igg
	label values igg pos_lb
	tab igg, m
	
	* IgM 
	rename igmpositive1negative2 igm
	label values igm pos_lb
	tab igm, m
	
	* Day of illness at admission
	rename DAYOFILLNESSonadnission dayofillness
	tab dayofillness
	
	* Outcome
	rename outcome1discharge2death3dam outcome
	label values outcome outcome_lb
	tab outcome
	
	rename alteredsensoriumEncephalopath encephalo
	label values encephalo bin_lb
	tab encephalo

* Derive additional variables for analysis

	* Extra variables for loops
	gen ldh_day6 =.
	
	* Generate a variable for any RRT requirement
	gen need_rrt =.
	
	forvalues x=1/7 {
	
		replace need_rrt = 1 if rrt_day`x'!="0" & rrt_day`x'!="none"
		
	}
	
	tab need_rrt
	replace need_rrt = 2 if need_rrt==.
	label values need_rrt bin_lb
	tab need_rrt
	
	gen total = 1

	* Liver involvement grading
	
	gen grade1 = 1 if liverinvolv==1
	gen grade2 = 1 if liverinvolv==2
	gen grade3 = 1 if liverinvolv==3
	gen grade4 = 1 if liverinvolv==4
	
	/*foreach x in admission 48 96 120 {
	
		replace grade4 = 1 if inr_`x'>=2 & inr_`x'!=.
	
	}
	
	foreach x in admission 48 96 120 144 192 {
	
		replace grade3 = 1 if tbili_`x'>=1.3 & tbili_`x'!=. & grade4==.
	
	}
	
	foreach x in admission 48 96 120 day6 {
		
		replace grade2 = 1 if ((ferritin_`x'>=1000 & ferritin_`x'!=.) | (ldh_`x'>=250 & ldh_`x'!=.)) & grade3!=1 & grade4!=1
		
	}
	
	foreach x in admission 48 96 120 {
	
		replace grade1 = 1 if ((sgot_`x'>=120 & sgot_`x'!=.) | (sgpt_`x'>=140 & sgpt_`x'!=.)) & grade2!=1 & grade3!=1 & grade4!=1
		
	}*/
	
	tab grade1 // 3
	tab grade2 // 11
	tab grade3 // 13
	tab grade4 // 18

	* Maximum ferritin over the course of the hospital stay
	
	gen max_ferritin = max(ferritin_admission, ferritin_48, ferritin_96, ferritin_120, ferritin_day6)
	
	gen ferritin_lt5000 = 1 if max_ferritin<5000
	gen ferritin_5to10 = 1 if max_ferritin>=5000 & max_ferritin<10000
	gen ferritin_10to50 = 1 if max_ferritin>=10000 & max_ferritin<50000
	gen ferritin_gt50000 = 1 if max_ferritin>=50000
	
	gen ferritin_levels = 1 if ferritin_lt5000==1
	replace ferritin_levels = 2 if ferritin_5to10==1
	replace ferritin_levels = 3 if ferritin_10to50==1
	replace ferritin_levels = 4 if ferritin_gt50000==1
	
	* Maximum platelet count over the course of the hospital stay
	
	gen min_pcc = min(platelet_admission, platelet_48, platelet_96, platelet_120, platelet_day6)
	
	* Maximum AST/SGOT over the course of the hospital stay
	
	gen max_sgot = max(sgot_admission, sgot_48, sgot_96, sgot_120)
	
	* Maximum ALT/SGPT over the course of the hospital stay
	
	gen max_sgpt = max(sgpt_admission, sgpt_48, sgpt_96, sgpt_120)
	
	* Maximum INR over the course of the hospital stay
	
	gen max_inr = max(inr_admission, inr_48, inr_96, inr_120)
	
	* Maximum creatinine over the course of the hospital stay
	
	gen max_creat = max(creat_admission, creat_48, creat_96, creat_120, creat_day6, creat_day8)
	
	* Maximum lactate over the course of the hospital stay
	
	gen max_lactate = max(lactate_day1, lactate_day2, lactate_day3, lactate_day4)
	
	* Maximum haemoglobin over the course of hospital stay
	
	gen max_haem = max(hb_admission, hb_48, hb_96, hb_120)
	
	* Max CRP
	
	gen max_crp = max(crp_admission, crp_48, crp_96, crp_120)
	
	* High CRP
	
	gen high_crp =.
	
	foreach x in admission 48 96 120 {
		
		replace high_crp = 1 if crp_`x'>=12
		
	}
	
	gen crp_scale =.
	
	foreach x in admission 48 96 120 {
		
		replace crp_scale = 1 if crp_`x'>=6
		
	}
	
	foreach x in admission 48 96 120 {
		
		replace crp_scale = 2 if crp_`x'>=12
		
	}
	
	foreach x in admission 48 96 120 {
		
		replace crp_scale = 3 if crp_`x'>=18
		
	}
	
	tab crp_scale, m // n=5 missing
	
	* Timing of immunomodulation
	
	foreach x in akinra ivig {
		
		gen `x'_timing = 1 if `x'_day1>0
		replace `x'_timing = 2 if (`x'_day1==0 | `x'_day1==.) & `x'_day2>0 & `x'_day2!=.
		replace `x'_timing = 3 if `x'_day1==0 & `x'_day2==0 & `x'_day3>0 & `x'_day3!=.
		replace `x'_timing = 4 if `x'_day1==0 & `x'_day2==0 & `x'_day3==0 & `x'_day4>0 & `x'_day4!=.
		replace `x'_timing = 5 if `x'_day1==0 & `x'_day2==0 & `x'_day3==0 & `x'_day4==0 & `x'_day5>0 & `x'_day5!=.
		tab `x'_timing
			
	}
	
	foreach x in steroids {
		
		gen `x'_timing = 1 if `x'_day1>0
		replace `x'_timing = 2 if `x'_day1==0 & `x'_day2>0 & `x'_day2!=.
		replace `x'_timing = 3 if `x'_day1==0 & `x'_day2==0 & `x'_day3>0 & `x'_day3!=.
		replace `x'_timing = 4 if `x'_day1==0 & `x'_day2==0 & `x'_day3==0 & `x'_day4>0 & `x'_day4!=.
		replace `x'_timing = 5 if `x'_day1==0 & `x'_day2==0 & `x'_day3==0 & `x'_day4==0 & `x'_day5>0 & `x'_day5!=.
		replace `x'_timing = 6 if `x'_day1==0 & `x'_day2==0 & `x'_day3==0 & `x'_day4==0 & `x'_day5==0 & `x'_day6>0 & `x'_day6!=.
		replace `x'_timing = 7 if `x'_day1==0 & `x'_day2==0 & `x'_day3==0 & `x'_day4==0 & `x'_day5==0 & `x'_day6>0 & `x'_day7>0 & `x'_day7!=.
		tab `x'_timing
		
	}
	
	foreach x in plasmapheresis {
		
		gen `x'_timing = 1 if `x'_day1>0
		replace `x'_timing = 2 if `x'_day1==0 & `x'_day2>0 & `x'_day2!=.
		replace `x'_timing = 3 if `x'_day1==0 & `x'_day2==0 & `x'_day3>0 & `x'_day3!=.
		replace `x'_timing = 4 if `x'_day1==0 & `x'_day2==0 & `x'_day3==0 & `x'_day4>0 & `x'_day4!=.
		replace `x'_timing = 5 if `x'_day1==0 & `x'_day2==0 & `x'_day3==0 & `x'_day4==0 & `x'_day5>0 & `x'_day5!=.
		replace `x'_timing = 6 if `x'_day1==0 & `x'_day2==0 & `x'_day3==0 & `x'_day4==0 & `x'_day5==0 & `x'_day6>0 & `x'_day6!=.
		replace `x'_timing = 6 if `x'_day1==0 & `x'_day2==0 & `x'_day3==0 & `x'_day4==0 & `x'_day5==0 & `x'_day6==0 & `x'_day10>0 & `x'_day10!=.
		replace `x'_timing = 6 if `x'_day1==0 & `x'_day2==0 & `x'_day3==0 & `x'_day4==0 & `x'_day5==0 & `x'_day6==0 & `x'_day10==0 & `x'_day11>0 & `x'_day11!=.
		replace `x'_timing = 6 if `x'_day1==0 & `x'_day2==0 & `x'_day3==0 & `x'_day4==0 & `x'_day5==0 & `x'_day6==0 & `x'_day10==0 & `x'_day11==0 & `x'_day12>0 & `x'_day12!=.
		replace `x'_timing = 6 if `x'_day1==0 & `x'_day2==0 & `x'_day3==0 & `x'_day4==0 & `x'_day5==0 & `x'_day6==0 & `x'_day10==0 & `x'_day11==0 & `x'_day12==0 & `x'_day13>0 & `x'_day13!=.
		replace `x'_timing = 6 if `x'_day1==0 & `x'_day2==0 & `x'_day3==0 & `x'_day4==0 & `x'_day5==0 & `x'_day6==0 & `x'_day10==0 & `x'_day11==0 & `x'_day12==0 & `x'_day13==0 & `x'_day14>0 & `x'_day14!=.
		replace `x'_timing = 6 if `x'_day1==0 & `x'_day2==0 & `x'_day3==0 & `x'_day4==0 & `x'_day5==0 & `x'_day6==0 & `x'_day10==0 & `x'_day11==0 & `x'_day12==0 & `x'_day13==0 & `x'_day14==0 & `x'_day15>0 & `x'_day15!=.
		
		tab `x'_timing
		
	}
	
	gen akinra_alone = 1 if akinra_timing!=. & steroids_timing==. & plasmapheresis_timing==.
	gen steroids_plasma = 1 if steroids_timing!=. & plasmapheresis_timing!=.
	gen steroids_any = 1 if steroids_timing!=. & steroids_plasma==.
	gen plasmapheresis_any = 1 if plasmapheresis_timing!=. & steroids_plasma==.
	
	gen immunomodulation = 1 if akinra_alone==1
	replace immunomodulation = 2 if steroids_any==1
	replace immunomodulation = 3 if plasmapheresis_any==1
	replace immunomodulation = 4 if steroids_plasma==1
	
	* Any immunomodulation timing
	
	gen immunomodulation_timing =.
	
	forvalues x=1/7 {
		
		replace immunomodulation_timing = `x' if akinra_timing==`x' | steroids_timing==`x' | plasmapheresis_timing==`x' | ivig_timing==`x'
		
	}
	
	* Serological status
	
	gen sero_status = 1 if igm==1 & ns1==2
	replace sero_status = 2 if igm==2 & ns1==1
	replace sero_status = 3 if igm==1 & ns1==1
	
	label define sero_lb 1"-NS1 +IgM" 2"+NS1 -IgM" 3"+NS1 +IgM"
	label values sero_status sero_lb
	tab sero_status
	
	* Cumulative dose
	
	gen cum_dose = akinra_day1 + akinra_day2 + akinra_day3 + akinra_day4 + akinra_day5
	gen cum_dose_days = cum_dose/akinra_duration
	tab cum_dose_days
	
	save "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/analysis_dataset.dta", replace
