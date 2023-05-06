import { api, LightningElement } from 'lwc';

export default class DG_canvasHost extends LightningElement {
    @api openCanvas;
    @api word;

    constructor(){
        super();

        this.template.addEventListener('load', ()=>{
            console.log('I am here!!');
            const canvas = this.template.querySelector('canvas');
            //const canvas = document.querySelector("#canvas");
            const context = canvas.getContext("2d");

            //resizing programmatically!       
            canvas.height = window.innerHeight;
            canvas.width = window.innerWidth;

            let drawing = false;
            function startDrawing(event){ drawing = true; draw(event)}
            function stopDrawing(){ drawing = false; context.beginPath();}
            function draw(event){
                if(!drawing) return;
                console.log('I am drawing!!');
                var x = event.clientX - canvas.offsetLeft;
                var y = event.clientY - canvas.offsetTop;
                context.lineWidth = 8;
                context.lineCap = "round";
                context.stokeStyle = "blue"; //colour
                //createPointer(event);

                context.lineTo(x, y);
                context.stroke();
                //context.beginPath();
                context.moveTo(x, y);
            }
            function createPointer(event){
                context.beginPath();
                context.arc(event.clientX, event.clientY, 10, 0, 2*Math.PI);
                context.fillStyle = 'orange';
                context.fill();
                context.stroke();
                context.closePath();
            }
            
            canvas.addEventListener('mousedown', startDrawing);
            canvas.addEventListener('mouseup', stopDrawing);
            canvas.addEventListener('mouseout', stopDrawing);
            canvas.addEventListener('mousemove', draw);
        })
        
        /*
        window.addEventListener('resize', ()=>{
            //resizing programmatically! 
            canvas.height = window.innerHeight;
            canvas.width = window.innerWidth;
            
        })
        */
    }

    connectedCallback(){

    }

    disconnectedCallback(){
        console.log('->dis-connected<-');
    }

    closeModal(){
        this.openCanvas = false;
        this.dispatchEvent(new CustomEvent('modalclose'));
    }
}


/*
 * How to draw context in canvas ? Help
/*This is how we can draw lines circles rectangles etc.
            //rectanle and circles and etc.
            context.lineWidth = 5;
            context.strokeStyle = "red";
            context.fillRect(50,50,100,100);
            context.strokeStyle = "blue";
            context.strokeRect(100,100,200,200);
            //how to draw line? 
            context.beginPath();
            context.moveTo(100, 100);
            context.lineTo(200, 100);
            context.lineTo(200, 200);
            context.closePath();
            context.stroke();

*/