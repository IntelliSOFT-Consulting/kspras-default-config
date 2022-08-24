select  surgery as 'Procedure Name' , count(distinct(pid)) as 'Total'
 from (
select o.order_id, o.concept_id,
(select name from concept_name where concept_id = o.concept_id and concept_name_type = "FULLY_SPECIFIED" and voided = 0) as Surgery,
o.patient_id, o.voided, o.date_created, cs.concept_set from orders o 
left join concept_set cs on o.concept_id = cs.concept_id
where cs.concept_set =
(select concept_id from concept_name where name = "Hand and upper limb surgery" and concept_name_type = "FULLY_SPECIFIED" and voided = 0) 
and o.date_created between '#startDate#' and '#endDate#' and o.voided = 0
)tBurns inner join (
select distinct(pa.person_id) as pid, concat(coalesce(given_name, ''), "  ", coalesce(middle_name, ''), ' ', coalesce(family_name , '') ) as 'PatientName', 
gender as sex ,floor(datediff(curdate(),p.birthdate) / 365) as 'Age'
from person_attribute as pa 
INNER JOIN person_attribute_type as pat on pa.person_attribute_type_id = pat.person_attribute_type_id  
INNER JOIN person as p on pa.person_id = p.person_id 
LEFT JOIN person_name as pn on p.person_id = pn.person_id 
LEFT JOIN patient as pt on p.person_id = pt.patient_id
where pa.person_attribute_type_id is not null
)tDemographics on tBurns.patient_id = tDemographics.pid
left join (
select patient_id, identifier, voided from patient_identifier
)tPatientIdentifier on tDemographics.pid = tPatientIdentifier.patient_id 
group by surgery
