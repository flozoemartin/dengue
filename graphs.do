
	


	cd "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/graphs"

* Ferritin levels by day of immunomodulation initiation	

		forvalues x=1/45 {
		
			use "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/analysis_dataset.dta", clear
		
			rename ferritin_admission ferritin_1
			rename ferritin_48 ferritin_2
			rename ferritin_96 ferritin_3
			rename ferritin_120 ferritin_4
			gen ferritin_5 =.
			rename ferritin_day6 ferritin_6
			
			keep patid akinra_timing ferritin_1 ferritin_2 ferritin_3 ferritin_4 ferritin_5 ferritin_6
		
			keep if patid==`x'
			
			if akinra_timing==1 {
			
				drop akinra_timing
			
				reshape long ferritin_, i(patid) j(day)
				
				rename ferritin_ ferritin_`x'
				drop patid
			
			}
			
			else if akinra_timing==2 {
				
				drop akinra_timing
				
				drop ferritin_1
				
				forvalues y=2/5 {
					
					local z=`y'-1
					
					rename ferritin_`y' ferritin_`z'
					
				}
				
				reshape long ferritin_, i(patid) j(day)
				
				rename ferritin_ ferritin_`x'
				drop patid
				
			}
			
			else {
				
				drop akinra_timing
				
				drop ferritin_1 ferritin_2
				
				forvalues y=3/5 {
					
					local z=`y'-2
					
					rename ferritin_`y' ferritin_`z'
					
			}
			
			reshape long ferritin_, i(patid) j(day)
			
			rename ferritin_ ferritin_`x'
			drop patid
			
		}
		
		save "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tempdata/pat_`x'.dta", replace
	
	}
	
	use "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tempdata/pat_1.dta", clear
	
	forvalues x=2/45 {
		
		merge 1:1 day using "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tempdata/pat_`x'.dta", nogen
		
	}
	
	drop if day==5 | day==6
	
	twoway line ferritin_1-ferritin_45 day, title("Ferritin levels since" "immunomodulation initiation", size(medium) color(black)) yscale(range(0 200000) titlegap(5)) ylabel(25000 (50000) 175000) xtitle("Day elapsed since anakinra initiation", margin(medium)) ytitle("Ferritin level (ng/mL)") graphregion(color(white)) plotregion(color(white)) legend(off) name(ferritin_anakinra, replace)
	
	graph export ferritin_immunoday.pdf, replace
	
*********************************************************************

* Fluid requirement by day of immunomodulation initiation	

	forvalues x=1/45 {
		
		use "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/analysis_dataset.dta", clear
		
		rename fluidreq_6 fluidreq_1
		rename fluidreq_12 fluidreq_2
		rename fluidreq_18 fluidreq_3
		rename fluidreq_24 fluidreq_4
		rename fluidreq_30 fluidreq_5
		rename fluidreq_36 fluidreq_6
		
		keep patid akinra_timing fluidreq*
	
		keep if patid==`x'
		
		reshape long fluidreq_, i(patid) j(day)
		
		rename fluidreq fluidreq_`x'
		drop patid
		
		save "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tempdata/pat_`x'.dta", replace
	
	}
	
	use "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tempdata/pat_1.dta", clear
	
	forvalues x=2/45 {
		
		merge 1:1 day using "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tempdata/pat_`x'.dta", nogen
		
	}
	
	twoway line fluidreq_1-fluidreq_45 day, title("Fluid requirement since" "immunomodulation initiation", size(small) color(black)) xtitle("Hours elapsed since anakinra initiation", margin(medium)) yscale(range(0 20) titlegap(5)) ylabel(0 (5) 20) xlabel(1 "0-6" 2 "6-12" 3"12-18" 4"18-24" 5"24-30" 6"30-36") ytitle("Fluid requirement (ml/kg/day)") legend(off) graphregion(color(white)) plotregion(color(white)) name(fluidreq_anakinra, replace)
	
	graph export fluidreq_immunoday.pdf, replace

