public class CovidWrapData{
        public string country{get;set;}
       /* public integer statePopulation{get;set;}
        public string stateName{get;set;}
        public integer totalConfirmed{get;set;}
        public integer totalTested{get;set;}
        public integer totalVaccinated1{get;set;}
        public integer totalVaccinated2{get;set;}*/
        public static CovidWrapData parse(string json){
            return (CovidWrapData) System.JSON.deserialize(json,CovidWrapData.class);
        }
    }