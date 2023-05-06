import { LightningElement,wire,api } from 'lwc';
import getAllWords from '@salesforce/apex/DG_DataController.getAllWords';
import newWordInsertion from '@salesforce/apex/DG_DataController.newWordInsertion';
import { refreshApex } from '@salesforce/apex';
export default class DG_addNewWord extends LightningElement {
    newWords='';
    @api roomCode;
    @wire(getAllWords, {roomCode: '$roomCode'})
    allWords;

    handleChange(event){
        this.newWords = event.target.value;
    }

    handleSave(){
        console.log('words-->'+this.newWords);
        if(this.newWords !== ''){
            newWordInsertion({newWords: this.newWords, 
                              roomCode: this.roomCode
            })
            .then(data=>{
                alert('resolved? :'+data);
                refreshApex(this.allWords);
            })
            .catch(err=>{
                alert('rejected? :'+JSON.stringify(err));
            })
        }else{
            alert('some error need to be handled!');
        }

    }
}