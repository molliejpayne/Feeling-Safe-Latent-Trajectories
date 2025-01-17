********************************************************************************
**               Principal Trajectories Modelling Framework                   **
********************************************************************************
/*The following code was used to conduct a principal trajectories analysis 
following the model presented within Dunn G, Emsley R, Liu H, et al. Evaluation 
and validation of social and psychological markers in randomised trials of complex 
interventions in mental health: a methodological research programme. Health 
Technology Assessment (Winchester, England). 2015 Nov;19(93):1-115, v-vi. 
DOI: 10.3310/hta19930. */


/*This script implements a principal trajectories model. First, we fit the optimal 
latent trajectory model to our data, following the methodology outlined in Jenner 
et al. (2024). Using the posterior probabilities, we estimate class membership for 
participants in the treatment arm. Using the predicted probabilities, we estimate 
class membership for participants in the control arm. This approach enables us to 
assign control arm participants to the latent class they would likely belong to if 
they had been allocated to the Feeling Safe treatment.

We then estimate the intention-to-treat effect within each class. To explore 
potential mediators further, we calculate the 'a' path within each class to screen 
for mechanisms by which the Feeling Safe intervention operates.
*/ 


**---Contents of Script---------------------------------------------------------
*Data Preparation 
*Fit Latent Class Trajectory Model
*Assign Intervention Arm 
*Assign Control Arm
*Estimate ITT Effect
*Explore Potential Mediators


**#---Data Preparation-----------------------------------------------------------

clear
cd "/DataFileLocation" //Set the directory to the location of your file
use FeelingSafeData //Open Data file

**#---Fit Latent Class Trajectory Model ------------------------------

/* Within each class, we apply a series of constraints to ensure that the mean 
change in threat belief remains consistent across all time points. */

constraint 1 _b[threat_b_3:1.C]-_b[threat_b_2:1.C]=_b[threat_b_2:1.C]-_b[threat_b_1:1.C]
constraint 2 _b[threat_b_4:1.C]-_b[threat_b_3:1.C]=_b[threat_b_3:1.C]-_b[threat_b_2:1.C]
constraint 3 _b[threat_b_5:1.C]-_b[threat_b_4:1.C]=_b[threat_b_4:1.C]-_b[threat_b_3:1.C]
constraint 4 _b[threat_b_6:1.C]-_b[threat_b_5:1.C]=_b[threat_b_5:1.C]-_b[threat_b_4:1.C]
constraint 5 _b[threat_b_7:1.C]-_b[threat_b_6:1.C]=_b[threat_b_6:1.C]-_b[threat_b_5:1.C]
constraint 6 _b[threat_b_8:1.C]-_b[threat_b_7:1.C]=_b[threat_b_7:1.C]-_b[threat_b_6:1.C]
constraint 7 _b[threat_b_9:1.C]-_b[threat_b_8:1.C]=_b[threat_b_8:1.C]-_b[threat_b_7:1.C]
constraint 8 _b[threat_b_10:1.C]-_b[threat_b_9:1.C]=_b[threat_b_9:1.C]-_b[threat_b_8:1.C]
constraint 9 _b[threat_b_11:1.C]-_b[threat_b_10:1.C]=_b[threat_b_10:1.C]-_b[threat_b_9:1.C]
constraint 10 _b[threat_b_12:1.C]-_b[threat_b_11:1.C]=_b[threat_b_11:1.C]-_b[threat_b_10:1.C]
constraint 11 _b[threat_b_13:1.C]-_b[threat_b_12:1.C]=_b[threat_b_12:1.C]-_b[threat_b_11:1.C]
constraint 12 _b[threat_b_14:1.C]-_b[threat_b_13:1.C]=_b[threat_b_13:1.C]-_b[threat_b_12:1.C]
constraint 13 _b[threat_b_15:1.C]-_b[threat_b_14:1.C]=_b[threat_b_14:1.C]-_b[threat_b_13:1.C]
constraint 14 _b[threat_b_16:1.C]-_b[threat_b_15:1.C]=_b[threat_b_15:1.C]-_b[threat_b_14:1.C]
constraint 15 _b[threat_b_17:1.C]-_b[threat_b_16:1.C]=_b[threat_b_16:1.C]-_b[threat_b_15:1.C]
constraint 16 _b[threat_b_18:1.C]-_b[threat_b_17:1.C]=_b[threat_b_17:1.C]-_b[threat_b_16:1.C]
constraint 17 _b[threat_b_19:1.C]-_b[threat_b_18:1.C]=_b[threat_b_18:1.C]-_b[threat_b_17:1.C]