*********************************************************************

* SGOT by day of immunomodulation initiation	

	forvalues x=1/45 {
		
		use "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/analysis_dataset.dta", clear
		
		rename sgot_admission sgot_1
		rename sgot_48 sgot_2
		rename sgot_96 sgot_3
		rename sgot_120 sgot_4
		
		keep patid akinra_timing sgot_*
	
		keep if patid==`x'
		
		if akinra_timing==1 {
			
				drop akinra_timing
			
				reshape long sgot_, i(patid) j(day)
				
				rename sgot_ sgot_`x'
				drop patid
			
			}
			
			else if akinra_timing==2 {
				
				drop akinra_timing
				
				drop sgot_1
				
				forvalues y=2/4 {
					
					local z=`y'-1
					
					rename sgot_`y' sgot_`z'
					
				}
				
				reshape long sgot_, i(patid) j(day)
				
				rename sgot_ sgot_`x'
				drop patid
				
			}
			
			else {
				
				drop akinra_timing
				
				drop sgot_1 sgot_2
				
				forvalues y=3/4 {
					
					local z=`y'-2
					
					rename sgot_`y' sgot_`z'
					
			}
			
			reshape long sgot_, i(patid) j(day)
			
			rename sgot_ sgot_`x'
			drop patid
			
		}
		
		save "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tempdata/pat_`x'.dta", replace
	
	}
	
	use "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tempdata/pat_1.dta", clear
	
	forvalues x=2/45 {
		
		merge 1:1 day using "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tempdata/pat_`x'.dta", nogen
		
	}
	
	twoway line sgot_1-sgot_45 day, title("SGOT since" "immunomodulation initiation", size(small) color(black)) xtitle("Day elapsed since anakinra initiation", margin(medium)) yscale(range(0 20000) titlegap(5)) ylabel(0 (5000) 20000)  ytitle("SGOT") legend(off) graphregion(color(white)) plotregion(color(white)) name(sgot_immunomod, replace)
	
	graph export sgot_immunoday.pdf, replace
	
*********************************************************************

* Bilirubin by day of immunomodulation initiation	

	forvalues x=1/45 {
		
		use "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/analysis_dataset.dta", clear
		
		rename tbili_admission bili_1
		rename tbili_48 bili_2
		rename tbili_96 bili_3
		rename tbili_120 bili_4
		rename tbili_144 bili_5
		rename tbili_192 bili_6
		
		keep patid akinra_timing bili_*
	
		keep if patid==`x'
		
		if akinra_timing==1 {
			
				drop akinra_timing
			
				reshape long bili_, i(patid) j(day)
				
				rename bili_ bili_`x'
				drop patid
			
			}
			
			else if akinra_timing==2 {
				
				drop akinra_timing
				
				drop bili_1
				
				forvalues y=2/4 {
					
					local z=`y'-1
					
					rename bili_`y' bili_`z'
					
				}
				
				reshape long bili_, i(patid) j(day)
				
				rename bili_ bili_`x'
				drop patid
				
			}
			
			else {
				
				drop akinra_timing
				
				drop bili_1 bili_2
				
				forvalues y=3/4 {
					
					local z=`y'-2
					
					rename bili_`y' bili_`z'
					
			}
			
			reshape long bili_, i(patid) j(day)
			
			rename bili_ bili_`x'
			drop patid
			
		}
		
		save "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tempdata/pat_`x'.dta", replace
	
	}
	
	use "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tempdata/pat_1.dta", clear
	
	forvalues x=2/45 {
		
		merge 1:1 day using "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tempdata/pat_`x'.dta", nogen
		
	}
	
	twoway line bili_1-bili_45 day, title("Bilirubin since" "immunomodulation initiation", size(small) color(black)) xtitle("Day elapsed since anakinra initiation", margin(medium)) yscale(range(0 16) titlegap(5)) ylabel(0 (2) 16)  ytitle("Bilirubin") legend(off) graphregion(color(white)) plotregion(color(white)) name(bili_immunomod, replace)
	
	graph export bili_immunoday.pdf, replace
	
