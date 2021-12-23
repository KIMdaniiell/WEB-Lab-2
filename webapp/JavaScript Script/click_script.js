window.onload = function (){
    showGraph();
    showAttempts();

    let img = document.getElementById("Canvas");

    let getOffsetTop = element => {
        let offsetTop = 0;
        while(element) {
            offsetTop += element.offsetTop;
            element = element.offsetParent;
        }
        return offsetTop;
    }

    let getOffsetLeft = element => {
        let offsetLeft = 0;
        while(element) {
            offsetLeft += element.offsetLeft;
            element = element.offsetParent;
        }
        return offsetLeft;
    }

    let imgTopOffset = getOffsetTop(img)+22;
    let imgLeftOffset = getOffsetLeft(img)+21;


    window.onresize = function (){
        imgTopOffset = getOffsetTop(img)+22;
        imgLeftOffset = getOffsetLeft(img)+21;

        console.log("[ClickScript] x0 = "+imgLeftOffset+"  y0 = "+imgTopOffset);
    }

    img.onclick = function () { clickHandler(event,imgLeftOffset,imgTopOffset) };
}

function showGraph(){
    let canvas = document.getElementById("Canvas");
    let context = canvas.getContext("2d");
    let img = document.getElementById("Graph");
    context.drawImage(img,0,0,512,512);
}

function showAttempts(){
    console.log("Рисуем точки");
    let canvas = document.getElementById("Canvas");
    let context = canvas.getContext("2d");
    context.strokeStyle = "#aab6c3";
    Array.from(document.getElementById("result_table").getElementsByTagName("tr")).slice(2)
        .forEach( row => {
            console.log("Опа, точка");
            let rowdata = Array.from(row.getElementsByTagName("td"));
            let r = parseFloat(rowdata[2].innerText);
            let x = parseFloat(rowdata[0].innerText)/r;
            let y = parseFloat(rowdata[1].innerText)/r;
            let result= rowdata[3].innerText;

            if (result === "Промах") {
                context.fillStyle = 'red';
            } else if (result === "Попадание") {
                context.fillStyle = 'green';
            }
            context.beginPath();
            context.arc(255+x*200, 255-y*200, 4, 0, Math.PI * 2, false);
            context.closePath();
            context.fill();
        });
}

function clickHandler ( mouseClick, LeftOffset, TopOffset) {
    console.log("[ClickScript] X = "+(mouseClick.pageX - LeftOffset -255)/200 + "  Y = " + -(mouseClick.pageY - TopOffset-255)/200);
    console.log("[ClickScript] x0 = "+LeftOffset+"  y0 = "+TopOffset);

    let dataIsCorrect = true;
    let rAlreadyChecked = false;
    let r;

    Array.from(document.getElementsByName("R"))
        .filter( node => {
            return node.checked;
        })
        .forEach( node => {
            if (rAlreadyChecked === true) {
                document.getElementById("r_error").innerHTML="<br>Пожалуйста, выберите одно значение R";
                dataIsCorrect = false;
            } else {
                document.getElementById("r_error").innerHTML="";
                let v = validateR(node);
                dataIsCorrect = dataIsCorrect * v;
                r = node.value;
                rAlreadyChecked = true;
            }
        });
    if (rAlreadyChecked === false) {
        document.getElementById("r_error").innerHTML="<br>Пожалуйста, выберите одно значение R";
        dataIsCorrect = false;
        console.log("[ClickScript] Валидность R = " + false);
    }

    let x = ((mouseClick.pageX - LeftOffset -255)/200*r).toFixed(2);
    let y = (-(mouseClick.pageY - TopOffset-255)/200*r).toFixed(2);

    console.log("\tX равен:" + x);
    console.log("\tY равен:" + y);
    console.log("\tR равен:" + r);
    console.log("[ClickScript] Результат проверки:" + dataIsCorrect);

    if (dataIsCorrect) {
        handle(x, y, r);
        console.log("[ClickScript] POST запрос сформирован и отправлен.");
    }
}