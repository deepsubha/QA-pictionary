public without sharing class DG_DataController {
    public DG_DataController() { }

    @AuraEnabled(cacheable=true)
    public static List<Word__c> getAllWords(String roomCode) {
        return [
            SELECT Id, Name, Name__c, CreatedById
            FROM Word__c where Room__r.Room_Name__c =:roomCode
            LIMIT 35
        ];
    }

    @AuraEnabled(cacheable=true)
    public static List<Participant__c> getAllParticipants(String roomCode) {
        return [
            SELECT Id, Participant_Name__c, Score__c
            FROM Participant__c where Room__r.Room_Name__c =:roomCode
            LIMIT 35
        ];
    }

    @AuraEnabled
    public static Boolean newWordInsertion(String newWords, String roomCode) {
        List<Word__c> wordRecords = new List<Word__c>();
        Id roomId = [select id from Room__c where Room_Name__c =: roomCode]?.id;

        if(newWords != ''){
            List<String> finalWords = newWords.split(',');
            System.debug('getting string>>>>>'+finalWords+'size:::'+ finalWords.size());
            System.debug('room id'+roomId);
            for(Integer i=0; i<finalWords.size(); i++){
                Word__c wd = new Word__c(Name__c=finalWords[i], Room__c=roomId);
                wordRecords.add(wd);
            }
            System.debug('final words'+ wordRecords);
            if(wordRecords.size() > 0){
                //Database.insert(wordRecords, false);
                customDml(wordRecords, 'insert');
                return true;
            }
        }
        return false;
    }

    private static Boolean customDml(List<SObject> listOfRecords, String operation){
        try{
            if(operation == 'insert' || operation == 'create')
            Database.insert(listOfRecords, false);
            return true;
        }catch(Exception ex){
            return false;
        }
    }

}