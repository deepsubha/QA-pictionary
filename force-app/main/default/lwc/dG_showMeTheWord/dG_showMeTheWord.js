import { LightningElement, api } from 'lwc';

export default class DG_showMeTheWord extends LightningElement {
@api word;
openCanvas = false;

connectedCallback(){
    var elem = document.getElementById("wordId");
    if(this.word !== ''){
        setTimeout(function(){ alert("Hello"); }, 3000);
    }
    //setTimeout(()=>{elem.style.display = "none"},2000);
    
}

constructor(){
    super();
    //setTimeout(function(){ alert("Hello"); }, 3000);
}

handleDraw(){
    console.log('handling canvas!!');
    this.openCanvas = !this.openCanvas;
}

}