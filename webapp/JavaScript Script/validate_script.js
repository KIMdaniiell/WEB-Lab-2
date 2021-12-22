function validate() {

    let dataIsCorrect = true;
    let x;
    let y;
    let r;
    console.log("Валидация...");

    let rAlreadyChecked = false; //переменная для проверки количества отмеченных R чекбоксов
    Array.from(document.getElementsByClassName("formfield"))
        .forEach(node => {
                switch (node.name) {
                    case 'X' : {
                        let v = validateX(node);
                        dataIsCorrect = dataIsCorrect * v;
                        console.log("\tВалидность X = " + v);
                        x = node.value;
                        break;
                    }
                    case 'Y' : {
                        if (node.checked) {
                            let v = validateY(node);
                            dataIsCorrect = dataIsCorrect * v;
                            console.log("\tВалидность Y = " + v);
                            y = node.value;
                        }
                        break;
                    }
                    case 'R' : {
                        if (node.checked) {
                            if (rAlreadyChecked === true) {
                                document.getElementById("r_error").innerHTML="<br>Пожалуйста, выберите одно значение R";
                                dataIsCorrect = false;
                                console.log("\tВалидность R = " + false);
                            } else {
                                document.getElementById("r_error").innerHTML="";
                                let v = validateR(node);
                                dataIsCorrect = dataIsCorrect * v;
                                console.log("\tВалидность R = " + v);
                                r = node.value;
                                rAlreadyChecked = true;
                            }
                        }
                        break;
                    }
                }
            }
        );
    if (rAlreadyChecked === false) {
        document.getElementById("r_error").innerHTML="<br>Пожалуйста, выберите одно значение R";
        dataIsCorrect = false;
        console.log("\tВалидность R = " + false);
    }

    console.log("\tX равен:" + x);
    console.log("\tY равен:" + y);
    console.log("\tR равен:" + r);
    console.log("Результат проверки:" + dataIsCorrect);
    if (dataIsCorrect) {
        console.log("Формируется POST запрос.");
        handle(x, y, r);
        console.log("POST запрос сформирован и отправлен.");
        return true;
    }
    return false;
}


function markField(field) {
    /** Выделяет выбранное поле как некорректно введенное  */
    field.classList.add("invalidInput");
    Array.from(field.parentElement.getElementsByClassName("error"))
        .forEach(o =>
            o.innerHTML = "<br>Пожалуйста, проверьте содержимое поля " + field.id + ".");
}

function unmarkField(field) {
    /** Убирает выделение (см. markField) с выбранного поля */
    field.classList.remove("invalidInput");
    Array.from(field.parentElement.getElementsByClassName("error")).forEach(o =>
        o.innerHTML = "");
}

function validateX(field) {
    /** Выполняет валидацию поля X.
     * x ∈ { -5, ..., 3}
     * @param field HTML элемент - т.е. фоле формы.
    **/
    let x = field.value;

    let reg1 = /^-5(\.0+)?$/;           //  [ -5.(0) ; -5 ]
    let reg2 = /^-[34](\.\d+)?$/;       //  ( -5 ; -3 ]
    let reg3 = /^-?[0-2](\.\d+)?$/;     //  ( -3 ; 3 )
    let reg4 = /^3(\.0+)?$/;            //  [ 3 ; 3.(0) )
    let reg5 = /^0+$/;                  //  (0)

    if (reg1.test(x) || reg2.test(x) || reg3.test(x) || reg4.test(x) || reg5.test(x)) {
        unmarkField(field);
        return true;
    }
    markField(field);
    return false;
}

function validateY(field) {
    /** Выполняет валидацию поля Y.
     * y ∈ { -5, -4, -3, -2, -1, 0, 1, 2, 3}
     * @param field HTML элемент - т.е. фоле формы.
    **/
    let y = field.value;

    if (y === "-5" || y === "-4" || y === "-3" || y === "-2" || y === "-1" || y === "0" || y === "1" || y === "2" || y === "3") {
        unmarkField(field);
        return true;
    }
    markField(field);
    return false;
}

    function validateR(field) {
        /** Выполняет валидацию поля R.
         * x ∈ { 1, 2, 3, 4, 5}
         * @param field HTML элемент - т.е. фоле формы.
         **/

        let r = field.value;

        if (r === "1" || r === "2" || r === "3" || r === "4" || r === "5") {
            unmarkField(field);
            return true;
        }
        markField(field);
        return false;
    }

    function handle(x, y, r) {
        /**
         * Формирует POST запрос и отправляет на обработку.
         * @param x,y,r Данные введенные пользователем в форму .
         **/

        let xhr = new XMLHttpRequest();
        xhr.open('POST', './controller')
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

        xhr.onload = function () {
            window.location.reload(true);
        }

        xhr.send('X=' + x + '&Y=' + y + '&R=' + r);
        //Т.к. искользуется метод POST, данные передаются в теле запроса.
    }

    function addRow(response) {

        /**
         * Добавляет в HTML таблицу данные о результате вычисления и вводные данные.
         * @param response Расспаршенный (см. handle) ассоциативный массив с данными.
         */

        let row = document.createElement('tr');

        //этот участок кода нужен, для красивого отображения длинных чисел в таблице
        let y = `${response['y']}`;
        if (y.length>6) {
            y = Number(`${response['y']}`).toFixed(6);
        }

        row.innerHTML = `<td>${response['x']}</td>
                    <td>` + y + `</td>
                    <td>${response['r']}</td>
                    <td>${response['result']}</td>
                    <td>${response['ctime']}</td>
                    <td>${response['etime']}</td>`;

        document.getElementById('result_table').appendChild(row);
    }
