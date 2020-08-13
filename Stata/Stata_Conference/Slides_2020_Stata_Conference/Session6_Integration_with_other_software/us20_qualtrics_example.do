










qualtrics get, id(SV_eWBXeO2yZzxMs4d) u(danial) p(EarthQuake) ///
 csv(`"C:/Users/dhoepfner/Desktop/"') dta(`"C:/Users/dhoepfner/Desktop/cleaned_data.dta"') clean  relab revallab


cap label variable _text2 `"ADDITIONAL INFORMATION"'
cap label variable q23_4 `"I received an email about it"'
cap label variable q23_8 `"I saw it on social media"'
cap label variable q23_9 `"I saw it on the school`=uchar(8217)'s website"'
cap label variable q23_3 `"I saw a flyer"'
cap label variable q23_5 `"My school called me"'
cap label variable q23_7 `"Other (please describe)"'
cap label variable leg_yn_leg_yn_q19 `"For students age 14 and up: The school provides planning for life after high school, including services to help my child reach his or her goals."'

cap label define QID17  1 "No"  2 "Yes"  3 "N/A" , replace
cap label values leg_yn_leg_yn_q19 leg_yn_leg_yn_q20 leg_yn_leg_yn_q21 QID17
cap label define QID21  1 "Never"  2 "Sometimes"  3 "Always" , replace
cap label values leg_nsa_leg_nsa_q15 leg_nsa_leg_nsa_q16 leg_nsa_leg_nsa_q17 QID21
cap label define QID22  1 "Disagree"  2 "Neutral"  3 "Agree" , replace
cap label values leg_dna_q18_leg_dna_q18 QID22

desc
fre rasch_rasch_q1
char list rasch_rasch_q1[]
