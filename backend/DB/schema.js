const skillSchema = {
    title: 'skill schema',
    type: 'object',
    required: ['id', 'name', 'type'],
    properties: {
        id: {
            type: 'number'
        },
        type: {
            type: 'string',
            enum: ['SOFT', 'TECH', 'OTHER']
        },
        name: {
            type: 'string'
        }
    }
}

const availableSkillSchema = {
    title: 'skills schema for soft and tech skills',
    type: 'object',
    required: ['technicalSkills', 'softSkills'],
    properties: {
        softSkills: {
            type: 'array',
            items: {
                type: skillSchema 
            }
        },
        type: {
            type: 'string',
            enum: ['SOFT', 'TECH', 'OTHER']
        },
        name: {
            type: 'string'
        }
    }
}