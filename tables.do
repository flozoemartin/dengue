
*********************************************************************

* Load in the data

	use "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/analysis_dataset.dta", clear
	
*********************************************************************
	
* Fluid requirements among survivors and non-survivors

	tempname myhandle	
	file open `myhandle' using "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tables/fluidreq_survival.txt", write replace
	
	file write `myhandle' "" _tab "Mean (SD) of fluid requirement" _n
	
	file write `myhandle' "Time from anakinra initiation" _tab "Total" _tab "Survivors" _tab "Non-survivors" _n
	
	foreach x in 0 6 12 18 24 30 36 {
		
		summ fluidreq_`x', det
		
		local mean=`r(mean)'
		local sd=`r(sd)'
	
		summ fluidreq_`x' if outcome==1, det
		
		local mean_surv=`r(mean)'
		local sd_surv=`r(sd)'
		
		summ fluidreq_`x' if outcome==2, det
		
		local mean_died=`r(mean)'
		local sd_died=`r(sd)'
		
		file write `myhandle' "Hour `x'" _tab %3.1fc (`mean') (" (") %3.1fc (`sd') (")") _tab %3.1fc (`mean_surv') (" (") %3.1fc (`sd_surv') (")") _tab %3.1fc (`mean_died') (" (") %3.1fc (`sd_died') (")") _n
		
	}
	
	file close `myhandle'
	
		* Table for graph
		
		tempname myhandle	
		file open `myhandle' using "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tables/fluidreq_survival_graphdata.txt", write replace
	
		file write `myhandle' "hour" _tab "total" _tab "survived" _tab "surv_lci" _tab "surv_uci" _tab "died" _tab "died_lci" _tab "died_uci" _n
		
		foreach x in 0 6 12 18 24 30 36 {
			
			count if fluidreq_`x'!=.
			local total_n=`r(N)'
			
			summ fluidreq_`x', det
			local mean=`r(mean)'
			local sd=`r(sd)'
			local lci=`mean'-(2*`sd')
			local uci=`mean'+(2*`sd')
		
			count if outcome==1 & fluidreq_`x'!=.
			local surv_n=`r(N)'
			
			summ fluidreq_`x' if outcome==1, det
			local mean_surv=`r(mean)'
			local sd_surv=`r(sd)'
			local lci_surv=`mean_surv'-(2*`sd_surv')
			local uci_surv=`mean_surv'+(2*`sd_surv')
			
			count if outcome==2 & fluidreq_`x'!=.
			local died_n=`r(N)'
			
			summ fluidreq_`x' if outcome==2, det
			local mean_died=`r(mean)'
			local sd_died=`r(sd)'
			local lci_died=`mean_died'-(2*`sd_died')
			local uci_died=`mean_died'+(2*`sd_died')
			
			file write `myhandle' (`x') _tab %3.1fc (`mean') _tab %3.1fc (`mean_surv') _tab (`lci_surv') _tab (`uci_surv') _tab %3.1fc (`mean_died') _tab (`lci_died') _tab (`uci_died') _n
			
		}
		
		file close `myhandle'
	
* Restricted to those with leakage

	count if leak==1

	tempname myhandle	
	file open `myhandle' using "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tables/fluidreq_survival_leakage.txt", write replace
	
	file write `myhandle' "" _tab "Mean (SD) of fluid requirement" _n
	
	file write `myhandle' "Time from anakinra initiation" _tab "Total" _tab "Survivors" _tab "Non-survivors" _n
	
	foreach x in 0 6 12 18 24 30 36 {
		
		summ fluidreq_`x' if leak==1, det
		
		local mean=`r(mean)'
		local sd=`r(sd)'
	
		summ fluidreq_`x' if outcome==1 & leak==1, det
		
		local mean_surv=`r(mean)'
		local sd_surv=`r(sd)'
		
		summ fluidreq_`x' if outcome==2 & leak==1, det
		
		local mean_died=`r(mean)'
		local sd_died=`r(sd)'
		
		file write `myhandle' "Hour `x'" _tab %3.1fc (`mean') (" (") %3.1fc (`sd') (")") _tab %3.1fc (`mean_surv') (" (") %3.1fc (`sd_surv') (")") _tab %3.1fc (`mean_died') (" (") %3.1fc (`sd_died') (")") _n
		
	}
	
	file close `myhandle'
	
* Restricted to those with leakage and mixed phenotype

	count if leak==1 & mixedpheno==1

	tempname myhandle	
	file open `myhandle' using "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tables/fluidreq_survival_leakage_mixed.txt", write replace
	
	file write `myhandle' "" _tab "Mean (SD) of fluid requirement" _n
	
	file write `myhandle' "Time from anakinra initiation" _tab "Total" _tab "Survivors" _tab "Non-survivors" _n
	
	foreach x in 0 6 12 18 24 30 36 {
		
		summ fluidreq_`x' if leak==1 & mixed==1, det
		
		local mean=`r(mean)'
		local sd=`r(sd)'
	
		summ fluidreq_`x' if outcome==1 & leak==1 & mixed==1, det
		
		local mean_surv=`r(mean)'
		local sd_surv=`r(sd)'
		
		summ fluidreq_`x' if outcome==2 & leak==1 & mixed==1, det
		
		local mean_died=`r(mean)'
		local sd_died=`r(sd)'
		
		file write `myhandle' "Hour `x'" _tab %3.1fc (`mean') (" (") %3.1fc (`sd') (")") _tab %3.1fc (`mean_surv') (" (") %3.1fc (`sd_surv') (")") _tab %3.1fc (`mean_died') (" (") %3.1fc (`sd_died') (")") _n
		
	}
	
	file close `myhandle'
	
*********************************************************************

* Demographics table

	tempname myhandle	
	file open `myhandle' using "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tables/demog_table.txt", write replace
	
	file write `myhandle' "Characteristic" _tab "Total" _tab "Grade 1" _tab "Grade 2" _tab "Grade 3" _tab "Grade 4" _n
		
* Total in each group
		
	file write `myhandle' "Total"
		
	foreach  x in total grade1 grade2 grade3 grade4 {
		
		count if `x'==1
		local n=`r(N)'
		
		file write `myhandle' _tab (`n') 
		
	}
		
	file write `myhandle' _n
		
* Age
		
	file write `myhandle' "Age (months)"
		
	foreach  x in total grade1 grade2 grade3 grade4 {
		
		summ age if `x'==1, det
		local median =`r(p50)'
		local q1 = `r(p25)'
		local q3 = `r(p75)'
		local iqr = `q3'-`q1'
	
		file write `myhandle' _tab (`median') (" (") %2.0f (`iqr') (")")
		
	}
		
	file write `myhandle' _n
		
* Sex 
		
	file write `myhandle' "Male, n (%)"
		
	foreach  x in total grade1 grade2 grade3 grade4 {
		
		count if `x'==1 & sex==1
		local n=`r(N)'
		count if `x'==1
		local total=`r(N)'
		local percent=((`n')/(`total'))*100
		
		file write `myhandle' _tab (`n') (" (") %2.0f (`percent') (")")
		
	}
		
	file write `myhandle' _n
		
* Day of illness at admission
		
	file write `myhandle' "Day of illness at admission"
		
	foreach  x in total grade1 grade2 grade3 grade4 {
		
		summ dayofillness if `x'==1, det
		local median =`r(p50)'
		local q1 = `r(p25)'
		local iqr = `q3'-`q1'
	
		file write `myhandle' _tab (`median') (" (") %3.0f (`iqr') (")")
		
	}
		
	file write `myhandle' _n
	
* Fever at admission
		
	file write `myhandle' "Fever at admission, n (%)"
		
	foreach  x in total grade1 grade2 grade3 grade4 {
		
		count if `x'==1 & fever_admission==1
		local n=`r(N)'
		count if `x'==1
		local total=`r(N)'
		local percent=((`n')/(`total'))*100
		
		file write `myhandle' _tab (`n') (" (") %2.0f (`percent') (")")
		
	}
		
	file write `myhandle' _n	
	
* Systolic blood pressure 

	file write `myhandle' "Systolic blood pressure, median (IQR)" _n

	file write `myhandle' "At admission"
		
	foreach  x in total grade1 grade2 grade3 grade4 {
		
		summ SBP if `x'==1, det
		local median =`r(p50)'
		local q1 = `r(p25)'
		local q3 = `r(p75)'
		local iqr = `q3'-`q1'
	
		file write `myhandle' _tab (`median') (" (") %2.0f (`iqr') (")")
		
	}
		
	file write `myhandle' _n
	
	file write `myhandle' "Minimum during stay"
		
	foreach  x in total grade1 grade2 grade3 grade4 {
		
		summ LeastSBP if `x'==1, det
		local median =`r(p50)'
		local q1 = `r(p25)'
		local q3 = `r(p75)'
		local iqr = `q3'-`q1'
	
		file write `myhandle' _tab (`median') (" (") %2.0f (`iqr') (")")
		
	}
		
	file write `myhandle' _n
	
* Diastolic blood pressure 

	file write `myhandle' "Diatolic blood pressure, median (IQR)" _n

	file write `myhandle' "At admission"
		
	foreach  x in total grade1 grade2 grade3 grade4 {
		
		summ DBP if `x'==1, det
		local median =`r(p50)'
		local q1 = `r(p25)'
		local q3 = `r(p75)'
		local iqr = `q3'-`q1'
	
		file write `myhandle' _tab (`median') (" (") %2.0f (`iqr') (")")
		
	}
		
	file write `myhandle' _n
	
	file write `myhandle' "Minimum during stay"
		
	foreach  x in total grade1 grade2 grade3 grade4 {
		
		summ leastDBP if `x'==1, det
		local median =`r(p50)'
		local q1 = `r(p25)'
		local q3 = `r(p75)'
		local iqr = `q3'-`q1'
	
		file write `myhandle' _tab (`median') (" (") %2.0f (`iqr') (")")
		
	}
		
	file write `myhandle' _n
	
* Pulse pressure 

	file write `myhandle' "Pulse pressure, median (IQR)" _n

	file write `myhandle' "At admission"
		
	foreach  x in total grade1 grade2 grade3 grade4 {
		
		summ PP if `x'==1, det
		local median =`r(p50)'
		local q1 = `r(p25)'
		local q3 = `r(p75)'
		local iqr = `q3'-`q1'
	
		file write `myhandle' _tab (`median') (" (") %2.0f (`iqr') (")")
		
	}
		
	file write `myhandle' _n
	
	file write `myhandle' "Maximum during stay" _n
	