*********************************************************************

* INR by day of immunomodulation initiation	

	forvalues x=1/45 {
		
		use "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/analysis_dataset.dta", clear
		
		rename inr_admission inr_1
		rename inr_48 inr_2
		rename inr_96 inr_3
		rename inr_120 inr_4
		
		keep patid akinra_timing inr_*
	
		keep if patid==`x'
		
		if akinra_timing==1 {
			
				drop akinra_timing
			
				reshape long inr_, i(patid) j(day)
				
				rename inr_ inr_`x'
				drop patid
			
			}
			
			else if akinra_timing==2 {
				
				drop akinra_timing
				
				drop inr_1
				
				forvalues y=2/4 {
					
					local z=`y'-1
					
					rename inr_`y' inr_`z'
					
				}
				
				reshape long inr_, i(patid) j(day)
				
				rename inr_ inr_`x'
				drop patid
				
			}
			
			else {
				
				drop akinra_timing
				
				drop inr_1 inr_2
				
				forvalues y=3/4 {
					
					local z=`y'-2
					
					rename inr_`y' inr_`z'
					
			}
			
			reshape long inr_, i(patid) j(day)
			
			rename inr_ inr_`x'
			drop patid
			
		}
		
		save "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tempdata/pat_`x'.dta", replace
	
	}
	
	use "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tempdata/pat_1.dta", clear
	
	forvalues x=2/45 {
		
		merge 1:1 day using "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tempdata/pat_`x'.dta", nogen
		
	}
	
	twoway line inr_1-inr_45 day, title("INR on day since" "immunomodulation initiation", size(small) color(black)) xtitle("Day elapsed since anakinra initiation") yscale(range(0 8) titlegap(5)) ylabel(0 (1) 10)  ytitle("INR") legend(off) graphregion(color(white)) plotregion(color(white)) name(inr_immunomod, replace)
	
	graph export inr_immunoday.pdf, replace
	
*********************************************************************

* VIS score by day of immunomodulation initiation	

	forvalues x=1/45 {
		
		use "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/analysis_dataset.dta", clear
		
		rename vis06hrs visscore_1
		rename vis612hrs visscore_2
		rename vis1218hrs visscore_3
		rename vis1824hrs visscore_4
		rename vis2430hrs visscore_5
		rename vis3036hrs visscore_6
		
		keep patid akinra_timing visscore_*
	
		keep if patid==`x'
		
		if akinra_timing==1 {
			
				drop akinra_timing
			
				reshape long visscore_, i(patid) j(day)
				
				rename visscore_ visscore_`x'
				drop patid
			
			}
			
			else if akinra_timing==2 {
				
				drop akinra_timing
				
				drop visscore_1
				
				forvalues y=2/6 {
					
					local z=`y'-1
					
					rename visscore_`y' visscore_`z'
					
				}
				
				reshape long visscore_, i(patid) j(day)
				
				rename visscore_ visscore_`x'
				drop patid
				
			}
			
			else {
				
				drop akinra_timing
				
				drop visscore_1 visscore_2
				
				forvalues y=3/6 {
					
					local z=`y'-2
					
					rename visscore_`y' visscore_`z'
					
			}
			
			reshape long visscore_, i(patid) j(day)
			
			rename visscore_ visscore_`x'
			drop patid
			
		}
		
		save "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tempdata/pat_`x'.dta", replace
	
	}
	
	use "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tempdata/pat_1.dta", clear
	
	forvalues x=2/45 {
		
		merge 1:1 day using "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tempdata/pat_`x'.dta", nogen
		
	}
	
	twoway line visscore_1-visscore_45 day, title("VIS Score on days since" "immunomodulation initiation", size(small) color(black)) xtitle("Day elapsed since anakinra initiation", margin(medium)) xscale(range(1 6)) yscale(range(0 110) titlegap(5)) ylabel(0(100)600)  ytitle("VIS score") legend(off) graphregion(color(white)) plotregion(color(white)) name(visscore_immunomod, replace)
	
	graph export visscore_immunoday.pdf, replace
	
