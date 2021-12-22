<%@ page import="WebLab.Data.TableDataBean" %>
<%@ page import="java.util.LinkedList" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Web-Lab-1</title>
    <link rel="stylesheet" href="../CSS%20Style%20Sheets/body_styles.css">
    <link rel="stylesheet" href="../CSS%20Style%20Sheets/header_styles.css">
    <link rel="stylesheet" href="../CSS%20Style%20Sheets/picture_styles.css">
    <link rel="stylesheet" href="../CSS%20Style%20Sheets/form_styles.css">
    <link rel="stylesheet" href="../CSS%20Style%20Sheets/resultTable_styles.css">
    <script src="../JavaScript%20Script/validate_script.js"></script>
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
            <img id="Graph" class="bordered" src="../Resources/Graph.png" alt="Resource not found">
        </td>
        <td id="right=part">
            <h2>Форма</h2>
            <form class="bordered" onsubmit="validate();return false;"
                  action="" method="post">
                <table id="form_table">
                    <tr>
                        <td>
                            <label for="X">X </label>
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
                            <span class="error"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="Y">Y </label>
                            <input class="formfield" id="Y" type="text" name="Y" placeholder="Значение от -3 до 5" required>
                            <span class="error"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="R">R </label>
                            <select class="formfield" id="R" name="R" required>
                                <option value="">Выбрать</option>
                                <option value="1">1</option>
                                <option value="1.5">1.5</option>
                                <option value="2">2</option>
                                <option value="2.5">2.5</option>
                                <option value="3">3</option>
                            </select>
                            <span class="error"></span>
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
                        beanList.stream().filter(o -> {
                             return o instanceof TableDataBean;
                        }).forEachOrdered(o -> {
                            TableDataBean bean = (TableDataBean) o;
                            out.println("<tr><td>" + bean.getX()
                                    + "</td><td>" + bean.getY()
                                    + "</td><td>" + bean.getR()
                                    + "</td><td>" + bean.getResult()
                                    + "</td><td>" + bean.getCurrentTime()
                                    + "</td><td>" + bean.getProcessingTime() + "</td></tr>");
                        });
                    }
                %>
            </table>
        </td>
    </tr>
</table>
</body>
</html>