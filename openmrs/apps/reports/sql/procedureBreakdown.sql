Select identifier as 'Patient ID' ,PatientName as 'Patient Name' ,
(select name from concept_name where concept_name_type = "FULLY_SPECIFIED" and voided = 0 and concept_id = procedures) as 'Procedure'
from( 
select distinct(pa.person_id) as pid, concat(coalesce(given_name, ''), "  ", coalesce(middle_name, ''), ' ', coalesce(family_name , '') ) as 'PatientName', 
gender as sex ,floor(datediff(curdate(),p.birthdate) / 365) as 'Age'
from person_attribute as pa 
INNER JOIN person_attribute_type as pat on pa.person_attribute_type_id = pat.person_attribute_type_id  
INNER JOIN person as p on pa.person_id = p.person_id 
LEFT JOIN person_name as pn on p.person_id = pn.person_id 
LEFT JOIN patient as pt on p.person_id = pt.patient_id
where pa.person_attribute_type_id is not null
)tDemographics right join (
SELECT patient_id , concept_id as 'procedures' , date_activated,
voided from orders where voided = 0 and date_activated between '#startDate#' and '#endDate#' 
)tOrder on tDemographics.pid = tOrder.patient_id
left join (
select patient_id, identifier, voided from patient_identifier
)tPatientIdentifier on tDemographics.pid = tPatientIdentifier.patient_id 
 
