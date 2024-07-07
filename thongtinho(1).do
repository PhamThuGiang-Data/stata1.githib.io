*TÌM HHSIZE
use "C:\Users\ADMIN\Downloads\VARHS-2008-16Clean\2008-16Clean\2016_new\Q1_New_16.dta",replace
*tạo biến mã hộ*
gen double hhid_2016= tinh_2016*(10^6)+quan_2016*(10^4)+xa_2016*(10^2)+ma_h0_2016
format hhid_2016 %15.0f 
order hhid_2016
sort hhid_2016
tostring hhid_2016, generate(hhid2016_string)
gen double hhid_2014= tinh_2014*(10^6)+quan_2014*(10^4)+xa_2014*(10^2)+ma_h0_2014
format hhid_2014 %15.0f 
order hhid_2014
sort hhid_2014
tostring hhid_2014, generate(hhid2014_string)
tostring hhid_2016, generate(hhid_string)
*quy mô hộ gia đình
egen hhsize= count(ma_h0_2016), by(hhid_2016)
*tìm so luong nguoi lon
gen age=2016-p1q4b_
egen hh_adults=total(age>17), by (hhid_2016)
*tim so nam
gen gender= p1q3_
tab gender
label define sex 1 "Male" 2 "Female", replace
label values gender sex
egen hh_male= total(gender == 1), by (hhid_2016)
collapse (mean) hhid_2014 tinh_2016 quan_2016 xa_2016 ma_h0_2016 tinh_2014 quan_2014 xa_2014 ma_h0_2014 hhsize hh_adults hh_male, by (hhid_2016)
tostring hhid_2014, generate(hhid2014_string)
tostring hhid_2016, generate(hhid_string)
save "C:\Users\ADMIN\OneDrive\Documents\DỰ BÁO\hhsize.dta"




use "C:\Users\ADMIN\Downloads\VARHS-2008-16Clean\2008-16Clean\2014_new\Q1_New_14.dta"
gen double hhid_2014= tinh_2014*(10^6)+quan_2014*(10^4)+xa_2014*(10^2)+ma_h0_2014
format hhid_2014 %15.0f 
order hhid_2014
sort hhid_2014
tostring hhid_2014, generate(hhid2014_string)
egen hhsize= count(ma_h0_2014), by(hhid_2014)
gen age=2016-p1q4_
egen hh_adults=total(age>17), by (hhid_2014)
gen gender= p1q3_
tab gender
label define sex 1 "Male" 2 "Female", replace
label values gender sex
egen hh_male= total(gender == 1), by (hhid_2014)
keep if p1q2_==1 | p1q2_==2
tab gender
label define sex 1 "Male" 2 "Female", replace
label values gender sex
tab age
gen education= p2q10_
replace education=15 if p2q12_==5
replace education=16 if p2q12_==6
gen edu_h=education if p1q2_==1
gen edu_s=education if p1q2_==2
replace education=15 if p2q12_==5
replace education=16 if p2q12_==6
egen edu_head= sum(edu_h), by(hhid_2014)
egen edu_spouse= sum(edu_s), by(hhid_2014)
keep hhid_2014 hhid2014_string  gender age education edu_head edu_spouse p1q2_
keep if p1q2_==1
save "C:\Users\ADMIN\OneDrive\Documents\DỰ BÁO\thongtinho(1).dta"


*Credit
use "C:\Users\ADMIN\Downloads\VARHS-2008-16Clean\2008-16Clean\2014_new\Q8_New_14.dta"
gen double hhid_2014= tinh_2014*(10^6)+quan_2014*(10^4)+xa_2014*(10^2)+ma_h0_2014
format hhid_2014 %15.0f 
order hhid_2014
sort hhid_2014
tostring hhid_2014, generate(hhid2014_string)
gen credit = 1
keep hhid_2014 hhid2014_string credit
save "C:\Users\ADMIN\OneDrive\Documents\DỰ BÁO\credit.dta"


*Saving
use "C:\Users\ADMIN\Downloads\VARHS-2008-16Clean\2008-16Clean\2014_new\Q7C_New_14.dta"
gen double hhid_2014= tinh_2014*(10^6)+quan_2014*(10^4)+xa_2014*(10^2)+ma_h0_2014
format hhid_2014 %15.0f 
order hhid_2014
sort hhid_2014
tostring hhid_2014, generate(hhid2014_string)
gen saving = 1
keep hhid_2014 hhid2014_string saving
save "C:\Users\ADMIN\OneDrive\Documents\DỰ BÁO\saving.dta"




