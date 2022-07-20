Bahmni.ConceptSet.FormConditions.rules = {
    'Diastolic Data' : function (formName, formFieldValues) {
        var systolic = formFieldValues['Systolic'];
        var diastolic = formFieldValues['Diastolic'];
        if (systolic || diastolic) {
            return {
                enable: ["Posture"]
            }
        } else {
            return {
                disable: ["Posture"]
            }
        }
    },
    'Systolic Data' : function (formName, formFieldValues) {
        var systolic = formFieldValues['Systolic'];
        var diastolic = formFieldValues['Diastolic'];
        if (systolic || diastolic) {
            return {
                enable: ["Posture"]
            }
        } else {
            return {
                disable: ["Posture"]
            }
        }
    },
    "Mode of Payment" : function (formName, formFieldValues) {
        var paymentMode = formFieldValues['Mode of Payment'];
        if (paymentMode === "Insurance, Mode of Payment") {
            return {
                show: ["NHIF Number","NHIF Comments"]
            }  
        } else {
            return {
                hide: ["NHIF Number","NHIF Comments"]
            }
        }
    }

};