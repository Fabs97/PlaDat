class SuperError extends Error {
    constructor(code, message) {
        super(message);
        this.code = code;
    }
}

//ERROR CODES
const ERR_INTERNAL_SERVER_ERROR = 500;
const ERR_NOT_FOUND = 500;
const ERR_BAD_REQUEST = 400; 
const ERR_UNAUTHORIZED = 401; 
const ERR_FORBIDDEN = 403; 

//OTHER CODES
const RES_SUCCESS = 200;

module.exports = {  
    SuperError,
    ERR_INTERNAL_SERVER_ERROR,
    ERR_BAD_REQUEST,
    ERR_NOT_FOUND,
    ERR_UNAUTHORIZED,
    ERR_FORBIDDEN,

    RES_SUCCESS,
    
}