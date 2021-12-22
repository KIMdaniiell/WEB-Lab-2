<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="WebLab.Data.TableDataBean" %>
<%@ page import="java.util.LinkedList" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Web-Lab-1</title>
    <link rel="stylesheet" href="CSS%20Style%20Sheets/body_styles.css">
    <link rel="stylesheet" href="CSS%20Style%20Sheets/header_styles.css">
    <link rel="stylesheet" href="CSS%20Style%20Sheets/picture_styles.css">
    <link rel="stylesheet" href="CSS%20Style%20Sheets/form_styles.css">
    <link rel="stylesheet" href="CSS%20Style%20Sheets/resultTable_styles.css">
    <script src="JavaScript%20Script/validate_script.js"></script>
    <style>
        .bordered {
            border: 2px solid #2d333b;
            border-radius: 5%;
        }
    </style>
</head>
<body>

<header class="header">
    <table>
        <tr>
            <td><h3>Ким Даниил Кванхенович</h3></td>
            <td></td>
            <td><h3>[P3231]</h3></td>
            <td></td>
            <td><h3>31010</h3></td>
        </tr>
    </table>
</header>

<table id="content">
    <tr id="table_section">
        <td id="left_part">
            <img id="Graph" class="bordered" src="Resources/Graph.png" alt="Resource not found">
        </td>
        <td id="right=part">
            <h2>Форма</h2>
            <form class="bordered" onsubmit="return validate();"
                  action="" method="post">
                <table id="form_table">
                    <tr>
                        <td>
                            <label for="X">X </label>
                            <!--
                            <select class="formfield" id="X" name="X" required>
                                <option value="">Выбрать</option>
                                <option value="-4">-4</option>
                                <option value="-3">-3</option>
                                <option value="-2">-2</option>
                                <option value="-1">-1</option>
                                <option value="0">0</option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                            </select>
                            -->
                            <input class="formfield" id="X" type="text" name="X" placeholder="Значение от -5 до 3" required>
                            <span class="error"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>Y </label>
                            <!--
                            <input class="formfield" id="Y" type="text" name="Y" placeholder="Значение от -3 до 5" required>
                            -->
                            <label for="Y1">-5</label>
                            <input class="formfield" id="Y1" name="Y" type="radio" value="-5" required>
                            <label for="Y2">-4</label>
                            <input class="formfield" id="Y2" name="Y" type="radio" value="-4" required>
                            <label for="Y3">-3</label>
                            <input class="formfield" id="Y3" name="Y" type="radio" value="-3" required>
                            <label for="Y4">-2</label>
                            <input class="formfield" id="Y4" name="Y" type="radio" value="-2" required>
                            <label for="Y5">-1</label>
                            <input class="formfield" id="Y5" name="Y" type="radio" value="-1" required>
                            <label for="Y6">0</label>
                            <input class="formfield" id="Y6" name="Y" type="radio" value="0" required>
                            <label for="Y7">1</label>
                            <input class="formfield" id="Y7" name="Y" type="radio" value="1" required>
                            <label for="Y8">2</label>
                            <input class="formfield" id="Y8" name="Y" type="radio" value="2" required>
                            <label for="Y9">3</label>
                            <input class="formfield" id="Y9" name="Y" type="radio" value="3" required>
                            <span class="error"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>R </label>
                            <!--
                            <select class="formfield" id="R" name="R" required>
                                <option value="">Выбрать</option>
                                <option value="1">1</option>
                                <option value="1.5">1.5</option>
                                <option value="2">2</option>
                                <option value="2.5">2.5</option>
                                <option value="3">3</option>
                            </select>
                            -->
                            <label for="R1">1</label>
                            <input class="formfield rbox" id="R1" name="R" type="checkbox" value="1">
                            <label for="R2">2</label>
                            <input class="formfield rbox" id="R2" name="R" type="checkbox" value="2">
                            <label for="R3">3</label>
                            <input class="formfield rbox" id="R3" name="R" type="checkbox" value="3">
                            <label for="R4">4</label>
                            <input class="formfield rbox" id="R4" name="R" type="checkbox" value="4">
                            <label for="R5">5</label>
                            <input class="formfield rbox" id="R5" name="R" type="checkbox" value="5">
                            <span class="error" id="r_error"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <button type="submit" name="Submit">Отправить</button>
                        </td>
                    </tr>
                </table>
            </form>
            <h2>Таблица результатов</h2>
            <table id="result_table" class="bordered">
                <tr id="result_table_header">
                    <th> X</th>
                    <th> Y</th>
                    <th> R</th>
                    <th>Результат</th>
                    <th>Время</th>
                    <th>Выполнение</th>
                </tr>
                <tr></tr>
                <%
                    Object sessionBeans = request.getSession().getAttribute("sessionBeans");
                    if ( sessionBeans instanceof LinkedList ){
                        LinkedList beanList = (LinkedList) sessionBeans;
                        for (Object o: beanList) {
                            if (o instanceof TableDataBean) {
                                TableDataBean bean = (TableDataBean) o;
                                out.println("<tr><td>" + bean.getX()
                                        + "</td><td>" + bean.getY()
                                        + "</td><td>" + bean.getR()
                                        + "</td><td>" + bean.getResult()
                                        + "</td><td>" + bean.getCurrentTime()
                                        + "</td><td>" + bean.getProcessingTime() + "</td></tr>");
                            }
                        }
                    }
                %>
            </table>
        </td>
    </tr>
</table>
</body>
</html>