constraint 18 _b[threat_b_3:2.C]-_b[threat_b_2:2.C]=_b[threat_b_2:2.C]-_b[threat_b_1:2.C]
constraint 19 _b[threat_b_4:2.C]-_b[threat_b_3:2.C]=_b[threat_b_3:2.C]-_b[threat_b_2:2.C]
constraint 20 _b[threat_b_5:2.C]-_b[threat_b_4:2.C]=_b[threat_b_4:2.C]-_b[threat_b_3:2.C]
constraint 21 _b[threat_b_6:2.C]-_b[threat_b_5:2.C]=_b[threat_b_5:2.C]-_b[threat_b_4:2.C]
constraint 22 _b[threat_b_7:2.C]-_b[threat_b_6:2.C]=_b[threat_b_6:2.C]-_b[threat_b_5:2.C]
constraint 23 _b[threat_b_8:2.C]-_b[threat_b_7:2.C]=_b[threat_b_7:2.C]-_b[threat_b_6:2.C]
constraint 24 _b[threat_b_9:2.C]-_b[threat_b_8:2.C]=_b[threat_b_8:2.C]-_b[threat_b_7:2.C]
constraint 25 _b[threat_b_10:2.C]-_b[threat_b_9:2.C]=_b[threat_b_9:2.C]-_b[threat_b_8:2.C]
constraint 26 _b[threat_b_11:2.C]-_b[threat_b_10:2.C]=_b[threat_b_10:2.C]-_b[threat_b_9:2.C]
constraint 27 _b[threat_b_12:2.C]-_b[threat_b_11:2.C]=_b[threat_b_11:2.C]-_b[threat_b_10:2.C]
constraint 28 _b[threat_b_13:2.C]-_b[threat_b_12:2.C]=_b[threat_b_12:2.C]-_b[threat_b_11:2.C]
constraint 29 _b[threat_b_14:2.C]-_b[threat_b_13:2.C]=_b[threat_b_13:2.C]-_b[threat_b_12:2.C]
constraint 30 _b[threat_b_15:2.C]-_b[threat_b_14:2.C]=_b[threat_b_14:2.C]-_b[threat_b_13:2.C]
constraint 31 _b[threat_b_16:2.C]-_b[threat_b_15:2.C]=_b[threat_b_15:2.C]-_b[threat_b_14:2.C]
constraint 32 _b[threat_b_17:2.C]-_b[threat_b_16:2.C]=_b[threat_b_16:2.C]-_b[threat_b_15:2.C]
constraint 33 _b[threat_b_18:2.C]-_b[threat_b_17:2.C]=_b[threat_b_17:2.C]-_b[threat_b_16:2.C]
constraint 34 _b[threat_b_19:2.C]-_b[threat_b_18:2.C]=_b[threat_b_18:2.C]-_b[threat_b_17:2.C]

