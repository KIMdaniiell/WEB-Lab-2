package WebLab.Servlets;

import WebLab.Data.TableDataBean;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
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

        try {
            double x = Double.parseDouble(requestParameterX);
            double y = Double.parseDouble(requestParameterY);
            double r = Double.parseDouble(requestParameterR);

            if (xIsValid(x) && yIsValid(y) && rIsValid(r)) {
                tdBean.setX(x);
                tdBean.setY(y);
                tdBean.setR(r);

                if (isHit(x,y,r)){
                    tdBean.setResult("HIT");
                } else {
                    tdBean.setResult("MISS");
                }
            } else {
                tdBean.setResult("OUT OF BOUNDS");
            }
        } catch (NumberFormatException e){
            tdBean.setResult("INVALID DATA");
        }

        tdBean.setProcessing_time(getProcessingTime(request));
        tdBean.setCurrent_time(LocalDateTime.now());

        LinkedList beanList;
        Object contextBeans = getServletContext().getAttribute("contextBeans");
        if ( contextBeans instanceof LinkedList ){
            beanList = (LinkedList) contextBeans;
        } else {
            beanList = new LinkedList<> ();
        }
        beanList.add(tdBean);
        getServletContext().setAttribute("contextBeans",beanList);
        requestDispatcher.forward(request, response);
    }

    private double getProcessingTime(HttpServletRequest request){
        HttpSession session = request.getSession();
        long start_time = (long) session.getAttribute("startTime");
        long current_time = System.nanoTime();
        return (double) (current_time - start_time) / 1000000;
    }
    private boolean xIsValid (double x){
        /* Выполняет валидацию поля X.
         * x ∈ { -5, ..., 3}
         */
        return  (x >= -5 && x <=3);
    }
    private boolean yIsValid (double y){
        /* Выполняет валидацию поля Y.
         * y ∈ { -5, -4, -3, -2, -1, 0, 1, 2, 3}
         */
        return (y >= -5 && y <=3);
    }
    private boolean rIsValid (double r){
        /* Выполняет валидацию поля R.
         * x ∈ { 1, 2, 3, 4, 5}
         */
        return  (r >= 1 && r <=5);
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