*********************************************************************

* pSofa by day of immunomodulation initiation	

	forvalues x=1/45 {
		
		use "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/analysis_dataset.dta", clear
		
		gen psofaday5=.
		
		forvalues y=1/10 {
			
			rename psofaday`y' psofaday_`y'
			
		}
		
		drop psofaday_10
		
		keep patid akinra_timing psofaday_*
	
		keep if patid==`x'
		
		if akinra_timing==1 {
			
				drop akinra_timing
			
				reshape long psofaday_, i(patid) j(day)
				
				rename psofaday_ psofaday_`x'
				drop patid
			
			}
			
			else if akinra_timing==2 {
				
				drop akinra_timing
				
				drop psofaday_1
				
				forvalues y=2/9 {
					
					local z=`y'-1
					
					rename psofaday_`y' psofaday_`z'
					
				}
				
				reshape long psofaday_, i(patid) j(day)
				
				rename psofaday_ psofaday_`x'
				drop patid
				
			}
			
			else {
				
				drop akinra_timing
				
				drop psofaday_1 psofaday_2
				
				forvalues y=3/9 {
					
					local z=`y'-2
					
					rename psofaday_`y' psofaday_`z'
					
			}
			
			reshape long psofaday_, i(patid) j(day)
			
			rename psofaday_ psofaday_`x'
			drop patid
			
		}
		
		save "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tempdata/pat_`x'.dta", replace
	
	}
	
	use "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tempdata/pat_1.dta", clear
	
	forvalues x=2/45 {
		
		merge 1:1 day using "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tempdata/pat_`x'.dta", nogen
		
	}
	
	twoway line psofaday_1-psofaday_45 day, title("pSofa on days since" "immunomodulation initiation", size(small) color(black)) xtitle("Day elapsed since anakinra initiation", margin(medium)) xscale(range(1 9)) xlabel(1(2)9) yscale(range(0 15) titlegap(5)) ylabel(0(5)25) ytitle("pSofa") legend(off) graphregion(color(white)) plotregion(color(white)) name(psofa_immunomod, replace)
	
	graph export psofa_immunoday.pdf, replace
	
*********************************************************************

* PFR by day of immunomodulation initiation	

	forvalues x=1/45 {
		
		use "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/analysis_dataset.dta", clear
		
		keep patid akinra_timing ofi_day*
	
		keep if patid==`x'
		
		if akinra_timing==1 {
			
				drop akinra_timing
			
				reshape long ofi_day, i(patid) j(day)
				
				rename ofi_day ofi_day`x'
				drop patid
			
			}
			
			else if akinra_timing==2 {
				
				drop akinra_timing
				
				drop ofi_day1
				
				forvalues y=2/5 {
					
					local z=`y'-1
					
					rename ofi_day`y' ofi_day`z'
					
				}
				
				reshape long ofi_day, i(patid) j(day)
				
				rename ofi_day ofi_day`x'
				drop patid
				
			}
			
			else {
				
				drop akinra_timing
				
				drop ofi_day1 ofi_day2
				
				forvalues y=3/5 {
					
					local z=`y'-2
					
					rename ofi_day`y' ofi_day`z'
					
			}
			
			reshape long ofi_day, i(patid) j(day)
			
			rename ofi_day ofi_day`x'
			drop patid
			
		}
		
		save "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tempdata/pat_`x'.dta", replace
	
	}
	
	use "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tempdata/pat_1.dta", clear
	
	forvalues x=2/45 {
		
		merge 1:1 day using "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tempdata/pat_`x'.dta", nogen
		
	}
	
	drop ofi_day6 ofi_day21 // only have PFR so missing
	
	twoway line ofi_day1-ofi_day45 day, title("Oxygenation index on days since" "immunomodulation initiation", size(small) color(black)) xtitle("Day elapsed since anakinra initiation", margin(medium)) xscale(range(1 5)) yscale(range(0 40) titlegap(5)) ylabel(0(10)40) xlabel(1(1)5)  ytitle("PF ratio") legend(off) graphregion(color(white)) plotregion(color(white)) name(ofi_immunomod, replace)
	
	graph export ofi_immunoday.pdf, replace
	