* Compensated shock

	file write `myhandle' "Compensated shock" _n
		
	file write `myhandle' "At admission"
		
	foreach  x in total grade1 grade2 grade3 grade4 {
		
		count if `x'==1 & shock==1
		local n=`r(N)'
		count if `x'==1
		local total=`r(N)'
		local percent=((`n')/(`total'))*100
		
		file write `myhandle' _tab (`n') (" (") %2.0f (`percent') (")")
		
	}
		
	file write `myhandle' _n
	
	file write `myhandle' "Any time during stay" _n
	
* Decompensated shock

	file write `myhandle' "Decompensated shock, n (%)" _n
		
	file write `myhandle' "At admission"
		
	foreach  x in total grade1 grade2 grade3 grade4 {
		
		count if `x'==1 & shock==2
		local n=`r(N)'
		count if `x'==1
		local total=`r(N)'
		local percent=((`n')/(`total'))*100
		
		file write `myhandle' _tab (`n') (" (") %2.0f (`percent') (")")
		
	}
		
	file write `myhandle' _n
	
	file write `myhandle' "Any time during stay" _n
		
* Ferritin at admission
		
	file write `myhandle' "Ferritin, median (IQR)" _n
	
	file write `myhandle' "At admission"
		
	foreach  x in total grade1 grade2 grade3 grade4 {
		
		summ ferritin_admission if `x'==1, det
		local median =`r(p50)'
		local q1 = `r(p25)'
		local q3 = `r(p75)'
		local iqr = `q3'-`q1'
	
		file write `myhandle' _tab %6.0fc (`median') (" (") %6.0fc (`iqr') (")")
		
	}
		
	file write `myhandle' _n
	
	file write `myhandle' "Maximum during stay"
		
	foreach  x in total grade1 grade2 grade3 grade4 {
		
		summ max_ferritin if `x'==1, det
		local median =`r(p50)'
		local q1 = `r(p25)'
		local q3 = `r(p75)'
		local iqr = `q3'-`q1'
	
		file write `myhandle' _tab %6.0fc (`median') (" (") %6.0fc (`iqr') (")")
		
	}
		
	file write `myhandle' _n
	
* Peak haemoglobin
	
	file write `myhandle' "Peak haemoglobin, median (IQR)"
		
	foreach  x in total grade1 grade2 grade3 grade4 {
		
		summ max_haem if `x'==1, det
		local median =`r(p50)'
		local q1 = `r(p25)'
		local q3 = `r(p75)'
		local iqr = `q3'-`q1'
	
		file write `myhandle' _tab (`median') (" (") %1.0f (`iqr') (")")
		
	}
		
	file write `myhandle' _n
		
* Peak pSofa
		
	file write `myhandle' "Peak pSofa, median (IQR)"
		
	foreach  x in total grade1 grade2 grade3 grade4 {
		
		summ pSofamax if `x'==1, det
		local median =`r(p50)'
		local q1 = `r(p25)'
		local q3 = `r(p75)'
		local iqr = `q3'-`q1'
	
		file write `myhandle' _tab (`median') (" (") %1.0f (`iqr') (")")
		
	}
		
	file write `myhandle' _n
		
* Bleeding at admission
		
	file write `myhandle' "Bleeding at admission, n (%)"
		
	foreach  x in total grade1 grade2 grade3 grade4 {
		
		count if `x'==1 & bleeding==1
		local n=`r(N)'
		count if `x'==1
		local total=`r(N)'
		local percent=((`n')/(`total'))*100
		
		file write `myhandle' _tab (`n') (" (") %2.0f (`percent') (")")
		
	}
		
	file write `myhandle' _n
		
* Min platelet cell count
		
	file write `myhandle' "Lowest platelet cell count, median (IQR)"
		
	foreach  x in total grade1 grade2 grade3 grade4 {
		
		summ min_pcc if `x'==1, det
		local median =`r(p50)'
		local q1 = `r(p25)'
		local q3 = `r(p75)'
		local iqr = `q3'-`q1'
	
		file write `myhandle' _tab %6.0fc (`median') (" (") %6.0fc (`iqr') (")")
		
	}
		
	file write `myhandle' _n
		
* Max AST
		
	file write `myhandle' "Peak AST, median (IQR)"
		
	foreach  x in total grade1 grade2 grade3 grade4 {
		
		summ max_sgot if `x'==1, det
		local median =`r(p50)'
		local q1 = `r(p25)'
		local q3 = `r(p75)'
		local iqr = `q3'-`q1'
	
		file write `myhandle' _tab %6.0fc (`median') (" (") %6.0fc (`iqr') (")")
		
	}
		
	file write `myhandle' _n
		
* Max ALT
		
	file write `myhandle' "Peak ALT, median (IQR)"
		
	foreach x in total grade1 grade2 grade3 grade4 {
		
		summ max_sgpt if `x'==1, det
		local median =`r(p50)'
		local q1 = `r(p25)'
		local q3 = `r(p75)'
		local iqr = `q3'-`q1'
	
		file write `myhandle' _tab %5.0fc (`median') (" (") %5.0fc (`iqr') (")")
		
	}
		
	file write `myhandle' _n
		
* Max INR
		
	file write `myhandle' "Peak INR, median (IQR)"
		
	foreach x in total grade1 grade2 grade3 grade4 {
		
		summ max_inr if `x'==1, det
		local median =`r(p50)'
		local q1 = `r(p25)'
		local q3 = `r(p75)'
		local iqr = `q3'-`q1'
	
		file write `myhandle' _tab %3.1f (`median') (" (") %1.0f (`iqr') (")")
	
	}
		
	file write `myhandle' _n
		
* Max serum creatinine
		
	file write `myhandle' "Peak serum creatinine, median (IQR)"
		
	foreach x in total grade1 grade2 grade3 grade4 {
		
		summ max_creat if `x'==1, det
		local median =`r(p50)'
		local q1 = `r(p25)'
		local q3 = `r(p75)'
		local iqr = `q3'-`q1'
	
		file write `myhandle' _tab %3.1f (`median') (" (") %1.0f (`iqr') (")")
		
	}
		
	file write `myhandle' _n
		
* Max serum lactate
		
	file write `myhandle' "Peak serum lactate, median (IQR)"
		
	foreach x in total grade1 grade2 grade3 grade4 {
		
		summ max_lactate if `x'==1, det
		local median =`r(p50)'
		local q1 = `r(p25)'
		local q3 = `r(p75)'
		local iqr = `q3'-`q1'
	
		file write `myhandle' _tab %3.1f (`median') (" (") %1.0f (`iqr') (")")
		
	}
		
	file write `myhandle' _n
		
* Survival
		
	file write `myhandle' "Survival, n (%)"
		
	foreach  x in total grade1 grade2 grade3 grade4 {
		
		count if `x'==1 & outcome==1
		local n=`r(N)'
		count if `x'==1
		local total=`r(N)'
		local percent=((`n')/(`total'))*100
		
		file write `myhandle' _tab (`n') (" (") %2.0f (`percent') (")")
	
	}
		
	file write `myhandle' _n
		
	file close `myhandle'
	
*********************************************************************

* Grade by type of immunomodulation

	tempname myhandle	
	file open `myhandle' using "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tables/immunomod_grade.txt", write replace
	
	file write `myhandle' "Type of immunomodulation" _tab "Total"  _tab "Grade 1" _tab "Grade 2" _tab "Grade 3" _tab "Grade 4" _n
	
	file write `myhandle' "Total"
	
	count
	local n=`r(N)'
	
	count if grade1==1
	local g1=`r(N)'
	local pct_g1=((`g1')/(`n'))*100
	
	count if grade2==1
	local g2=`r(N)'
	local pct_g2=((`g2')/(`n'))*100
	
	count if grade3==1
	local g3=`r(N)'
	local pct_g3=((`g3')/(`n'))*100
	
	count if grade4==1
	local g4=`r(N)'
	local pct_g4=((`g4')/(`n'))*100
	
	file write `myhandle' _tab (`n') (" (100)") _tab (`g1') (" (") %2.0f (`pct_g1') (")") _tab (`g2') (" (") %2.0f (`pct_g2') (")") _tab (`g3') (" (") %2.0f (`pct_g3') (")") _tab (`g4') (" (") %2.0f (`pct_g4') (")") _n
	
	forvalues x=1/4 {
		
		file write `myhandle' "`x'"
		
		count if immunomodulation==`x'
		local n_`x'=`r(N)'
		local pct_n_`x'=((`n_`x'')/(`n_`x''))*100
		
		count if immunomodulation==`x' & grade1==1
		local g1_`x'=`r(N)'
		local pct_g1_`x'=((`g1_`x'')/(`n_`x''))*100
		
		count if immunomodulation==`x' & grade2==1
		local g2_`x'=`r(N)'
		local pct_g2_`x'=((`g2_`x'')/(`n_`x''))*100
		
		count if immunomodulation==`x' & grade3==1
		local g3_`x'=`r(N)'
		local pct_g3_`x'=((`g3_`x'')/(`n_`x''))*100
		
		count if immunomodulation==`x' & grade4==1
		local g4_`x'=`r(N)'
		local pct_g4_`x'=((`g4_`x'')/(`n_`x''))*100
		
		file write `myhandle' _tab (`n_`x'') (" (") %2.0f (`pct_n_`x'') (")") _tab (`g1_`x'') (" (") %2.0f (`pct_g1_`x'') (")") _tab (`g2_`x'') (" (") %2.0f (`pct_g2_`x'') (")") _tab (`g3_`x'') (" (") %2.0f (`pct_g3_`x'') (")") _tab (`g4_`x'') (" (") %2.0f (`pct_g4_`x'') (")") _n
		
	}
	
	file close `myhandle'
	
*********************************************************************

* Grade by dose of immunomodulation

	tempname myhandle	
	file open `myhandle' using "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tables/dose_grade.txt", write replace
	
	file write `myhandle' "Dose of immunomodulation" _tab "Total" _tab  "Grade 1" _tab "Grade 2" _tab "Grade 3" _tab "Grade 4" _n
	
	file write `myhandle' "Total"
	
	sum cum_dose_days, det
	local mean=`r(mean)'
	local sd=`r(sd)'
	
	sum cum_dose_days if grade1==1, det
	local mean_g1=`r(mean)'
	local sd_g1=`r(sd)'
	
	sum cum_dose_days if grade2==1, det
	local mean_g2=`r(mean)'
	local sd_g2=`r(sd)'
	
	sum cum_dose_days if grade3==1, det
	local mean_g3=`r(mean)'
	local sd_g3=`r(sd)'
	
	sum cum_dose_days if grade4==1, det
	local mean_g4=`r(mean)'
	local sd_g4=`r(sd)'
	
	file write `myhandle' _tab %4.1fc (`mean') (" (") %4.1fc (`sd') (")") _tab %4.1fc (`mean_g1') (" (") %4.1fc (`sd_g1') (")") _tab %4.1fc (`mean_g2') (" (") %4.1fc (`sd_g2') (")") _tab %4.1fc (`mean_g3') (" (") %4.1fc (`sd_g3') (")") _tab %4.1fc (`mean_g4') (" (") %4.1fc (`sd_g4') (")") _n
	
	sum cum_dose_days if immunomodulation==1
	local mean=`r(mean)'
	local sd=`r(sd)'
			
	file write `myhandle' _tab %4.1fc (`mean') (" (") %4.1fc (`sd') (")")
	
	forvalue x=1/4 {
	
		sum cum_dose_days if immunomodulation==1 & grade`x'==1
		local mean=`r(mean)'
		local sd=`r(sd)'
				
		file write `myhandle' _tab %4.1fc (`mean') (" (") %4.1fc (`sd') (")")
	
	}
	
	file write `myhandle' _n
	
	sum cum_dose_days if immunomodulation==2
	local mean=`r(mean)'
	local sd=`r(sd)'
			
	file write `myhandle' _tab %4.1fc (`mean') (" (") %4.1fc (`sd') (")")
	
	sum cum_dose_days if immunomodulation==2 & grade1==1
			
	file write `myhandle' _tab %4.1fc ("0")
	
	forvalue x=2/4 {
	
		sum cum_dose_days if immunomodulation==2 & grade`x'==1
		local mean=`r(mean)'
		local sd=`r(sd)'
				
		file write `myhandle' _tab %4.1fc (`mean') (" (") %4.1fc (`sd') (")")
	
	}
	
	file write `myhandle' _n
	
	sum cum_dose_days if immunomodulation==3
	local mean=`r(mean)'
	local sd=`r(sd)'
			
	file write `myhandle' _tab %4.1fc (`mean') (" (") %4.1fc (`sd') (")")
	
	sum cum_dose_days if immunomodulation==3 & grade1==1
			
	file write `myhandle' _tab %4.1fc ("0")
	
	sum cum_dose_days if immunomodulation==3 & grade2==1
			
	file write `myhandle' _tab %4.1fc ("0")
	
	sum cum_dose_days if immunomodulation==3 & grade3==1
	
	file write `myhandle' _tab %4.1fc ("0")
	
	sum cum_dose_days if immunomodulation==3 & grade4==1
	local mean=`r(mean)'
	local sd=`r(sd)'
			
	file write `myhandle' _tab %4.1fc (`mean') (" (") %4.1fc (`sd') (")") _n
	
	sum cum_dose_days if immunomodulation==4
	local mean=`r(mean)'
			
	file write `myhandle' _tab %4.1fc (`mean') 
	
	sum cum_dose_days if immunomodulation==4 & grade1==1
	local mean=`r(mean)'
			
	file write `myhandle' _tab %4.1fc (`mean') 
	
	sum cum_dose_days if immunomodulation==4 & grade2==1
	
	file write `myhandle' _tab %4.1fc ("0")
	
	sum cum_dose_days if immunomodulation==4 & grade3==1
	
	file write `myhandle' _tab %4.1fc ("0")
	
	sum cum_dose_days if immunomodulation==4 & grade4==1
	local mean=`r(mean)'
			
	file write `myhandle' _tab %4.1fc (`mean') _n
	
