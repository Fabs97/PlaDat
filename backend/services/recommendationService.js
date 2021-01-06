const skillsService = require('./skillsService');
const placementsService = require('./placementService');
const studentService = require('./studentService');

const SuperError = require('../errors').SuperError;
const ERR_INTERNAL_SERVER_ERROR = require('../errors').ERR_INTERNAL_SERVER_ERROR;

const techSoftRate = 7/3;
const skillsWeight = 0.7;
const locationWeight = 0.1;
const educationWeight = 0.17;
const workWeight = 0.03;
const threshold = 0.5;

recommender = module.exports = {

    //for employers
    getStudentRecommendationsForPlacement: async (placementID) => {

        try {
            let placement = await placementsService.getPlacementById(placementID);
            let students = await studentService.getStudentsForRecommendation(placementID);

            let placementSkills = placement.skills; 
            let placementMajors = placement.majors;
            let placementInstitutions = placement.institutions;

            let recommendedStudents = [];

            for(let i = 0; i < students.length; i++){
                let student = students[i];

                let workScore = 0;
                let skillsScore = 0;
                let locationScore = 0;
                let educationScore = 0;

                let studentSkills = student.skills;
                let studentEducation = student.education;

                if(student.work.length > 0) {
                    workScore = 1;
                }

                if(studentSkills.length>0 && placementSkills.length>0){
                    skillsScore = recommender.calculateSkillsScore(studentSkills, placementSkills);
                }

                if(studentEducation.length >0 && (placementInstitutions.length>0 || placementMajors.length>0)){
                    educationScore = recommender.calculateEducationScore(studentEducation, placementInstitutions, placementMajors)
                }

                if(student.location && placement.location){
                    locationScore = recommender.calculateLocationScore(student.location, placement.location)
                }
                let finalScore = recommender.computeFinalScore(skillsScore, locationScore, educationScore, workScore);
                if(finalScore >= threshold){
                    recommendedStudents.push(student);
                }

            }

            return recommendedStudents;
        } catch(error) {
            if(error.code = ERR_INTERNAL_SERVER_ERROR){
                throw error;
            } else {
                throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There has been a problem with your recommendations. Please try again.')
            }
        }
        
    },

    //for students


    /* 
     * This is the updated version of the algorithm.
     * The parameters we agreed on, for example the 70% - 30% rate between tech and soft skills, are defined above as constatnts to be accessed easily.
     */ 
    getPlacementRecommendationsForStudent: async (studentID) => {
        
        try {
            let student = await studentService.getStudentProfile(studentID);
            let placements = await placementsService.getPlacementsForRecommendations(studentID);

            let studentSkills = student.skills; 
            let studentEducation = student.education;

            let recommendedPlacements = [];
            
            let workScore = 0;

            if(student.work.length > 0) {
                workScore = 1;
            }

            for(let i = 0; i < placements.length; i++){
                let skillsScore = 0;
                let locationScore = 0;
                let educationScore = 0;

                let placementSkills = placements[i].skills;
                let placementInstitutions = placements[i].institutions;
                let placementMajors = placements[i].majors;

                if(placementSkills.length>0 && studentSkills.length>0){
                    skillsScore = recommender.calculateSkillsScore(studentSkills, placementSkills);
                }

                if(studentEducation.length >0 && (placementInstitutions.length>0 || placementMajors.length>0)){
                    educationScore = recommender.calculateEducationScore(studentEducation, placementInstitutions, placementMajors)
                }

                if(student.location && placements[i].location){
                    locationScore = recommender.calculateLocationScore(student.location, placements[i].location)
                }
                
                let finalScore = recommender.computeFinalScore(skillsScore, locationScore, educationScore, workScore);
                if(finalScore >= threshold){
                    recommendedPlacements.push(placements[i]);
                }

            }

            return recommendedPlacements;
        } catch(error) {
            if(error.code = ERR_INTERNAL_SERVER_ERROR){
                throw error;
            } else {
                throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There has been a problem with your recommendations. Please try again.')
            }
        }
    },

    calculateSkillsScore: (studentSkills, placementSkills) => {
        let placementTechSkills = 0;
        let placementSoftSkills = 0;
        let matchingTechSkills = 0;
        let matchingSoftSkills = 0;

        for(let j = 0; j < placementSkills.length; j++){
            if(placementSkills[j].type == 'TECH'){
                placementTechSkills++;
                if(studentSkills.some(skill => skill.id == placementSkills[j].id)){
                    matchingTechSkills++;
                }
            } else {
                placementSoftSkills++;
                if(studentSkills.some(skill => skill.id == placementSkills[j].id)){
                    matchingSoftSkills++;
                }
            }
        }

        let softSkillsWeight = 1/(placementSoftSkills + placementTechSkills*techSoftRate);
        let techSkillsWeight = softSkillsWeight*techSoftRate;

        let skillsScore = matchingTechSkills*techSkillsWeight + matchingSoftSkills*softSkillsWeight;
        return skillsScore;
    },

    calculateEducationScore: (studentEducation, placementInstitutions, placementMajors) => {
        let hasMajor = 0;
        let hasInstitution = 0;
        for(let j = 0; j<placementMajors.length; j++){
            if(studentEducation.some(education => education.major == placementMajors[j].name)){
                hasMajor = 0.5;
            }
        }
        for(let j = 0; j<placementInstitutions.length; j++){
            if(studentEducation.some(education => education.institution == placementInstitutions[j].name)){
                hasInstitution = 0.5;
            }
        }

        let educationScore = hasInstitution + hasMajor;
        return educationScore;
    },
    calculateLocationScore: (studentLocation, placementLocation) =>  {
        let locationScore = 0;
        if(studentLocation.id == placementLocation.id){
            locationScore = 1;
        } else if(studentLocation.country == placementLocation.country){
            locationScore = 0.5;
        }
        return locationScore;
    },
    computeFinalScore: (skillsScore, locationScore, educationScore, workScore) => {
        return skillsScore*skillsWeight + locationScore*locationWeight + educationScore*educationWeight + workScore*workWeight;
    }
};