*********************************************************************

* Ferritin against CRP

	use "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/analysis_dataset.dta", clear
	
	twoway  (scatter max_crp max_ferritin if outcome==1, color(green%40)) (scatter max_crp max_ferritin if outcome==2, color(red%40)), ///
    legend(order(1 "Survivors" 2 "Non-survivors") rows(2) position(3)) ///
	xtitle("{bf:Maximum ferritin}", margin(medium)) ytitle("{bf:Maximum CRP}", margin(medium)) yscale(range(0 350)) ylabel(0(50)350, angle(0)) xlabel(, format(%7.0fc)) title("{bf:Maximum CRP by maximum ferritin}", size(medium) color(black)) ///
	graphregion(color(white) margin(1 7 1 1)) plotregion(color(white)) name(ferritin_crp, replace)
	
	graph export ferritin_crp.pdf, replace
	
*********************************************************************

* Ferritin against anakinra dose
	
	twoway  (scatter max_ferritin cum_dose_days if immunomodulation==1, color(purple%40)) (scatter max_ferritin cum_dose_days if immunomodulation==2, color(pink%40)) (scatter max_ferritin cum_dose_days if immunomodulation==3, color(blue%40)) (scatter max_ferritin cum_dose_days if immunomodulation==4, color(orange%40)), ///
	legend(order(1 "Anakinra, only" 2 "Corticosteroids, any + anakinra" 3 "Plasmapheresis, any + anakinra" 4) label(4 "Both corticosteroids and plasmapheresis" "+ anakinra") rows(4) position(3) size(small)) ///
	xtitle("{bf:Cumulative anakinra dose (mg/kg/day)}", margin(medium)) ytitle("{bf:Maximum ferritin}", margin(medium)) title("{bf:Maximum ferritin by cumulative anakinra dose}", size(medium) color(black)) /// 
	ylabel(, angle(0) format(%7.0fc)) xlabel(0(2)12) graphregion(color(white)) plotregion(color(white)) name(ferritin_dose, replace)
	
	graph export ferritin_dose.pdf, replace
	
*********************************************************************

* Average fluid requirement in hours since anakinra initiation

	import delimited using "/Users/ti19522/Library/CloudStorage/OneDrive-UniversityofBristol/Documents/PhD/Year 4/Collaborations/Dengue study/tables/fluidreq_survival_graphdata.txt", clear
	
	tw ///
	(rarea surv_lci surv_uci hour, color(green) fintensity(inten30)) ///
	(line survived hour, color(green)), ///
	ytitle(Mean fluid requirement in mg/kg/day) name(survived, replace)
	
	tw ///
	(rarea died_lci died_uci hour, color(red) fintensity(inten30)) ///
	(line died hour, color(red)), ///
	ytitle(Mean fluid requirement in mg/kg/day) name(died, replace)
	
	tw ///
	(rarea died_lci died_uci hour, color(red) fintensity(inten10) lcolor(white)) ///
	(rarea surv_lci surv_uci hour, color(green) fintensity(inten10) lcolor(white)) ///
	(line survived hour, color(green)) ///
	(line died hour, color(red)), ///
	title(Fluid requirement over time since anakinra initiation) ///
	ytitle(Mean fluid requirement in mg/kg/day) ///
	xtitle(Hours since anakinra intiation) xlabel(0(6)36) ///
	legend(order(3 "Survivors" 2 "95%CI" 4 "Non-survivors" 1 "95%CI") pos(3) row(2)) name(fluid_req, replace)
	
	graph export fluid_req.pdf, replace
	
	