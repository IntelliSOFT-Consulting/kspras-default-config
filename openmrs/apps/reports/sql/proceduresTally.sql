select identifier as 'Patient Id' , PatientName as 'Patient Name' , name as 'Procedure Name' from (
select distinct(pa.person_id) as pid, concat(coalesce(given_name, ''), "  ", coalesce(middle_name, ''), ' ', coalesce(family_name , '') ) as 'PatientName', 
gender as sex ,floor(datediff(curdate(),p.birthdate) / 365) as 'Age'
from person_attribute as pa 
INNER JOIN person_attribute_type as pat on pa.person_attribute_type_id = pat.person_attribute_type_id  
INNER JOIN person as p on pa.person_id = p.person_id 
LEFT JOIN person_name as pn on p.person_id = pn.person_id 
LEFT JOIN patient as pt on p.person_id = pt.patient_id
where pa.person_attribute_type_id is not null
)tDemographics right join (
SELECT o.patient_id , o.concept_id as 'procedures' , o.date_activated, 
cs.concept_set, cn.name,
o.voided from orders o
LEFT JOIN concept_set cs on o.concept_id = cs.concept_id
left join concept_name cn on cs.concept_set = cn.concept_id and cn.concept_name_type = 'FULLY_SPECIFIED'
where o.voided = 0 and o.date_activated between '2022-08-01' and '2022-08-31' and cn.name in ('Breast surgery','Burns surgery',
'Paediatric and craniofacial Plastic surgery','Breast surgery','Hand and upper limb surgery',
'Orthoplastic surgery','Oncoplastic surgery, label','Aesthetic surgery')
)tInfectionSite on tDemographics.pid = tInfectionSite.patient_id
left join (
select patient_id, identifier, voided from patient_identifier
)tPatientIdentifier on tDemographics.pid = tPatientIdentifier.patient_id 
union all 
select '','',''
union all
select 'Total Procedures','', count(name) from (
select distinct(pa.person_id) as pid, concat(coalesce(given_name, ''), "  ", coalesce(middle_name, ''), ' ', coalesce(family_name , '') ) as 'PatientName', 
gender as sex ,floor(datediff(curdate(),p.birthdate) / 365) as 'Age'
from person_attribute as pa 
INNER JOIN person_attribute_type as pat on pa.person_attribute_type_id = pat.person_attribute_type_id  
INNER JOIN person as p on pa.person_id = p.person_id 
LEFT JOIN person_name as pn on p.person_id = pn.person_id 
LEFT JOIN patient as pt on p.person_id = pt.patient_id
where pa.person_attribute_type_id is not null
)tDemographics right join (
SELECT o.patient_id , o.concept_id as 'procedures' , o.date_activated, 
cs.concept_set, cn.name,
o.voided from orders o
LEFT JOIN concept_set cs on o.concept_id = cs.concept_id
left join concept_name cn on cs.concept_set = cn.concept_id and cn.concept_name_type = 'FULLY_SPECIFIED'
where o.voided = 0 and o.date_activated between '2022-08-01' and '2022-08-31' and cn.name in ('Breast surgery','Burns surgery',
'Paediatric and craniofacial Plastic surgery','Breast surgery','Hand and upper limb surgery',
'Orthoplastic surgery','Oncoplastic surgery, label','Aesthetic surgery')
)tInfectionSite on tDemographics.pid = tInfectionSite.patient_id
left join (
select patient_id, identifier, voided from patient_identifier
)tPatientIdentifier on tDemographics.pid = tPatientIdentifier.patient_id 

