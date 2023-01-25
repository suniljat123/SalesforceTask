({
    fileToBase64 : function(cmp,file) { 
        var reader = new FileReader();
        reader.onload = function (e) {
            var fileContent = reader.result;
            var base64 = 'base64,';
            var dataStart = fileContent.indexOf(base64) + base64.length;
            fileContent = fileContent.substring(dataStart)
            var fileObj = {"fileName" : file.name, "fileType" : file.type, "fileContent" :fileContent,"Size" : file.size };
            var oldFile = cmp.get("v.tempList");
            oldFile.push(fileObj);
            cmp.set("v.tempList",oldFile);
            return fileContent;            
        };
        reader.readAsDataURL(file);
    }
})