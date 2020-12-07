class SuperError extends Error {
    constructor(code, message) {
        super(message);
        this.code = code;
    }
}

//ERROR CODES
const ERR_INTERNAL_SERVER_ERROR = 500;

//OTHER CODES
const RES_SUCCESS = 200;

module.exports = {  
    SuperError,
    ERR_INTERNAL_SERVER_ERROR,
    RES_SUCCESS
}