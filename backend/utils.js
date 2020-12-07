module.exports = {
    toUnderscore: (list) => {
        let underscoreList = [];
        function camelToUnderscore(key) {
            return key.replace( /([A-Z])/g, "_$1" ).toLowerCase();
        }
        
        for(let i=0; i<list.length; i++) {
            let item = list[i];
            let newItem = {};
            for(var property in item) {
                newItem[camelToUnderscore(property)] = item[property];
            }
            underscoreList.push(newItem);
        }

        return underscoreList;
        
    }
}