*Farm-size
use "C:\Users\ADMIN\Downloads\VARHS-2008-16Clean\2008-16Clean\2014_new\Q2_New_14.dta"
gen double hhid_2014= tinh_2014*(10^6)+quan_2014*(10^4)+xa_2014*(10^2)+ma_h0_2014
format hhid_2014 %15.0f 
order hhid_2014
sort hhid_2014
tostring hhid_2014, generate(hhid2014_string)
egen farm_size = sum(p5q3a), by(hhid_2014)
collapse (mean) tinh_2014 quan_2014 xa_2014 ma_h0_2014 farm_size, by(hhid_2014)
tostring hhid_2014, generate(hhid2014_string)
save "C:\Users\ADMIN\OneDrive\Documents\DỰ BÁO\farm-size.dta"


*Wage-employ và self-employ(2014)
*tạo biến mã hộ
use "C:\Users\ADMIN\Downloads\VARHS-2008-16Clean\2008-16Clean\2014_new\Q5_New_14.dta"
gen double hhid_2014= tinh_2014*(10^6)+quan_2014*(10^4)+xa_2014*(10^2)+ma_h0_2014
format hhid_2014 %15.0f 
order hhid_2014
sort hhid_2014
tostring hhid_2014, generate(hhid2014_string)
*tạo biến công việc
gen wage_employ = 1 if p26q1a_==1
replace wage_employ = 0 if missing(wage_employ)
egen wage_employ1 = total(wage_employ), by (hhid_2014)
gen wageemploy = 1 if wage_employ1>0
replace wageemploy = 0 if missing(wageemploy)
gen self_employ = 1 if p26q1b_==1|p26q1c_==1
replace self_employ = 0 if missing(self_employ)
egen self_employ1 = total(self_employ), by (hhid_2014)
gen selfemploy = 1 if self_employ1>0
replace selfemploy = 0 if missing(selfemploy)
collapse (mean) tinh_2014 quan_2014 xa_2014 ma_h0_2014 wageemploy selfemploy, by(hhid_2014)
tostring hhid_2014, generate(hhid2014_string)
save "C:\Users\ADMIN\OneDrive\Documents\DỰ BÁO\employ.dta"

*Wage-employ và self-employ(2016)
use "C:\Users\ADMIN\Downloads\VARHS-2008-16Clean\2008-16Clean\2016_new\Q5_New_16.dta"
*tạo biến mã hộ
gen double hhid_2016= tinh_2016*(10^6)+quan_2016*(10^4)+xa_2016*(10^2)+ma_h0_2016
format hhid_2016 %15.0f 
order hhid_2016
sort hhid_2016
tostring hhid_2016, generate(hhid2016_string)
gen double hhid_2014= tinh_2014*(10^6)+quan_2014*(10^4)+xa_2014*(10^2)+ma_h0_2014
format hhid_2014 %15.0f 
order hhid_2014
sort hhid_2014
tostring hhid_2014, generate(hhid2014_string)
gen wage_employ = 1 if p25q1a_==1|p25q1b_==1
replace wage_employ = 0 if missing(wage_employ)
egen wage_employ2 = total(wage_employ), by (hhid_2014)
gen wageemploy1 = 1 if wage_employ2>0
replace wageemploy1 = 0 if missing(wageemploy1)
gen self_employ = 1 if p25q1c_==1|p25q1d_==1
replace self_employ = 0 if missing(self_employ)
egen self_employ2 = total(self_employ), by (hhid_2014)
gen selfemploy1 = 1 if self_employ2>0
replace selfemploy1 = 0 if missing(selfemploy1)
collapse (mean) hhid_2014 tinh_2016 quan_2016 xa_2016 ma_h0_2016 tinh_2014 quan_2014 xa_2014 ma_h0_2014 wageemploy1 selfemploy1, by(hhid_2016)
tostring hhid_2014, generate(hhid2014_string)
tostring hhid_2016, generate(hhid_string)
save "C:\Users\ADMIN\OneDrive\Documents\DỰ BÁO\employ(1).dta"

