Profile: RadiotherapyCourseSummary
Parent: Procedure
Id: radiotherapy-course-summary
Title: "Radiotherapy course Summary"
Description: "A summary of a course of radiotherapy planned or delivered to a patient"

* subject 1..1 
* subject MS
* subject only Reference(onco-patient)

* basedOn only Reference(treatment)

* category 1..1
* category MS
* category ^short = "Type (planned or delivered)"
* category ^definition = "Type (planned or delivered)"
* category.coding.code from vs-radiotherapy-category (required)
* category.coding.code 1..1 MS

* code = SnomedCS#1217123003
* code.coding.display = "Radiotherapy course of treatment (regime/therapy)"
* code 1..1 MS

* extension contains treatmentIntent named treatmentIntent 0..1 MS
* extension[treatmentIntent] ^short = "Objective"
* extension[treatmentIntent] ^definition = "A code explaining the objective (eg curative, palliative, preventive therapy). Dicom Tag (3001,000A)."

* extension contains treatmentTerminationReason named treatmentTerminationReason 0..1 MS 
* extension[treatmentTerminationReason] ^short = "Termination Reason"
* extension[treatmentTerminationReason] ^definition = "A code explaining the reason for unplanned or premature end, or normal completion. It should be extracted from MOSAIQ/ARIA Record and Verify."

* extension contains numberOfSessions named numberOfSessions 0..1 MS 
* extension[numberOfSessions] ^short = "Number of Sessions. Obligatory if category is Planned"
* extension[numberOfSessions] ^definition = "Total number of fractions planned. Summarize from phases. Obligatory if category is Planned"

* performed[x] only Period
* performed[x] 1..1 MS
* performed[x] ^definition = "The start and end period " 
* performedPeriod.start 1..1 MS
* performedPeriod.start ^short = "Start date"
* performedPeriod.start ^definition = "Start date and time. They should be extracted from MOSAIQ/ARIA Record and Verify."
* performedPeriod.end 1..1 MS
* performedPeriod.end ^short = "End date"
* performedPeriod.end ^definition = "End date and time. They should be extracted from MOSAIQ/ARIA Record and Verify."

// ################ 
// Extension     ##
// ################ 

Extension:  TreatmentIntent
Id: treatmentIntent
Title: "Treatment Intent"
Description: "The treatment Intent"
* value[x] only CodeableConcept
* valueCodeableConcept from vs-radiotherapy-intent (required)

Extension:  TreatmentTerminationReason
Id: treatmentTerminationReason
Title: "Treatment Termination Reason"
Description: "The treatment Termination Reason"
* value[x] only CodeableConcept 
* valueCodeableConcept from vs-radiotherapy-termination-reason (required)

Extension:  NumberOfSessions
Id: numberOfSessions
Title: "Number of Sessions"
Description: "The number of sessions"
* value[x] only unsignedInt


/*
    ##########################
    # FHIR-OSIRIS <--> OSIRIS #
    ##########################
*/

Mapping: FhirOSIRIS-RadiotherapyCourse
Source: radiotherapy-course-summary
Target: "RadiotherapyCourse"
Id: fhir-osiris-RadiotherapyCourse
Title: "OSIRIS pivot files"

* subject -> "OSIRIS_pivot_CourseRT.Patient_Id"
* category -> "OSIRIS_pivot_CourseRT.Course_Type"
* performedPeriod.start -> "OSIRIS_pivot_CourseRT.Course_StartDate"
* performedPeriod.end -> "OSIRIS_pivot_CourseRT.Course_EndDate"
* extension[treatmentIntent] -> "OSIRIS_pivot_CourseRT.Course_TreatmentIntent"
* extension[treatmentTerminationReason] -> "OSIRIS_pivot_CourseRT.Course_TerminationReason"
* extension[numberOfSessions] -> "OSIRIS_pivot_CourseRT.Course_NumberOfSessions"
* basedOn -> "OSIRIS_pivot_CourseRT.Treatment_Ref"


/*
    #############################
    # FHIR-OSIRIS <--> DICOM TAG #
    #############################
*/

Mapping: FhirOSIRIS-DicomTag-RadiotherapyCourse
Source: radiotherapy-course-summary
Target: "RadiotherapyCourse"
Id: fhir-osiris-dicomTag-RadiotherapyCourse
Title: "DICOM Tag Mapping (version OSIRIS)"

* extension[treatmentIntent] -> "RT Plan/RT General Plan/Plan Intent (300A,000A)"
