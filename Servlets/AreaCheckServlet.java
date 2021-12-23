package WebLab.Servlets;

import WebLab.Data.TableDataBean;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.LinkedList;

public class AreaCheckServlet extends HttpServlet {
    /**
     * Сервлет осуществляющий проверку попадания точки в область на координатной плоскости и
     * формирующий HTML-страницу с результатами проверки.
     * Должен обрабатывать все запросы, содержащие сведения о координатах точки и радиусе области.
     */
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/index.jsp");
        TableDataBean tdBean = new TableDataBean();

        String requestParameterX = request.getParameter("X");
        String requestParameterY = request.getParameter("Y");
        String requestParameterR = request.getParameter("R");

        if (xIsValid(requestParameterX) && yIsValid(requestParameterY) && rIsValid(requestParameterR)) {
            double x = Double.parseDouble(requestParameterX);
            double y = Double.parseDouble(requestParameterY);
            double r = Double.parseDouble(requestParameterR);
            tdBean.setX(x);
            tdBean.setY(y);
            tdBean.setR(r);

            if (isHit(x,y,r)){
                tdBean.setResult("Попадание");
            } else {
                tdBean.setResult("Промах");
            }

        } else {
            tdBean.setResult("Некорректные данные!");
        }

        tdBean.setProcessing_time(getProcessingTime(request));
        tdBean.setCurrent_time(LocalDateTime.now());

        request.getSession().setAttribute("tdBean",tdBean);

        LinkedList beanList;
        Object sessionBeans = request.getSession().getAttribute("sessionBeans");
        if ( sessionBeans instanceof LinkedList ){
            beanList = (LinkedList) sessionBeans;
        } else {
            beanList = new LinkedList<> ();
        }
        beanList.add(tdBean);
        request.getSession().setAttribute("sessionBeans",beanList);
        requestDispatcher.  forward(request, response);
    }

    private double getProcessingTime(HttpServletRequest request){
        HttpSession session = request.getSession();
        long start_time = (long) session.getAttribute("startTime");
        long current_time = System.nanoTime();
        return (double) (current_time - start_time) / 1000000;
    }
    private boolean xIsValid (String x){
        /* Выполняет валидацию поля X.
         * x ∈ { -5, ..., 3}
         */
        try {
            double temp = Double.parseDouble(x);
            if (temp >= -5 && temp <=3) {
                return  true;
            }
        } catch (NumberFormatException e){
            return false;
        }
        return  false;
    }
    private boolean yIsValid (String y){
        /* Выполняет валидацию поля Y.
         * y ∈ { -5, -4, -3, -2, -1, 0, 1, 2, 3}
         */
        try {
            double temp = Double.parseDouble(y);
            if (temp >= -5 && temp <=3) {
                return  true;
            }
        } catch (NumberFormatException e){
            return false;
        }
        return  false;
    }
    private boolean rIsValid (String r){
        /* Выполняет валидацию поля R.
         * x ∈ { 1, 2, 3, 4, 5}
         */
        try {
            double temp = Double.parseDouble(r);
            if (temp >= 1 && temp <=5) {
                return  true;
            }
        } catch (NumberFormatException e){
            return false;
        }
        return  false;
    }

    private boolean isHit(double x, double y, double r){
        /* Выполняет проверку попадания точки на координатной плоскости в заданную область.*/
        //Из-за оссобености варианта можно не проверять правый верхний угол. В него невозможно попасть.
        return isLeftTop(x,y,r) || isRightBottom(x,y,r) || isLeftBottom(x,y,r);
    }
    private boolean isLeftTop(double x, double y, double r){
        r /= 2;
        return ( x <= 0 ) &&
                ( y >= 0 ) &&
                ( x*x + y*y <= r*r );
    }
    private boolean isRightBottom(double x, double y, double r){
        r /=2;
        return  ( x >= 0 ) &&
                ( y <= 0 ) &&
                ( x - y <= r );
    }
    private boolean isLeftBottom(double x, double y, double r){
        return  ( x <= 0 ) &&
                ( y <= 0 ) &&
                ( x >= -r ) &&
                ( y >= -r );
    }
}