constraint 35 _b[threat_b_3:3.C]-_b[threat_b_2:3.C]=_b[threat_b_2:3.C]-_b[threat_b_1:3.C]
constraint 36 _b[threat_b_4:3.C]-_b[threat_b_3:3.C]=_b[threat_b_3:3.C]-_b[threat_b_2:3.C]
constraint 37 _b[threat_b_5:3.C]-_b[threat_b_4:3.C]=_b[threat_b_4:3.C]-_b[threat_b_3:3.C]
constraint 38 _b[threat_b_6:3.C]-_b[threat_b_5:3.C]=_b[threat_b_5:3.C]-_b[threat_b_4:3.C]
constraint 39 _b[threat_b_7:3.C]-_b[threat_b_6:3.C]=_b[threat_b_6:3.C]-_b[threat_b_5:3.C]
constraint 40 _b[threat_b_8:3.C]-_b[threat_b_7:3.C]=_b[threat_b_7:3.C]-_b[threat_b_6:3.C]
constraint 41 _b[threat_b_9:3.C]-_b[threat_b_8:3.C]=_b[threat_b_8:3.C]-_b[threat_b_7:3.C]
constraint 42 _b[threat_b_10:3.C]-_b[threat_b_9:3.C]=_b[threat_b_9:3.C]-_b[threat_b_8:3.C]
constraint 43 _b[threat_b_11:3.C]-_b[threat_b_10:3.C]=_b[threat_b_10:3.C]-_b[threat_b_9:3.C]
constraint 44 _b[threat_b_12:3.C]-_b[threat_b_11:3.C]=_b[threat_b_11:3.C]-_b[threat_b_10:3.C]
constraint 45 _b[threat_b_13:3.C]-_b[threat_b_12:3.C]=_b[threat_b_12:3.C]-_b[threat_b_11:3.C]
constraint 46 _b[threat_b_14:3.C]-_b[threat_b_13:3.C]=_b[threat_b_13:3.C]-_b[threat_b_12:3.C]
constraint 47 _b[threat_b_15:3.C]-_b[threat_b_14:3.C]=_b[threat_b_14:3.C]-_b[threat_b_13:3.C]
constraint 48 _b[threat_b_16:3.C]-_b[threat_b_15:3.C]=_b[threat_b_15:3.C]-_b[threat_b_14:3.C]
constraint 49 _b[threat_b_17:3.C]-_b[threat_b_16:3.C]=_b[threat_b_16:3.C]-_b[threat_b_15:3.C]
constraint 50 _b[threat_b_18:3.C]-_b[threat_b_17:3.C]=_b[threat_b_17:3.C]-_b[threat_b_16:3.C]
constraint 51 _b[threat_b_19:3.C]-_b[threat_b_18:3.C]=_b[threat_b_18:3.C]-_b[threat_b_17:3.C]

constraint 52 _b[threat_b_3:4.C]-_b[threat_b_2:4.C]=_b[threat_b_2:4.C]-_b[threat_b_1:4.C]
constraint 53 _b[threat_b_4:4.C]-_b[threat_b_3:4.C]=_b[threat_b_3:4.C]-_b[threat_b_2:4.C]
constraint 54 _b[threat_b_5:4.C]-_b[threat_b_4:4.C]=_b[threat_b_4:4.C]-_b[threat_b_3:4.C]
constraint 55 _b[threat_b_6:4.C]-_b[threat_b_5:4.C]=_b[threat_b_5:4.C]-_b[threat_b_4:4.C]
constraint 56 _b[threat_b_7:4.C]-_b[threat_b_6:4.C]=_b[threat_b_6:4.C]-_b[threat_b_5:4.C]
constraint 57 _b[threat_b_8:4.C]-_b[threat_b_7:4.C]=_b[threat_b_7:4.C]-_b[threat_b_6:4.C]
constraint 58 _b[threat_b_9:4.C]-_b[threat_b_8:4.C]=_b[threat_b_8:4.C]-_b[threat_b_7:4.C]
constraint 59 _b[threat_b_10:4.C]-_b[threat_b_9:4.C]=_b[threat_b_9:4.C]-_b[threat_b_8:4.C]
constraint 60 _b[threat_b_11:4.C]-_b[threat_b_10:4.C]=_b[threat_b_10:4.C]-_b[threat_b_9:4.C]
constraint 61 _b[threat_b_12:4.C]-_b[threat_b_11:4.C]=_b[threat_b_11:4.C]-_b[threat_b_10:4.C]
constraint 62 _b[threat_b_13:4.C]-_b[threat_b_12:4.C]=_b[threat_b_12:4.C]-_b[threat_b_11:4.C]
constraint 63 _b[threat_b_14:4.C]-_b[threat_b_13:4.C]=_b[threat_b_13:4.C]-_b[threat_b_12:4.C]
constraint 64 _b[threat_b_15:4.C]-_b[threat_b_14:4.C]=_b[threat_b_14:4.C]-_b[threat_b_13:4.C]
constraint 65 _b[threat_b_16:4.C]-_b[threat_b_15:4.C]=_b[threat_b_15:4.C]-_b[threat_b_14:4.C]
constraint 66 _b[threat_b_17:4.C]-_b[threat_b_16:4.C]=_b[threat_b_16:4.C]-_b[threat_b_15:4.C]
constraint 67 _b[threat_b_18:4.C]-_b[threat_b_17:4.C]=_b[threat_b_17:4.C]-_b[threat_b_16:4.C]
constraint 68 _b[threat_b_19:4.C]-_b[threat_b_18:4.C]=_b[threat_b_18:4.C]-_b[threat_b_17:4.C]