*********************************************************************

* Survival by type of immunomodulation

	tempname myhandle	
	file open `myhandle' using "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tables/immunomod_outcome.txt", write replace
	
	file write `myhandle' "Total" _tab "Survivors" _tab "Non-survivors" _n
	
	count
	local n=`r(N)'
	
	count if outcome==1
	local surv=`r(N)'
	local surv_pct=((`surv')/(`n'))*100
	
	count if outcome==2
	local died=`r(N)'
	local died_pct=((`died')/(`n'))*100
	
	file write `myhandle' (`n') (" (100)") _tab (`surv') (" (") %2.0f (`surv_pct') (")") _tab (`died') (" (") %2.0f (`died_pct') (")") _n
	
	forvalues x=1/4 {
		
		count if immunomodulation==`x'
		local n_`x'=`r(N)'
		local pct_n_`x'=((`n_`x'')/(`n_`x''))*100
		
		count if immunomodulation==`x' & outcome==1
		local surv_`x'=`r(N)'
		local pct_surv_`x'=((`surv_`x'')/(`n_`x''))*100
		
		count if immunomodulation==`x' & outcome==2
		local died_`x'=`r(N)'
		local pct_died_`x'=((`died_`x'')/(`n_`x''))*100
		
		file write `myhandle' (`n_`x'') (" (") %2.0f (`pct_n_`x'') (")") _tab (`surv_`x'') (" (") %2.0f (`pct_surv_`x'') (")") _tab (`died_`x'') (" (") %2.0f (`pct_died_`x'') (")") _n
		
	}
	
	file close `myhandle'
	
*********************************************************************

* Outcome by phenotype

	tempname myhandle	
	file open `myhandle' using "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tables/outcome_pheno.txt", write replace
	
	file write `myhandle' "Phenotype" _tab "Total" _tab "Survivors" _tab "Non-survivors" _n
	
	foreach x in severebleeding liverdys leak {
		
		file write `myhandle' "`x'"
		
		count if `x'==1 & mixedpheno==2
		local n=`r(N)'
		local pct=((`n')/(`n'))*100
		
		count if `x'==1 & outcome==1 & mixedpheno==2
		local n_surv=`r(N)'
		local pct_surv=((`n_surv')/(`n'))*100
		
		count if `x'==1 & outcome==2 & mixedpheno==2
		local n_died=`r(N)'
		local pct_died=((`n_died')/(`n'))*100
		
		file write `myhandle' _tab (`n') (" (") %2.0f (`pct') (")") _tab (`n_surv') (" (") %2.0f (`pct_surv') (")") _tab (`n_died') (" (") %2.0f (`pct_died') (")") _n
		
	}
	
	file write `myhandle' "`x'"
		
	count if mixedpheno==1 
	local n=`r(N)'
	local pct=((`n')/(`n'))*100
		
	count if mixedpheno==1 & outcome==1 
	local n_surv=`r(N)'
	local pct_surv=((`n_surv')/(`n'))*100
		
	count if mixedpheno==1 & outcome==2
	local n_died=`r(N)'
	local pct_died=((`n_died')/(`n'))*100
		
	file write `myhandle' "mixedpheno" _tab (`n') (" (") %2.0f (`pct') (")") _tab (`n_surv') (" (") %2.0f (`pct_surv') (")") _tab (`n_died') (" (") %2.0f (`pct_died') (")") _n
	
*********************************************************************

* Day of immunomodulation by day of anakinra initiation

	foreach z in ivig_timing steroids_timing plasmapheresis_timing {

		tempname myhandle	
		file open `myhandle' using "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tables/`z'.txt", write replace
		
		file write `myhandle' "" _tab "`z'" _n
		file write `myhandle' "" _tab "Day 1" _tab "Day 2" _tab "Day 3" _tab "Day 4" _tab "Day 5" _tab "Day 6" _tab "Day 7" _n
		file write `myhandle' "Day of anakinra initiation" 
		
		forvalues x=1/5 {
			
			file write `myhandle' _tab "Day `x'"
			
			count if `z'>0 & `z'!=.
			local n=`r(N)'
			
			forvalues y=1/7 {
			
				count if `z'==`y' & akinra_timing==`x'
				local ivig_`y'=`r(N)'
				local ivig_`y'_pct=((`ivig_`y'')/(`n'))*100
				
			}
			
			file write `myhandle' _tab (`ivig_1') (" (") %2.0f (`ivig_1_pct') (")") _tab (`ivig_2') (" (") %2.0f (`ivig_2_pct') (")") _tab (`ivig_3') (" (") %2.0f (`ivig_3_pct') (")") _tab (`ivig_4') (" (") %2.0f (`ivig_4_pct') (")") _tab (`ivig_5') (" (") %2.0f (`ivig_5_pct') (")") _tab (`ivig_6') (" (") %2.0f (`ivig_6_pct') (")") _tab (`ivig_7') (" (") %2.0f (`ivig_7_pct') (")") _n
			
		}
		
		file close `myhandle'
		
	}
	
	tab ivig_timing patid if steroids_timing!=. & plasmapheresis_timing!=.
	
	tab plasmapheresis_timing steroids_timing if steroids_timing!=.
	tab steroids_timing akinra_timing if plasmapheresis_timing!=.
	tab outcome if steroids_timing!=. & plasmapheresis_timing!=.
	
*********************************************************************

* Survival by NS1 / IgM positivity

	tempname myhandle	
	file open `myhandle' using "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tables/survival_ns1_igm.txt", write replace
	
	file write `myhandle' "Serological status of NS1 and IgM" _tab "Total" _tab "Survivors" _tab "Non-survivors" _n
	
	file write `myhandle' "Total"
	
	count
	local n=`r(N)'
	local pct=((`n')/(`n'))*100
	
	count if outcome==1
	local surv=`r(N)'
	local surv_pct=((`surv')/(`n'))*100
	
	count if outcome==2
	local died=`r(N)'
	local died_pct=((`died')/(`n'))*100
	
	file write `myhandle' _tab (`n') (" (") %2.0f (`pct') (")") _tab (`surv') (" (") %2.0f (`surv_pct') (")") _tab (`died') (" (") %2.0f (`died_pct') (")") _n
	
	forvalues x=1/3 {
		
		file write `myhandle' "`x'"
		
		count if sero_status==`x'
		local n=`r(N)'
		local pct=100
		
		count if outcome==1 & sero_status==`x'
		local surv=`r(N)'
		local surv_pct=((`surv')/(`n'))*100
		
		count if outcome==2 & sero_status==`x'
		local died=`r(N)'
		local died_pct=((`died')/(`n'))*100
		
		file write `myhandle' _tab (`n') (" (") %2.0f (`pct') (")") _tab (`surv') (" (") %2.0f (`surv_pct') (")") _tab (`died') (" (") %2.0f (`died_pct') (")") _n
		
	}
	
	file close `myhandle'
	
*********************************************************************

* Survival by NS1 / IgM positivity and type of immunomodulation

	forvalues y=1/3 {

		tempname myhandle	
		file open `myhandle' using "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tables/survival_ns1_igm_by`y'.txt", write replace
		
		if `y'==1 {
		
			file write `myhandle' "–NS1 +IgM" _tab "Total" _tab "Survivors" _tab "Non-survivors" _n
			
		}
		
		if `y'==2 {
		
			file write `myhandle' "+NS1 -IgM" _tab "Total" _tab "Survivors" _tab "Non-survivors" _n
			
		}
		
		else if `y'==3 {
		
			file write `myhandle' "+NS1 +IgM" _tab "Total" _tab "Survivors" _tab "Non-survivors" _n
			
		}
		
		file write `myhandle' "Total"
		
		count if sero_status==`y'
		local n=`r(N)'
		local pct=((`n')/(`n'))*100
		
		count if outcome==1 & sero_status==`y'
		local surv=`r(N)'
		local surv_pct=((`surv')/(`n'))*100
		
		count if outcome==2 & sero_status==`y'
		local died=`r(N)'
		local died_pct=((`died')/(`n'))*100
		
		file write `myhandle' _tab (`n') (" (") %2.0f (`pct') (")") _tab (`surv') (" (") %2.0f (`surv_pct') (")") _tab (`died') (" (") %2.0f (`died_pct') (")") _n
		
		forvalues x=1/4 {
			
			file write `myhandle' "`x'"
			
			count if sero_status==`y' & immunomodulation==`x'
			local n=`r(N)'
			local pct=((`n')/(`n'))*100
			
			count if outcome==1 & sero_status==`y' & immunomodulation==`x'
			local surv=`r(N)'
			local surv_pct=((`surv')/(`n'))*100
			
			count if outcome==2 & sero_status==`y' & immunomodulation==`x'
			local died=`r(N)'
			local died_pct=((`died')/(`n'))*100
			
			file write `myhandle' _tab (`n') (" (") %2.0f (`pct') (")") _tab (`surv') (" (") %2.0f (`surv_pct') (")") _tab (`died') (" (") %2.0f (`died_pct') (")") _n
			
		}
		
		file close `myhandle'

	}
	