*Địa điểm
*tạo biến mã hộ
use "C:\Users\ADMIN\Downloads\VARHS-2008-16Clean\2008-16Clean\2016_new\Q1_New_16.dta"
gen double hhid_2016= tinh_2016*(10^6)+quan_2016*(10^4)+xa_2016*(10^2)+ma_h0_2016
format hhid_2016 %15.0f 
order hhid_2016
sort hhid_2016
tostring hhid_2016, generate(hhid2016_string)
gen double hhid_2014= tinh_2014*(10^6)+quan_2014*(10^4)+xa_2014*(10^2)+ma_h0_2014
format hhid_2014 %15.0f 
order hhid_2014
sort hhid_2014
tostring hhid_2014, generate(hhid2014_string)
tostring hhid_2016, generate(hhid_string)
*tạo biến địa điểm
gen dbsh = 1 if tinh_2016==105
replace dbsh=0 if missing(dbsh)
gen trungduvamiennuiphiabac = 1 if tinh_2016==205|tinh_2016==217|tinh_2016==301|tinh_2016==302
replace trungduvamiennuiphiabac = 0 if missing(trungduvamiennuiphiabac)
gen duyenhaimientrung = 1 if tinh_2016==503|tinh_2016==511
replace duyenhaimientrung = 0 if missing(duyenhaimientrung)
gen taynguyen = 1 if tinh_2016==606|tinh_2016==607
replace taynguyen=0 if missing(taynguyen)
collapse (mean) hhid_2014 tinh_2016 quan_2016 xa_2016 ma_h0_2016 tinh_2014 quan_2014 xa_2014 ma_h0_2014 dbsh trungduvamiennuiphiabac duyenhaimientrung taynguyen, by(hhid_2016)
tostring hhid_2014, generate(hhid2014_string)
tostring hhid_2016, generate(hhid_string)
save "C:\Users\ADMIN\OneDrive\Documents\DỰ BÁO\diadiem.dta"




*Income(2014)
*tạo biến mã hộ
use "C:\Users\ADMIN\Downloads\VARHS-2008-16Clean\2008-16Clean\2014_new\Phieu_New_14.dta"
gen double hhid_2014= tinh_2014*(10^6)+quan_2014*(10^4)+xa_2014*(10^2)+ma_h0_2014
format hhid_2014 %15.0f 
order hhid_2014
sort hhid_2014
tostring hhid_2014, generate(hhid2014_string)
*tạo biến income
egen income1 = total (p35q10), by (hhid_2014)
collapse (mean) tinh_2014 quan_2014 xa_2014 ma_h0_2014 income1, by(hhid_2014)
tostring hhid_2014, generate(hhid2014_string)
save "C:\Users\ADMIN\OneDrive\Documents\DỰ BÁO\Income(1).dta"

*Income(2016)
*tạo biến mã hộ
use "C:\Users\ADMIN\Downloads\VARHS-2008-16Clean\2008-16Clean\2016_new\Phieu_New_16.dta"
gen double hhid_2014= tinh_2014*(10^6)+quan_2014*(10^4)+xa_2014*(10^2)+ma_h0_2014
format hhid_2014 %15.0f 
order hhid_2014
sort hhid_2014
gen double hhid_2016= tinh_2016*(10^6)+quan_2016*(10^4)+xa_2016*(10^2)+ma_h0_2016
format hhid_2016 %15.0f 
order hhid_2016
sort hhid_2016
tostring hhid_2016, generate(hhid2016_string)
*tạo biến income
egen income2 = total (p34q10), by (hhid_2016)
collapse (mean)  hhid_2014 tinh_2016 quan_2016 xa_2016 ma_h0_2016 tinh_2014 quan_2014 xa_2014 ma_h0_2014 income2, by(hhid_2016)
tostring hhid_2014, generate(hhid2014_string)
tostring hhid_2016, generate(hhid_string)
save "C:\Users\ADMIN\OneDrive\Documents\DỰ BÁO\Income(2).dta"

*INCOME
merge m:m hhid2014_string using "C:\Users\ADMIN\OneDrive\Documents\DỰ BÁO\Income(1).dta"
drop if income1==.
drop if income2==.
gen income=income2-income1
drop _merge




*Food
*tạo biến mã hộ
use "C:\Users\ADMIN\Downloads\VARHS-2008-16Clean\2008-16Clean\2014_new\Q7A_New_14.dta"
gen double hhid_2014= tinh_2014*(10^6)+quan_2014*(10^4)+xa_2014*(10^2)+ma_h0_2014
format hhid_2014 %15.0f 
order hhid_2014
sort hhid_2014
tostring hhid_2014, generate(hhid2014_string)
*Tạo biên total food expenditure 12 month*
collapse (sum) tinh_2014 quan_2014 xa_2014 ma_h0_2014 panel0816 p37q4_, by(hhid_2014)
gen food_expenditure=(p37q4_*12)/1000
tostring hhid_2014, generate(hhid2014_string)
save "C:\Users\ADMIN\OneDrive\Documents\DỰ BÁO\food(1).dta"