/*We specify our latent trajectory model, identified as the best fit to our data 
in prior analyses. This is an unconditional trajectories and conditional class 
probabilities model, where predictors influence class membership, and class 
membership explains the outcome.

The model includes four latent classes. We impose constraints on the mean changes 
of the outcome within classes and ensure that the residual error variance is 
consistent across all measures of the outcome at each time point. */

// Latent Trajectory Model
gsem (threat_b_1 threat_b_2 threat_b_3 threat_b_4 threat_b_5 threat_b_6 threat_b_7 threat_b_8 threat_b_9 threat_b_10 threat_b_11 threat_b_12 threat_b_13 threat_b_14 threat_b_15 threat_b_16 threat_b_17 threat_b_18 threat_b_19<-) ///
(C <- conviction expectancy bcss_others_positive_total), lclass (C 4) ///
constraints (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68) ///
var(e.threat_b_1@a e.threat_b_2@a e.threat_b_3@a e.threat_b_4@a e.threat_b_5@a e.threat_b_6@a e.threat_b_7@a e.threat_b_8@a e.threat_b_9@a e.threat_b_10@a e.threat_b_11@a e.threat_b_12@a e.threat_b_13@a e.threat_b_14@a e.threat_b_15@a e.threat_b_16@a e.threat_b_17@a e.threat_b_18@a e.threat_b_19@a)

estat ic //BIC = 


**Note: For the next stages, we require no missing data in the predictors of 
**trajectory class. We drop all participants with missing baseline data. 
drop if conviction == . | expectancy == . | bcss_others_positive_total == .

**#---Assign Intervention Arm---------------------------------------- 
/*We calculate the posterior probabilities from the latent trajectory analysis and 
assign all Feeling Safe participants to their most likely class. */

if allocation == 1 {
//Predict posterior probabilities for sample
predict pr_*, classposteriorpr 
//Assign individuals in group 1 to their most likely class
egen maxprob = rowmax(pr_1 pr_2 pr_3 pr_4)
gen classall = .
replace classall = 2 if allocation == 1 & pr_1 == maxprob
replace classall = 1 if allocation == 1 & pr_2 == maxprob
replace classall = 4 if allocation == 1 & pr_3 == maxprob
replace classall = 3 if allocation == 1 & pr_4 == maxprob	
}

**#---Assign Control Arm---------------------------------------- 
/*We then estimate the predicted probabilities, using the regression model within 
the latent trajectories analysis and assign the control arm to the latent class 
that they would most likely be in, if they had received Feeling Safe treatment.*/

//Estimate predicted probabilities for sample
predict pr2_*, classpr 

//Assign individuals to their most likely class. 
egen maxprob2 = rowmax(pr2_1 pr2_2 pr2_3 pr2_4)
gen classall2 = .
replace classall2 = 2 if allocation == 0 & pr2_1 == maxprob2
replace classall2 = 1 if allocation == 0 & pr2_2 == maxprob2
replace classall2 = 4 if allocation == 0 & pr2_3 == maxprob2
replace classall2 = 3 if allocation == 0 & pr2_4 == maxprob2

//We create a final class variable based off our previous assignments
gen class_final = .
replace class_final = classall if allocation == 1
replace class_final = classall2 if allocation == 0 
*This code is creating a new variable for class membership, based on the 
*posterior probabilities for the treatment arm assignment and the predicted 
*probabilities for the control arm assigment. 

