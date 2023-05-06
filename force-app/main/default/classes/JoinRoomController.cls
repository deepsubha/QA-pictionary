public without sharing class JoinRoomController {
    String redirecrtLink;
    String rCode='XX-1234'; //XX-1234
    Integer charCodeLen = 2;
    Integer numCodeLen = 4;
    public String userId{get; set;}
    public String roomCode{get; set;}
    public Boolean hasCode{get; set;}
    public Boolean hasError{get; set;}
    
    public String roomLabel{get; set;}
    public String inputName{get; set;}
    public String errorMsg{get; set;}
    public JoinRoomController() {
        redirecrtLink = '/apex/pictionaryHost';
        this.roomCode = null;
        this.hasCode = false;
        this.roomLabel = 'roomLabel';
        this.inputName = 'inputName';
        this.hasError = false;
        this.errorMsg = 'OOps!! Something went worng, Try again Later!';
    }

    public void createRoom(){
        this.hasCode = false;
        rCode = getCharCode(charCodeLen) +'-'+ getNumCode(numCodeLen);
        this.roomCode = rCode;
    }
    public void joinRoom(){
        this.roomCode = '';
        this.hasError = false;
		this.hasCode = true;
    }

    public Pagereference gotoPictionary(){
        this.errorMsg = getErrorCheck();
        this.hasError = this.errorMsg != '' ? true : false;
        Savepoint sp;
        Room__c r = new Room__c();
        Participant__c p = new Participant__c();

        if(!this.hasError){
            try{
                sp = Database.setSavepoint();
                System.debug('hasCode######'+ this.hasCode);
                if(!this.hasCode){
                    r = new Room__c(Room_Name__c = this.roomCode, isActive__c  = true);
                    insert r; 
                }else{
                    r = [select id from Room__c where Room_Name__c=:this.roomCode and isActive__c  = true];
                }
                System.debug('room code id######'+ r.Id);
                if(r.id != null){              
                    p.Participant_Name__c = this.userId;
                    p.Room__c = r.id;
                    insert p;
                }else{
                    this.errorMsg = 'Something went wrong!';
                    this.hasError = true;
                    return null;
                }
                PageReference pageRef = new PageReference(redirecrtLink);
                pageRef.setRedirect(true);
                pageRef.getParameters().put('roomCode', this.roomCode); 
                pageRef.getParameters().put('userId', this.userId); 
                //pageRef.getParameters().put('TimeStamp', '10:05:34');
                return pageRef;
            }catch(Exception ex){
                this.errorMsg = ex.getMessage();
                this.hasError = true;
                Database.rollback(sp);
                return null;
            }
        }
        return null;
    }

    public String getCharCode(Integer charCodeLen){
        final String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        String charCode = '';
        while (charCode.length() < charCodeLen) {
           Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
           charCode += chars.substring(idx, idx+1);
        }
        return charCode; 
    }

    public String getNumCode(Integer numCodeLen) {
        Integer max = 9999;
        Integer min = 1000;
        Integer numCode = (Integer)(Math.random()*(max-min+1)+min);  
        return String.valueOf(numCode); 
    }
    
    public String getErrorCheck() {
        if(this.hasCode){
            if(this.roomCode.length() != 7) return 'Room code length should be 7 characters';
            if(!this.roomCode.contains('-')) return 'Room code must have \'-\'';
            if(this.roomCode.contains('-')){
                String[] codes = this.roomCode.split('-');
                if(codes.size() != 2) return 'room code format should be \'TT-NNNN\'';
                else{
                    if(codes[0].length()!=2 || codes[1].length()!=4) return 'room code format should be \'TT-NNNN\'';
                    
                    String regexForNum = '[0-9]+';
        			Pattern p1 = Pattern.compile(regexForNum);
                    Matcher m1 = p1.matcher(codes[1]);
                    if (!m1.matches()) return 'last four characters should be numbers';
                    
                    /* Regular expression for upper character only
                    String regexForChar = '/[A-Z]/g';
        			Pattern p2 = Pattern.compile(regexForChar);
                    Matcher m2 = p2.matcher(codes[0]);
                    if (!m2.matches()) return 'first two characters should be alphabets (case sensitive)';
                    */
                    
                    return codes[0].isAlpha() ? '': 'first two characters should be alphabets';
                    
                }
            }
        }
        return ''; 
    }

}