*********************************************************************

* Presence of fever at immunomodulation

	tempname myhandle	
	file open `myhandle' using "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tables/fever_immunomod.txt", write replace
	
	file write `myhandle' "Fever at immunomodulation" _tab "Total" _tab "Survivors" _tab "Non-survivors" _n
	
	file write `myhandle' "Total"
		
	count 
	local n=`r(N)'
	local pct=((`n')/(`n'))*100
		
	count if outcome==1
	local surv=`r(N)'
	local surv_pct=((`surv')/(`n'))*100
		
	count if outcome==2
	local died=`r(N)'
	local died_pct=((`died')/(`n'))*100
		
	file write `myhandle' _tab (`n') (" (") %2.0f (`pct') (")") _tab (`surv') (" (") %2.0f (`surv_pct') (")") _tab (`died') (" (") %2.0f (`died_pct') (")") _n
	
	forvalues x=1/2 {
		
		if `x'==1 {
	
			file write `myhandle' "Fever"
		
		}
		
		else if `x'==2 {
			
			file write `myhandle' "No fever"
		
		}
		
		count if fever_immunomod==`x'
		local n=`r(N)'
		local pct=((`n')/(`n'))*100
		
		count if fever_immunomod==`x' & outcome==1
		local fever_surv=`r(N)'
		local surv_pct=((`fever_surv')/(`n'))*100
		
		count if fever_immunomod==`x' & outcome==2
		local fever_died=`r(N)'
		local died_pct=((`fever_died')/(`n'))*100
		
		file write `myhandle' _tab (`n') (" (") %2.0f (`pct') (")") _tab (`fever_surv') (" (") %2.0f (`surv_pct') (")") _tab (`fever_died') (" (") %2.0f (`died_pct') (")") _n 
		
	}

*********************************************************************

* Presence of fever by immunomodulation among those with CRP>=12 at any time

	tempname myhandle	
	file open `myhandle' using "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tables/fever_highcrp.txt", write replace
	
	file write `myhandle' "High CRP (>=12)" _tab "Total" _tab "Fever" _tab "No fever" _n
	
	file write `myhandle' "Total"
	
	count if high_crp==1
	local n=`r(N)'
	local pct=((`n')/(`n'))*100
		
	count if high_crp==1 & fever_immunomod==1
	local fever=`r(N)'
	local fever_pct=((`fever')/(`n'))*100
		
	count if high_crp==1 & fever_immunomod==2
	local nofev=`r(N)'
	local nofev_pct=((`nofev')/(`n'))*100
	
	file write `myhandle' _tab (`n') (" (") %2.0f (`pct') (")") _tab (`fever') (" (") %2.0f (`fever_pct') (")") _tab (`nofev') (" (") %2.0f (`nofev_pct') (")") _n
	
	forvalues x=1/4 {
		
		file write `myhandle' "`x'"
	
		count if high_crp==1 & immunomodulation==`x'
		local n=`r(N)'
		local pct=((`n')/(`n'))*100
			
		count if high_crp==1 & fever_immunomod==1 & immunomodulation==`x'
		local fever=`r(N)'
		local fever_pct=((`fever')/(`n'))*100
			
		count if high_crp==1 & fever_immunomod==2 & immunomodulation==`x'
		local nofev=`r(N)'
		local nofev_pct=((`nofev')/(`n'))*100
		
		file write `myhandle' _tab (`n') (" (") %2.0f (`pct') (")") _tab (`fever') (" (") %2.0f (`fever_pct') (")") _tab (`nofev') (" (") %2.0f (`nofev_pct') (")") _n
		
	}

*********************************************************************

* Survival by immunomodulation among those with co-infection

	tempname myhandle	
	file open `myhandle' using "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tables/survival_coinfect.txt", write replace
	
	file write `myhandle' "Co-infection" _tab "Total" _tab "Survivors" _tab "Non-survivors" _n
	
	file write `myhandle' "Total"
	
	count if coinfection==1
	local n=`r(N)'
	local pct=((`n')/(`n'))*100
		
	count if coinfection==1 & outcome==1
	local surv=`r(N)'
	local surv_pct=((`surv')/(`n'))*100
		
	count if coinfection==1 & outcome==2
	local died=`r(N)'
	local died_pct=((`died')/(`n'))*100
	
	file write `myhandle' _tab (`n') (" (") %2.0f (`pct') (")") _tab (`surv') (" (") %2.0f (`surv_pct') (")") _tab (`died') (" (") %2.0f (`died_pct') (")") _n
	
	forvalues x=1/4 {
		
		file write `myhandle' "`x'"
	
		count if coinfection==1 & immunomodulation==`x'
		local n=`r(N)'
		local pct=((`n')/(`n'))*100
			
		count if coinfection==1 & immunomodulation==`x' & outcome==1
		local surv=`r(N)'
		local surv_pct=((`surv')/(`n'))*100
			
		count if coinfection==1 & immunomodulation==`x' & outcome==2
		local died=`r(N)'
		local died_pct=((`died')/(`n'))*100
		
		file write `myhandle' _tab (`n') (" (") %2.0f (`pct') (")") _tab (`surv') (" (") %2.0f (`surv_pct') (")") _tab (`died') (" (") %2.0f (`died_pct') (")") _n
		
	}
	
*********************************************************************

* Survival by immunomodulation among those with co-infection of influenza

	tempname myhandle	
	file open `myhandle' using "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tables/survival_flu.txt", write replace
	
	file write `myhandle' "Influenza" _tab "Total" _tab "Survivors" _tab "Non-survivors" _n
	
	file write `myhandle' "Total"
	
	count if influenza==1
	local n=`r(N)'
	local pct=((`n')/(`n'))*100
		
	count if influenza==1 & outcome==1
	local surv=`r(N)'
	local surv_pct=((`surv')/(`n'))*100
		
	count if influenza==1 & outcome==2
	local died=`r(N)'
	local died_pct=((`died')/(`n'))*100
	
	file write `myhandle' _tab (`n') (" (") %2.0f (`pct') (")") _tab (`surv') (" (") %2.0f (`surv_pct') (")") _tab (`died') (" (") %2.0f (`died_pct') (")") _n
	
	forvalues x=1/4 {
		
		file write `myhandle' "`x'"
	
		count if influenza==1 & immunomodulation==`x'
		local n=`r(N)'
		local pct=((`n')/(`n'))*100
			
		count if influenza==1 & immunomodulation==`x' & outcome==1
		local surv=`r(N)'
		local surv_pct=((`surv')/(`n'))*100
			
		count if influenza==1 & immunomodulation==`x' & outcome==2
		local died=`r(N)'
		local died_pct=((`died')/(`n'))*100
		
		file write `myhandle' _tab (`n') (" (") %2.0f (`pct') (")") _tab (`surv') (" (") %2.0f (`surv_pct') (")") _tab (`died') (" (") %2.0f (`died_pct') (")") _n
		
	}
	
*********************************************************************

* Type of immunomodulation by maximum ferritin levels

	tempname myhandle	
	file open `myhandle' using "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tables/immunomod_ferritin.txt", write replace
	
	file write `myhandle' "" _tab "Peak ferritin" _n
	
	file write `myhandle' "" _tab "Total" _tab "<5,000" _tab "5,000–9,999" _tab "10,000–49,999" _tab "50,000+" _n
	
	file write `myhandle' "Type of immunomodulation" _tab "N (%)" _tab "Average dose (SD)" _tab "N (%)" _tab "Average dose (SD)" _tab "N (%)" _tab "Average dose (SD)" _tab "N (%)" _tab "Average dose (SD)" _tab "N (%)" _tab "Average dose (SD)" _n
	
	file write `myhandle' "Total"
	
	count
	local n=`r(N)'
	local pct=((`n')/(`n'))*100
	
	file write `myhandle' _tab (`n') (" (") %2.0f (`pct') (")")
	
	summ cum_dose_days
	local mean=`r(mean)'
	local sd=`r(sd)'
	
	file write `myhandle' _tab %4.1fc (`mean') (" (") %4.1fc (`sd') (")")
	
	forvalues x=1/4 {
	
		count if ferritin_levels==`x'
		local ferr_`x'=`r(N)'
		local ferr_`x'_pct=((`ferr_`x'')/(`n'))*100
			
			file write `myhandle' _tab (`ferr_`x'') (" (") %2.0f (`ferr_`x'_pct') (")")
			
		summ cum_dose_days if ferritin_levels==`x'
		local mean=`r(mean)'
		local sd=`r(sd)'
		
		file write `myhandle' _tab %4.1fc (`mean') (" (") %4.1fc (`sd') (")")
	
	}
	
	file write `myhandle' _n
	
	file write `myhandle' "Anakinra, alone"
	
	count if immunomodulation==1
	local n=`r(N)'
	local pct=((`n')/(`n'))*100
	
	file write `myhandle' _tab (`n') (" (") %2.0f (`pct') (")")
	
	summ cum_dose_days if immunomodulation==1
	local mean=`r(mean)'
	local sd=`r(sd)'
	
	file write `myhandle' _tab %4.1fc (`mean') (" (") %4.1fc (`sd') (")")
	
	summ cum_dose_days if immunomodulation==1 & ferritin_levels==1
	
	file write `myhandle' _tab ("0") _tab ("")
	
	count if immunomodulation==1 & ferritin_levels==2
	local n_2=`r(N)'
	local pct=((`n_2')/(`n'))*100
	
	file write `myhandle' _tab (`n_2') (" (") %2.0f (`pct') (")")
	
	summ cum_dose_days if immunomodulation==1 & ferritin_levels==2
	local mean=`r(mean)'
	local sd=`r(sd)'
	
	file write `myhandle' _tab %4.1fc (`mean') (" (") %4.1fc (`sd') (")")
	
	count if immunomodulation==1 & ferritin_levels==3
	local n_3=`r(N)'
	local pct=((`n_3')/(`n'))*100
	
	file write `myhandle' _tab (`n_3') (" (") %2.0f (`pct') (")")
	
	summ cum_dose_days if immunomodulation==1 & ferritin_levels==3
	local mean=`r(mean)'
	local sd=`r(sd)'
	
	file write `myhandle' _tab %4.1fc (`mean') (" (") %4.1fc (`sd') (")")
	
	count if immunomodulation==1 & ferritin_levels==4
	local n_4=`r(N)'
	local pct=((`n_4')/(`n'))*100
	
	file write `myhandle' _tab (`n_4') (" (") %2.0f (`pct') (")")
	
	summ cum_dose_days if immunomodulation==1 & ferritin_levels==4
	local mean=`r(mean)'
	local sd=`r(sd)'
	
	file write `myhandle' _tab %4.1fc (`mean') (" (") %4.1fc (`sd') (")") _n
	
	file write `myhandle' "Corticosteroids, any + anakinra"
	
	count if immunomodulation==2
	local n=`r(N)'
	local pct=((`n')/(`n'))*100
	
	file write `myhandle' _tab (`n') (" (") %2.0f (`pct') (")")
	
	summ cum_dose_days if immunomodulation==2
	local mean=`r(mean)'
	local sd=`r(sd)'
	
	file write `myhandle' _tab %4.1fc (`mean') (" (") %4.1fc (`sd') (")")
	
	summ cum_dose_days if immunomodulation==2 & ferritin_levels==1
	local n_1=`r(N)'
	local pct=((`n_1')/(`n'))*100
	
	file write `myhandle' _tab (`n_1') (" (") %2.0f (`pct') (")")
	
	summ cum_dose_days if immunomodulation==2 & ferritin_levels==1
	local mean=`r(mean)'
	local sd=`r(sd)'
	
	file write `myhandle' _tab %4.1fc (`mean') (" (") %4.1fc (`sd') (")")
	
	count if immunomodulation==2 & ferritin_levels==2
	
	file write `myhandle' _tab ("0") _tab ("")
	
	count if immunomodulation==2 & ferritin_levels==3
	local n_3=`r(N)'
	local pct=((`n_3')/(`n'))*100
	
	file write `myhandle' _tab (`n_3') (" (") %2.0f (`pct') (")")
	
	summ cum_dose_days if immunomodulation==2 & ferritin_levels==3
	local mean=`r(mean)'
	local sd=`r(sd)'
	
	file write `myhandle' _tab %4.1fc (`mean') (" (") %4.1fc (`sd') (")")
	
	count if immunomodulation==2 & ferritin_levels==4
	local n_4=`r(N)'
	local pct=((`n_4')/(`n'))*100
	
	file write `myhandle' _tab (`n_4') (" (") %2.0f (`pct') (")")
	
	summ cum_dose_days if immunomodulation==2 & ferritin_levels==4
	local mean=`r(mean)'
	local sd=`r(sd)'
	
	file write `myhandle' _tab %4.1fc (`mean') (" (") %4.1fc (`sd') (")") _n
	
	file write `myhandle' "Plasmapheresis, any + anakinra"
	
	count if immunomodulation==3
	local n=`r(N)'
	local pct=((`n')/(`n'))*100
	
	file write `myhandle' _tab (`n') (" (") %2.0f (`pct') (")")
	
	summ cum_dose_days if immunomodulation==3
	local mean=`r(mean)'
	local sd=`r(sd)'
	
	file write `myhandle' _tab %4.1fc (`mean') (" (") %4.1fc (`sd') (")")
	
	summ cum_dose_days if immunomodulation==3 & ferritin_levels==1
	
	file write `myhandle' _tab ("0") _tab ("")
	
	count if immunomodulation==3 & ferritin_levels==2
	
	file write `myhandle' _tab ("0") _tab ("")
	
	count if immunomodulation==3 & ferritin_levels==3
	
	file write `myhandle' _tab ("0") _tab ("")
	
	count if immunomodulation==3 & ferritin_levels==4
	local n_4=`r(N)'
	local pct=((`n_4')/(`n'))*100
	
	file write `myhandle' _tab (`n_4') (" (") %2.0f (`pct') (")")
	
	summ cum_dose_days if immunomodulation==3 & ferritin_levels==4
	local mean=`r(mean)'
	local sd=`r(sd)'
	
	file write `myhandle' _tab %4.1fc (`mean') (" (") %4.1fc (`sd') (")") _n
	
	file write `myhandle' "Both corticosteroids and plasmapheresis + anakinra"
	
	count if immunomodulation==4
	local n=`r(N)'
	local pct=((`n')/(`n'))*100
	
	file write `myhandle' _tab (`n') (" (") %2.0f (`pct') (")")
	
	summ cum_dose_days if immunomodulation==4
	local mean=`r(mean)'
	local sd=`r(sd)'
	
	file write `myhandle' _tab %4.1fc (`mean') (" (") %4.1fc (`sd') (")")
	
	summ cum_dose_days if immunomodulation==4 & ferritin_levels==1
	
	file write `myhandle' _tab ("0") _tab ("")
	
	count if immunomodulation==4 & ferritin_levels==2
	
	file write `myhandle' _tab ("0") _tab ("")
	
	count if immunomodulation==4 & ferritin_levels==3
	
	file write `myhandle' _tab ("0") _tab ("")
	
	count if immunomodulation==4 & ferritin_levels==4
	local n_4=`r(N)'
	local pct=((`n_4')/(`n'))*100
	
	file write `myhandle' _tab (`n_4') (" (") %2.0f (`pct') (")")
	
	summ cum_dose_days if immunomodulation==4 & ferritin_levels==4
	local mean=`r(mean)'
	local sd=`r(sd)'
	
	file write `myhandle' _tab %4.1fc (`mean') (" (") %4.1fc (`sd') (")") _n
	