//We assess the probabilities in our model
bysort classall (pr_*): summarize pr_*
bysort classall2 (pr2_*): summarize pr2_*
bysort class_final (maxprob2): summarize maxprob2


**#---Estimate ITT Effect------------------------------------------
/*We can now examine the effect of randomisation on the outcome within each class 
separately. We consider the primary outcome at 6 and 12 months*/

//ITT Effect Final (6 Months)
regress conviction_6 conviction allocation

//ITT Effect Within Each Class
forval i = 1/4{
	di "Effect of treatment on outcome within class `i'"
	regress conviction_6 conviction allocation  if class_final == `i'
}

//ITT Effect Final (12 Months)
regress conviction_12 conviction allocation

//ITT Effect Within Each Class
forval i = 1/4{
	di "Effect of treatment on outcome within class `i'"
	regress conviction_12 conviction allocation  if class_final == `i'
}

**#---Explore Potential Mediators------------------------------------------

/* This is an exploratory mediation analysis. In the main Feeling Safe trial, 
various potential mediators were examined, with some identified as significant 
mediators. In this analysis, we aim to investigate how randomization is associated 
with potential mediators within each class. The association between treatment and 
mediator is assessed through the estimation of the 'a' path. If an association is 
found, this suggests that the variable may serve as a mediator. Although further 
analysis to calculate the indirect effect would typically follow, since the 
relationship between mediator and outcome has already been established in the 
Feeling Safe trial, we focus solely on the 'a' path as part of a screening process 
for identifying potential mediators within each class. */


//Jumping to Conclusions
forval i = 1/4{
	di "Effect of treatment on mediator within class `i'"
	regress jtc_beads_6m allocation jtc_beads conviction if class_final == `i'
}

//Safety Behaviours
forval i = 1/4{
	di "Effect of treatment on mediator within class `i'"
	regress safety_behaviours_totalfreq_6m allocation safety_behaviours_totalfreq conviction if class_final == `i'
}

//Safety
forval i = 1/4{
		di "Effect of treatment on mediator within class `i'"
	regress safety_6m allocation safety conviction if class_final == `i'
}

//ISI 
forval i = 1/4{
		di "Effect of treatment on mediator within class `i'"
	regress isi_total_6m allocation isi_total conviction if class_final == `i'
}

// PSWQ
forval i = 1/4{
		di "Effect of treatment on mediator within class `i'"
	regress pswq_total_6m allocation pswq_total conviction if class_final == `i'
}

//BCSS Self Neg
forval i = 1/4{
		di "Effect of treatment on mediator within class `i'"
	regress bcss_self_negative_total_6m allocation bcss_self_negative_total conviction if class_final == `i'
}

//BCSS Self Pos
forval i = 1/4{
		di "Effect of treatment on mediator within class `i'"
	regress bcss_self_positive_total_6m allocation bcss_self_positive_total conviction if class_final == `i'
}

//BCSS Others Neg
forval i = 1/4{
		di "Effect of treatment on mediator within class `i'"
	regress bcss_others_negative_total_6m allocation bcss_others_negative_total conviction if class_final == `i'
}

//BCSS others Pos
forval i = 1/4{
		di "Effect of treatment on mediator within class `i'"
	regress bcss_others_positive_total_6m allocation bcss_others_positive_total conviction if class_final == `i'
}

//Anomalous exp
forval i = 1/4{
		di "Effect of treatment on mediator within class `i'"
	regress anomalousexperiences_total_6m allocation anomalousexperiences_total conviction if class_final == `i'
}

//Vulnerability
forval i = 1/4{
		di "Effect of treatment on mediator within class `i'"
	regress vulnerability_6m allocation vulnerability conviction if class_final == `i'
}

//Belief Flexibilty - mads
forval i = 1/4{
		di "Effect of treatment on mediator within class `i'"
	regress mads_6m allocation mads conviction if class_final == `i'
}

**---End of Analysis------------------------------------------------------------