*food(2016)
use "C:\Users\ADMIN\Downloads\VARHS-2008-16Clean\2008-16Clean\2016_new\Q7A_New_16.dta", clear
*tạo biến mã hộ*
gen double hhid_2016= tinh_2016*(10^6)+quan_2016*(10^4)+xa_2016*(10^2)+ma_h0_2016
format hhid_2016 %15.0f 
order hhid_2016
sort hhid_2016
tostring hhid_2016, generate(hhid2016_string)
gen double hhid_2014= tinh_2014*(10^6)+quan_2014*(10^4)+xa_2014*(10^2)+ma_h0_2014
format hhid_2014 %15.0f 
order hhid_2014
sort hhid_2014
tostring hhid_2014, generate(hhid2014_string)
*Tạo biên total food expenditure 12 month*
collapse (sum) hhid_2014 tinh_2016 quan_2016 xa_2016 ma_h0_2016 tinh_2014 quan_2014 xa_2014 ma_h0_2014 panel0816 p36q4_, by(hhid_2016)
gen food_expenditure1=(p36q4_*12)/1000
tostring hhid_2014, generate(hhid2014_string)
tostring hhid_2016, generate(hhid_string)
save "C:\Users\ADMIN\OneDrive\Documents\DỰ BÁO\food(3).dta"



*Tham gia off_farm(2016)
use "C:\Users\ADMIN\Downloads\VARHS-2008-16Clean\2008-16Clean\2016_new\Q5C1_New_16.dta"
*tạo biến mã hộ
gen double hhid_2016= tinh_2016*(10^6)+quan_2016*(10^4)+xa_2016*(10^2)+ma_h0_2016
format hhid_2016 %15.0f 
order hhid_2016
sort hhid_2016
gen double hhid_2014= tinh_2014*(10^6)+quan_2014*(10^4)+xa_2014*(10^2)+ma_h0_2014
format hhid_2014 %15.0f 
order hhid_2014
sort hhid_2014
tostring hhid_2014, generate(hhid2014_string)
gen off_farm1=1
collapse (mean) hhid_2014 tinh_2016 quan_2016 xa_2016 ma_h0_2016 tinh_2014 quan_2014 xa_2014 ma_h0_2014 off_farm1, by(hhid_2016)
tostring hhid_2014, generate(hhid2014_string)
tostring hhid_2016, generate(hhid_string)
save "C:\Users\ADMIN\OneDrive\Documents\DỰ BÁO\off_farm1.dta"

*Tham gia off_farm(2014)
use "C:\Users\ADMIN\Downloads\VARHS-2008-16Clean\2008-16Clean\2014_new\Q5C1_New_14.dta"
*tạo biến mã hộ
gen double hhid_2014= tinh_2014*(10^6)+quan_2014*(10^4)+xa_2014*(10^2)+ma_h0_2014
format hhid_2014 %15.0f 
order hhid_2014
sort hhid_2014
tostring hhid_2014, generate(hhid2014_string)
gen off_farm=1
collapse (mean) tinh_2014 quan_2014 xa_2014 ma_h0_2014 off_farm, by(hhid_2014)
tostring hhid_2014, generate(hhid2014_string)
save "C:\Users\ADMIN\OneDrive\Documents\DỰ BÁO\off_farm.dta"