*********************************************************************

* Outcomes by maximum ferritin levels

	tempname myhandle	
	file open `myhandle' using "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tables/outcomes_ferritin.txt", write replace
	
	file write `myhandle' "Outcomes" _n
	
	file write `myhandle' "Total" _tab "Non-survivors" _tab "Hospital stay duration" _tab "ICU stay duration" _tab "Mechanical ventilation duration" _tab "Need for RRT" _n
	
	count
	local n=`r(N)'
	local pct=((`n')/(`n'))*100
	
	file write `myhandle' (`n') (" (") (`pct') (")")
	
	count if outcome==2
	local died=`r(N)'
	local died_pct=((`died')/(`n'))*100
	
	file write `myhandle' _tab (`died') (" (") %2.0f (`died_pct') (")")
	
	summ hospstay_duration, det
	local median =`r(p50)'
	local q1 = `r(p25)'
	local q3 = `r(p75)'
	local iqr = `q3' - `q1'
	
	file write `myhandle' _tab (`median') (" (") %2.0f (`iqr') (")")
	
	summ icustay_duration, det
	local median =`r(p50)'
	local q1 = `r(p25)'
	local q3 = `r(p75)'
	local iqr = `q3' - `q1'
	
	file write `myhandle' _tab (`median') (" (") %2.0f (`iqr') (")")

	summ suppther_duration, det
	local median =`r(p50)'
	local q1 = `r(p25)'
	local q3 = `r(p75)'
	local iqr = `q3' - `q1'
	
	file write `myhandle' _tab (`median') (" (") %2.0f (`iqr') (")")
	
	count if need_rrt==2
	local rrt=`r(N)'
	local rrt_pct=((`rrt')/(`n'))*100
	
	file write `myhandle' _tab (`rrt') (" (") %2.0f (`rrt_pct') (")") _n
	
	forvalues x=1/4 {
		
		count if ferritin_levels==`x'
		local n=`r(N)'
		local pct=((`n')/(`n'))*100
		
		file write `myhandle' (`n') (" (") (`pct') (")")
		
		count if outcome==2 & ferritin_levels==`x'
		local died=`r(N)'
		local died_pct=((`died')/(`n'))*100
		
		file write `myhandle' _tab (`died') (" (") %2.0f (`died_pct') (")")
		
		summ hospstay_duration if ferritin_levels==`x', det
		local median =`r(p50)'
		local q1 = `r(p25)'
		local q3 = `r(p75)'
		local iqr = `q3' - `q1'
	
		file write `myhandle' _tab (`median') (" (") %2.0f (`iqr') (")")
		
		summ icustay_duration if ferritin_levels==`x', det
		local median =`r(p50)'
		local q1 = `r(p25)'
		local q3 = `r(p75)'
		local iqr = `q3' - `q1'
	
		file write `myhandle' _tab (`median') (" (") %2.0f (`iqr') (")")

		summ suppther_duration if ferritin_levels==`x', det
		local median =`r(p50)'
		local q1 = `r(p25)'
		local q3 = `r(p75)'
		local iqr = `q3' - `q1'
	
		file write `myhandle' _tab (`median') (" (") %2.0f (`iqr') (")")
		
		count if need_rrt==1 & ferritin_levels==`x'
		local rrt=`r(N)'
		local rrt_pct=((`rrt')/(`n'))*100
		
		file write `myhandle' _tab (`rrt') (" (") %2.0f (`rrt_pct') (")") _n
		
	}
	
	file close `myhandle'
	
*********************************************************************

* Outcomes by CRP elevation

	tempname myhandle	
	file open `myhandle' using "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tables/outcomes_crp.txt", write replace
	
	file write `myhandle' "Outcomes" _n
	
	file write `myhandle' "Total" _tab "Non-survivors" _tab "Hospital stay duration" _tab "ICU stay duration" _tab "Mechanical ventilation duration" _tab "Need for RRT" _tab "Peak ferritin" _n
	
	count
	local n=`r(N)'
	local pct=((`n')/(`n'))*100
	
	file write `myhandle' (`n') (" (") (`pct') (")")
	
	count if outcome==2
	local died=`r(N)'
	local died_pct=((`died')/(`n'))*100
	
	file write `myhandle' _tab (`died') (" (") %2.0f (`died_pct') (")")
	
	summ hospstay_duration, det
	local median =`r(p50)'
	local q1 = `r(p25)'
	local q3 = `r(p75)'
	local iqr = `q3' - `q1'
	
	file write `myhandle' _tab (`median') (" (") %2.0f (`iqr') (")")
	
	summ icustay_duration, det
	local median =`r(p50)'
	local q1 = `r(p25)'
	local q3 = `r(p75)'
	local iqr = `q3' - `q1'
	
	file write `myhandle' _tab (`median') (" (") %2.0f (`iqr') (")")

	summ suppther_duration, det
	local median =`r(p50)'
	local q1 = `r(p25)'
	local q3 = `r(p75)'
	local iqr = `q3' - `q1'
	
	file write `myhandle' _tab (`median') (" (") %2.0f (`iqr') (")")
	
	count if need_rrt==2
	local rrt=`r(N)'
	local rrt_pct=((`rrt')/(`n'))*100
	
	file write `myhandle' _tab (`rrt') (" (") %2.0f (`rrt_pct') (")")
	
	summ max_ferritin, det
	local median =`r(p50)'
	local q1 = `r(p25)'
	local q3 = `r(p75)'
	local iqr = `q3' - `q1'
	
	file write `myhandle' _tab %6.0fc (`median') (" (") %6.0fc (`iqr') (")") _n
	
	forvalues x=1/3 {
		
		count if crp_scale==`x'
		local n=`r(N)'
		local pct=((`n')/(`n'))*100
		
		file write `myhandle' (`n') (" (") (`pct') (")")
		
		count if outcome==2 & crp_scale==`x'
		local died=`r(N)'
		local died_pct=((`died')/(`n'))*100
		
		file write `myhandle' _tab (`died') (" (") %2.0f (`died_pct') (")")
		
		summ hospstay_duration if crp_scale==`x', det
		local median =`r(p50)'
		local q1 = `r(p25)'
		local q3 = `r(p75)'
		local iqr = `q3' - `q1'
	
		file write `myhandle' _tab (`median') (" (") %2.0f (`iqr') (")")
		
		summ icustay_duration if crp_scale==`x', det
		local median =`r(p50)'
		local q1 = `r(p25)'
		local q3 = `r(p75)'
		local iqr = `q3' - `q1'
	
		file write `myhandle' _tab (`median') (" (") %2.0f (`iqr') (")")

		summ suppther_duration if crp_scale==`x', det
		local median =`r(p50)'
		local q1 = `r(p25)'
		local q3 = `r(p75)'
		local iqr = `q3' - `q1'
	
		file write `myhandle' _tab (`median') (" (") %2.0f (`iqr') (")")
		
		count if need_rrt==1 & crp_scale==`x'
		local rrt=`r(N)'
		local rrt_pct=((`rrt')/(`n'))*100
		
		file write `myhandle' _tab (`rrt') (" (") %2.0f (`rrt_pct') (")")
		
		summ max_ferritin if crp_scale==`x', det
		local median =`r(p50)'
		local q1 = `r(p25)'
		local q3 = `r(p75)'
		local iqr = `q3' - `q1'
	
		file write `myhandle' _tab %6.0fc (`median') (" (") %6.0fc (`iqr') (")") _n
		
	}
	
	file close `myhandle'
	
*********************************************************************

* Outcomes by immunomodulation among those with >=18 CRP

	tempname myhandle	
	file open `myhandle' using "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tables/outcomes_immunomod_highcrp.txt", write replace
	
	file write `myhandle' "Outcomes" _n
	
	file write `myhandle' "Total" _tab "Non-survivors" _tab "Hospital stay duration" _tab "ICU stay duration" _tab "Mechanical ventilation duration" _tab "Need for RRT" _tab "Peak ferritin" _n
	
	count if crp_scale==3
	local n=`r(N)'
	local pct=((`n')/(`n'))*100
	
	file write `myhandle' (`n') (" (") (`pct') (")")
	
	count if outcome==2 & crp_scale==3
	local died=`r(N)'
	local died_pct=((`died')/(`n'))*100
	
	file write `myhandle' _tab (`died') (" (") %2.0f (`died_pct') (")")
	
	summ hospstay_duration if crp_scale==3, det
	local median =`r(p50)'
	local q1 = `r(p25)'
	local q3 = `r(p75)'
	local iqr = `q3' - `q1'
	
	file write `myhandle' _tab (`median') (" (") %2.0f (`iqr') (")")
	
	summ icustay_duration if crp_scale==3, det
	local median =`r(p50)'
	local q1 = `r(p25)'
	local q3 = `r(p75)'
	local iqr = `q3' - `q1'
	
	file write `myhandle' _tab (`median') (" (") %2.0f (`iqr') (")")

	summ suppther_duration if crp_scale==3, det
	local median =`r(p50)'
	local q1 = `r(p25)'
	local q3 = `r(p75)'
	local iqr = `q3' - `q1'
	
	file write `myhandle' _tab (`median') (" (") %2.0f (`iqr') (")")
	
	count if need_rrt==2 & crp_scale==3
	local rrt=`r(N)'
	local rrt_pct=((`rrt')/(`n'))*100
	
	file write `myhandle' _tab (`rrt') (" (") %2.0f (`rrt_pct') (")")
	
	summ max_ferritin if crp_scale==3, det
	local median =`r(p50)'
	local q1 = `r(p25)'
	local q3 = `r(p75)'
	local iqr = `q3' - `q1'
	
	file write `myhandle' _tab %7.0fc (`median') (" (") %7.0fc (`iqr') (")") _n
	
	forvalues x=1/4 {
		
		count if crp_scale==3 & immunomodulation==`x'
		local n=`r(N)'
		local pct=((`n')/(`n'))*100
		
		file write `myhandle' (`n') (" (") (`pct') (")")
		
		count if outcome==2 & crp_scale==3 & immunomodulation==`x'
		local died=`r(N)'
		local died_pct=((`died')/(`n'))*100
		
		file write `myhandle' _tab (`died') (" (") %2.0f (`died_pct') (")")
		
		summ hospstay_duration if crp_scale==3 & immunomodulation==`x', det
		local median =`r(p50)'
		local q1 = `r(p25)'
		local q3 = `r(p75)'
		local iqr = `q3' - `q1'
	
		file write `myhandle' _tab (`median') (" (") %2.0f (`iqr') (")")
		
		summ icustay_duration if crp_scale==3 & immunomodulation==`x', det
		local median =`r(p50)'
		local q1 = `r(p25)'
		local q3 = `r(p75)'
		local iqr = `q3' - `q1'
	
		file write `myhandle' _tab (`median') (" (") %2.0f (`iqr') (")")

		summ suppther_duration if crp_scale==3 & immunomodulation==`x', det
		local median =`r(p50)'
		local q1 = `r(p25)'
		local q3 = `r(p75)'
		local iqr = `q3' - `q1'
	
		file write `myhandle' _tab (`median') (" (") %2.0f (`iqr') (")")
		
		count if need_rrt==1 & crp_scale==3 & immunomodulation==`x'
		local rrt=`r(N)'
		local rrt_pct=((`rrt')/(`n'))*100
		
		file write `myhandle' _tab (`rrt') (" (") %2.0f (`rrt_pct') (")")
		
		summ max_ferritin if crp_scale==3 & immunomodulation==`x', det
		local median =`r(p50)'
		local q1 = `r(p25)'
		local q3 = `r(p75)'
		local iqr = `q3' - `q1'
	
		file write `myhandle' _tab %7.0fc (`median') (" (") %7.0fc (`iqr') (")") _n
		
	}
	
	file close `myhandle'	
