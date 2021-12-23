window.onload = function (){
    console.log("[GraphScript] Страница загружена.");
    let canvas = document.getElementById("Canvas");
    let context = canvas.getContext("2d");
    let img = document.getElementById("Graph");
    context.drawImage(img,0,0,512,512);

    console.log("[ClickScript] Страница загружена.");
    img = document.getElementById("Canvas");

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
    let imgWidth = img.offsetWidth;
    let imgHeight = img.offsetHeight;

    window.onresize = function (){
        imgTopOffset = getOffsetTop(img)+22;
        imgLeftOffset = getOffsetLeft(img)+21;
        imgWidth = img.offsetWidth;
        imgHeight = img.offsetHeight;
        console.log("[ClickScript] x0 = "+imgLeftOffset+"  y0 = "+imgTopOffset+"  width = "+imgWidth+"  height = "+imgHeight);
    }

    img.onclick = function (event) {
        console.log("[ClickScript] X = "+(event.pageX - imgLeftOffset -255)/200 + "  Y = " + -(event.pageY - imgTopOffset-255)/200);
        console.log("[ClickScript] x0 = "+imgLeftOffset+"  y0 = "+imgTopOffset+"  width = "+imgWidth+"  height = "+imgHeight);

        let dataIsCorrect = true;
        let rAlreadyChecked = false;
        let r;

        Array.from(document.getElementsByName("R"))
            .forEach(node => {
                if (node.checked) {
                    if (node.checked) {
                        if (rAlreadyChecked === true) {
                            document.getElementById("r_error").innerHTML="<br>Пожалуйста, выберите одно значение R";
                            dataIsCorrect = false;
                            console.log("[ClickScript] Валидность R = " + false);
                        } else {
                            document.getElementById("r_error").innerHTML="";
                            let v = validateR(node);
                            dataIsCorrect = dataIsCorrect * v;
                            console.log("[ClickScript] Валидность R = " + v);
                            r = node.value;
                            rAlreadyChecked = true;
                        }
                    }
                }
            });
        if (rAlreadyChecked === false) {
            document.getElementById("r_error").innerHTML="<br>Пожалуйста, выберите одно значение R";
            dataIsCorrect = false;
            console.log("[ClickScript] Валидность R = " + false);
        }
        let x = ((event.pageX - imgLeftOffset -255)/200*r).toFixed();
        let y = (-(event.pageY - imgTopOffset-255)/200*r).toFixed();
        console.log("\tX равен:" + x);
        console.log("\tY равен:" + y);
        console.log("\tR равен:" + r);
        console.log("[ClickScript] Результат проверки:" + dataIsCorrect);
        if (dataIsCorrect) {
            console.log("[ClickScript] Формируется POST запрос.");
            handle(x, y, r);
            console.log("[ClickScript] POST запрос сформирован и отправлен.");
            return false;
        }
    }
}
