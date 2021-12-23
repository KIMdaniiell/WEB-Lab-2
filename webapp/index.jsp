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
    <script src="JavaScript%20Script/click_script.js"></script>
    <style>
        .bordered {
            border: 2px solid #2d333b;
            border-radius: 5%;
            width: 100%;
            padding: 20px;
            margin: 0 30px 0 30px;
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
            <canvas id="Canvas" class="bordered" width="512" height="512">
                <img id="Graph" class="bordered" src="Resources/CoolGraph.png" alt="Resource not found">
            </canvas>
        </td>
        <td id="right=part">
            <h2>Форма</h2>
            <form class="bordered" onsubmit="return validate();"
                  action="" method="post">
                <table id="form_table">
                    <tr>
                        <td>
                            <label for="X">X </label>

                            <input class="formfield" id="X" type="text" name="X" placeholder="Значение от -5 до 3" required>
                            <span class="error"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label style="display: inline;" for="Yradios">Y </label>

                            <table style="display: inline;" id="Yradios">
                                <tr>
                                    <td><label for="Y1">-5</label></td>
                                    <td><label for="Y2">-4</label></td>
                                    <td><label for="Y3">-3</label></td>
                                    <td><label for="Y4">-2</label></td>
                                    <td><label for="Y5">-1</label></td>
                                    <td><label for="Y6">0</label></td>
                                    <td><label for="Y7">1</label></td>
                                    <td><label for="Y8">2</label></td>
                                    <td><label for="Y9">3</label></td>
                                </tr>
                                <tr>
                                    <td><input class="formfield" id="Y1" name="Y" type="radio" value="-5" required></td>
                                    <td><input class="formfield" id="Y2" name="Y" type="radio" value="-4" required></td>
                                    <td><input class="formfield" id="Y3" name="Y" type="radio" value="-3" required></td>
                                    <td><input class="formfield" id="Y4" name="Y" type="radio" value="-2" required></td>
                                    <td><input class="formfield" id="Y5" name="Y" type="radio" value="-1" required></td>
                                    <td><input class="formfield" id="Y6" name="Y" type="radio" value="0" required></td>
                                    <td><input class="formfield" id="Y7" name="Y" type="radio" value="1" required></td>
                                    <td><input class="formfield" id="Y8" name="Y" type="radio" value="2" required></td>
                                    <td><input class="formfield" id="Y9" name="Y" type="radio" value="3" required></td>
                                </tr>
                            </table>

                            <span class="error"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>R </label>

                            <label for="R1">1</label>
                            <input class="formfield" id="R1" name="R" type="checkbox" value="1">
                            <label for="R2">2</label>
                            <input class="formfield" id="R2" name="R" type="checkbox" value="2">
                            <label for="R3">3</label>
                            <input class="formfield" id="R3" name="R" type="checkbox" value="3">
                            <label for="R4">4</label>
                            <input class="formfield" id="R4" name="R" type="checkbox" value="4">
                            <label for="R5">5</label>
                            <input class="formfield" id="R5" name="R" type="checkbox" value="5">
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
                    Object contextBeans = application.getAttribute("contextBeans");
                    if ( contextBeans instanceof LinkedList ){
                        LinkedList beanList = (LinkedList) contextBeans;
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