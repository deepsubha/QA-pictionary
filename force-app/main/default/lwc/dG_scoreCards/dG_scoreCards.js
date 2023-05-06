import { LightningElement, wire , api} from 'lwc';
import getAllParticipants from '@salesforce/apex/DG_DataController.getAllParticipants';

const columns = [
    { label: 'Participant Name', fieldName: 'Participant_Name__c' },
    { label: 'Total Score', fieldName: 'Score__c' },
    {label: 'Edit', type: "button", typeAttributes: {
        label: 'Edit',
        name: 'Edit',
        title: 'Edit',
        disabled: false,
        value: 'edit',
        iconPosition: 'left'
    }},
    {label: 'Delete', type: "button", typeAttributes: {
        label: 'Delete',
        name: 'Delete',
        title: 'Delete',
        disabled: false,
        value: 'delete',
        iconPosition: 'left'
    }}
];
export default class DG_scoreCards extends LightningElement {
    columns = columns;
    @api roomCode;
    connectedCallback(){
        console.log('received DG_scoreCards: '+this.roomCode);
    }

    @wire(getAllParticipants,{roomCode: '$roomCode'})
    allParticipants;
}