*MERGE
use "C:\Users\ADMIN\OneDrive\Documents\DỰ BÁO\food(3).dta"
merge m:m hhid_string using  "C:\Users\ADMIN\OneDrive\Documents\DỰ BÁO\diadiem.dta"
drop _merge
merge m:m hhid2014_string using "C:\Users\ADMIN\OneDrive\Documents\DỰ BÁO\thongtinho(1).dta"
drop _merge
merge m:m hhid2014_string using "C:\Users\ADMIN\OneDrive\Documents\DỰ BÁO\credit.dta"
drop _merge
merge m:m hhid2014_string using "C:\Users\ADMIN\OneDrive\Documents\DỰ BÁO\saving.dta"
drop _merge
merge m:m hhid2014_string using "C:\Users\ADMIN\OneDrive\Documents\DỰ BÁO\farm-size.dta"
drop _merge
merge m:m hhid2014_string using "C:\Users\ADMIN\OneDrive\Documents\DỰ BÁO\employ(1).dta"
drop _merge
merge m:m hhid2014_string using "C:\Users\ADMIN\OneDrive\Documents\DỰ BÁO\diadiem.dta"
drop _merge
merge m:m hhid2014_string using "C:\Users\ADMIN\OneDrive\Documents\DỰ BÁO\Income(1).dta"
drop _merge
merge m:m hhid2014_string using"C:\Users\ADMIN\OneDrive\Documents\DỰ BÁO\Income(2).dta"
drop _merge
merge m:m hhid2014_string using "C:\Users\ADMIN\OneDrive\Documents\DỰ BÁO\food(1).dta"
drop _merge
merge m:m hhid2014_string using "C:\Users\ADMIN\OneDrive\Documents\DỰ BÁO\off_farm1.dta"
drop _merge
merge m:m hhid2014_string using "C:\Users\ADMIN\OneDrive\Documents\DỰ BÁO\off_farm.dta"
drop _merge
merge m:m hhid_string using "C:\Users\ADMIN\OneDrive\Documents\DỰ BÁO\hhsize.dta"
drop _merge

drop if income1==.
drop if income2==.
gen income=income2-income1
drop if food_expenditure1==.
drop if food_expenditure==.
gen foodexpenditure = food_expenditure1-food_expenditure
replace credit = 0 if missing(credit)
replace saving = 0 if missing(saving)
replace off_farm1 = 0 if missing(off_farm1)
*đối với năm 2014, các hộ gia đình không tham gia off farm
drop if off_farm==1
replace gender = 1 if gender==1
replace gender = 0 if gender==2
drop p1q2_ edu_spouse income1 income2 panel0816 p36q4_ food_expenditure1 food_expenditure p37q4_  off_farm
save "C:\Users\ADMIN\OneDrive\Documents\DỰ BÁO\datachinh.dta"






*CHẠY HỒI QUY
replace selfemploy1 =0 if off_farm1==0
replace wageemploy1 =0 if off_farm1==0
gen farmsize1= farm_size/10000
logit off_farm1 dbsh trungduvamiennuiphiabac duyenhaimientrung taynguyen farmsize1 credit age gender education hhsize hh_adults hh_male 
*Đối với Self-employment
logit selfemploy1 dbsh trungduvamiennuiphiabac duyenhaimientrung taynguyen farmsize1 credit age gender education wageemploy1 hhsize hh_adults hh_male 
*Đối với Wage-employment
logit wageemploy1 dbsh trungduvamiennuiphiabac duyenhaimientrung taynguyen farmsize1 credit age gender education selfemploy1 hhsize hh_adults hh_male 




*CHẠY ATT
gen income1=income/1000
gen foodexpenditure1=foodexpenditure/1000
kmatch ps off_farm1 dbsh trungduvamiennuiphiabac duyenhaimientrung taynguyen farmsize1 credit age gender education hhsize hh_adults hh_male (income1), att vce(boot, reps(500))
kmatch ps off_farm1 dbsh trungduvamiennuiphiabac duyenhaimientrung taynguyen farmsize1 credit age gender education hhsize hh_adults 
> hh_male (income1), att vce(boot, reps(500))
kmatch ps selfemploy1 dbsh trungduvamiennuiphiabac duyenhaimientrung taynguyen farmsize1 credit age gender education wageemploy1 hhsize hh_adults hh_male (income1), att vce(boot, reps(500))
kmatch ps wageemploy1 dbsh trungduvamiennuiphiabac duyenhaimientrung taynguyen farmsize1 credit age gender education selfemploy1 hhsize hh_adults hh_male (income1), att vce(boot, reps(500))
kmatch ps off_farm1 dbsh trungduvamiennuiphiabac duyenhaimientrung taynguyen farmsize1 credit age gender education hhsize hh_adults hh_male (foodexpenditure1), att vce(boot, reps(500))
kmatch ps selfemploy1 dbsh trungduvamiennuiphiabac duyenhaimientrung taynguyen farmsize1 credit age gender education wageemploy1 hhsize hh_adults hh_male (foodexpenditure1), att vce(boot, reps(500))
kmatch ps wageemploy1 dbsh trungduvamiennuiphiabac duyenhaimientrung taynguyen farmsize1 credit age gender education selfemploy1 hhsize hh_adults hh_male (foodexpenditure1), att vce(boot, reps(500))















.